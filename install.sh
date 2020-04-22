#!/bin/bash

echo -e "\n----------------------------------------"
echo "Cleaning up existing VIM stuff."
echo "----------------------------------------"
rm -rf $HOME/.vim_backup
rm $HOME/.vimrc_backup
if [ -h $HOME/.vim ]; then
    rm -rf $HOME/.vim
    echo "Removed old .vim sym link."
fi
if [ -h $HOME/.vimrc ]; then
    rm -rf $HOME/.vimrc
    echo "Removed old .vimrc sym link."
fi
if [ -d $HOME/.vim ]; then
    mv $HOME/.vim $HOME/.vim_bak
    echo "Moved existing .vim/ to .vim_backup/."
fi
if [ -f $HOME/.vimrc ]; then
    mv $HOME/.vimrc $HOME/.vimrc_bak
    echo "Moved existing .vimrc to .vimrc_backup."
fi

mkdir $HOME/.vim

echo -e "\n----------------------------------------"
echo "Creating pathogen autoload."
echo "----------------------------------------"
git clone https://github.com/tpope/vim-pathogen.git $HOME/.vim/pathogen
mv $HOME/.vim/pathogen/autoload $HOME/.vim/autoload
rm -rf $HOME/.vim/pathogen

echo -e "\n----------------------------------------"
echo "Adding nerdtree to bundle."
echo "----------------------------------------"
git clone https://github.com/scrooloose/nerdtree.git $HOME/.vim/bundle/nerdtree

echo -e "\n----------------------------------------"
echo "Adding nerdcommenter to bundle."
echo "----------------------------------------"
git clone https://github.com/scrooloose/nerdcommenter.git $HOME/.vim/bundle/nerdcommenter

echo -e "\n----------------------------------------"
echo "Adding supertab to bundle."
echo "----------------------------------------"
git clone https://github.com/ervandew/supertab $HOME/.vim/bundle/vim-supertab

echo -e "\n----------------------------------------"
echo "Adding bufexplorer to bundle."
echo "----------------------------------------"
git clone https://github.com/markabe/bufexplorer.git $HOME/.vim/bundle/bufexplorer

echo -e "\n----------------------------------------"
echo "Adding CtrlP to bundle."
echo "----------------------------------------"
git clone https://github.com/kien/ctrlp.vim.git $HOME/.vim/bundle/ctrlp

echo -e "\n----------------------------------------"
echo "Adding closetag to bundle."
echo "----------------------------------------"
git clone https://github.com/alvan/vim-closetag $HOME/.vim/bundle/closetag

echo -e "\n----------------------------------------"
echo "Adding vim-less to bundle."
echo "----------------------------------------"
git clone https://github.com/genoma/vim-less.git $HOME/.vim/bundle/vim-less

echo -e "\n----------------------------------------"
echo "Adding lightline to bundle."
echo "----------------------------------------"
git clone https://github.com/itchyny/lightline.vim $HOME/.vim/bundle/lightline.vim

echo -e "\n----------------------------------------"
echo "Adding goyo to bundle."
echo "----------------------------------------"
git clone https://github.com/junegunn/goyo.vim $HOME/.vim/bundle/goyo.vim

echo -e "\n----------------------------------------"
echo "Adding vim-pencil to bundle."
echo "----------------------------------------"
git clone https://github.com/reedes/vim-pencil $HOME/.vim/bundle/vim-pencil

echo -e "\n----------------------------------------"
echo "Adding vim-lexical to bundle."
echo "----------------------------------------"
git clone https://github.com/reedes/vim-lexical $HOME/.vim/bundle/vim-lexical

echo -e "\n----------------------------------------"
echo "Adding vim-litecorrect to bundle."
echo "----------------------------------------"
git clone https://github.com/reedes/vim-litecorrect $HOME/.vim/bundle/vim-litecorrect

echo -e "\n----------------------------------------"
echo "Adding vimwiki to bundle."
echo "----------------------------------------"
git clone https://github.com/vimwiki/vimwiki $HOME/.vim/bundle/vimwiki

