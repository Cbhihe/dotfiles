" ==============================
"    .VIMRC
" ==============================
" Last edit: 2020.04.19 at 17:21:13 [ckb]

set encoding=utf-8
scriptencoding utf-8
set termencoding=utf-8
"set nocompatible       " Superfluous: vim automatically sets nocompatible if it finds
                       " ~/.vimrc or gvimrc " at startup

" =========================
" Sensitive content
" =========================
source ~/.vim/sensitive.vim

" =========================
" Function definitions
" =========================
source ~/.vim/functions.vim

" =========================
" Plugins {{{1
" =========================
" :scriptnames
                " check loaded plugins
" :set runtimepath?
                " check loaded plugins' rt path
" :echo syntastic#util#system('echo "$path"')
                " see syntastic's idea of env-var $path

" ---- use with `vundlevim/vundle.vim'  {{{2
" Lines commented with 3 double quotes can be activated by removing them,
" while single quotes remain.

"""filetype off
"""set rtp+=~/.vim/bundle/Vundle.vim
                " set run-time path for vundle, required
"""call vundle#begin()
                " initialize vundle, required

" keep all 'plugin' commands below this line
" ------------------------------------
" for github repos: specify plugins using 'user/repository' format or
"  'user/repository.git' format
" for vim scripts: reference the plugin by name as it appears on site

"""Plugin 'vundlevim/vundle.vim'
                " let vundle manage vundle, required
"""Plugin 'vim-syntastic/syntastic'
                " syntax checker
"""Plugin 'ycm-core/youcompleteme'
                " compiled plugin 'youcompleteme.vim' in
                " '/usr/share/vim/vimfiles/autoload'
"""Plugin 'raimondi/delimitmate'
                " replaces 'townk/vim-autoclose' below
                " unlike 'townk/vim-autoclose' it takes syntax into account
                " installed directly from plugins' repository
"""Plugin 'dougireton/vim-chef'
                " detects chef cookbook and chef-repo files and sets the filetype
                " to 'ruby.chef'
"""Plugin 'jimhester/lintr'
                " detects syntax errors and inconsistencies in r scripts
                " git-cloned from https://github.com/jimhester/lintr.git
"""Plugin 'vim-scripts/latex-suite-aka-vim-latex'
                " located at
                " https://github.com/vim-scripts/latex-suite-aka-vim-latex.git
"""Plugin 'syngan/vim-vimlint'
                " located at https://github.com/syngan/vim-vimlint.git
                " written in vim, hence very slow with syntastic
"""Plugin 'ynkdir/vim-vimlparser'
                " located at https://github.com/ynkdir/vim-vimlparser.git
"""Plugin 'kuniwak/vint'
                " cloned from https://github.com/kuniwak/vint  << deprecated
                " or installed from aur as 'python-vint'  << ok
                " can also be installed via '/usr/bin/python3 -m pip install ...'

" ---- disabled vundle-managed plugins   {{{3
" ====================================
"Plugin 'Vimjas/vint'
                " located at https://github.com/Vimjas/vint
                " vim script Language Lint implemented in Python
                " installed on 2020.04.18 to replace 'kunivak/vint'
                " Not maintained any longer
"Plugin 'dbakker/vim-lint'
                " located at https://github.com/dbakker/vim-lint.git
                " Not maintained any longer
"Plugin 'townk/vim-autoclose'
                " Create pairs of (,{,[,",` and ' automatically.
                " Place cursor between them automatically.
                " Delete with one keystroke by doing bs on first sign .
                " Suppress creation of closing sign, by typing ctrl-v in
                " insert mode immediately prior to typing the opening sign.
                " Purged 2018.10.28 for incompatibility reasons
"Plugin 'vim/matchit.vim'
                " part of vim standard distribution since vim 6.0
"Plugin 'karamcc/vim-streamline'
" statusline changes to adapt to theme  }}}3
" ------------------------------------
" all vundle-managed plugins must be added before above line
"""call vundle#end()
"}}}2

" ---- use with vim 8.x native plugins management  {{{2
set loadplugins
                " Default: on
                " Option can be reset in ~/.vimrc to 'noloadplugins'
                " in order to disable all plugin loading.
if &loadplugins
    if has('packages')
        " Optional lazy loading (with!)of *.vim files in " ~/vim/pack/plugins/opt/
        " Pick loaded plugins one by one
        packadd! delimitmate
        packadd! syntastic
        packadd! vim-vimlint
        packadd! vim-vimlparser
        packadd! vint
        packadd! lintr
        packadd! youcompleteme
        "packadd! latex-suite-aka-vim-latex
        "packadd! vim-chef
    else
        " Automatic loading of *.vim files in ~/vim/pack/plugins/start/
        packloadall
    endif
endif
" }}}2

filetype plugin indent on
                " Required
                " Load ftplugin.vim and indent.vim from $vimruntime
                " (/usr/share/vim/vim82)
                " Turn automatic filetype detection on

let g:ft_ignore_pat = '\.\(z\|gz\|bz2\|zip\|tgz\)$'
                " Ensure contents of compressed files not inspected.
let g:rmd_include_html = 1
                " Source '~/.vim/after/ftplugin/html.vim' for r markdown
"}}}1

" =========================
" General settings   {{{1
" =========================
set noerrorbells    " Turn off audible error bells
set visualbell
"set t_vb=^[[?5h$<100>^[[?5l
                    " Does not work in xterm, although should turn on visual
                    " bell (flash display 100ms)
set title           " Set terminal title to opened file name and appends 'pwd'
set magic           " Make characters have the same meaning as in grep regexp
                    " 'very magic': \v in front of a search pattern make
                    "   every following character except 'a-zA-Z0-9' and '_' have
                    "   special meaning
                    " 'anti very magic': \V has the opposite effect of \v. All
                    "   characters are parsed literally and must be preceded by \
                    "   to activate their special meaning.
                    " ':set nomagic' is the opposite of ':set magic'
