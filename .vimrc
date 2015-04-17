" .vimrc

syntax on               " Use syntax hilighting
set nocompatible	" Use Vim defaults, as opposed to Vi defaults
set bs=indent,eol,start	" Allow backspacing over everything in insert mode
set viminfo='20,<5000	" Store ' filesworth of marks and < lines in each register in the .viminfo file
set history=5000	" Keep this many lines of command line history
set ruler		" Show the cursor position all the time, bottom right corner of the screen
set nowrap              " Do not wrap lines
set shiftwidth=2        " Number of spaces to use for each autoindent, by default
set shiftround          " Round indentation to a multiple of shiftwidth, e.g. when using >>
set expandtab           " Expand tabs to spaces, by default
set autoindent          " Keep indentation when starting a new line
set formatoptions-=t    " t: auto-wrap using textwidth, but not comments
set lcs=tab:○─,eol:●,nbsp:◇ " visible tabs and eols when :set list
set ignorecase          " Ignore case during search, /?
set smartcase           " Override ignorecase if search contains upper case characters
set incsearch           " Show search matches while typing
set hlsearch            " Hilight all matches when searching
set gdefault            " When substituting, the g flag is on by default
set cot=menuone,preview " ^X^O should open scratch window even if there is only one match
set whichwrap=~,[,]     " List of left-right movements that are allow to wrap lines, [ and ] mean arrow keys in insert mode
set matchpairs+=<:>     " Make <...> work with the %, brace matching command
set virtualedit=block   " Allow selecting beyond ends of lines in visual block mode
set nocsverb            " Stop complaining 'duplicate cscope database not added'
set nowrapscan          " Do not search past the end of the file
set title               " Sets the title on the term window
set nrformats=          " Only allow base10 numbers with ctrl-a and -x, don't trim my leading zeros
set mouse=a             " enable mouse always. Hint: use Shift+Click to send clicks to terminal emu)
set guioptions-=m       " remove menu
set guioptions-=T       " remove toolbar
set gfn=Monospace\ 12   " GUI font
set ttyfast             " send more text to the screen faster
set cpo+=$              " delay erasing the changed text when using c commands
set isfname=@,48-57,/,.,-,_,~ " file names can contain alphas (@), numbers (48-57), and some puncts
set cino=L0,:0,l1       " (L) Jump labels at +0 columns, (:) case labels at +0 columns, (l) non-stupid after case labels
set background=dark     " This is just a hint for Vim, it doesn't change the color
set sessionoptions-=options " Sessions do NOT save options
set scrolloff=5         " Can't get any closer to the top/bottom of the screen
set autoread            " Automatically re-read when buffer has no change, but file on disk DOES change
set nofoldenable        " No folding by default

augroup vimrc
  autocmd!
augroup END

let g:PHP_vintage_case_default_indent = 1
let g:PHP_default_indenting = 1

" PIV PHP Integration for Vim
let g:DisableAutoPHPFolding = 1
let g:PIVCreateDefaultMappings = 0

" Git Gutter
let g:gitgutter_sign_added = '+ '
let g:gitgutter_sign_modified = '𝚫 '
let g:gitgutter_sign_removed = '↷ '
let g:gitgutter_sign_modified_removed = 'Ⴕ '
nnoremap <leader>g :GitGutterPreviewHunk<CR>

" for gf and related, search in file's dir, then cwd, then file's dir's parents, then cwd's parents
set path=.,,.;,;,/usr/include/SDL2

" ignore leading slash when using gf
nnoremap gf :exe 'find' substitute(expand('<cfile>'), '^/', '', '')<CR>

" better for airline
set laststatus=2 " Always display the statusline in all windows
set noshowmode " Hide the default mode text (e.g. -- INSERT -- below the statusline)

" airline!
if $TERM_PROGRAM == 'Apple_Terminal'
  let g:airline#left_sep = ' '
  let g:airline#left_alt_sep = '|'
  let g:airline_left_sep = ''
  let g:airline_left_alt_sep = '|'
  let g:airline_right_sep = ''
  let g:airline_right_alt_sep = '|'
else
  let g:airline_powerline_fonts=1
endif
let g:airline_detect_modified=1
let g:airline_detect_paste=1
let g:airline#extensions#whitespace#enabled=1
let g:airline_theme='powerlineish'

" Don't let yankstack touch Y or S
let g:yankstack_yank_keys = ['c', 'C', 'd', 'D', 's', 'x', 'X', 'y']

" Figure out files' indentation patterns automatically
let g:detectindent_preferred_expandtab = 1
let g:detectindent_preferred_indent = 2


" get out of insert mode faster
autocmd vimrc InsertEnter * set timeoutlen=150
autocmd vimrc InsertLeave * set timeoutlen=1000