echo -e "\n----------------------------------------"
echo "Writing vimrc."
echo "----------------------------------------"
cat << "ENDFILE" > $HOME/.vimrc

" -----------------------------------------------------------------------------
"  General
" -----------------------------------------------------------------------------

set nocompatible
set history=100
set encoding=utf8
set fileencoding=utf8

filetype off
call pathogen#infect('bundle/{}')
call pathogen#helptags()

nmap :Q :q

" -----------------------------------------------------------------------------
"  Backups
" -----------------------------------------------------------------------------

if has("vms")
    set nobackup              " do not keep a backup file, use versions instead
endif

" -----------------------------------------------------------------------------
"  UI
" -----------------------------------------------------------------------------

set number
set ruler               " show the cursor position all the time
set wildmenu
set wildmode=list:longest
set hlsearch
set scrolloff=3
set mouse=a
set backspace=indent,eol,start

set showcmd             " display incomplete commands
set incsearch           " do incremental searching
set hlsearch

" -----------------------------------------------------------------------------
"  Visual Cues
" -----------------------------------------------------------------------------

filetype on                  " try to detect filetypes
filetype plugin indent on    " enable loading indent file for filetype
syntax on
colorscheme ir_black

" Set global color scheme.
let python_highlight_all = 1
if &term =~ '^\(xterm\|screen\)' && $TERM_PROGRAM != 'Apple_Terminal'
  set t_Co=256
endif
if &t_Co != 256
  let g:CSApprox_loaded=0
endif

" -----------------------------------------------------------------------------
"  Text Formatting
" -----------------------------------------------------------------------------
set tabstop=2
set softtabstop=2
set shiftwidth=2
set smarttab
set expandtab

" -----------------------------------------------------------------------------
"  Whitespace
" -----------------------------------------------------------------------------
highlight ExtraWhiteSpace ctermbg=red guibg=red
:match ExtraWhiteSpace /\s\+$\|\t\+/
match ExtraWhitespace /\s\+$\|\t\+/

" -----------------------------------------------------------------------------
"  Autocommands
" -----------------------------------------------------------------------------
" Only do this part when compiled with support for autocommands.
if has("autocmd")
    autocmd BufWritePre * :%s/\s\+$//e
    autocmd colorscheme * highlight ExtraWhitespace ctermbg=red guibg=red

    " Put these in an autocmd group, so that we can delete them easily.
    augroup vimrcEx
        au!

        " For all text files set 'textwidth' to 78 characters.
        autocmd FileType text setlocal textwidth=78

        " When editing a file, jump to the last known cursor position.
        autocmd BufReadPost *
                    \ if line("'\"") > 0 && line("'\"") <= line("$") |
                    \   exe "normal g`\"" |
                    \ endif
    augroup END
endif

" -----------------------------------------------------------------------------
"  Variables
" -----------------------------------------------------------------------------

let mapleader=","

" -----------------------------------------------------------------------------
"  Mappings
" -----------------------------------------------------------------------------

" working directory follows current file
map Q gq

" these require the NERD_comments modules
map ,c <leader>cl
map ,d <leader>cu

" execute file being edited with <Shift> + e:
map <buffer> <S-e> :w<CR>:!/usr/bin/env python % <CR>

" map window movement commands
map <c-j> <c-w>j
map <c-k> <c-w>k
map <c-l> <c-w>l
map <c-h> <c-w>h

" bufexplorer
nnoremap - :BufExplorer<cr>

" ctrlp
let g:ctrlp_map = '<c-p>'
let g:ctrlp_cmd = 'CtrlP'
let g:ctrlp_custom_ignore = 'node_modules'

" NERDTree
nmap <silent> <c-n> :NERDTreeToggle<CR>
let NERDTreeIgnore          = ['\.pyc$','\.swp$']
let NERDTreeWinPos          = 'right'
let NERDTreeSplitVertical   = 1
let NERDTreeChDirMode       = 2
let NERDTreeShowBookmarks   = 1
let NERDTreeShowHidden      = 1

" closetag
let g:closetag_filenames = "*.html"

