local M = {}

function M.setup()
    local lsp_installer_servers = require('nvim-lsp-installer.servers')
    -- configuration: https://github.com/neovim/nvim-lspconfig/blob/master/doc/server_configurations.md
    -- installer: https://github.com/williamboman/nvim-lsp-installer#available-lsps
    local servers = {
        "tsserver", "tailwindcss", "eslint", "pyright", "efm", "jsonls",
        "sumneko_lua", "jdtls", "vimls", "html", "yamlls", "terraformls",
        "tflint", "cssls", "cssmodules_ls", "dockerls", "solargraph",
        "intelephense", "denols", "purescriptls", "rust_analyzer"
    }
    -- Loop through the servers listed above and set them up. If a server is
    -- not already installed, install it.
    for _, server_name in pairs(servers) do
        local server_available, server =
            lsp_installer_servers.get_server(server_name)
        if server_available then
            server:on_ready(function()
                local keymap_opts = {noremap = true, silent = true}
                local common_on_attach =
                    function(client, bufnr)
                        vim.api.nvim_buf_set_keymap(bufnr, 'n', 'gd',
                                                    '<cmd>lua require"fzf-lua".lsp_definitions()<cr>',
                                                    keymap_opts)
                        vim.api.nvim_buf_set_keymap(bufnr, 'n', 'K',
                                                    '<cmd>lua vim.lsp.buf.hover()<CR>',
                                                    keymap_opts)
                        vim.api.nvim_buf_set_keymap(bufnr, 'n', '<leader>ca',
                                                    '<cmd>lua vim.lsp.buf.code_action()<CR>',
                                                    keymap_opts)
                        vim.api.nvim_buf_set_keymap(bufnr, 'n', '<leader>cf',
                                                    ':lua require("lsp-fixcurrent")()<CR>',
                                                    keymap_opts)
                        -- TODO In typescript-language-server, no matter the kind, it always include disable rules as a result.
                        --      Thus, the code_action does not work as expected. We can probably fix this by allowing
                        --      apply_strategy to be "first" or "only"
                        -- vim.api.nvim_buf_set_keymap(bufnr, 'n', '<leader>cf',
                        --                             '<cmd>lua vim.lsp.buf.code_action({context={only={"quickfix"}}, apply=true})<CR>',
                        --                             keymap_opts)
                        vim.api.nvim_buf_set_keymap(bufnr, 'n', '<leader>ca',
                                                    '<cmd>lua vim.lsp.buf.code_action({context={only={"refactor"}}, apply=true})<CR>',
                                                    keymap_opts)
                        vim.api.nvim_buf_set_keymap(bufnr, 'n', '<leader>cr',
                                                    '<cmd>lua vim.lsp.buf.rename()<CR>',
                                                    keymap_opts)
                        vim.api.nvim_buf_set_keymap(bufnr, 'n', '<leader>c=',
                                                    '<cmd>lua vim.lsp.buf.format({async=true})<CR>',
                                                    keymap_opts)
                        vim.api.nvim_buf_set_keymap(bufnr, 'n', '<leader>cu',
                                                    '<cmd>lua require"fzf-lua".lsp_references()<cr>',
                                                    keymap_opts)
                        vim.api.nvim_buf_set_keymap(bufnr, 'v', '=',
                                                    ':\'<,\'>lua vim.lsp.buf.range_formatting()<CR>',
                                                    keymap_opts)
                        vim.api.nvim_set_keymap('n', '<leader>cd',
                                                '<cmd>FzfLua lsp_document_diagnostics<CR>',
                                                keymap_opts)
                        vim.api.nvim_set_keymap('n', '<leader>c?',
                                                '<cmd>FzfLua lsp_workspace_diagnostics<CR>',
                                                keymap_opts)
                        vim.api.nvim_set_keymap('n', '<leader>cp',
                                                '<cmd>lua vim.diagnostic.goto_prev()<CR>',
                                                keymap_opts)
                        vim.api.nvim_set_keymap('n', '<leader>cn',
                                                '<cmd>lua vim.diagnostic.goto_next()<CR>',
                                                keymap_opts)
                        require("aerial").on_attach(client, bufnr)
                    end
                local server_opts = {
                    on_attach = common_on_attach,
                    flags = {
                        -- This will be the default in neovim 0.7+
                        debounce_text_changes = 250
                    }
                }
                if server.name == "tsserver" then
                    server_opts.on_attach =
                        function(client, bufnr)
                            -- prefer eslint
                            client.server_capabilities
                                .documentFormattingProvider = false
                            client.server_capabilities
                                .documentRangeFormattingProvider = false
                            common_on_attach(client, bufnr)
                        end
                    server_opts.root_dir =
                        require("lspconfig").util.root_pattern("package.json",
                                                               "tsconfig.json",
                                                               "jsconfig.json")
                elseif server.name == "denols" then
                    server_opts.root_dir =
                        require("lspconfig").util.root_pattern("deno.json",
                                                               "deno.jsonc")
                elseif server.name == "eslint" then
                    server_opts.on_attach =
                        function(client, bufnr)
                            client.server_capabilities
                                .documentFormattingProvider = true
                            common_on_attach(client, bufnr)
                        end
                elseif server.name == "efm" then
                    server_opts.init_options = {documentFormatting = true}
                    server_opts.filetypes = {"python", "markdown", "lua"}
                    -- https://github.com/mattn/efm-langserver#example-for-configyaml
                    -- TODO markdown-lint
                    server_opts.settings = {
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
                elseif server.name == "jsonls" then
                    local capabilities = vim.lsp.protocol
                                             .make_client_capabilities()
                    capabilities.textDocument.completion.completionItem
                        .snippetSupport = true
                    server_opts.capabilities = capabilities
                    server_opts.settings = {
                        json = {schemas = require('schemastore').json.schemas()}
                    }
                elseif server.name == "html" then
                    local capabilities = vim.lsp.protocol
                                             .make_client_capabilities()
                    capabilities.textDocument.completion.completionItem
                        .snippetSupport = true
                    server_opts.capabilities = capabilities
                elseif server.name == "yamlls" then
                    server_opts.settings = {yaml = {format = {enable = true}}}
                elseif server.name == "sumneko_lua" then
                    local luadev = require("lua-dev").setup()
                    luadev.settings.Lua.diagnostics = {
                        -- vim and hammerspoon globals
                        globals = {"vim", "hs"}
                    }
                    luadev.settings.Lua.workspace.library['/Applications/Hammerspoon.app/Contents/Resources/extensions/hs/'] =
                        true
                    server_opts.on_attach = -- Ignore sumneko formatter and use lua formatter because it's not working on apple silicon
                    function(client, bufnr)
                        client.server_capabilities.documentFormattingProvider =
                            false
                        client.server_capabilities
                            .documentRangeFormattingProvider = false
                        common_on_attach(client, bufnr)
                    end
                    server_opts.settings = luadev.settings
                elseif server.name == "cssls" then
                    local capabilities = vim.lsp.protocol
                                             .make_client_capabilities()
                    capabilities.textDocument.completion.completionItem
                        .snippetSupport = true
                    server_opts.capabilities = capabilities
                elseif server.name == "solargraph" then
                    server_opts.cmd = {
                        os.getenv("HOME") .. "/.asdf/shims/bundle", "exec",
                        "solargraph", "stdio"
                    }
                elseif server.name == "jdtls" then
                    -- Currently, jdtls latest version is not allowing Java 11 to be used
                    -- To allow Java 11 to be used, we need to use the jdtls version the version that is supported
                    -- To do so:
                    --   :LspInstall jdtls@1.9.0-202203031534
                    -- ref: https://github.com/williamboman/nvim-lsp-installer/issues/763
                    server_opts.use_lombok_agent = true
                    server_opts.root_dir = function()
                        return vim.fn.getcwd()
                    end
                    local workspace = os.getenv("HOME") .. "/.java-workspace"
                    server_opts.workspace = workspace
                    server_opts.vmargs = {"-data", workspace}
                elseif server_name == "rust_analyzer" then
                    -- autoimport allows classes to be imported upon completion
                    --   Requires additionalTextEdits in neovim to work properly
                    --     source: https://rust-analyzer.github.io/manual.html#completion-with-autoimport
                    --   TODO: I can use the workaround in this issue
                    --     https://github.com/neovim/neovim/issues/12310
                    server_opts.settings = {
                        ["rust-analyzer"] = {
                            completion = {autoimport = {enable = true}}
                        }
                    }
                end
                server:setup(server_opts)
            end)
            if not server:is_installed() then
                -- Queue the server to be installed.
                server:install()
            end
        end
    end
end

return M