" when does wundo and rundo become available?
if version >= 703
  set undodir=~/.vim/undo " location to store undofiles

  " Always write undo history, but only read it on command
  " use <leader>u to load old undo info!
  " modified from example in :help undo-persistence
  nnoremap <leader>u :call ReadUndo()<CR>
  au BufWritePost * call WriteUndo()
  func! ReadUndo()
    let undofile = undofile(expand('%'))
    if filereadable(undofile)
      let undofile = escape(undofile,'% ')
      exec "rundo " . undofile
    endif
  endfunc
  func! WriteUndo()
    let undofile = escape(undofile(expand('%')),'% ')
    exec "wundo " . undofile
  endfunc

  set conceallevel=1      " Conceal text where syntax rules say to
  set concealcursor=niv   " Even conceal text while the cursor is on the same line, in normal, insert, visual
endif

"NeoBundle Scripts-----------------------------
set runtimepath+=$HOME/.vim/bundle/neobundle.vim/
call neobundle#begin(expand('$HOME/.vim/bundle'))

" Let NeoBundle manage NeoBundle
" Required:
NeoBundleFetch 'Shougo/neobundle.vim'

" Add or remove your Bundles here:
NeoBundle 'tpope/vim-repeat'
NeoBundle 'tpope/vim-fugitive'
NeoBundle 'tpope/vim-surround'
NeoBundle 'tpope/vim-commentary'
NeoBundle 'ctrlpvim/ctrlp.vim'
NeoBundle 'flazz/vim-colorschemes'
NeoBundle 'maxbrunsfeld/vim-yankstack'
NeoBundle 'superjer/modefiles'
NeoBundle 'scrooloose/syntastic'
NeoBundle 'superjer/vim-airline'
NeoBundle 'airblade/vim-gitgutter'
NeoBundle 'dietsche/vim-lastplace'
NeoBundle 'haya14busa/incsearch.vim'
NeoBundle 'ciaranm/detectindent'
NeoBundle 'kergoth/vim-hilinks'
NeoBundle 'ervandew/supertab'
"NeoBundle 'vim-scripts/swap-parameters'

" Removed when changing to NeoBundle. Add back?
"DidYouMean
"PIV "fix-PIV.sh
"neomake
"vdebug
"vim-enhanced-diff

" Required:
call neobundle#end()

" If there are uninstalled bundles found on startup,
" this will conveniently prompt you to install them.
NeoBundleCheck
"End NeoBundle Scripts-------------------------

" map only if incsearch plugin is loaded!
if version >= 703 && exists('g:loaded_incsearch')
  map /  <Plug>(incsearch-forward)
  map ?  <Plug>(incsearch-backward)
  map g/ <Plug>(incsearch-stay)
endif

" Load matchit.vim, but only if the user hasn't installed a newer version.
if !exists('g:loaded_matchit') && findfile('plugin/matchit.vim', &rtp) ==# ''
  runtime! macros/matchit.vim
endif

set t_Co=256
colorscheme molokai
hi RegexSpecial ctermfg=9
hi RegexClass ctermfg=10
hi RegexWhack ctermfg=12
hi Special ctermbg=none ctermfg=93
hi Statement ctermfg=220
hi Identifier ctermfg=255
hi PreProc ctermfg=220
hi Operator ctermfg=196
hi Type ctermfg=220
hi String ctermfg=45
hi Comment ctermfg=93
hi Constant ctermfg=82
hi Conditional ctermfg=197
hi SpecialChar ctermfg=197
hi Number ctermfg=82
hi LineNr ctermfg=232 ctermbg=236
hi NonText cterm=none ctermfg=1 ctermbg=16
hi Search term=none ctermfg=255 ctermbg=202
hi Todo ctermbg=93
hi DiffAdded ctermfg=82
hi javaScript ctermfg=255
hi Folded ctermbg=235 ctermfg=232

" Yankstack
let g:yankstack_map_keys = 0
nmap <C-P> <Plug>yankstack_substitute_older_paste
nmap <C-N> <Plug>yankstack_substitute_newer_paste

" Syntastic
"set statusline+=%#warningmsg#
"set statusline+=%{SyntasticStatuslineFlag()}
"set statusline+=%*
let g:syntastic_enable_signs=1
let g:syntastic_auto_loc_list=1
let g:syntastic_disabled_filetypes=["c","cpp","javascript","js","json","css"]
let g:loaded_syntastic_php_phpcs_checker=1 "no codesniffer, pls
let g:syntastic_c_include_dirs = [
      \'$HOME/SPARToR/engine',
      \'$HOME/SPARToR/game',
      \'/usr/include/SDL2',
      \'$HOME/xscreensaver-5.15/utils',
      \]

