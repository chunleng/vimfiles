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
    noremap('n', '<leader>cR', '<cmd>LspRestart<cr>')
    noremap('n', '<leader>cr', '<cmd>lua vim.lsp.buf.rename()<cr>')
    noremap('n', '<leader>c=', '<cmd>lua vim.lsp.buf.format({async=true})<cr>')
    noremap('n', '<leader>cu', '<cmd>FzfLua lsp_references<cr>')
    noremap('n', '<leader>cd', '<cmd>FzfLua lsp_document_diagnostics<cr>')
    noremap('n', '<leader>c?', '<cmd>FzfLua lsp_workspace_diagnostics<cr>')
    noremap('n', '<leader>cp', '<cmd>lua vim.diagnostic.goto_prev()<cr>')
    noremap('n', '<leader>cn', '<cmd>lua vim.diagnostic.goto_next()<cr>')
    noremap('n', '(', '<cmd>lua vim.diagnostic.goto_prev()<cr>')
    noremap('n', ')', '<cmd>lua vim.diagnostic.goto_next()<cr>')
end

local function setup_lsp()
    -- https://github.com/williamboman/mason-lspconfig.nvim/blob/main/doc/server-mapping.md
    local lspconfig = require('lspconfig')
    local common_on_attach = function(_, bufnr)
        local function noremap(b, mode, lhs, rhs, is_silent)
            if is_silent == nil then is_silent = true end
            vim.api.nvim_buf_set_keymap(b, mode, lhs, rhs,
                                        {silent = is_silent, noremap = true})
        end

        -- Insert keymap that might override default ones
        noremap(bufnr, 'n', 'gd', '<cmd>FzfLua lsp_definitions<cr>')
        noremap(bufnr, 'n', 'K', '<cmd>lua vim.lsp.buf.hover()<cr>')
        noremap(bufnr, 'v', '=',
                ':\'<,\'>lua vim.lsp.buf.range_formatting()<cr>')
    end

    configure_lsp_mappings()
    local lsp_setup = require("mason-lspconfig")
    lsp_setup.setup({
        ensure_installed = {
            "cssls", "cssmodules_ls", "denols", "dockerls", "efm", "eslint",
            "grammarly", "html", "intelephense", "jdtls", "jsonls", "pyright",
            "purescriptls", "rust_analyzer", "solargraph", "sumneko_lua",
            "tailwindcss", "terraformls", "tflint", "tsserver", "vimls",
            "yamlls"

        }
    })
    lsp_setup.setup_handlers {
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
                    lintDebounce = "500ms",
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
                            }, {
                                formatCommand = "yapf --quiet",
                                formatStdin = true,
                                rootMarkers = {".python-version"}
                            }, {
                                prefix = "Pylint",
                                lintCommand = "pylint --from-stdin --output-format text --score no --msg-template {path}:{line}:{column}:{C}:{msg} ${INPUT}",
                                lintStdin = true,
                                lintFormats = {'%f:%l:%c:%t:%m'},
                                lintOffsetColumns = 1,
                                lintCategoryMap = {
                                    I = "H",
                                    R = "I",
                                    C = "I",
                                    W = "W",
                                    E = "E",
                                    F = "E"
                                },
                                rootMarkers = {".python-version"}
                            }
                        },
                        markdown = {
                            {
                                prefix = "Markdownlint",
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
        pyright = function()
            local setup_dict = {on_attach = common_on_attach}
            local exit_code = os.execute(
                                  'which -a pyright|grep -v ${HOME}/.local/share/nvim/mason/bin/pyright')
            if exit_code ~= 0 then -- turn off diagnostic because no pyright found
                setup_dict["settings"] = {
                    python = {
                        analysis = {
                            typeCheckingMode = "off",
                            diagnosticSeverityOverrides = {
                                reportMissingModuleSource = "none",
                                reportMissingImports = "none",
                                reportUndefinedVariable = "none"
                            }
                        }
                    }
                }
            end

            lspconfig.pyright.setup(setup_dict)
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
            require("neodev").setup()
            lspconfig.sumneko_lua.setup({
                on_attach = function(client, bufnr)
                    -- Use efm lua-format instead
                    client.server_capabilities.documentFormattingProvider =
                        false
                    client.server_capabilities.documentRangeFormattingProvider =
                        false
                    common_on_attach(client, bufnr)
                end,
                settings = {Lua = {completion = {callSnippet = "Replace"}}}
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

local function setup_dap()
    local dap_setup = require('mason-nvim-dap')
    local dap = require("dap")
    local dapui = require("dapui")

    local theme = require('common-theme')
    theme.set_hl('DapBreakpointText', {fg = 14})
    theme.set_hl('DapStoppedText', {fg = 10})
    vim.fn.sign_define('DapBreakpoint',
                       {text = '', texthl = 'DapBreakpointText'})
    vim.fn.sign_define('DapStopped', {
        text = '',
        texthl = 'DapStoppedText',
        linehl = 'CursorLine'
    })

    vim.api.nvim_set_keymap('n', '<leader>db', '<cmd>DapToggleBreakpoint<cr>',
                            {silent = true, noremap = true})
    vim.api.nvim_set_keymap('n', '<leader>dc', '<cmd>DapContinue<cr>',
                            {silent = true, noremap = true})
    vim.api.nvim_set_keymap('n', '<leader>dC',
                            '<cmd>lua require("dap").run_last()<cr>',
                            {silent = true, noremap = true})
    vim.api.nvim_set_keymap('n', '<leader>dd', '<cmd>DapStepOver<cr>',
                            {silent = true, noremap = true})
    vim.api.nvim_set_keymap('n', '+', '<cmd>DapStepOver<cr>',
                            {silent = true, noremap = true})
    vim.api.nvim_set_keymap('n', '<leader>di', '<cmd>DapStepInto<cr>',
                            {silent = true, noremap = true})
    vim.api.nvim_set_keymap('n', '<leader>do', '<cmd>DapStepOut<cr>',
                            {silent = true, noremap = true})
    vim.api.nvim_set_keymap('n', '-', '<cmd>DapStepOut<cr>',
                            {silent = true, noremap = true})
    vim.api.nvim_set_keymap('n', '<leader>dt', '<cmd>DapTerminate<cr>',
                            {silent = true, noremap = true})
    vim.api.nvim_set_keymap('n', '<leader>Dr',
                            '<cmd>lua require("dap").repl.toggle()<cr>',
                            {silent = true, noremap = true})
    vim.api.nvim_set_keymap('n', '<leader>Du',
                            '<cmd>lua require("dapui").toggle()<cr>',
                            {silent = true, noremap = true})
    vim.api.nvim_set_keymap('n', '<leader>dn',
                            '<cmd>lua require("goto-breakpoints").next()<cr>',
                            {noremap = true})
    vim.api.nvim_set_keymap('n', '<leader>dp',
                            '<cmd>lua require("goto-breakpoints").prev()<cr>',
                            {noremap = true})

    -- List of install name
    -- https://github.com/jayp0521/mason-nvim-dap.nvim/blob/main/lua/mason-nvim-dap/mappings/source.lua
    dap_setup.setup({
        ensure_installed = {'python'},
        automatic_installation = true
    })

    dap_setup.setup_handlers({
        python = function()
            dap.adapters.python = {
                command = "debugpy-adapter",
                type = "executable"
            }
        end
    })

    dapui.setup({
        icons = {expanded = "", collapsed = "", current_frame = ""},
        mappings = {
            expand = {'<cr>', 'l', 'h'},
            open = 'o',
            remove = 'd',
            edit = 'e',
            toggle = 't'
        },
        element_mappings = {stacks = {open = {'<cr>', 'l', 'h'}, expand = 'o'}},
        layouts = {
            {
                elements = {
                    {id = 'stacks', size = 0.4}, {id = 'watches', size = 0.6}
                },
                size = 30,
                position = 'left'
            }
        },
        controls = {enabled = false}
    })
    theme.set_hl('DapUIVariable', {fg = theme.blender.fg_darker_2})
    theme.set_hl('DapUIScope', {bold = true, fg = 4})
    theme.set_hl('DapUIType', {link = 'Type'})
    theme.set_hl('DapUIValue', {fg = theme.blender.bg_lighter_3})
    theme.set_hl('DapUIModifiedValue', {fg = 15, underdashed = true})
    theme.set_hl('DapUIDecoration', {fg = theme.blender.bg_lighter_2})
    theme.set_hl('DapUIType', {link = 'Type'})
    theme.set_hl('DapUIStoppedThread', {bold = true, fg = 4})
    theme.set_hl('DapUIThread', {fg = 4})
    theme.set_hl('DapUISource', {fg = 12})
    theme.set_hl('DapUILineNumber', {link = 'Normal'})
    theme.set_hl('DapUIWatchesEmpty', {link = 'Comment'})
    theme.set_hl('DapUIWatchesValue', {link = 'Normal'})
    theme.set_hl('DapUIWatchesError', {link = 'Comment'})
    theme.set_hl('DapUIBreakpointsCurrentLine', {fg = 2})

    dap.listeners.after.event_initialized["dapui_config"] = function()
        dapui.open()
    end
    dap.listeners.before.event_terminated["dapui_config"] = function()
        dapui.close()
    end
    dap.listeners.before.event_exited["dapui_config"] = function()
        dapui.close()
    end
end

function M.setup()
    require("mason").setup()
    setup_lsp()
    setup_dap()
end

return M