" supertab
let g:SuperTabDefaultCompletionType = '<c-x><c-o>'

" turn off beeping
set noerrorbells visualbell t_vb=

" nice status with lightline
set laststatus=2

" set up vim for long-form writing
augroup pencil
  autocmd!
  autocmd FileType markdown,mkd call pencil#init({'wrap': 'hard', 'autoformat': 0})
                            \ | call lexical#init()
                            \ | call litecorrect#init()
augroup END

let g:vimwiki_list = [{'path': '~/Documents/src/wiki/', 'syntax': 'markdown', 'ext': '.md', 'auto_tags': 1}]

ENDFILE

echo "Writing colors."
echo "----------------------------------------"
mkdir $HOME/.vim/colors
cat << EOF > $HOME/.vim/colors/ir_black.vim
" ir_black color scheme
" More at: http://blog.infinitered.com/entries/show/8


" ********************************************************************************
" Standard colors used in all ir_black themes:
" Note, x:x:x are RGB values
"
"  normal: #f6f3e8
"
"  string: #A8FF60  168:255:96
"    string inner (punc, code, etc): #00A0A0  0:160:160
"  number: #FF73FD  255:115:253
"  comments: #7C7C7C  124:124:124
"  keywords: #96CBFE  150:203:254
"  operators: white
"  class: #FFFFB6  255:255:182
"  method declaration name: #FFD2A7  255:210:167
"  regular expression: #E9C062  233:192:98
"    regexp alternate: #FF8000  255:128:0
"    regexp alternate 2: #B18A3D  177:138:61
"  variable: #C6C5FE  198:197:254
"
" Misc colors:
"  red color (used for whatever): #FF6C60   255:108:96
"     light red: #FFB6B0   255:182:176
"
"  brown: #E18964  good for special
"
"  lightpurpleish: #FFCCFF
"
" Interface colors:
"  background color: black
"  cursor (where underscore is used): #FFA560  255:165:96
"  cursor (where block is used): white
"  visual selection: #1D1E2C
"  current line: #151515  21:21:21
"  search selection: #07281C  7:40:28
"  line number: #3D3D3D  61:61:61


" ********************************************************************************
" The following are the preferred 16 colors for your terminal
"           Colors      Bright Colors
" Black     #4E4E4E     #7C7C7C
" Red       #FF6C60     #FFB6B0
" Green     #A8FF60     #CEFFAB
" Yellow    #FFFFB6     #FFFFCB
" Blue      #96CBFE     #FFFFCB
" Magenta   #FF73FD     #FF9CFE
" Cyan      #C6C5FE     #DFDFFE
" White     #EEEEEE     #FFFFFF


" ********************************************************************************
set background=dark
hi clear

if exists("syntax_on")
  syntax reset
endif

let colors_name = "ir_black"


"hi Example         guifg=NONE        guibg=NONE        gui=NONE      ctermfg=NONE        ctermbg=NONE

" General colors
hi Normal           guifg=#f6f3e8     guibg=black       gui=NONE      ctermfg=NONE        ctermbg=NONE
hi NonText          guifg=#070707     guibg=black       gui=NONE      ctermfg=black       ctermbg=NONE

hi Cursor           guifg=black       guibg=white       gui=NONE      ctermfg=black       ctermbg=white       cterm=reverse
hi LineNr           guifg=#3D3D3D     guibg=black       gui=NONE      ctermfg=darkgray    ctermbg=NONE

hi VertSplit        guifg=#202020     guibg=#202020     gui=NONE      ctermfg=darkgray    ctermbg=NONE
hi StatusLine       guifg=#CCCCCC     guibg=#202020     gui=italic    ctermfg=darkgray    ctermbg=white
hi StatusLineNC     guifg=black       guibg=#202020     gui=NONE      ctermfg=darkgray    ctermbg=NONE

hi Folded           guifg=#a0a8b0     guibg=#384048     gui=NONE      ctermfg=NONE        ctermbg=NONE
hi Title            guifg=#f6f3e8     guibg=NONE        gui=bold      ctermfg=NONE        ctermbg=NONE
hi Visual           guifg=NONE        guibg=#262D51     gui=NONE      ctermfg=white        ctermbg=darkgray    cterm=NONE