set updatetime=250  " Update faster (CursorHold event)
set lazyredraw      " Don't allow redraw when using macros
set mouse=a         " Allow normal mouse behavior in all 4 principal modes
set number numberwidth=5
                    " Place a number left of each line start.
set timeout         " Timeout on :mappings and key codes (when timeout off (default))
set timeoutlen=1500 " Define time (ms) available to enter command after the <leader>
                    " or during entry of key combination. Default value is 1000.
                    " synonym of 'set tm=1500'
"}}}1

" =========================
" Sane text files {{{1
" =========================
set fileformats=unix,dos,mac
                    " Specify globally which file formats will be tried when
                    " Vim reads a file (i.e. how <EOL> detection will be done).
                    " When more than one format name is present, separated by
                    " commas, automatic detection attempts to detect <EOL> in
                    " the same order.
                    " When a new buffer (file) is opened, Vim automatically
                    " uses the first of the various proposed format as
                    " default.
                    " When empty, the format defined with 'fileformat' is used
                    " instead.
                    " When not empty 'fileformat' is ignored.
set fileformat=unix " Set file format locally
                    " :ff=unix to act locally on active buffer
"}}}1

" =========================
" Sane editing {{{1
" =========================

packadd! matchit    " Make % cmd jump to matching HTML tags, if/else/endif
                    " constructs, etc.
set wrap            " Display word wrapped text; do not change text in buffer
set linebreak       " Intelligent wrapping occurs at characters " ^I!@*-+;:,./?"
                    " (per vim default) or by 'breakat' option
                    " Does not introduce <EOL> at wrapped line visual "break"
set breakindent breakindentopt=min:25,shift:4
set showbreak=>>\   " display string ">>" at start of wrapped lines
"set textwidth=0     " Disable textwidth
                    " 'tw=75' (e.g.) introduces <EOL> at breaks
"set fo+=t           " Make default format setting in vim heed 'tw' change
"set wrapmargin=0    " Disable wrapmargin (counting from right border)
                    " 'wm=4' (e.g.) introduces <EOL> at breaks
set whichwrap=b,s,<,>,[,]
                    " Traverse line breaks with arrow keys

set showmatch       " Briefly jump to matching bracket
set autoindent      " Insert indent when starting new line with \<CR>,
                    " when ending previous line with \{, etc.
                    " When vim compiled with '+cindent' feature, this behavior is modified
set smartindent     " Copy previous indent, insert it on new line
set tabstop=4       " Define nbr of space(s) to use for each step of (auto)indent.
                    " Used for 'cindent', >>, <<, etc.
set shiftwidth=4
set smarttab        " Insert nbr of space(s) equal to shiftwidths,
                    " when <Tab> is inserted at line begin
set softtabstop=4   " Set nbr of spaces counted by <Tab> or <BS> in editing operations
set expandtab       " Convert tabs to spaces (for Python)
                    " (inverse behavior: 'set noexpandtab')
set list            " set list mode (local to window)
set listchars=tab:>-,trail:@
                    " Show any tab in file as '>--'
                    " where '-' are added as padding
                    " Show any spurious trailing space at eol as '@'
set cindent         " Make indent rule stricter for C programs
set cursorline      " Highlight current line (where cursor is)
set wildmenu        " Keyword completion. Pick choice of word with CTRL-P, CTRL-N
                    " cmd completion is enhanced by means of 'wildchar'
                    " Requires module +wildmenu feature
set wildchar=<Tab>  " Character to type when starting wildcard expansion
set wildcharm=<C-Z> " Works exactly as wildchar, but inside macro
                    " Use in mappings to automatically invoke completion mode
                    " e.g. ':cnoremap ss so $vim/session/*.vim<C-Z>'
                    " Use CTRL-P for previous and CTRL-N for next choice.
set wildignore=*.o,*.obj,*~,*.pyc,*.bak,*.class,*.cache
set wildignore+=*.swp,*.dll,tags
                    " ignore file matching given patterns when expanding wildcards
set wildignorecase
"set wildmode=list:longest
set wildmode=longest,list
                    " When more than 1 match occurs, list all matches
                    " and complete till longest common string, then list
                    " alternatives.
"}}}1

" =========================
" Mappings   {{{1
" =========================
set nopaste         " required for abbreviation and insertmode mapping to work
                    " in terminal

let g:mapleader = ',,'
                    " <leader> mapped to '\' by default.
let g:maplocalleader = ','
                    " <localleader> mapped to '\' by default.

" Mapping usage   {{{2
" Prepend prefix to 'map'
"     : normal, visual, select, operator-pending
"    n: normal            -- cursor motions and basic editing operations
"    o: operator-pending  -- cmd awaits motion instruction to execute (d,c,y,...)
"    i: insert or replace  -- character insertion (i,I,o,O,a,A,r,R,s,cw,ce,cb,c$)
"    x: (block) visual    -- select text (v,V,<C-V>)
"    s: select
"    v: visual + select
"    c: command           -- everytime 'ESC:' has been issued
"    l: insert, command & regexp-search & ...
"       collectively called "Lang-Arg" pseudo-mode)
"    t: terminal-job
" nore: non-recursive, i.e lhs expands literally to rhs only,
"       i.e even if rhs is already mapped to something else.

" Append suffix to 'map'
"    !: insert, command

" Just before the {rhs} a special character can appear:
"    *  indicates that it is not remappable
"    &  indicates that only script-local mappings are remappable
"    @  indicates a buffer-local mapping
"}}}2

map <C-R> :noh<cr>:redraw!"<cr>
                    " Redraw session screen erasing all highlights
map <silent> <leader><cr> :noh<cr>
                    " Temporarily disable highlight when <leader><cr> is pressed
