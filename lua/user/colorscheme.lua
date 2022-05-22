vim.cmd [[
try
    colorscheme darkplus

    " hi PmenuSel guibg=#2A2D2E "cursor line in dropdown menu
catch /^Vim\%((\a\+)\)\=:E185/
    colorscheme default
    set background=dark
endtry
]]