filetype on                                                   " Automatically detect file types
filetype plugin indent on                                     " Enable filetype plugins, indent plugins
autocmd vimrc FileType mail,human set formatoptions+=t textwidth=72 " Wrap mail messages to 72 chars
autocmd vimrc FileType c,cpp,slang,php,inc set cindent              " Use C-style indenting
autocmd vimrc FileType html set formatoptions+=tl                   " l: do not break long lines
autocmd vimrc FileType make set noexpandtab shiftwidth=8            " Makefiles need real tabs
autocmd vimrc FileType vim setlocal keywordprg=:help                " Vim help in vim files

" Set correct filetype when editing the current bash command line in Vim
if expand('%:t') =~?'bash-fc-\d\+'
  setfiletype sh
endif

let php_baselib = 1	" Highlight PHP funcs

" Syntax .inc files like .php
autocmd vimrc BufRead *.inc setlocal filetype=php

" Syntax .mhtm
autocmd vimrc BufRead *.mhtm setlocal filetype=mustache

" Syntax is C for .h files, NOT C++ for crying out loud
autocmd vimrc BufRead *.h setlocal filetype=c

autocmd vimrc BufRead *.wiki setlocal concealcursor=nv

" run syntax check on :mak in PHP files, and interpret errors
autocmd vimrc FileType php setlocal makeprg=php\ %
autocmd vimrc FileType php setlocal errorformat=%m\ in\ %f\ on\ line\ %l

" run python with :mak in .py files
autocmd vimrc FileType python setlocal makeprg=python\ %

" Autocomplete CSS and PHP stuff
autocmd vimrc FileType css setlocal omnifunc=csscomplete#CompleteCSS
autocmd vimrc FileType php setlocal omnifunc=phpcomplete#CompletePHP

" Fix nasty PIV defaults
function! Fix_PIV()
  unlet! php_sql_query
  unlet! php_htmlInStrings
  unlet! php_noShortTags
  unlet! php_folding
  unlet! PHP_autoformatcomment
  unlet! php_sync_method
endfunction
autocmd vimrc FileType php call Fix_PIV()

" Single Ctrl-H / Ctrl-L to switch to navigating the quickfix / location list
" Ctrl-J / Ctrl-K to jump to the next / previous quickfix or location
" Double Ctrl-H / Ctrl-L to go to the first / last quickfix or location
function! CtrlArrowForQuickfix()
  nnoremap <C-H><C-H> :cfirst<CR>
  nnoremap <C-J> :cnext<CR>
  nnoremap <C-K> :cprev<CR>
  nnoremap <C-L><C-L> :clast<CR>
  echo "Navigating Quickfix List"
endfunction
function! CtrlArrowForLocation()
  nnoremap <C-H><C-H> :lfirst<CR>
  nnoremap <C-J> :lnext<CR>
  nnoremap <C-K> :lprev<CR>
  nnoremap <C-L><C-L> :llast<CR>
  echo "Navigating Location List"
endfunction
silent call CtrlArrowForQuickfix()
nnoremap <C-H> :call CtrlArrowForQuickfix()<CR>
nnoremap <C-L> :call CtrlArrowForLocation()<CR>

" Ctrl-Q to use ctrlp
nnoremap <C-Q> :CommandT<CR>
let g:CommandTCancelMap=['<C-Q>', '<C-C>', '<Esc>']
let g:ctrlp_map = '<C-Q>'
let g:ctrlp_match_window = 'max:30'

" grxy to replace next x with y, like fxry but REPEATABLY with . thanks to repeat.vim
" Go Replace X with Y
" Stomps nearly useless gr builtin
function! ReplaceNext()
  let ch1 = nr2char(getchar())
  let ch2 = nr2char(getchar())
  exec "normal! f" . ch1 . "r" . ch2
  silent! call repeat#set("gr" . ch1 . ch2)
endfu
nnoremap gr :cal ReplaceNext()<CR>

function! InsertOnce(iora)
  let ch = nr2char(getchar())
  exec "normal! " . a:iora . ch
  silent! call repeat#set(a:iora . ch . "\e")
endfu

" -X to insert X, +X to append X
nnoremap - :cal InsertOnce("i")<CR>
nnoremap + :cal InsertOnce("a")<CR>

"Prevent a command from stomping the redo . command
function! ForgetNormal(chr) range
  exec "normal! ".a:chr
endfu

" Spacebar inserts a single space, no redo
nnoremap <space> :cal ForgetNormal("i \el")<CR>

" Insert spaces on multiple during block selection, and keep selection, no redo
vnoremap <space> :cal ForgetNormal("gvI \egvlolo")<CR>

