local M = {}

local TIMEOUT = 15 * 60 * 1000
local STALL = 5 * 60 * 1000

local function mason_packages()
	local names = {}
	for _, name in ipairs(LazyVim.opts("mason.nvim").ensure_installed or {}) do
		names[name] = true
	end
	local packages = require("mason-lspconfig.mappings").get_mason_map().lspconfig_to_package
	for server, config in pairs(LazyVim.opts("nvim-lspconfig").servers or {}) do
		if packages[server] and config ~= false and config.enabled ~= false and config.mason ~= false then
			names[packages[server]] = true
		end
	end
	return vim.tbl_keys(names)
end

local function install_mason()
	if not LazyVim.has("mason.nvim") then
		return {}
	end
	require("lazy").load({ plugins = { "mason.nvim", "mason-lspconfig.nvim" } })
	local registry = require("mason-registry")
	local names = mason_packages()
	local ready = false
	registry.refresh(function()
		for _, name in ipairs(names) do
			local ok, package = pcall(registry.get_package, name)
			if ok and not package:is_installed() and not package:is_installing() then
				package:install()
			end
		end
		ready = true
	end)
	vim.wait(TIMEOUT, function()
		if not ready then
			return false
		end
		for _, name in ipairs(names) do
			local ok, package = pcall(registry.get_package, name)
			if ok and package:is_installing() then
				return false
			end
		end
		return true
	end, 500)
	local missing = {}
	for _, name in ipairs(names) do
		local ok, package = pcall(registry.get_package, name)
		if not ok or not package:is_installed() then
			table.insert(missing, name)
		end
	end
	return missing
end

local function install_parsers()
	require("lazy").load({ plugins = { "nvim-treesitter" } })
	local treesitter = require("nvim-treesitter")
	local parsers = LazyVim.opts("nvim-treesitter").ensure_installed or {}
	local function missing()
		local installed = treesitter.get_installed("parsers")
		return vim.tbl_filter(function(parser)
			return not vim.tbl_contains(installed, parser)
		end, parsers)
	end
	-- LazyVim installs these itself on load, a second install of the same parser collides with it.
	local left = missing()
	if #left == 0 then
		return left
	end
	local progress = vim.uv.now()
	vim.wait(TIMEOUT, function()
		local now = missing()
		if #now < #left then
			left, progress = now, vim.uv.now()
		end
		return #left == 0 or vim.uv.now() - progress > STALL
	end, 1000)
	vim.wait(3000) -- queries are linked right after the parser appears
	return left
end

function M.run()
	-- the Lazy restore run before this one exits mid-install and leaves partial builds
	for _, path in ipairs(vim.fn.glob(vim.fn.stdpath("cache") .. "/tree-sitter-*", false, true)) do
		vim.fn.delete(path, "rf")
	end
	local report = {
		mason = install_mason(),
		parsers = install_parsers(),
	}
	io.stdout:write("Not installed: " .. vim.inspect(report) .. "\n")
end

return M