hi SpecialKey       guifg=#808080     guibg=#343434     gui=NONE      ctermfg=NONE        ctermbg=NONE

hi WildMenu         guifg=green       guibg=yellow      gui=NONE      ctermfg=black       ctermbg=yellow
hi PmenuSbar        guifg=black       guibg=white       gui=NONE      ctermfg=black       ctermbg=white
hi Ignore           guifg=grey        guibg=black       gui=NONE      ctermfg=NONE        ctermbg=NONE

hi Error            guifg=#FF6360     guibg=NONE        gui=NONE      ctermfg=red         ctermbg=NONE        guisp=#FF6360 " undercurl color
hi SpellBad         guifg=#FF6360     guibg=NONE        gui=NONE      ctermfg=red         ctermbg=NONE        guisp=#FF6360 " undercurl color
hi ErrorMsg         guifg=white       guibg=#FF6C60     gui=BOLD      ctermfg=white       ctermbg=red
hi WarningMsg       guifg=white       guibg=#FF6C60     gui=BOLD      ctermfg=black       ctermbg=yellow

" Message displayed in lower left, such as --INSERT--
hi ModeMsg          guifg=black       guibg=#C6C5FE     gui=BOLD      ctermfg=black       ctermbg=cyan        cterm=BOLD

if version >= 700 " Vim 7.x specific colors
  hi CursorLine     guifg=NONE        guibg=#121212     gui=NONE      ctermfg=NONE        ctermbg=NONE        cterm=BOLD
  hi CursorColumn   guifg=NONE        guibg=#121212     gui=NONE      ctermfg=NONE        ctermbg=NONE        cterm=BOLD
  hi MatchParen     guifg=#f6f3e8     guibg=#857b6f     gui=BOLD      ctermfg=white       ctermbg=darkgray
  hi Pmenu          guifg=#f6f3e8     guibg=#444444     gui=NONE      ctermfg=NONE        ctermbg=NONE
  hi PmenuSel       guifg=#000000     guibg=#cae682     gui=NONE      ctermfg=NONE        ctermbg=NONE
  hi Search         guifg=NONE        guibg=NONE        gui=underline ctermfg=NONE        ctermbg=NONE        cterm=underline
endif

" Syntax highlighting
hi Comment          guifg=#7C7C7C     guibg=NONE        gui=NONE      ctermfg=darkgray    ctermbg=NONE
hi String           guifg=#A8FF60     guibg=NONE        gui=NONE      ctermfg=green       ctermbg=NONE
hi Number           guifg=#FF73FD     guibg=NONE        gui=NONE      ctermfg=magenta     ctermbg=NONE

hi Keyword          guifg=#96CBFE     guibg=NONE        gui=NONE      ctermfg=blue        ctermbg=NONE
hi PreProc          guifg=#96CBFE     guibg=NONE        gui=NONE      ctermfg=blue        ctermbg=NONE
hi Conditional      guifg=#6699CC     guibg=NONE        gui=NONE      ctermfg=blue        ctermbg=NONE          " if else end

hi Todo             guifg=#FF6360     guibg=NONE        gui=NONE      ctermfg=red         ctermbg=NONE
hi Constant         guifg=#99CC99     guibg=NONE        gui=NONE      ctermfg=cyan        ctermbg=NONE

hi Identifier       guifg=#C6C5FE     guibg=NONE        gui=NONE      ctermfg=cyan        ctermbg=NONE
hi Function         guifg=#FFD2A7     guibg=NONE        gui=NONE      ctermfg=brown       ctermbg=NONE
hi Type             guifg=#FFFFB6     guibg=NONE        gui=NONE      ctermfg=yellow      ctermbg=NONE
hi Statement        guifg=#6699CC     guibg=NONE        gui=NONE      ctermfg=lightblue   ctermbg=NONE

