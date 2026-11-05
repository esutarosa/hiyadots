local M = {}

local TIMEOUT = 15 * 60 * 1000

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
	local installed = treesitter.get_installed("parsers")
	local missing = vim.tbl_filter(function(parser)
		return not vim.tbl_contains(installed, parser)
	end, parsers)
	if #missing > 0 then
		treesitter.install(missing):pwait(TIMEOUT)
	end
	installed = treesitter.get_installed("parsers")
	return vim.tbl_filter(function(parser)
		return not vim.tbl_contains(installed, parser)
	end, parsers)
end

function M.run()
	local report = {
		mason = install_mason(),
		parsers = install_parsers(),
	}
	io.stdout:write("Not installed: " .. vim.inspect(report) .. "\n")
end

return M
