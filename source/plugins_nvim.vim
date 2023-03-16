"===========================================================
"======================= colorizer =========================
"===========================================================

lua << EOF
require('colorizer').setup()
EOF

"===========================================================
"======================= scrollbar =========================
"===========================================================

lua << EOF
require("scrollbar").setup()
EOF

"==============================================================
"======================= catppuccin ===========================
"==============================================================

let g:catppuccin_flavour = "macchiato" " latte, frappe, macchiato, mocha

lua << EOF
require("catppuccin").setup()
EOF

colorscheme catppuccin

"==============================================================
"======================= lualine ==============================
"==============================================================

lua << END
require('lualine').setup()
END