hi Special          guifg=#E18964     guibg=NONE        gui=NONE      ctermfg=white       ctermbg=NONE
hi Delimiter        guifg=#00A0A0     guibg=NONE        gui=NONE      ctermfg=cyan        ctermbg=NONE
hi Operator         guifg=#96CBFE     guibg=NONE        gui=NONE      ctermfg=blue        ctermbg=NONE
hi ColorColumn      guifg=#000000     guibg=#303030     gui=NONE      ctermfg=black       ctermbg=236

hi link Character       Constant
hi link Boolean         Constant
hi link Float           Number
hi link Repeat          Statement
hi link Label           Statement
hi link Exception       Statement
hi link Include         PreProc
hi link Define          PreProc
hi link Macro           PreProc
hi link PreCondit       PreProc
hi link StorageClass    Type
hi link Structure       Type
hi link Typedef         Type
hi link Tag             Special
hi link SpecialChar     Special
hi link SpecialComment  Special
hi link Debug           Special


" Special for Ruby
hi rubyRegexp                  guifg=#B18A3D      guibg=NONE      gui=NONE      ctermfg=brown          ctermbg=NONE
hi rubyRegexpDelimiter         guifg=#FF8000      guibg=NONE      gui=NONE      ctermfg=brown          ctermbg=NONE
hi rubyEscape                  guifg=white        guibg=NONE      gui=NONE      ctermfg=cyan           ctermbg=NONE
hi rubyInterpolationDelimiter  guifg=#00A0A0      guibg=NONE      gui=NONE      ctermfg=blue           ctermbg=NONE
hi rubyControl                 guifg=#6699CC      guibg=NONE      gui=NONE      ctermfg=blue           ctermbg=NONE        "and break, etc
"hi rubyGlobalVariable          guifg=#FFCCFF      guibg=NONE      gui=NONE      ctermfg=lightblue      ctermbg=NONE        "yield
hi rubyStringDelimiter         guifg=#336633      guibg=NONE      gui=NONE      ctermfg=lightgreen     ctermbg=NONE
"rubyInclude
"rubySharpBang
"rubyAccess
"rubyPredefinedVariable
"rubyBoolean
"rubyClassVariable
"rubyBeginEnd
"rubyRepeatModifier
"hi link rubyArrayDelimiter    Special  " [ , , ]
"rubyCurlyBlock  { , , }

hi link rubyClass             Keyword
hi link rubyModule            Keyword
hi link rubyKeyword           Keyword
hi link rubyOperator          Operator
hi link rubyIdentifier        Identifier
hi link rubyInstanceVariable  Identifier
hi link rubyGlobalVariable    Identifier
hi link rubyClassVariable     Identifier
hi link rubyConstant          Type


" Special for Java
" hi link javaClassDecl    Type
hi link javaScopeDecl         Identifier
hi link javaCommentTitle      javaDocSeeTag
hi link javaDocTags           javaDocSeeTag
hi link javaDocParam          javaDocSeeTag
hi link javaDocSeeTagParam    javaDocSeeTag

hi javaDocSeeTag              guifg=#CCCCCC     guibg=NONE        gui=NONE      ctermfg=darkgray    ctermbg=NONE
hi javaDocSeeTag              guifg=#CCCCCC     guibg=NONE        gui=NONE      ctermfg=darkgray    ctermbg=NONE
"hi javaClassDecl              guifg=#CCFFCC     guibg=NONE        gui=NONE      ctermfg=white       ctermbg=NONE


" Special for XML
hi link xmlTag          Keyword
hi link xmlTagName      Conditional
hi link xmlEndTag       Identifier


" Special for HTML
hi link htmlTag         Keyword
hi link htmlTagName     Conditional
hi link htmlEndTag      Identifier


" Special for Javascript
hi link javaScriptNumber      Number


" Special for Python
hi  link pythonEscape         Keyword
hi  link pythonSymbol         Operator
hi  link pythonDottedName     Special
hi  link pythonDecorator      Identifier
hi  link pythonDot            Identifier
hi  link pythonParen          Identifier


" Special for CSharp
hi  link csXmlTag             Keyword


" Special for PHP

EOF

