lua <<EOF
require'nvim-treesitter.configs'.setup {
  highlight = {
    enable = true,              -- 구문 강조 활성화
    additional_vim_regex_highlighting = false,
  },
  indent = {
    enable = true               -- 코드 자동 들여쓰기 활성화
  },
  ensure_installed = {
      "vimdoc",
      "luadoc",
      "vim",
      "lua",
      "markdown"
  }
}
EOF
