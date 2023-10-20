local M = {}

local utils = require('common-utils')

local function configure_lsp_mappings()
    utils.keymap('n', '<leader>cf', '<cmd>lua require("lsp-fixcurrent")()<cr>')
    -- TODO In typescript-language-server, no matter the kind, it always include disable rules as a result.
    --      Thus, the code_action does not work as expected. We can probably fix this by allowing
    --      apply_strategy to be "first" or "only"
    -- noremap('n', '<leader>cf', '<cmd>lua vim.lsp.buf.code_action({context={only={"quickfix"}}, apply=true})<cr>')
    utils.keymap('n', '<leader>ca',
                 '<cmd>lua vim.lsp.buf.code_action({apply=true})<cr>')
    utils.keymap('n', '<leader>cr', '<cmd>lua vim.lsp.buf.rename()<cr>')
    utils.keymap('n', '<leader>c=',
                 '<cmd>lua vim.lsp.buf.format({async=true})<cr>')
    utils.keymap('n', '<leader>cu', '<cmd>FzfLua lsp_references<cr>')
    utils.keymap('n', '<leader>cd', '<cmd>FzfLua lsp_document_diagnostics<cr>')
    utils.keymap('n', '<leader>c?', '<cmd>FzfLua lsp_workspace_diagnostics<cr>')
    utils.keymap('n', {'[d', '[<c-d>'},
                 '<cmd>lua vim.diagnostic.goto_prev()<cr>')
    utils.keymap('n', {']d', ']<c-d>'},
                 '<cmd>lua vim.diagnostic.goto_next()<cr>')
end