nnoremap <cr> :noh<cr>
                    " Useful to disable highlighted search results

noremap ºº <Esc>
                    " in normal, visual, select, operator-pending modes
noremap! ºº <Esc>
                    " in insert and command modes

inoremap <Down> <C-o>gj
inoremap <Up> <C-o>gk
                    " Insert mode: make cursor move as expected with wrapped lines
                    " Disallow mapping of rhs to avoid nested or recursive mapping.

noremap! <Leader>< <Esc>:s/^    //<cr>:noh<cr>
noremap! <Leader>> <Esc>:s/^/    /<cr>:noh<cr>
vnoremap <Leader>< :s/^    //<cr>:noh<cr><Esc>
vnoremap <Leader>> :s/^/    /<cr>:noh<cr><Esc>
                    " Delete and insert 4 space indent at begining of line in
                    " insert and cmd, as well as visual modes

nmap <Leader>j :bnext<cr>
                    " Go to next normal buffer or to the next help buffer if
                    " in one when the command is issued.
                    " Wraps around end of buffer list
nmap <Leader>k :bprev<cr>
                    " Go to previous normal buffer or to the next help buffer if
                    " in one when the command is issued.
                    " Wraps around start of buffer list

"nnoremap <Leader>b :ls<cr>:b<Space>
                    " Move among buffers with CTRL key
nnoremap <Leader>b :set nomore <Bar> :ls <Bar> :set more <cr>:b<Space>
                    " List active buffers, prepare to switch to one
                    " either with buffer's partial name +TAB or with
                    " buffer number
map <space> /
                    " (normal/command, visual, select, operator-pending modes)
                    " Map <space> to forward search (/) in active window
"map <C-space> ?
                    " Map Ctrl-<space> to backward search (?) in active window
                    " WARNING: ineffectual because <C-space> produces no
                    " ASCII character

map! <F2> <Esc>a<C-R>=system('printf " [%b] " $USER').strftime('%Y.%m.%d at %H:%M:%S')]<cr><Esc>
nmap <F2> a<C-R>=system('printf " [%b] " $USER').strftime('%Y.%m.%d at %H:%M:%S')]<cr><Esc>
                    " Maps F2 for in-place insertion of timestamp,
                    "    e.g. ' [ckb] 2020.04.09 at 18:21:46'
                    " in insert and cmd modes (1st line - map suffix '!'), as
                    " well as in normal mode (2nd line - map prefix 'n').
nnoremap <Leader>le <Esc>o<C-R>="\t\" Last edit: ".strftime('%Y.%m.%d at %H:%M:%S').system('printf " [%b]" $USER')<Esc>
                    " Add last edit's timestamp and author below current line
                    " e.g. 'Last edit: 2020.04.09 at 18:21:46 [ckb]'
set go+=a           " Enable automatic X11 primary `"*y` register copying just
                    " by highlighting with mouse in visual mode
vmap <C-c> "+y
                    " Map CTRL+c to yank to system's clipboard in visual mode
vmap <C-x> "+d
                    " Map CTRL+x to cut to system's clipboard in visual mode

noremap <Leader>ft <Esc>:tabnew .<cr>
noremap <C-t> <Esc>:tabnew .<cr>
                    " Open new buffer with pwd's file tree (ft | t)
                    " ':q' to CLOSE and come back to calling buffer

inoremap <C-l> <Esc>ebveuea
nnoremap <C-l> ebveu
                    " Change whole current word to lowercase
inoremap <C-u> <Esc>ebveuea
nnoremap <C-u> ebveU
                    " Change whole current word to uppercase

" Function 'SelectMinTextObject()' defined in ~/.vim/functions.vim
" per the solution offered by @dedowsdi at
" https://vi.stackexchange.com/a/19524/4547
vnoremap ip <esc>:call SelectMinTextObject('({[<', 'i', 1)<cr>
vnoremap ap <esc>:call SelectMinTextObject('({[<', 'a', 1)<cr>
onoremap ip :call SelectMinTextObject('({[<', 'i', 0)<cr>
onoremap ap :call SelectMinTextObject('({[<', 'a', 0)<cr>
                    " Delete/yank/copy any text on or inside [],{},(),<>
                    " Respect order of embedding
                    " Use with 'dp', 'yp' or 'cp'
onoremap p  i(
onoremap p[ i[
onoremap p< i<
onoremap p{ i{
                    " Position cursor anywhere on or inside [],{},(),<>
                    " then select any of d, y, c operators w/ mapping to apply
                    " operation on bracketed content.

nnoremap <leader>ev :vsplit $MYVIMRC<cr>
                    " Edit ~/.vimrc in a jiffy
nnoremap <leader>sv :source $MYVIMRC<cr>
                    " Source  ~/.vimrc in a jiffy
nnoremap <silent> <Leader>ed :Explore<CR>
                    " Opens separate buffer in file tree exploration mode
cnoremap lg !ls -AF *<C-Z>
                    " Example of completion using either <tab> or <C-Z> after
                    " glob in command mode.
                    " Usage: `:lg'

map <leader>g :YcmCompleter GoToDefinitionElseDeclaration<cr>
                    " Define a shortcut for YCM goto definition