" Backspace removes all extraneous spaces on the line(s)
vnoremap <BS> :<C-U>let lol=@/<CR>:<C-U>let omg=&hls<CR>:<C-U>let &hls=0<CR>:'<,'>s/\v([^ ] ) +\|$/\1/<CR>:'<,'>s/\v *$/<CR>:let &hls=omg<CR>:let @/=lol<CR>
nnoremap <BS> :let lol=@/<CR>:let omg=&hls<CR>:let &hls=0<CR>:s/\v([^ ] ) +\|$/\1/<CR>:s/\v *$/<CR>:let &hls=omg<CR>:let @/=lol<CR>

func! PhpColors()
  syn match phpOperatorS "\$" contained display
  syn match phpParentS "[({[\]})]" contained
  syn match phpMemberSelectorS "->"  contained display
  syn match phpVarSelectorS "\$" contained display
  syn match phpNumberS "-\=\<\d\+\>" contained display
  syn match phpNumberS "\<0x\x\{1,8}\>"  contained display
  syn match phpFloatS  "\(-\=\<\d+\|-\=\)\.\d\+\>" contained display
  syn match phpSuperGlobal "\$\(GLOBALS\|_SERVER\|_GET\|_POST\|_FILES\|_COOKIE\|_SESSION\|_REQUEST\|_ENV\)" containedin=phpRegion display contains=phpOperator,phpVarSelector

  " Identifier
  syn match phpIdentifierS "$\h\w*"  contained contains=phpEnvVar,phpIntVar,phpVarSelectorS display
  syn match phpIdentifierSimply "${\h\w*}"  contains=phpOperatorS,phpParentS  contained display
  syn region  phpIdentifierComplex  matchgroup=phpParentS start="{\$"rs=e-1 end="}"  contains=phpIdentifierS,phpMemberSelectorS,phpVarSelectorS,phpIdentifierComplexP contained extend
  syn region  phpIdentifierComplexP matchgroup=phpParentS start="\[" end="]" contains=@phpClInsideS contained

  " String
  if exists("php_parent_error_open")
    syn region  phpStringDouble  matchgroup=phpQuote  start=+"+ skip=+\\\\\|\\"+ end=+"+  contains=phpIdentifierS,phpSpecialChar,phpIdentifierSimply,phpIdentifierComplex,phpBackslashSequences contained keepend
    syn region  phpStringDoubleS matchgroup=phpQuoteS start=+"+ skip=+\\\\\|\\"+ end=+"+  contains=phpIdentifierS,phpSpecialChar,phpIdentifierSimply,phpIdentifierComplex,phpBackslashSequences contained keepend
    syn region  phpBacktick      matchgroup=None      start=+`+ skip=+\\\\\|\\"+ end=+`+  contains=phpIdentifierS,phpSpecialChar,phpIdentifierSimply,phpIdentifierComplex,phpBackslashSequences contained keepend
    syn region  phpStringSingle  matchgroup=phpQuote  start=+'+ skip=+\\\\\|\\'+ end=+'+  contains=@phpAddStrings contained keepend
    syn region  phpStringSingleS matchgroup=phpQuoteS start=+'+ skip=+\\\\\|\\'+ end=+'+  contained keepend
  else
    syn region  phpStringDouble  matchgroup=phpQuote  start=+"+ skip=+\\\\\|\\"+ end=+"+  contains=phpIdentifierS,phpSpecialChar,phpIdentifierSimply,phpIdentifierComplex,phpBackslashSequences contained extend keepend
    syn region  phpStringDoubleS matchgroup=phpQuoteS start=+"+ skip=+\\\\\|\\"+ end=+"+  contains=phpIdentifierS,phpSpecialChar,phpIdentifierSimply,phpIdentifierComplex,phpBackslashSequences contained extend keepend
    syn region  phpBacktick      matchgroup=None      start=+`+ skip=+\\\\\|\\"+ end=+`+  contains=phpIdentifierS,phpSpecialChar,phpIdentifierSimply,phpIdentifierComplex,phpBackslashSequences contained extend keepend
    syn region  phpStringSingle  matchgroup=phpQuote  start=+'+ skip=+\\\\\|\\'+ end=+'+  contains=@phpAddStrings contained keepend extend
    syn region  phpStringSingleS matchgroup=phpQuoteS start=+'+ skip=+\\\\\|\\'+ end=+'+  contained keepend extend
  endif

  syn cluster phpClConstS  contains=phpFunctions,phpIdentifierS,phpConditional,phpRepeat,phpStatement,phpOperator,phpRelation,phpStringSingleS,phpStringDoubleS,phpBacktick,phpNumberS,phpFloatS,phpKeyword,phpType,phpBoolean,phpStructure,phpMethodsVar,phpConstant,phpCoreConstant,phpException
  syn cluster phpClInsideS contains=@phpClConstS,phpComment,phpLabel,phpParent,phpParentError,phpInclude,phpHereDoc

  syn match phpMethodsVarS "->\h\w*" contained contains=phpMethods,phpMemberSelectorS display containedin=phpStringDouble
  syn match phpParentC "[{}]" contained display containedin=phpParent
  syn match phpParentP "[()]" contained display containedin=phpParent
  syn match phpParentB "[][]" contained display containedin=phpParent

  hi link phpMethodsVar Identifier
  hi link phpLabel Repeat
  hi phpParentP ctermfg=202
  hi phpParentB ctermfg=82
  hi phpSuperGlobal ctermfg=196
  hi phpIdentifierS ctermfg=13
  hi phpMethodsVarS ctermfg=13
  hi phpParentS ctermfg=5
  hi phpStringSingleS ctermfg=13
  hi phpStringDoubleS ctermfg=13
  hi phpQuote ctermfg=15
  hi phpQuoteS ctermfg=15
  hi phpBackslashSequences ctermfg=10

  hi phpRegion ctermfg=255
  hi phpFunctions ctermfg=202

  " Conceal ugly multi-char sequences with wacky unicode chars
  syn match phpArrow "->" contained containedin=phpMemberSelector,phpMemberSelectorS display
  syn match phpDblArrow "=>" contained containedin=phpOperator display
  syn match phpLTE "<=" contained containedin=phpComparison display
  syn match phpGTE ">=" contained containedin=phpComparison display
  syn match phpNE "!=" contained containedin=phpComparison display
  if version >= 703
    syn match ArrowTail contained containedin=phpArrow "-" display conceal cchar=─ transparent
    syn match ArrowHead contained containedin=phpArrow ">" display conceal cchar=▶ transparent
    syn match DblArrowTail contained containedin=phpDblArrow "=" display conceal cchar=═
    syn match DblArrowHead contained containedin=phpDblArrow ">" display conceal cchar=▶
    syn match LTELess contained containedin=phpLTE "<" display conceal cchar=
    syn match LTEEqual contained containedin=phpLTE "=" display conceal cchar=
    syn match GTELess contained containedin=phpGTE ">" display conceal cchar=
    syn match GTEEqual contained containedin=phpGTE "=" display conceal cchar=
    syn match NENot contained containedin=phpNE "!" display conceal cchar=
    syn match NEEqual contained containedin=phpNE "=" display conceal cchar=
    syn match phpDollar '\$' contained containedin=phpVarSelector,phpVarSelectorS cchar=⌁ conceal
    hi Conceal ctermfg=196 ctermbg=233
  endif

  " Make literal wacky unicode characters obvious!
  hi Fake ctermfg=255 ctermbg=196
  syn match FakeArrow "─▶" contained containedin=phpRegion display
  hi link FakeArrow Fake
  syn match FakeDblArrow "═▶" contained containedin=phpRegion display
  hi link FakeDblArrow Fake
  syn match FakeComp "[≤≥≠ ]" contained containedin=phpRegion display
  hi link FakeComp Fake

  "hi MatchParen cterm=none ctermfg=9 ctermbg=7

  syn match TrailingWS '\s\+$' contained containedin=phpRegion
  hi TrailingWS ctermbg=darkred
