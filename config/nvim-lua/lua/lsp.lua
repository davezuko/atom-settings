-- https://github.com/neovim/nvim-lspconfig
-- reference: https://raygervais.dev/articles/2021/3/neovim-lsp
local nvim_lsp=require('lspconfig')

local on_attach=function(client, bufnr)
  require('completion').on_attach()

  local function buf_set_keymap(...) vim.api.nvim_buf_set_keymap(bufnr, ...) end
  local function buf_set_option(...) vim.api.nvim_buf_set_option(bufnr, ...) end

  -- enable completion triggered by <c-x><c-o>
  buf_set_option('omnifunc', 'v:lua.vim.lsp.omnifunc')

  -- format on save
  -- if client.resolved_capabilities.document_formatting then
  --   vim.api.nvim_command [[augroup Format]] 
  --   vim.api.nvim_command [[autocmd! * <buffer>]] 
  --   vim.api.nvim_command [[autocmd BufWritePre <buffer> lua vim.lsp.buf.formatting_seq_sync()]] 
  --   vim.api.nvim_command [[augroup END]] 
  -- end
  if client.resolved_capabilities.document_formatting then
    buf_set_keymap('n', '<leader>af', '<cmd>lua vim.lsp.buf.formatting()<cr>', {noremap=true, silent=true})
  end

  -- see `:help vim.lsp.*` for documentation on any of the below functions
  buf_set_keymap('n', 'gD', '<cmd>lua vim.lsp.buf.declaration()<CR>', {noremap=true, silent=true})
  buf_set_keymap('n', 'gd', '<cmd>lua vim.lsp.buf.definition()<CR>', {noremap=true, silent=true})
  buf_set_keymap('n', 'gi', '<cmd>lua vim.lsp.buf.implementation()<CR>', {noremap=true, silent=true})
  buf_set_keymap('n', 'K', '<cmd>lua vim.lsp.buf.hover()<CR>', {noremap=true, silent=true})
  buf_set_keymap('n', '<C-k>', '<cmd>lua vim.lsp.buf.signature_help()<CR>', {noremap=true, silent=true})
  buf_set_keymap('n', '<space>wa', '<cmd>lua vim.lsp.buf.add_workspace_folder()<CR>', {noremap=true, silent=true})
  buf_set_keymap('n', '<space>wr', '<cmd>lua vim.lsp.buf.remove_workspace_folder()<CR>', {noremap=true, silent=true})
  buf_set_keymap('n', '<space>wl', '<cmd>lua print(vim.inspect(vim.lsp.buf.list_workspace_folders()))<CR>', {noremap=true, silent=true})
  buf_set_keymap('n', '<space>D', '<cmd>lua vim.lsp.buf.type_definition()<CR>', {noremap=true, silent=true})
  buf_set_keymap('n', '<space>rn', '<cmd>lua vim.lsp.buf.rename()<CR>', {noremap=true, silent=true})
  buf_set_keymap('n', 'gr', '<cmd>lua vim.lsp.buf.references()<CR>', {noremap=true, silent=true})
  buf_set_keymap('n', '<space>e', '<cmd>lua vim.lsp.diagnostic.show_line_diagnostics()<CR>', {noremap=true, silent=true})
  buf_set_keymap('n', '[d', '<cmd>lua vim.lsp.diagnostic.goto_prev()<CR>', {noremap=true, silent=true})
  buf_set_keymap('n', ']d', '<cmd>lua vim.lsp.diagnostic.goto_next()<CR>', {noremap=true, silent=true})
  -- buf_set_keymap('n', '<space>ca', '<cmd>lua vim.lsp.buf.code_action()<CR>', {noremap=true, silent=true})
  -- buf_set_keymap('n', '<space>q', '<cmd>lua vim.lsp.diagnostic.set_loclist()<CR>', {noremap=true, silent=true})
  -- buf_set_keymap('n', '<space>f', '<cmd>lua vim.lsp.buf.formatting()<CR>', {noremap=true, silent=true})
end

-- setup typescript language server
nvim_lsp.tsserver.setup({
  on_attach=function(client)
    -- disable built-in formatting so that we can use prettier instead
    client.resolved_capabilities.document_formatting=false
    on_attach(client)
  end
})


nvim_lsp.cssls.setup({
  on_attach=function(client)
    -- disable built-in formatting so that we can use prettier instead
    client.resolved_capabilities.document_formatting=false
    on_attach(client)
  end
})

-- configure servers only when a language server attaches
local servers={'tsserver', 'gopls', 'cssls'}
for _, lsp in ipairs(servers) do
  nvim_lsp[lsp].setup({
    on_attach=on_attach,
  })
end