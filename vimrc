function UseFullColorRange()
  function UseFullColorRangeInTmux()
    let &t_8f="\<Esc>[38;2;%lu;%lu;%lum"
    let &t_8b="\<Esc>[48;2;%lu;%lu;%lum"
  endfunction

  set termguicolors
  call UseFullColorRangeInTmux()
endfunction

function KeepSwapFilesInHomeDirectory()
  " https://vi.stackexchange.com/questions/177/what-is-the-purpose-of-swap-files
  set directory^=$HOME/.vim/swp//
endfunction

function ReplaceTabsWithTwoSpaces()
  function ReplaceTabsWithSpaces()
    set expandtab
  endfunction

  function SetTabWidthToTwoSpaces()
    set tabstop=2
  endfunction

  function SetVimIndentWidthToTwoSpaces()
    set shiftwidth=2
  endfunction

  function IgnoreOffsettingSpacesOnIndent()
    set shiftround " When at 3 spaces and I hit >>, go to 4, not 5.
  endfunction

  call ReplaceTabsWithSpaces()
  call SetTabWidthToTwoSpaces()
  call SetVimIndentWidthToTwoSpaces()
  call IgnoreOffsettingSpacesOnIndent()
endfunction

function ShareSystemClipboard()
  set clipboard=unnamed
endfunction

function ShowTrailingWhitespace()
  set list listchars=tab:»·,trail:·,nbsp:·
endfunction

function ShowRelativeLineNumbers()
  set number relativenumber
endfunction

function EnableSyntaxHighlighting()
  syntax enable
endfunction

function AllowBackspacingInInsertMode()
  set backspace=indent,eol,start
endfunction

function InstallThirdPartyPlugins()
  call plug#begin('~/.vim/plugged')
  Plug 'lifepillar/vim-solarized8'
  Plug 'cormacrelf/vim-colors-github'
  Plug 'christoomey/vim-tmux-navigator'
  " Plug 'christoomey/vim-tmux-runner'
  Plug 'jgdavey/tslime.vim'
  Plug 'vim-scripts/tComment'
  Plug 'janko-m/vim-test'
  Plug 'tpope/vim-fugitive'
  Plug 'prettier/vim-prettier', { 'do': 'yarn install' }
  Plug 'sbdchd/neoformat'
  Plug 'iamcco/markdown-preview.nvim', { 'do': 'cd app & yarn install'  }
  Plug 'w0rp/ale'

  " rails syntax highlighting
  Plug 'tpope/vim-rails'

  " javascript syntax highlighting
  " Plug 'pangloss/vim-javascript'
  " Plug 'isRuslan/vim-es6'
  " Plug 'leafgarland/typescript-vim'
  Plug 'peitalin/vim-jsx-typescript'

  Plug 'sheerun/vim-polyglot'
  Plug 'HerringtonDarkholme/yats.vim'
  Plug 'morhetz/gruvbox'
  " Plug 'pangloss/vim-javascript'
  " Plug 'mxw/vim-jsx'
  " Plug 'leafgarland/typescript-vim'

  " Plug 'yuezk/vim-js'
  " Plug 'maxmellon/vim-jsx-pretty'

  Plug 'elmcast/elm-vim'
  Plug 'elixir-editors/vim-elixir'
  Plug 'mhinz/vim-mix-format'
  Plug 'keith/swift.vim'

  Plug 'iamcco/markdown-preview.nvim', { 'do': 'cd app & yarn install'  }

  " rescript
  Plug 'rescript-lang/vim-rescript'
  call plug#end()

  function ConfigureVimTest()
    nnoremap <silent> <Leader>t :TestFile<CR>
    nnoremap <silent> <Leader>s :TestNearest<CR>
    nnoremap <silent> <Leader>a :TestSuite<CR>
  endfunction

  function ConfigureNeoformat()
    autocmd BufWritePre *.js,*.jsx,*.mjs,*.ts,*.tsx,*.css,*.less,*.scss,*.json,*.graphql,*.md,*.vue,*.yaml,*.html PrettierAsync
  endfunction

  function ConfigureVimMixFormat()
    let g:mix_format_on_save = 1
  endfunction

  function ConfigurePrettier()
    let g:prettier#config#print_width = 80
    let g:prettier#config#tab_width = 2
    let g:prettier#config#use_tabs = 'false'
    let g:prettier#config#single_quote = 'false'
    let g:prettier#config#bracket_spacing = 'true'
    let g:prettier#config#jsx_bracket_same_line = 'false'
    let g:prettier#config#arrow_parens = 'avoid'
    let g:prettier#config#trailing_comma = 'all'
    let g:prettier#config#parser = 'typescript'
    let g:prettier#config#semi = 'false'
    let g:prettier#autoformat = 0
  endfunction

  call ConfigureVimTest()
  call ConfigureNeoformat()
  call ConfigureVimMixFormat()
  call ConfigurePrettier()
endfunction

function UseSolarizedDarkColorScheme()
  set background=light
  colorscheme github
endfunction

function AllowCapitalizedSaveAndQuitCommands()
  " I never want :W or :Q and it's too easy to keep holding shift
  command! W w
  command! Q q
endfunction

imap jj <Esc>
let mapleader=" "
call UseFullColorRange()
call KeepSwapFilesInHomeDirectory()
call ReplaceTabsWithTwoSpaces()
call ShareSystemClipboard()
call ShowTrailingWhitespace()
call ShowRelativeLineNumbers()
call EnableSyntaxHighlighting()
call AllowBackspacingInInsertMode()
call InstallThirdPartyPlugins()
call UseSolarizedDarkColorScheme()
call AllowCapitalizedSaveAndQuitCommands()

" configure t-slime
" for whatever reason, this does not work if placed in a vim function
let test#strategy = "tslime"
let g:tslime_always_current_session = 1
let g:tslime_always_current_window = 1
map <leader>tv <Plug>SetTmuxVars
nnoremap <leader>r :call Send_to_Tmux("./" . @% . "\n")<CR>

let g:solarized_extra_hi_groups = 1