endfun

autocmd vimrc FileType php call PhpColors()

" Make vimL look a bit better
autocmd vimrc FileType vim hi Statement ctermfg=202

function! CColors()
  syn region cBracket transparent matchgroup=cBracketX start='\[\|<::\@!' end=']\|:>' contains=ALLBUT,@cParenGroup,cErrInParen,cCppParen,cCppBracket,cCppString,@Spell
  syn match cParenX '[()]'

  " Make literal wacky unicode characters obvious!
  syn match FakeComp "[≤≥≠ ]" contained containedin=Region display
  hi link FakeComp Fake

  if version >= 703
    syn match ArrowHead contained ">" conceal cchar=▶
    syn match ArrowTail contained "-" conceal cchar=─
    syn match LTELess   contained "<" conceal cchar=
    syn match LTEEqual  contained "=" conceal cchar=
    syn match GTELess   contained ">" conceal cchar=
    syn match GTEEqual  contained "=" conceal cchar=
    syn match NENot     contained "!" conceal cchar=
    syn match NEEqual   contained "=" conceal cchar=
  endif

  syn match ArrowFull "->" contains=ArrowHead,ArrowTail
  syn match CLTEFull  "<=" contains=LTEEqual,LTELess
  syn match CGTEFull  ">=" contains=GTEEqual,GTELess
  syn match CNEFull   "!=" contains=NENot,NEEqual

  syn cluster cParenGroup   add=ArrowTail,ArrowHead,LTEEqual,LTELess,GTEEqual,GTELess,NENot,NEEqual
  syn cluster cPreProcGroup add=ArrowTail,ArrowHead,LTEEqual,LTELess,GTEEqual,GTELess,NENot,NEEqual
  syn cluster cMultiGroup   add=ArrowTail,ArrowHead,LTEEqual,LTELess,GTEEqual,GTELess,NENot,NEEqual

  hi cBracketX    ctermfg=82
  hi cParenX      ctermfg=202
  hi Repeat       ctermfg=220
  hi Conditional  ctermfg=220
  hi Conceal      ctermfg=196 ctermbg=233
  hi Label        ctermfg=220
  hi Normal       ctermfg=255
  hi Macro        ctermfg=201
  hi PreCondit    ctermfg=202
  hi StorageClass ctermfg=202
  hi Type         ctermfg=202
  hi PreProc      ctermfg=202
  hi Character    ctermfg=82

  call Color256Hax()

  "Make brace matching look less confusing!
  hi MatchParen ctermfg=220 ctermbg=196