local function setup_lsp()
    -- https://github.com/williamboman/mason-lspconfig.nvim/blob/main/doc/server-mapping.md
    local lspconfig = require('lspconfig')
    local common_on_attach = function(_, bufnr)
        -- Insert keymap that might override default ones
        utils.buf_keymap(bufnr, 'n', 'gd', '<cmd>FzfLua lsp_definitions<cr>')
        utils.buf_keymap(bufnr, 'n', 'K', '<cmd>lua vim.lsp.buf.hover()<cr>')
        utils.buf_keymap(bufnr, 'v', '=',
                         ':\'<,\'>lua vim.lsp.buf.range_formatting()<cr>')
    end
    local common_handlers = {
        ['textDocument/hover'] = vim.lsp.with(vim.lsp.handlers.hover, {
            border = {
                {"┌", "FloatBorder"}, {"─", "FloatBorder"},
                {"┐", "FloatBorder"}, {"│", "FloatBorder"},
                {"┘", "FloatBorder"}, {"─", "FloatBorder"},
                {"└", "FloatBorder"}, {"│", "FloatBorder"}
            }
        })
    }

    configure_lsp_mappings()
    local lsp_setup = require("mason-lspconfig")
    lsp_setup.setup({
        ensure_installed = {
            "cssls", "cssmodules_ls", "denols", "dockerls", "eslint", "gopls",
            "html", "intelephense", "jdtls", "jsonls", "ltex", "pyright",
            "purescriptls", "rust_analyzer", "solargraph", "lua_ls",
            "tailwindcss", "terraformls", "tflint", "tsserver", "vimls",
            "yamlls", 'zk'
        }
    })
    lsp_setup.setup_handlers {
        function(server_name)
            lspconfig[server_name].setup({
                on_attach = common_on_attach,
                handlers = common_handlers
            })
        end,
        cssls = function()
            local capabilities = vim.lsp.protocol.make_client_capabilities()
            capabilities.textDocument.completion.completionItem.snippetSupport =
                true
            lspconfig.cssls.setup({
                on_attach = common_on_attach,
                handlers = common_handlers,
                capabilities = capabilities
            })
        end,
        denols = function()
            lspconfig.denols.setup({
                on_attach = common_on_attach,
                handlers = common_handlers,
                root_dir = require("lspconfig").util.root_pattern("deno.json",
                                                                  "deno.jsonc"),
                -- To ensure that deno does not interfere with tsserver
                single_file_support = false
            })

        end,
        eslint = function()
            lspconfig.eslint.setup({
                on_attach = function(client, bufnr)
                    client.server_capabilities.documentFormattingProvider = true
                    common_on_attach(client, bufnr)
                end,
                handlers = common_handlers
            })
        end,
        html = function()
            local capabilities = vim.lsp.protocol.make_client_capabilities()
            capabilities.textDocument.completion.completionItem.snippetSupport =
                true
            lspconfig.html.setup({
                on_attach = common_on_attach,
                handlers = common_handlers,
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
                handlers = common_handlers,
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
                handlers = common_handlers,
                settings = {
                    json = {schemas = require('schemastore').json.schemas()}
                },
                capabilities = capabilities
            })
        end,
        ltex = function()
            local export_path = vim.fn.getcwd() .. '/.vim/'
            local dict_path = export_path .. 'ltex.dictionary.en-US.txt'
            local words = {}
            if vim.fn.filereadable(dict_path) == 1 then
                for word in io.open(dict_path, "r"):lines() do
                    table.insert(words, word)
                end
            end

            lspconfig.ltex.setup({
                on_attach = function(client, bufnr)
                    require("ltex_extra").setup({path = export_path})
                    common_on_attach(client, bufnr)
                end,
                handlers = common_handlers,
                settings = {ltex = {dictionary = {['en-US'] = words}}},
                root_dir = function() return vim.fn.getcwd() end
            })
        end,
        lua_ls = function()
            require("neodev").setup()
            lspconfig.lua_ls.setup({
                on_attach = function(client, bufnr)
                    -- Use efm lua-format instead
                    client.server_capabilities.documentFormattingProvider =
                        false
                    client.server_capabilities.documentRangeFormattingProvider =
                        false
                    common_on_attach(client, bufnr)
                end,
                handlers = common_handlers,
                settings = {Lua = {completion = {callSnippet = "Replace"}}}
            })
        end,
        pyright = function()
            local setup_dict = {
                on_attach = common_on_attach,
                handlers = common_handlers
            }
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
        tailwindcss = function()
            lspconfig.tailwindcss.setup({
                on_attach = common_on_attach,
                handlers = common_handlers,
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
                handlers = common_handlers,
                root_dir = require("lspconfig").util.root_pattern(
                    "package.json", "tsconfig.json", "jsconfig.json")
            })
        end,
        yamlls = function()
            lspconfig.yamlls.setup({
                on_attach = common_on_attach,
                handlers = common_handlers,
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

    utils.keymap('n', '<leader>db', '<cmd>DapToggleBreakpoint<cr>')
    utils.keymap('n', '<leader>dc', '<cmd>DapContinue<cr>')
    utils.keymap('n', '<leader>dd', '<cmd>lua require("dap").run_last()<cr>')
    utils.keymap('n', {'<leader>dl', '<right>'}, '<cmd>DapStepOver<cr>')
    utils.keymap('n', {'<leader>dj', '<down>'}, '<cmd>DapStepInto<cr>')
    utils.keymap('n', {'<leader>dk', '<up>'}, '<cmd>DapStepOut<cr>')
    utils.keymap('n', '<leader>dt', '<cmd>DapTerminate<cr>')
    utils.keymap('n', {']b', ']<c-b>'},
                 function() require('goto-breakpoints').next() end)
    utils.keymap('n', {'[b', '[<c-b>'},
                 function() require('goto-breakpoints').prev() end)

    -- List of install name
    -- https://github.com/jayp0521/mason-nvim-dap.nvim/blob/main/lua/mason-nvim-dap/mappings/source.lua
    dap_setup.setup({
        ensure_installed = {'python'},
        automatic_installation = true,
        handlers = {
            python = function(config)
                config.adapters = {
                    command = "debugpy-adapter",
                    type = "executable"
                }
                dap_setup.default_setup(config)
            end
        }
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

local function setup_null_ls()
    local null_ls = require('null-ls')

    local sources = {}

    -- formatters
    if os.execute('type yapf >& /dev/null') == 0 then
        table.insert(sources, null_ls.builtins.formatting.yapf)
    end
    if os.execute('type black >& /dev/null') == 0 then
        table.insert(sources, null_ls.builtins.formatting.black)
    end
    if os.execute('type isort >& /dev/null') == 0 then
        table.insert(sources, null_ls.builtins.formatting.isort)
    end
    if os.execute('type lua-format >& /dev/null') == 0 then
        table.insert(sources, null_ls.builtins.formatting.lua_format)
    end
    if os.execute('type goimports >& /dev/null') == 0 then
        table.insert(sources, null_ls.builtins.formatting.goimports)
    end
    if os.execute('type leptosfmt >& /dev/null') then
        table.insert(sources, {
            method = null_ls.methods.FORMATTING,
            filetypes = {'rust'},
            generator = null_ls.formatter({
                async = false,
                command = "leptosfmt",
                to_stdin = true,
                args = {'-s'}
            })
        })
    end

    -- diagnostics
    if os.execute('type pylint >& /dev/null') == 0 then
        table.insert(sources, null_ls.builtins.diagnostics.pylint)
    end
    if os.execute('type mypy >& /dev/null') == 0 then
        table.insert(sources, null_ls.builtins.diagnostics.mypy)
    end
    if os.execute('type markdownlint >& /dev/null') == 0 then
        table.insert(sources, null_ls.builtins.diagnostics.markdownlint)
    end

    -- both (format and diagnose)
    if os.execute('type ruff >& /dev/null') == 0 then
        table.insert(sources, null_ls.builtins.formatting.ruff)
        table.insert(sources, null_ls.builtins.diagnostics.ruff)
    end

    null_ls.setup({sources = sources})
end

function M.setup()
    require("mason").setup()
    require('kitty-launcher').setup()
    setup_lsp()
    setup_dap()
    setup_null_ls()
end

return M
