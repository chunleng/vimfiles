local M = {}

local function configure_lsp_mappings()
    local function noremap(mode, lhs, rhs, is_silent)
        if is_silent == nil then is_silent = true end
        vim.api.nvim_set_keymap(mode, lhs, rhs,
                                {silent = is_silent, noremap = true})
    end
    noremap('n', '<leader>cf', '<cmd>lua require("lsp-fixcurrent")()<cr>')
    -- TODO In typescript-language-server, no matter the kind, it always include disable rules as a result.
    --      Thus, the code_action does not work as expected. We can probably fix this by allowing
    --      apply_strategy to be "first" or "only"
    -- noremap('n', '<leader>cf', '<cmd>lua vim.lsp.buf.code_action({context={only={"quickfix"}}, apply=true})<cr>')
    noremap('n', '<leader>ca',
            '<cmd>lua vim.lsp.buf.code_action({apply=true})<cr>')
    noremap('n', '<leader>cr', '<cmd>lua vim.lsp.buf.rename()<cr>')
    noremap('n', '<leader>c=', '<cmd>lua vim.lsp.buf.format({async=true})<cr>')
    noremap('n', '<leader>cu', '<cmd>lua require"fzf-lua".lsp_references()<cr>')
    noremap('n', '<leader>cd', '<cmd>FzfLua lsp_document_diagnostics<cr>')
    noremap('n', '<leader>c?', '<cmd>FzfLua lsp_workspace_diagnostics<cr>')
    noremap('n', '<leader>cp', '<cmd>lua vim.diagnostic.goto_prev()<cr>')
    noremap('n', '<leader>cn', '<cmd>lua vim.diagnostic.goto_next()<cr>')
end