endfun

autocmd vimrc FileType c call CColors()

" dx command deletes up to and including a [, <, ( or { and the matching }, ), > or ]
nnoremap dx :<C-u>cal DelToBraceAndMatch()<CR>

function! DelToBraceAndMatch()
  let start = col(".")
  let end = 99999
  exec "normal! f{" | if start != col(".") && col(".") < end | let end = col(".") | endif | exec "normal! " . start . "|"
  exec "normal! f(" | if start != col(".") && col(".") < end | let end = col(".") | endif | exec "normal! " . start . "|"
  exec "normal! f<" | if start != col(".") && col(".") < end | let end = col(".") | endif | exec "normal! " . start . "|"
  exec "normal! f[" | if start != col(".") && col(".") < end | let end = col(".") | endif | exec "normal! " . start . "|"
  if end < 99999
    exec "normal! d" . end . "|%xx"
  endif
endfun

" Hold Ctrl and use the arrow keys to bubble selected or current line(s)
" Works with block selection horizontally

" Bubble single lines
nnoremap <C-Up>   :silent! move .-2<CR>
nnoremap <C-Down> :silent! move .+<CR>

" Bubble multiple lines
vnoremap <C-K>   :<C-U>try \| silent! '<,'>move .-2 \| exe "normal! `[V`]" \| finally \| exe "normal! gv" \| endtry<CR>
vnoremap <C-J> :<C-U>try \| silent! '<,'>move '>+ \| exe "normal! `[V`]" \| finally \| exe "normal! gv" \| endtry<CR>

" Bubble multiple lines w/ scrolling
vnoremap <C-Y>    :<C-U>try \| silent! '<,'>move .-2 \| exe "normal! `[V`]" \| finally \| exe "normal! gv" \| endtry<CR><C-Y>
vnoremap <C-E>    :<C-U>try \| silent! '<,'>move '>+ \| exe "normal! `[V`]" \| finally \| exe "normal! gv" \| endtry<CR><C-E>

" Bubble left and right
vnoremap <C-H>  d:<C-U>try \| silent! exe "normal! h" \| finally \| exe "normal! P`[<C-V><C-V>`]" \| endtry<CR>
vnoremap <C-L> dp`[<C-V>`]

autocmd vimrc BufRead *.png.txt set filetype=texdef

autocmd vimrc FileType texdef call TexDefColors()

function! TexDefColors()
  syn keyword Keyword anchor pos size cols flipx flipy floor bump
  syn match Define '\v\.(grid|also|end|skip|default)?'
  syn match Number '\v<[-+]?[0-9]+>'
  syn match Constant '\v<(ce(n|nt|nter?)?|bo(t|tt|ttom?)?|mid(d|dle?)?|top?|le(ft?)?|ri(g|ght?)?)>'
  syn match Question '\v\^'
  syn match Function '\v^\s*[a-zA-Z_][a-zA-Z_0-9]*(\s|$)'
  syn match Comment '^\s*#.*$'
endfunction

" Decide whether to syntax hilite from the top or not
function! LargeFileSmallFile()
  if line2byte(line("$")) < 10000000
    set incsearch
    syntax sync fromstart
  else
    set noincsearch
    syntax sync minlines=50
  endif
endfunction

autocmd vimrc BufReadPost * call LargeFileSmallFile()

" Make I work as expected in linewise visual mode
vnoremap I <ESC>`<<C-V>`>I

" Close the scratch window (if open) when exiting insert mode (but not for the
" command window (or any vimscript buffer really))
autocmd vimrc InsertLeave * if pumvisible() == 0|silent! pclose|endif

" Adjustment for 256 color terms
function! Color256Hax()
  if &t_Co == 256
    " Spiffy colors for vimdiff / folding
    highlight DiffAdd        cterm=none            ctermbg=17
    highlight DiffDelete     cterm=none ctermfg=52 ctermbg=52
    highlight DiffChange     cterm=none            ctermbg=234
    highlight DiffText       cterm=none            ctermbg=17
    highlight Folded         term=standout ctermfg=0 ctermbg=7
    highlight FoldColumn     term=standout cterm=bold,reverse ctermfg=0 ctermbg=0
  endif