map <Leader>vpu :term sh -c "for p in ~/.vim/pack/plugins/{opt,start}/*; do if [ -n \"$(\ls -A $(dirname \"$p\"))\" ]; then echo \"$p\" ; git -C \"$p\" pull --recurse-submodules; fi; done"<CR>
"map <Leader>vpu :term sh -c "for p in ~/.vim/pack/plugins/{start,opt}/*; do echo \"$p\" ; git -C \"$p\" pull; done"<CR>
                    " `vim plugins update' for git-repo update
"}}}1

" =========================
" Command completion with YCM   {{{1
" =========================
"let g:ycm_server_keep_logfiles = 1
"let g:ycm_server_log_level = 'debug'
                " Keep for YCM plugin install debug
let g:ycm_server_python_interpreter = '/usr/bin/python3'
                " NEEDED because YCM's server is compiled with Python 2.7
                " Nevertheless YCM accepts vim clients with both py2 or py3

" ==== YCM extra for C/C++ projects
let g:ycm_global_ycm_extra_conf = '~/.config/ycm/clang/.ycm_extra_conf.py'
                " Default location is at project's root, extra
                " configuration file location is:
let g:ycm_confirm_extra_conf = 1
                " Extra conf file is python; when found, request
                " confirmation before loading
let g:ycm_extra_conf_globlist = ['~/.config/ycm/clang/*','!~/**']
                " Request confirmation before loading only when
                " extra_conf files are not white listed above.

" ==== YCM extra for java projects
                " See https://wiki.archlinux.org/index.php/Vim/YouCompleteMe

" ==== YCM extra for python projects
"set pyxversion=2
"let g:ycm_python_binary_path ='/usr/bin/python2'
let g:ycm_python_interpreter_path = ''
let g:ycm_python_sys_path = []
let g:ycm_extra_conf_vim_data = [
  \  'g:ycm_python_interpreter_path',
  \  'g:ycm_python_sys_path'
  \]
let g:ycm_global_ycm_extra_conf = '~/.config/ycm/python/global_extra_conf.py'
let g:ycm_autoclose_preview_window_after_completion = 1
                " Ensure auto-complete window goes away when done with it
"}}}1

" =========================
" Sane linting with Syntastic   {{{1
" =========================
" Syntastic home: https://github.com/vim-syntastic/syntastic

" ==== Syntastic debug mode config
"let g:syntastic_debug = 3
let g:syntastic_debug_file = '~/.vim/syntastic.log'

" ==== pymode config for syntax checkers
let g:pymode_python = '/usr/bin/python3'
"let g:pymode_lint_on_write = 0
                " if needed disable lint check in 'python-mode'
"let g:pymode_lint_ignore = 'E265,E266'
                " Disables PEP8 linting messages selectively // OLD
let g:python_recommended_style = 0
                " Do not follow PEP8 style recommendation for format
                " (in particular 'tabstop=8')

" ==== Syntastic configuration
let g:syntastic_shell = '/usr/bin/bash'
                " Specify shell which accepts Bourne compatible syntax
let g:syntastic_always_populate_loc_list = 1
                " Default: 0
                " Set to 1 for other plugins to use and fill loc-list
                " Obviate the need to issue ':Errors' before opening loc-list
                " Just use `:lopen' and `:lclose' instead.
let g:syntastic_auto_loc_list = 2
                " Default: 2
                " Does not open loc-list automatically when errors occur.
                " Closes loc-list window automatically when last error has
                " been suppressed.
let g:syntastic_check_on_open = 1
let g:syntastic_check_on_wq = 0
let g:syntastic_auto_jump = 0
                " Default = 0
                " When set to 1, jump automatically to 1st detected issue
let g:syntastic_enable_signs = 1
                " keep defaults margin signs
set signcolumn=yes
                " Anchor sign column permanently

"let g:syntastic_error_symbol = "\u2717"
                "Default: syntax error symbol ">>"
"let g:syntastic_style_error_symbol =
                " Default: style error symbol "S>"
hi clear SyntasticErrorSign
                " Change default color for syntastic's error sign in margin
hi SyntasticErrorSign ctermfg=1* ctermbg=0 guifg=LightRed guibg=grey

"let g:syntastic_warning_symbol = "\u26A0"
                " Default: syntax warning symbol ">>"
"let syntastic_style_warning_symbol =
                " Default: style warning symbol "S>"
hi clear SyntasticWarningSign
                " Change default color for syntastic's warning sign in margin
hi SyntasticWarningSign ctermfg=3* ctermbg=0 guifg=LightYellow guibg=grey

let g:syntastic_enable_highlighting = 1
                " Enable error and warning highlighting whenever possible
hi clear SyntasticError
                " Change default for Syntastic's error highlight
hi SyntasticError ctermfg=201 cterm=underline guisp=Pink gui=undercurl

hi clear SyntasticWarning
                " Change default for Syntastic's warning highlight
hi SyntasticWarning ctermfg=215 cterm=underline guisp=Pink

let g:syntastic_enable_balloons = 1
                " Not available with every checker
let g:syntastic_aggregate_errors = 1
                " Set to 0 (defaut) to show errors for 1st checker chosen, then 
                " 2nd if 1st checker returns zero error, etc.
                " Set to 1 to show all errors at once.
let g:syntastic_sort_aggregated_errors = 1
                " Default: 1
                " Let error messages be grouped by check-engine used.
                " Useful when 'syntastic_aggregate_errors = 1' above.
"let g:syntastic_echo_current_error = 1
let g:syntastic_cursor_column = 0
                " When several errors are found on same line,
                " pick first error for the given column

"let g:syntastic_extra_filetypes = ["3rd_party_filetype","etc"]
                " Only used for filetypes of checkers added by 3rd party
                " plugins

let g:syntastic_filetype_map = {
    \ 'plaintex': 'tex',
    \ 'ruby.chef': 'chef'}
                " file mapping dict to map unknown or composite file types
                " to known ones

let g:syntastic_mode_map = {
    \ 'mode': 'active',
    \ 'active_filetypes': ['python','c','cpp','r','perl','sh','php','erlang','vim','sql','tex'],
    \ 'passive_filetypes': ['chef', 'puppet']}
                " Enable selective active mode when passive mode is activated
                " in local buffer, with: ':SyntasticToggleMode'

"let g:syntastic_quiet_messages = {
"    \ "level":  [""],
"    \ "type":   [""],
"    \ "regex":   '\m\[C03\d\d\]',
"    \ "file:p":  ['\m^/usr/include/', '\m\c\.h$'] }
"let g:syntastic_python_flake8_quiet_messages = {
"    \ "level":  ["warnings"],
"    \ "type":   ["style"],
"    \ "regex":   [''],
"    \ "file:p":  ['\m\c\.py$'] }
                " filetype and checker specific filter have precedence over
                " general ones (as the one commented out above). They can be
                " used to build exceptions to general rules.


" ----------------------------
" See available checkers with ':h syntastic-checkers' in vim buffer
" ----------------------------
let g:syntastic_extra_filetypes = ['make', 'gitcommit']

let g:syntastic_java_checkers = []
                " Manual disabling of Syntastic Java diagnostics
                " due to incompatibility with YCM's native RT diagnostics
let g:syntastic_c_checkers = ['make', 'splint']
"let g:syntastic_c_flawfinder_thres = 3
                " Default value = 3.  Useful only if 'flawfinder' is included
                " in checkers' list instead of 'splint'.
                " Overridden by YCM

let g:syntastic_cpp_checkers = ['clang_check', 'flawfinder']
                " Overridden by YCM

let g:syntastic_python_checkers = ['pylint', 'flake8', 'bandit']
let g:syntastic_python_python_use_codec = 0
                " Enable the use of codes to encode Python declarations, with
                " the 'python' checker.
                " See https://docs.python.org/reference/lexical_analysis.html \
                " \ #encoding-declarations such as:
                " https://noseofyeti.readthedocs.org/en/latest/
let g:syntastic_python_flake8_args = '--ignore=E265,E266'
                " Suppress Flake8 messages:
                "   E265: comment blocks should start with `# '
                "   E266: doubled '#` as in '##` at line start are not standard
let g:syntastic_fortran_checkers = ['gfortran']
                " Checker ignores usual 'g:syntastic_fortran_gfortran_<option>' variables.
                " See ':h syntastic-checkers' for more details and config tips

let g:syntastic_php_checkers = ['php', 'phplint']
                " 'phplint' not installed as of 2018.10.18

"lklflf  ñfdf
let g:syntastic_html_checkers = ['tidy']
                " Install with pacman
"123lklflf  ñfdf
let g:syntastic_vim_checkers = ['vint', 'vimlint', 'vimlparser']
                " Obtained directly from Github.com
                " vint installed from AUR is located at /usr/bin/vint
let g:syntastic_vim_vint_exec = '/usr/bin/vint'
                " vint executable path
let g:no_vim_maps = 0
                " Enable vim map
                " Move to start and end of functions with [[ and ]].
                " Move around comments with ]" and ["

"let g:syntastic_tex_checkers = ['lacheck', 'tex/language_check']
let g:tex_flavor = 'latex'
                " Possible values: 'plain', 'context', 'latex'
                " Not required, if 'g:syntastic_filetype_map' implemented.
                " When 1st line of *.tex file has %&<format>, filetype can be
                " is either: 'plaintex' (for plain TeX), 'context' (for ConTeXt),
                " or 'tex' (for LaTeX).
                " Otherwise, vim conducts kw-search in file to choose
                " context or tex. In the absence of kws, default is 'plaintex'.
                " Default can be changed w/: " 'g:tex_flavor = '[format]'
let g:plaintex_delimiters = 1
                " to highlight brackets [] and braces {} in 'plaintex' format


let g:syntastic_enable_r_lintr_checker = 1
                " Required
let g:syntastic_r_checkers = ['lintr']
                " Static analysis tools
                " Executes R code in vim (may be security risk for foreign code).
                " Plugin git-cloned from https://github.com/jimhester/lintr

let g:syntastic_sh_checkers = ['shellcheck', 'sh']
let g:syntastic_sh_shellcheck_args = '-x'

let g:syntastic_perl_checkers = ['perlcritic']
                " Static analyzer. Does not run code.
                " checker not installed as of 2018.10.18
let g:syntastic_perl_perlcritic_thres = 5
                " Highlight policy violation as error for level >= 5 (default)
                " Others shown as warnings.

let g:syntastic_erlang_checkers = ['syntaxerl', 'escript']
                " checkers not installed as of 2018.10.18

let g:syntastic_puppet_checkers = ['puppet', 'puppet-lint']
                " See this style-linter project at http://puppet-lint.com/

let g:syntastic_sql_checkers = ['sqlint']
                " valid for ANSI SQL

let g:syntastic_chef_checkers = ['foodcritic']
                " Style-linter
                " See project at: https://github.com/Foodcritic/foodcritic/
                " Step 1: install chef + foodcritic with AUR package 'chef-dk'
                " Step 2: Install plugin vim-chef to define filetype 'ruby.chef'
                " Step 3: Make Syntastic recognize composite filetype 'ruby.chef'
                " Step 4: Make Syntastic recognize executable '/usr/bin/foodcritic'
let g:syntastic_chef_foodcritic_exec = '/usr/bin/foodcritic'
                " Default executable path

let g:syntastic_ruby_checkers = ['mri']
                " See this style-linter project at http://github.com/foodcritic/
let g:syntastic_ruby_mri_exec = '/user/bin/ruby'
                " Default executable path
"}}}1

" =========================
" Status line {{{1
" =========================
let g:streamline_minimal_ui = 1
                    " Plugin: KaraMCC/vim-streamline
                    " Enable minimalist mode for status line
let g:streamline_show_ale_status = 1
                    " Plugin: KaraMCC/vim-streamline
                    " show ALE errors and warnings in status line

" How to format syntastic error and warning messages in status line   {{{2
"        %e  - number of errors
"        %w  - number of warnings
"        %t  - total number of warnings and errors
"        %ne - filename of file containing first error
"        %nw - filename of file containing first warning
"        %N  - filename of file containing first warning or error
"        %pe - filename with path of file containing first error
"        %pw - filename with path of file containing first warning
"        %P  - filename with path of file containing first warning or error
"        %fe - line number of first error
"        %fw - line number of first warning
"        %F  - line number of first warning or error

"    These flags accept width and alignment controls similar to the ones used by
"    |'statusline'| flags:
"        %-0{minwid}.{maxwid}{flag}

"    All fields except {flag} are optional. A single percent sign can be given as
"    "%%".

"    Several additional flags are available to hide text under certain conditions:
"        %E{...} - hide the text in the brackets unless there are errors
"        %W{...} - hide the text in the brackets unless there are warnings
"        %B{...} - hide the text in the brackets unless there are both warnings AND
"                  errors
"}}}2

set showcmd
                    " Show cmd at bottom rhs of screen.
                    " <leader> disappears after timeoutlen has expired.
set showmode
                    " Show current vim mode in statusline at bottom lhs of screen

" How to format the aspect of status lines   {{{2
                    " %<    truncate line if too long;
                    "       default is at start of line
                    " %n    current buffer number
                    " %F    full path of file in buffer
                    " %m    modified flag [+] if buffer still unsaved;
                    "       [-] means "not modifiable"
                    " %r    readonly flag [RO]
                    " %h    help buffer flag [help]
                    " %y    filetype for file currently in buffer
                    " %=    separation between left and right aligned items on
                    "       status line
                    " %l    line number
                    " %L    total number of lines in current buffer
                    " %p    scroll down percentage position in current buffer
                    " %c    cursor's current line's colum number
"}}}2

set statusline=%<
set statusline+=%#GitBranch#
set statusline+=%{StatuslineGit()}
                    " defined in ~/.vim/functions.vim
set statusline+=%*
set statusline+=\ \%n\ \%F\ \%m\%r\%h\ \%=\ \%y
set statusline+=\ %{&fileencoding?&fileencoding:&encoding}
set statusline+=\ \[%{&fileformat}\]
set statusline+=\ (\%p\%%)
set statusline+=\ %l/%L:%c
set statusline+=\ 
set statusline+=%#warningmsg#
                    " display last warning message, w/ "warningmsg" hl group
set statusline+=%{SyntasticStatuslineFlag()}
                    " Syntastic default statusline tweak
let g:syntastic_stl_format = ' [%E{Error #%e at line %fe}%B{, }%W{Warning #%w at line %fw}]'

set statusline+=%*
                    " '*' restore normal highlight mode
set laststatus=2
                    " always display status line
"}}}1

" =========================
" Colors   {{{1
" =========================
"syntax on          " Enable syntax highlighting using vim default highlight colors.
                    " By default 'syntax on' also turns on filetype detection.
                    " Overrule previously defined user highlight color settings.

if &term ==# 'xterm'
    set background=dark
elseif &term ==# 'xterm-256color'
    set background=dark
    set t_Co=256
endif
                    " Define dark or light terminal background and set term color
                    " to 256 color, if no automatic detection of terminal color
                    " takes place (default).
set termguicolors
                    " Override the above. Do not limit colors to 256.
                    " Instead, use all available terminal colors.
                    " Set BEFORE color scheme below.

" Color themes  "{{{2
" See available color schemes in $VIMRUNTIME/colors/,
" currently at /usr/share/vim/vim81/colors/ (for vim v8.1)
":color default
":color ron         "high contrast very similar to 'murphy' and 'industry'
":color murphy      " high contrast very similar to 'ron' and 'industry'
":color industry    " high contrast very similar to 'ron' and 'murphy'
":color slate
":color koehler
":color zellner     " strange wine colors
":color delek
":color peachpuff
":color torte       " very similar to 'pablo'
":color pablo       " very similar to 'torte'
color desert
":color elflord
":color solarized   " very similar to 'shine' and 'morning'
":color morning     " very similar to 'shine' and 'solarized'
":color shine       " very similar to 'solarized' and 'morning'   "}}}2

if !exists('g:syntax_on')
    syntax enable   " Set syntax highlighting groups not yet set.
endif
                    " Turn syntax highlighting on for different types of files
                    " equivalent to ':source $VIMRUNTIME/syntax/syntax.vim'
                    " Allow subsequent use of :highlight command to set user defined
                    " highlighting  color, i.e. keep user defined highlight
                    " color settings.

" Highlight groups: " Normal, Special, Comment, Constant, Type, Error, Underlined,
                    " Boolean, Conditional, NonText, Cursor, CursorLine, Function,
                    " Include, Debug, ErrorMsg, Folded, Todo ('TODO','FIXME','XXX'), etc.
                    " (see http://vimdoc.sourceforge.net/htmldoc/syntax.html#xterm-color)

" Key=Value pairs   "{{{2
"           cterm=    underline | bold | none | reverse | italic
" ctermfg,ctermbg=    NR-16   NR-8    COLOR NAME
"                       0       0       Black
"                       1       4       DarkBlue
"                       2       2       DarkGreen
"                       3       6       DarkCyan
"                       4       1       DarkRed
"                       5       5       DarkMagenta
"                       6       3       Brown, DarkYellow
"                       7       7       LightGray, LightGrey, Gray, Grey
"                       8       0*      DarkGray, DarkGrey
"                       9       4*      Blue, LightBlue
"                       10      2*      Green, LightGreen
"                       11      6*      Cyan, LightCyan
"                       12      1*      Red, LightRed
"                       13      5*      Magenta, LightMagenta
"                       14      3*      Yellow, LightYellow
"                       15      7*      White
"     guifg, guibg=   #000000, ...
"}}}2

hi Normal ctermbg=Black guibg=#222222
                    " Assign anthracite-black (#222222) bg to 'Normal'
                    " group, if terminal = 'cterm' (color terminal)
"highlight Comment ctermfg=Cyan ctermbg=Black cterm=underline
                    " Override 'Comment' group's color
                    " Note: all but any one 'key=value' pair optional

set cursorline
hi CursorLine term=bold cterm=bold ctermbg=Black guibg=#000000
                    " Set cursor line highlight preferences

hi clear SignColumn
hi SignColumn cterm=none ctermbg=Black guibg=#222222

hi GitBranch cterm=bold ctermbg=Black ctermfg=LightGreen
                    " guibg=Black guifg=Green

hi NonAscii cterm=none ctermbg=Black ctermfg=Red
                    " guibg=Black guifg=Red
augroup hlNonAscii
    autocmd!
    autocmd BufReadPost * if  count(['vim','python'],&filetype)
        \ | syntax match NonAscii "[^\u0000-\u007F]"  containedin=ALL
        \ | endif
"   autocmd BufRead *.vim syntax match NonAscii "[^\u0000-\u007F]"  containedin=ALL
"   autocmd BufRead *.vim syntax match NonAscii "[^\x00-\x7F]" containedin=ALL
"   autocmd BufRead * syntax match NonAscii "[^\d0-\d127]" containedin=ALL
                    " Highlight non ASCII characters in Vim
                    " In ex mode, to find non ASCIIs: /[^[:alnum:][:punct:][:space:]]/
augroup END
"1}}}

" ========================
" Folding modes, method, text and pattern {{{1
" ========================

" Commands to manage folds   {{{3
" za to toggle the current fold
" zA to recursively toggle the current fold
" zf#j creates a fold from the cursor down # lines.
" zf/string creates a fold from the cursor to string.
" zfip folds a whole paragraph
" zj moves the cursor to the next fold.
" zk moves the cursor to the previous fold.
" zo opens a fold at the cursor.
" zO opens all folds at the cursor.
" zm increases the foldlevel by one.
" zM closes all folds.
" zr decreases the foldlevel by one.
" zR decreases the foldlevel to zero — unfold everything
" zd deletes the fold at the cursor.
" zE deletes all folds.
" [z moves to start of open fold.
" ]z moves to end of open fold.  "}}}3

set foldenable            " When on (default) all folds are closed when opening file

"set foldmethod=manual     " Default
"set foldmethod=indent     " Specify for python only, in ~/.vim/after/plugin/python.vim
"set foldmethod=marker     " Specialize in ~/.vim/after/plugin/*.vim
"set foldmarker={{{,}}}    " Default, specify in ~/.vim/after/plugin/*.vim
"set foldnestmax=4         " Default: 20
                          " maximum nesting of folds for "indent" and "syntax" methods
set foldlevel=0           " Default:0
                          " Folds with levels smaller than or equal to 'foldlevel' will
                          " not be closed upon exiting buffer
set foldcolumn=1

" Function MyfoldText() {{{2
"function! MyFoldText()
"    let line = getline(v:foldstart)

"    let nucolwidth = &foldcolumn + &number * &numberwidth
"    let windowwidth = winwidth(0) - nucolwidth - 4
"    let foldedlinecount = v:foldend - v:foldstart

"    " expand tabs into spaces
"    let chunks = split(line, "\t", 1)
"    let line = join(map(chunks[:-2], 'v:val . repeat(" ", &tabstop - strwidth(v:val) % &tabstop)'), '') . chunks[-1]
"
"    let line = strpart(line, 0, windowwidth - 2 - len(foldedlinecount))
"    let fillcharcount = windowwidth - len(line) - len(foldedlinecount) - 1
"    return line . ' ...' . repeat(' ', fillcharcount) . foldedlinecount . ' '
"endfunction
"}}}2
"set foldtext=MyFoldText()
"}}}1

" =========================
" viminfo  {{{1
" =========================
":help 'viminfo'    " for more details
":set viminfo?      " to inspect parameter values
"  '20  :  marks will be remembered for up to 20 previously edited files
"  <1000:  limit the number of lines saved for each register to 1000 lines
"  s100 :  registers with more than 100 KB of text are skipped.
"  h    :  disable search highlight when opening a file
"  c    :  attempt by foreign vim shell to read 'viminfo' file w/ original
"          encoding (need +iconv at compilation time)
"  "100 :  will save up to 100 lines for each register
"  :100 :  up to 100 lines of command-line history will be remembered
"  %    :  saves and restores the buffer list
"  n... :  where to save the viminfo files
set viminfo='20,<1000,s100,h,c,\"100,:100,%,n~/.vim/.viminfo
                    " Remember last cursor position when reopening file
set viminfo+=/100
                    " Control history size
"}}}1

" =========================
" Last cursor position {{{1
" =========================

" ----- buffer view method {{{2
" =========================
 set viewoptions=cursor,options,curdir
                    " Default
                    " 'cursor' and 'folds' are necessary to preserve
                    " exact cursor position with 'au' below.
augroup resCur
    autocmd!
                    " `!` removes all autocmds from group 'resCur' every time
                    " ~/.vimrc is sourced.
    au BufWinLeave,BufLeave,BufWritePost ?* nested silent! mkview!
                    " regex going from '+*' to '?*' no longer matches empty file names
                    " 'silent!' causes cmds to be executed silently and error
                    " messages to be supressed.
                    " 'mkview!' causes existing file to be clobbered.
    au VimEnter ?* silent! loadview
                    " Use as an alternative to group 'BufWinEnter'
                    " (below) in case of Plugin incompatibility
    "au BufWinEnter * silent loadview
augroup END    "}}}2
" ----- last cursor position {{{2
" =========================
" Inspired from https://github.com/benknoble/Dotfiles/links/vim/plugin/lastpos.vim
"if !exists('g:loaded_lastpos')
"    let g:loaded_lastpos = 1
"
"    if has('autocmd')
"        augroup resCur
"            autocmd!
"            " When editing a file, always jump to the last known cursor position.
"            " Don't do it when the position is invalid or when inside an event handler
"            " (happens when dropping a file on gvim).
"            au BufReadPost *
"                \ if line("'\"") > 1 && line("'\"") <= line("$") && &ft !~# 'gitcommit' |
"                \   exe "normal! g`\"" |
"                " make g`" into g'" to restore cursor position
"                " to last known line, at beginning of line
"                \ endif
"        augroup END
"    endif
"endif " }}}2
" ----- function method {{{2
" =========================
" THIS IS INCOMPATIBLE WITH FOLD MARKERS
" https://vim.fandom.com/wiki/Restore_cursor_to_file_position_in_previous_editing_session

"function! ResCur()
"    " Restore session with cursor in last line-column position
"    " Adding suffix ! silently overwrites previously defined function with
"    " identical name.
"    if line("'\"") > 1 && line("'\"") <= line('$')
"        normal! g`"
"                    " make g`" into g'" to restore cursor position
"                    " to last known line, at beginning of line
"        return 1
"    endif
"endfunction
"
"if has('folding')
"    function! UnfoldCur()
"        if !&foldenable
"            return
"        endif
"        let cl = line('.')
"        if cl <= 1
"            return
"        endif
"        let cf  = foldlevel(cl)
"        let uf  = foldlevel(cl - 1)
"        let min = (cf > uf ? uf : cf)
"        if min
"            execute 'normal!' min . 'zo'
"            return 1
"        endif
"    endfunction
"endif
"
"augroup resCur
"    autocmd!
"                    " `!` removes all autocmds from group 'resCur' every time
"                    " ~/.vimrc is sourced.
"    if has('folding')
"        autocmd BufWinEnter * if ResCur() | call UnfoldCur() | endif
"    else
"        autocmd BufWinEnter * call ResCur()
"    endif
"augroup END    "}}}2
"}}}1

" =========================
" Undo  {{{1
" =========================
set undodir=~/.vim/undodir
set undofile
"}}}1

" =========================
" Buffer swap, backup, write-backup files, temporary working directory  {{{1
" =========================
set noswapfile      " disable swap for vim buffers
set nobackup        " don't make ~ file backups
set writebackup     " save a temporary backup of file(s) being edited with vim
set backupdir=~/.vim/backups
set directory=~/.vim/tmp
"}}}1

" =========================
" Spell checking  {{{1
" =========================
" See ':help spell-quickstart'
" After manual editing of ~/.vim/after/$USER-*.utf-8.add, recreate corresponding
" *.spl files, with: ':mkspell! ~/.vim/after/$USER-*.utf-8.add'
" '1zg' or '2zg' to add word under cursor to tech or general dictionary
" '1zug' or '2zug' to undo adding word under cursor to tech or general dict
" '1zw' or '1zw' to add word under cursor to bad spelling dict
" '1zuw' or '2zuw' to undo adding word under cursor to bad spelling dict

set spell spelllang=en_us,fr,de,es,cjk
                    " enable spellchecking in English, French, German, Spanish
                    " 'cjk' indicate Chinese, Japanese and Korean, but treatment
                    " of those three cases differs, in that none of the 3 Asian
                    " languages' characters are checked.

augroup speLang
  autocmd!
  autocmd FileType plaintext setlocal spell spelllang=en_us,fr,de,es,cjk
augroup END

set spellfile=/home/$USER/.vim/after/$USER-tech.utf-8.add,/home/$USER/.vim/after/$USER-plain.utf-8.add
" Change default color for spell-checker to highlight words
hi clear SpellBad
"hi SpellBad ctermfg=1* ctermbg=3* cterm=underline guisp=Blue gui=undercurl
hi SpellBad ctermfg=1* ctermbg=0* cterm=none guisp=Blue gui=undercurl
"   above: 'guisp` is used for undercurl and strike through in gui mode

"hi clear SpellCap
"hi SpellCap ctermfg=00 ctermbg=06 cterm=none guifg=#000000 guibg=#008080
"hi clear SpellRare
"hi SpellRare ctermfg=00 ctermbg=06 cterm=none guifg=#000000 guibg=#008080
"hi clear SpellLocal
"hi SpellLocal ctermfg=00 ctermbg=06 cterm=none guifg=#000000 guibg=#008080
"}}}1

" =========================
" Input completion  {{{1
" =========================
set complete+=k     " 'k' = scan the files given in 'set dict=...' option below
set dictionary+=~/.vim/dict/iab-dict
"}}}1

" =========================
" Search {{{1
" =========================
set incsearch       " Show match incrementally as search proceeds
set ignorecase      " Make case insensitive
set smartcase       " Use case/become case-sensitive if caps is used
set hlsearch

:command WR :let @/=""
                    " Wipe register containing the last searched string.
                    " Make `:norm n` or `norm N` unavailable to search
                    " next occurrence either forward or backward,
hi clear Search     " Change default color for searched words
hi Search ctermfg=DarkRed ctermbg=grey cterm=none guisp=red gui=underline
"}}}1

" =========================
" User defined commands {{{1
" =========================
" CMDS only accepted if initial letter is capitalized
:command WQ wq
                    " command mode: auto correction
:command Wq wq
                    " command mode: auto correction
:command W  w
                    " command mode: auto correction
:command Q  q
                    " command mode: auto correction
"}}}1

" =========================
" Check dynamic loading of python 2.x or 3.x at 'vim' launch  {{{1
" =========================
"if has('python_compiled')
"  echo 'compiled with Python 2.x support'
"  if has('python_dynamic')
"    echo 'Python 2.x dynamically loaded'
"  endif
"endif
"if has('python3_compiled')
"  echo 'compiled with Python 3.x support'
"  if has('python3_dynamic')
"    echo 'Python 3.x dynamically loaded'
"  endif
"endif
"}}}1

