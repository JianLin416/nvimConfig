local opt = vim.opt
opt.number = true
opt.relativenumber = true
opt.termguicolors = true
opt.foldmethod = "indent"
opt.foldlevel = 99
opt.foldenable = false

local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not vim.loop.fs_stat(lazypath) then
  vim.fn.system({
    "git",
    "clone",
    "--filter=blob:none",
    "https://github.com/folke/lazy.nvim.git",
    "--branch=stable",
    lazypath,
  })
end
vim.opt.rtp:prepend(lazypath)

vim.opt.tabstop    = 4
vim.opt.shiftwidth = 4

local opts = { noremap = true, silent = true }

vim.g.barbar_auto_setup = false

-- space+e 打开nvim-tree
vim.g.mapleader    = " "
vim.api.nvim_set_keymap('n', '<leader>e', ':NvimTreeToggle<CR>', opts)

-- space+d 显示报错
vim.api.nvim_set_keymap('n', '<leader>d', '<cmd>lua vim.diagnostic.open_float(nil, { focusable = false })<CR>', { noremap = true, silent = true })

vim.opt.guicursor = { --配置nvim的光标样式
  "i:ver25",
  "a:blinkwait700-blinkoff400-blinkon250-Cursor/lCursor",
}

require("lazy").setup("plugins") --使用lazy插件

require('lualine').setup { --使用lualine插件（底下的状态栏）
  options = { theme = 'auto' } --设置lualine的配色主题
}

require('mini.indentscope').setup()

require('barbar').setup { -- 配置缓冲区显示插件
	animation = false,
	auto_hide = true
}

require("nvim-tree").setup() --使用nvim-tree插件

require("xcodebuild").setup() --使用xcodebuild插件

require('nightfox').setup { --设置nightfox配色主题
	options = {
		transparent = true
	}
}

require('onedark').setup { -- 设置ondark配色主题
	style = 'dark',
	transparent = true
}

require('conform').setup({ --使用conform插件 保存自动格式化
	formatters_by_ft = {
		swift = { "swiftformat" },
		html = {
			"html",
			formatter_on_save = true,
		},
		css = {
			"cssls",
			formatter_on_save = true,
		},
		javascript = {
			formatters = { "volar", "ts_ls" },
			run_all_formatters = true,
			formatter_on_save = true,
		},
		typescript = {
			formatters = { "volar", "ts_ls" },
			run_all_formatters = true,
			formatter_on_save = true,
		},
		vue = {
			formatters = { "volar", "ts_ls" },
			run_all_formatters = true,
			formatter_on_save = true,
		},
    	go = {
      		"gopls",
      		format_on_save = true
    	}
	},
	format_on_save = function(bufnr)
		local ignore_filetypes = { "oil" }
		if vim.tbl_contains(ignore_filetypes, vim.bo[bufnr].filetype) then
			return
		end

		return { timeout_ms = 500, lsp_fallback = true }
	end,
	log_level = vim.log.levels.ERROR,
})

require("mason").setup({ --使用mason插件
  ui = {
    icons = {
      package_installed = "✓",
      package_pending = "➜",
      package_uninstalled = "✗"
    }
  }
})

require("mason-lspconfig").setup({ --确保已安装的lsp
	ensure_installed = {
		"volar",
		"ts_ls",
		"html",
		"cssls",
		"pyright",
		"gopls"
	}
})

local cmp = require('cmp') --使用cmp插件（代码补全）

cmp.setup({
  snippet = {
    expand = function(args)
      require('luasnip').lsp_expand(args.body) --使用luasnip作为snippet插件
    end,
  },
  mapping = cmp.mapping.preset.insert({ --配置cmp的快捷键
    ['<C-z>'] = cmp.mapping.complete(),
    ['<C-x>'] = cmp.mapping.abort(),
    ['<Tab>'] = cmp.mapping.confirm({ select = true }),
  }),
  sources = cmp.config.sources({ --配置代码补全的来源
    { name = 'nvim_lsp' },
    { name = 'luasnip' }
  }, {
    { name = 'buffer' },
  })
})

local capabilities = require('cmp_nvim_lsp').default_capabilities() --通过此变量 将lsp添加到nvim_lsp的列表中

require'lspconfig'.ts_ls.setup { --lsp ts_ls
  init_options = {
    plugins = {
      {
        name = "@vue/typescript-plugin",
        location = "/Users/lijianlin/Library/pnpm/global/5/node_modules/@vue/typescript-plugin",
        languages = {"javascript", "typescript", "vue"},
      },
    },
  },
  filetypes = {
    "javascript",
    "javascriptreact",
    "javascript.jsx",
    "typescript",
    "typescriptreact",
    "typescript.tsx",
    "vue"
  },
  single_file_support = true
}

require("lspconfig").volar.setup { --lsp volar
  capabilities = capabilities,
}

require("lspconfig").cssls.setup { --lsp css
  capabilities = capabilities,
}

require("lspconfig").html.setup { --lsp html
  capabilities = capabilities,
}

require("lspconfig").sourcekit.setup { -- lsp swift && swiftui
	capabilities = capabilities,
	filetypes = { "swift", "objective-c", "objective-cpp" },
}

require("lspconfig").pyright.setup { -- lsp python
	capabilities = capabilities,
}

require("lspconfig").gopls.setup{ -- lsp go
	capabilities = capabilities,
}

-- vim.cmd("colorscheme nordfox") --设置nvim主题
vim.cmd('colorscheme onedark')