endfunction

" _ to jump to next underscore char, even in operator-pending mode
nnoremap _ f_
onoremap _ t_
nnoremap d_ df_
vnoremap _ f_

" insert mode hax!
inoremap <C-H> <Left>
inoremap <C-J> <Down>
inoremap <C-K> <Up>
inoremap <C-L> <Right>
inoremap <C-W> <C-O>w
inoremap <C-B> <C-O>b

" cmdline mode hax!
cnoremap <C-H> <Left>
cnoremap <C-J> <Down>
cnoremap <C-K> <Up>
cnoremap <C-L> <Right>

" restore stomped-over CTRL-K ✓
inoremap <C-Z> <C-K>
cnoremap <C-Z> <C-K>

" :w in insert mode WOO!
inoremap :w<CR> <ESC>:w<CR>

" Y for system clipboard yank
" Be careful to keep yankstack from stealing these back!
nnoremap Y "+y
vnoremap Y "+y
nnoremap YY "+yy

" Q for opposite of J
nnoremap Q i<CR><C-C>

if exists('g:loaded_detectindent')
  autocmd vimrc BufReadPost * :DetectIndent
endif

" Quick calculator in insert mode
inoremap <C-Q> <C-O>:let search_bak=@/<CR><C-O>v?[^-+*/0-9.]<CR>ld<C-R>=<C-R>"<CR><C-O>:let @/=search_bak<CR>

" Enter key to switch between c and header file
autocmd vimrc BufRead *.c nnoremap <buffer> <CR> :e <C-R>%<BS>h<CR>
autocmd vimrc BufRead *.h nnoremap <buffer> <CR> :e <C-R>%<BS>c<CR>

