-- lua/plugins/lsp-config.lua
return {
    -- Mason (package manager)
    {
        "mason-org/mason.nvim",
        build = ":MasonUpdate",
        opts = {}, -- default UI/paths are fine
    },

    -- nvim-lspconfig
    {
        "neovim/nvim-lspconfig",
        event = { "BufReadPre", "BufNewFile" },
        dependencies = {
            "hrsh7th/cmp-nvim-lsp",
        },
        init = function()
            local ok, lsp = pcall(require, "config.lsp")
            if not ok then
                lsp = lsp or {}
                lsp.on_attach = lsp.on_attach or function() end
                local cmp = require("cmp_nvim_lsp")
                lsp.capabilities = lsp.capabilities or cmp.default_capabilities()
            end

            -- Go
            vim.lsp.config("gopls", {
                on_attach = lsp.on_attach,
                capabilities = lsp.capabilities,
                settings = {
                    gopls = {
                        analyses = { unusedparams = true, unusedwrite = true, shadow = true },
                        staticcheck = true,
                        gofumpt = true,
                    },
                },
            })

            -- Python
            vim.lsp.config("pyright", {
                on_attach = lsp.on_attach,
                capabilities = lsp.capabilities,
                settings = {
                    python = {
                        analysis = {
                            typeCheckingMode = "basic",
                            autoSearchPaths = true,
                            useLibraryCodeForTypes = true,
                        },
                    },
                },
                on_new_config = function(config, root_dir)
                    local pybin = root_dir .. "/.venv/bin/python"
                    if vim.fn.executable(pybin) == 1 then
                        config.settings = config.settings or {}
                        config.settings.python = config.settings.python or {}
                        config.settings.python.pythonPath = pybin
                    end
                end,
            })

            -- Lua
            vim.lsp.config("lua_ls", {
                on_attach = lsp.on_attach,
                capabilities = lsp.capabilities,
                settings = {
                    Lua = {
                        runtime = { version = "LuaJIT" },
                        diagnostics = { globals = { "vim" } },
                        workspace = {
                            library = vim.api.nvim_get_runtime_file("", true),
                            checkThirdParty = false,
                        },
                        completion = { callSnippet = "Replace" },
                    },
                },
            })
        end,
    },

    -- mason-lspconfig
    {
        "mason-org/mason-lspconfig.nvim",
        dependencies = {
            { "mason-org/mason.nvim", opts = {} },
            "neovim/nvim-lspconfig",
        },
        opts = {
            ensure_installed = { "gopls", "pyright", "lua_ls" },
            automatic_enable = {
                exclude = { "stylua" },
            },
        },
    },
}
