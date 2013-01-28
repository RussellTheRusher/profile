" All system-wide defaults are set in $VIMRUNTIME/debian.vim (usually just
" /usr/share/vim/vimcurrent/debian.vim) and sourced by the call to :runtime
" you can find below.  If you wish to change any of those settings, you should
" do it in this file (/etc/vim/vimrc), since debian.vim will be overwritten
" everytime an upgrade of the vim packages is performed.  It is recommended to
" make changes after sourcing debian.vim since it alters the value of the
" 'compatible' option.

" This line should not be removed as it ensures that various options are
" properly set to work with the Vim-related packages available in Debian.
runtime! debian.vim

" Uncomment the next line to make Vim more Vi-compatible
" NOTE: debian.vim sets 'nocompatible'.  Setting 'compatible' changes numerous
" options, so any other options should be set AFTER setting 'compatible'.
"set compatible

" Vim5 and later versions support syntax highlighting. Uncommenting the
" following enables syntax highlighting by default.
if has("syntax")
  syntax on
endif

" If using a dark background within the editing area and syntax highlighting
" turn on this option as well
"set background=dark

" Uncomment the following to have Vim jump to the last position when
" reopening a file
if has("autocmd")
  au BufReadPost * if line("'\"") > 1 && line("'\"") <= line("$") | exe "normal! g'\"" | endif
endif

" Uncomment the following to have Vim load indentation rules and plugins
" according to the detected filetype.
if has("autocmd")
  filetype plugin indent on
endif

" The following are commented out as they cause vim to behave a lot
" differently from regular Vi. They are highly recommended though.
set showcmd		" Show (partial) command in status line.
"set showmatch		" Show matching brackets.
set number
set ignorecase		" Do case insensitive matching
set smartcase		" Do smart case matching
set incsearch		" Incremental search
set smartindent
set hlsearch
set autoindent
set cursorline
"set autochdir
set tabstop=4
set shiftwidth=4

nmap ," bi"<ESC>ea"<ESC>
imap ;< <ESC>F<ya<f>pF<a/<ESC>F<i
"let &termencoding=&encoding
set fileencodings=utf-8
"set fileencodings=utf-8,gbk
"set autowrite		" Automatically save before commands like :next and :make
"set hidden             " Hide buffers when they are abandoned
"set mouse=a		" Enable mouse usage (all modes)

" Source a global configuration file if available
if filereadable("/etc/vim/vimrc.local")
  source /etc/vim/vimrc.local
endif

function! MySys() 
	if has("win16") || has("win32") || has("win64") || has("win95")
		return "windows"
	elesif has("linux")
		return "linux"
	endif
endfunction

if MySys() == "windows"
	let $VIMFILES = $VIM.'/vimfiles'
elseif MySys() == "linux"
	let $VIMFILES = $HOME.'/.vim'
endif

let helptags=$VIMFILES.'/doc'

nnoremap <C-X>x	:!<C-R>=getline(".")<CR><CR>

"let Tlist_Show_One_File=1
"let Tlist_Exit_OnlyWindow=1
"
function! Set_modeline()
	normal o# vim: set nu ai sw=4 ts=4 tw=79:
endfunction

function! Gen_python()
	normal GGO#! /usr/bin/python2.7
	normal o# -*- encoding:utf-8 -*-
	call Set_modeline()
	normal j^
endfunction

function! Executable_it()
	silent !sudo  chmod +x %
endfunction

function! Gen_bash()
	normal GGO#! /bin/bash
	call Set_modeline()
	normal j^
endfunction

function! Get_result()
"	let a:no = 0
"	while filereadable('/tmp/out-'. a:no . '.txt')
"		let a:no = a:no + 1
"	endwhile
"	let a:f =  '/tmp/out-' . a:no . '.txt'
	let a:f = tempname()
	let a:cmd = ':silent !./% >'.  a:f
	exe a:cmd
	exe 'pedit'. a:f
endfunction

noremap <C-X>r <Esc>:source ~/.vimrc<CR>
noremap <C-x>y <Esc>:call Gen_python()<CR>:w<CR>:call Executable_it()<CR>
noremap <C-x>b <Esc>:call Gen_bash()<CR>:w<CR>:call Executable_it()<CR>
noremap <C-x>o <Esc>:call Get_result()<CR>:redraw!<CR>

set modeline