" Search for selected text, forwards or backwards.
vnoremap <silent> * :<C-U>
  \let old_reg=getreg('"')<Bar>let old_regtype=getregtype('"')<CR>
  \gvy/<C-R><C-R>=substitute(
  \escape(@", '/\.*$^~['), '\_s\+', '\\_s\\+', 'g')<CR><CR>
  \gV:call setreg('"', old_reg, old_regtype)<CR>
vnoremap <silent> # :<C-U>
  \let old_reg=getreg('"')<Bar>let old_regtype=getregtype('"')<CR>
  \gvy?<C-R><C-R>=substitute(
  \escape(@", '?\.*$^~['), '\_s\+', '\\_s\\+', 'g')<CR><CR>
  \gV:call setreg('"', old_reg, old_regtype)<CR>

" Ctrl-O-O in insert mode to get cursor inside block when this: if(...) ¬ { ¬ } <CURSOR>
inoremap <C-O><C-O> <C-O>O

" 1s to search-again in all files in Git
func! GitGrep(...)
  let save = &grepprg
  set grepprg=git\ grep\ -n\ $*
  let s = 'grep'
  for i in a:000
    let s = s . " " . i
  endfor
  exe s
  let &grepprg = save
endfun
command! -nargs=? GitGrep call GitGrep(<f-args>)
nnoremap 1s :cope \| GitGrep '<C-R>=substitute(substitute(substitute(@/,"'","'\\\\''","g"),"\|","\\\\\\\\\|","g"),"\\\\v","","g")<CR>'<Left><CR>

" 1h to temporarily disable highlighing
noremap 1h :nohls<CR>

" 1p to run the selected PHP code and replace it with the results
nnoremap 1p gv:!php -a \| tail -n +3<CR>
vnoremap 1p :!php -a \| tail -n +3<CR>

" 1y for python
autocmd vimrc FileType python nnoremap 1y gv:!python -i 2>/dev/null<CR>
autocmd vimrc FileType python vnoremap 1y :!python -i 2>/dev/null<CR>

" 1<space> toggle paste / nopaste
set pastetoggle=1<space>

" 1w toggle line wrapping
nnoremap 1w :set wrap!<CR>

" 1l toggle list chars
nnoremap 1l :set list!<CR>

" 1m counts matches (depends on default /g!)
nnoremap 1m :%s///n<CR>

" 1n inserts incrementing numbers in front of all current search matches
nnoremap 1n :let i=1 \| g~\(<C-R>/\)\@=~s~~\=printf("%02d",i)~ \| let i=i+1

" 1t to view current buffer in Chromium w/ syntax colors
nnoremap 1t :TOhtml<CR>:w! /tmp/to.html<CR>:q!<CR>:!chromium-browser /tmp/to.html<CR>

" Columnize
function! Columnize(...) range abort
  let firstline = a:firstline
  let lastline = a:lastline
  if firstline >= lastline
    let firstline = line("'<")
    let lastline = line("'>")
    if firstline >= lastline
      let firstline = line('.')
      let lastline = firstline + str2nr(input("Number of lines to Columnize: ")) - 1
      if firstline >= lastline
        echo "Error: Columnizing requires a valid range"
        return
      endif
    endif
  endif
  let origsearch = @/
  exec "normal! :".firstline.",".lastline."s/\\v$/#/\n"
  let stcol = 1
  let i = 0
  while a:0 == 0 || l:i < a:0
    let @/ = ""
    redraw
    if( a:0 > 0 )
      let patt = a:000[l:i]
    else
      let patt = input(stcol."| Enter column delimiter (Esc or empty to finish): ")
    endif
    if empty(patt) | break | endif
    let bestcol = stcol
    " find the farthest out delimiter, then push them all out as far
    for firstpass in [1,0]
      for nl in range(firstline,lastline)
        exec "silent! normal! ".nl."G".stcol."|/\\v($|(\\V".patt."\\v))\n"
        let thiscol = col('.')
        if line('.') != nl | continue | endif
        if thiscol == stcol | continue | endif
        if firstpass
          if thiscol > bestcol | let bestcol = thiscol | endif
        else
          exec "normal! i" . repeat(' ',bestcol - thiscol)
        endif
      endfor
    endfor
    " continue columnizing only right of stcol
    let stcol = bestcol + strlen(patt) - 1
    let i = l:i + 1
  endwhile
  exec "normal! :".firstline.",".lastline."s/\\v\\s*#$//\n"
  exec ":redraw | echo 'Columnized ".(lastline-firstline+1)." lines, ".(l:i+1)." columns'"
  let @/ = origsearch
endfunction
noremap <C-S> :call Columnize()<CR>

" LEADERS!

" <leader>g
" and
" <leader>u
" are in use ABOVE ^^
"
"ip2long and long2ip
nnoremap <leader>l viWo<ESC>Ea <ESC>B"adiwx"bdiwx"cdiwx"ddiw"=<C-R>a*16777216+<C-R>b*65536+<C-R>c*256+<C-R>d<CR>Plx
nnoremap <leader>i viWo<ESC>Ea <ESC>B"adiW"=<C-R>a/16777216.".".<C-R>a/65536%256.".".<C-R>a/256%256.".".<C-R>a%256<CR>Plx

nnoremap <leader>v :split $MYVIMRC<CR>

" Manual retab?
nnoremap <leader>a :%s/\v(^\|)  /\1/<CR>
nnoremap <leader>b :set ts=4 sw=4 et\|%s//    /<CR>

" convert from PHP var to Mustache and go to next search hit
nmap <leader>m xhveolS}gvS}n
nmap <leader>t i_<esc>lf#x,xhveolS}gvS}Xn
nmap <leader>T i_<esc>lf#x,xhveolS}gvS}gvS}Xn

" where's my digraphs?!
nnoremap <leader>d :h digraph-table<CR>

" run some spartors
nnoremap <leader>2 :!killall spartor<CR>
                  \:!./spartor console window_2 winpos_0_0 listen 2>host.log &<CR>
                  \:!./spartor console window_2 winpos_1100_0 connect 2>client.log &<CR><CR>
nnoremap <leader>3 :!killall spartor<CR>
                  \:!./spartor console window_2 winpos_0_0 listen 2>host.log &<CR>
                  \:!valgrind ./spartor console window_2 winpos_1100_0 connect<CR>
nnoremap <leader>4 :!killall spartor<CR>
                  \:!./spartor console window_2 winpos_1100_0 connect 2>client.log &<CR>
                  \:!valgrind ./spartor console window_2 winpos_0_0 listen<CR>

nnoremap gb :cal SwapParams('left')<CR>
nnoremap gs :cal SwapParams('right')<CR>

function! SwapParams(direction)
  let origsearch = @/
  let line = line('.')
  let col = col('.')
  if a:direction == 'left'
    s/\v(^|[[(,])(\s*)([^][(),]+),(\s*)([^]),]*%#[^]),]*)/\1\2\5,\4\3/e
  else
    s/\v(^|[[(,])(\s*)([^][(),]*%#[^][(),]*),(\s*)([^]),]+)/\1\2\5,\4\3/e
  endif
  cal cursor(line,col)
  let @/ = origsearch
endfunction

nnoremap du :diffupdate<CR>

" reselect pasted (changed) text, kind of like gv
nnoremap gz `[v`]

" CTRL-SPACE shortcut for redraw! (I stomped CTRL-L long ago)
nnoremap <C-@> :redraw!<CR>

" Shortcut for :diffthis... Dr Diff This?
nnoremap dr :diffthis<CR>

" Conflict roundup
nnoremap cr :cal ConflictRoundup()<CR>
function! ConflictRoundup()
  vimgrep '^\([<=|>]\)\1\1\1\1' %
  cope
endfu