function M.setup()
    -- https://github.com/williamboman/mason-lspconfig.nvim/blob/main/doc/server-mapping.md

    local lspconfig = require('lspconfig')
    local common_on_attach = function(client, bufnr)
        local function noremap(b, mode, lhs, rhs, is_silent)
            if is_silent == nil then is_silent = true end
            vim.api.nvim_buf_set_keymap(b, mode, lhs, rhs,
                                        {silent = is_silent, noremap = true})
        end

        -- Insert keymap that might override default ones
        noremap(bufnr, 'n', 'gd',
                '<cmd>lua require"fzf-lua".lsp_definitions()<cr>')
        noremap(bufnr, 'n', 'K', '<cmd>lua vim.lsp.buf.hover()<cr>')
        noremap(bufnr, 'v', '=',
                ':\'<,\'>lua vim.lsp.buf.range_formatting()<cr>')

        require("aerial").on_attach(client, bufnr)
    end

    configure_lsp_mappings()
    require("mason").setup()
    require("mason-lspconfig").setup({
        ensure_installed = {
            "cssls", "cssmodules_ls", "denols", "dockerls", "efm", "eslint",
            "grammarly", "html", "intelephense", "jdtls", "jsonls", "pyright",
            "purescriptls", "rust_analyzer", "solargraph", "sumneko_lua",
            "tailwindcss", "terraformls", "tflint", "tsserver", "vimls",
            "yamlls"

        }
    })
    require("mason-lspconfig").setup_handlers {
        function(server_name)
            lspconfig[server_name].setup({on_attach = common_on_attach})
        end,
        cssls = function()
            local capabilities = vim.lsp.protocol.make_client_capabilities()
            capabilities.textDocument.completion.completionItem.snippetSupport =
                true
            lspconfig.cssls.setup({
                on_attach = common_on_attach,
                capabilities = capabilities
            })
        end,
        denols = function()
            lspconfig.denols.setup({
                on_attach = common_on_attach,
                root_dir = require("lspconfig").util.root_pattern("deno.json",
                                                                  "deno.jsonc"),
                -- To ensure that deno does not interfere with tsserver
                single_file_support = false
            })

        end,
        efm = function()
            lspconfig.efm.setup({
                on_attach = common_on_attach,
                init_options = {documentFormatting = true},
                filetypes = {"python", "markdown", "lua"},
                -- https://github.com/mattn/efm-langserver#example-for-configyaml
                settings = {
                    languages = {
                        python = {
                            {
                                formatCommand = "isort --quiet -",
                                formatStdin = true,
                                rootMarkers = {".python-version"}
                            }, {
                                formatCommand = "black --quiet -",
                                formatStdin = true,
                                rootMarkers = {".python-version"}
                            }
                        },
                        markdown = {
                            {
                                lintCommand = "markdownlint -s",
                                lintStdin = true,
                                lintFormats = {
                                    '%f:%l %m', '%f:%l:%c %m', '%f: %l: %m'
                                }
                            }
                        },
                        lua = {
                            {
                                formatCommand = "lua-format -i",
                                formatStdin = true
                            }
                        }
                    }
                }
            })
        end,
        eslint = function()
            lspconfig.eslint.setup({
                on_attach = function(client, bufnr)
                    client.server_capabilities.documentFormattingProvider = true
                    common_on_attach(client, bufnr)
                end
            })
        end,
        grammarly = function()
            lspconfig.grammarly.setup({
                -- https://github.com/znck/grammarly/blob/23ace62e1568a49349807bae500157246a85aff3/extension/src/GrammarlyClient.ts#L71
                init_options = {clientId = "client_BaDkMgx4X19X9UxxYRCXZo"}
            })
        end,
        html = function()
            local capabilities = vim.lsp.protocol.make_client_capabilities()
            capabilities.textDocument.completion.completionItem.snippetSupport =
                true
            lspconfig.html.setup({
                on_attach = common_on_attach,
                capabilities = capabilities
            })
        end,
        jdtls = function()
            -- Currently, jdtls latest version is not allowing Java 11 to be used
            -- To allow Java 11 to be used, we need to use the jdtls version the version that is supported
            -- To do so:
            --   :MasonInstall jdtls@1.9.0
            -- ref: https://github.com/williamboman/nvim-lsp-installer/issues/763
            local workspace = os.getenv("HOME") .. "/.java-workspace"
            lspconfig.jdtls.setup({
                on_attach = common_on_attach,
                use_lombok_agent = true,
                root_dir = function() return vim.fn.getcwd() end,
                workspace = workspace,
                vmargs = {"-data", workspace}
            })
        end,
        jsonls = function()
            local capabilities = vim.lsp.protocol.make_client_capabilities()
            capabilities.textDocument.completion.completionItem.snippetSupport =
                true
            lspconfig.jsonls.setup({
                on_attach = common_on_attach,
                settings = {
                    json = {schemas = require('schemastore').json.schemas()}
                },
                capabilities = capabilities
            })

        end,
        solargraph = function()
            lspconfig.solargraph.setup({
                cmd = {
                    os.getenv("HOME") .. "/.asdf/shims/bundle", "exec",
                    "solargraph", "stdio"
                }
            })
        end,
        sumneko_lua = function()
            local luadev = require("lua-dev").setup()
            if luadev == nil then luadev = {} end
            lspconfig.sumneko_lua.setup({
                on_attach = function(client, bufnr)
                    -- Use efm lua-format instead
                    client.server_capabilities.documentFormattingProvider =
                        false
                    client.server_capabilities.documentRangeFormattingProvider =
                        false
                    common_on_attach(client, bufnr)
                end,
                settings = luadev.settings
            })
        end,
        tailwindcss = function()
            lspconfig.tailwindcss.setup({
                on_attach = common_on_attach,
                filetypes = {
                    "aspnetcorerazor", "astro", "astro-markdown", "blade",
                    "css", "django-html", "edge", "eelixir", "ejs", "erb",
                    "eruby", "gohtml", "haml", "handlebars", "hbs", "heex",
                    "html", "html-eex", "htmldjango", "jade", "javascript",
                    "javascriptreact", "leaf", "less", "liquid", "markdown",
                    "mdx", "mustache", "njk", "nunjucks", "php", "postcss",
                    "razor", "reason", "rescript", "rust", "sass", "scss",
                    "slim", "stylus", "sugarss", "svelte", "twig", "typescript",
                    "typescriptreact", "vue"
                },
                settings = {tailwindCSS = {emmetCompletions = true}},
                init_options = {userLanguages = {rust = "html"}}
            })
        end,
        tsserver = function()
            lspconfig.tsserver.setup({
                on_attach = function(client, bufnr)
                    -- prefer eslint
                    client.server_capabilities.documentFormattingProvider =
                        false
                    client.server_capabilities.documentRangeFormattingProvider =
                        false
                    common_on_attach(client, bufnr)
                end,
                root_dir = require("lspconfig").util.root_pattern(
                    "package.json", "tsconfig.json", "jsconfig.json")
            })
        end,
        yamlls = function()
            lspconfig.yamlls.setup({
                on_attach = common_on_attach,
                settings = {yaml = {format = {enable = true}}}
            })
        end
    }
end

return M
