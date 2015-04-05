set shell=/bin/sh
set nocompatible
set autoindent
set hidden
filetype off

set rtp+=~/.vim/bundle/Vundle.vim/
call vundle#rc()

" Let Vundle manage Vundle
Bundle 'gmarik/vundle'

" My Bundles
Bundle 'tpope/vim-sensible'
Bundle 'tpope/vim-surround'
Bundle 'tpope/vim-fugitive'
Bundle 'tpope/vim-rails'
Bundle 'tpope/vim-rake'
Bundle 'nanotech/jellybeans.vim'
" "Bundle 'Lokaltog/vim-powerline'
Bundle 'Lokaltog/vim-easymotion'
Bundle 'scrooloose/syntastic'
Bundle 'scrooloose/nerdtree'
Bundle 'kien/ctrlp.vim'
Bundle 'rking/ag.vim'
Bundle 'kana/vim-textobj-user'
Bundle 'nelstrom/vim-textobj-rubyblock'
Bundle 'slim-template/vim-slim'
Bundle 'jeetsukumaran/vim-buffergator'
"Bundle 'thoughtbot/vim-rspec'
"Bundle 'jgdavey/tslime.vim'
Bundle 'tomtom/tcomment_vim'
Bundle 'benmills/vimux'
Bundle 'pcragone/vim-turbux'
Bundle 'jingweno/vimux-zeus'

Bundle "MarcWeber/vim-addon-mw-utils"
Bundle "tomtom/tlib_vim"
Bundle "garbas/vim-snipmate"
Bundle 'Valloric/YouCompleteMe'
Bundle 'milkypostman/vim-togglelist'
Bundle 'bkad/CamelCaseMotion'
Bundle 'ecomba/vim-ruby-refactoring'
Bundle 'noprompt/vim-yardoc'
Bundle 'kaichen/vim-snipmate-ruby-snippets'

Bundle 'tpope/vim-endwise'
Bundle 'Chiel92/vim-autoformat'
Bundle 'jiangmiao/auto-pairs'
Bundle 'godlygeek/tabular'
Bundle 'bling/vim-airline'
" Bundle 'vim-php/phpctags'
Bundle 'majutsushi/tagbar'
Bundle 'kchmck/vim-coffee-script'

Bundle 'tpope/vim-haml'
Bundle 'tpope/vim-abolish'

" Optional:
Bundle "honza/vim-snippets"

filetype plugin indent on

let mapleader=","

silent! color jellybeans

set cursorline
set expandtab
set modelines=0
set shiftwidth=2
set clipboard=unnamed
set synmaxcol=180
set textwidth=80
set ttyscroll=10
set encoding=utf-8
set tabstop=2
set nowrap
set number
set expandtab
set nowritebackup
set noswapfile
set nobackup
set hlsearch
set ignorecase
set smartcase

"" Automatic formatting
autocmd BufWritePre *.rb :%s/\s\+$//e
autocmd BufWritePre *.go :%s/\s\+$//e
autocmd BufWritePre *.haml :%s/\s\+$//e
autocmd BufWritePre *.html :%s/\s\+$//e
autocmd BufWritePre *.scss :%s/\s\+$//e
autocmd BufWritePre *.slim :%s/\s\+$//e

au BufNewFile * set noeol
au BufRead,BufNewFile *.go set filetype=go

" No show command
autocmd VimEnter * set nosc

" Quick ESC
imap jj <ESC>
"imap jj <ESC>:SyntasticCheck<CR>

" Use paste with F10
nnoremap <F10> :set invpaste paste?<CR>
set pastetoggle=<F10>

" Jump to the next row on long lines
map <Down> gj
map <Up>   gk
nnoremap j gj
nnoremap k gk

" format the entire file
nmap <leader>fef ggVG=

" Open new buffers
nmap <leader>s<left>   :leftabove  vnew<cr>
nmap <leader>s<right>  :rightbelow vnew<cr>
nmap <leader>s<up>     :leftabove  new<cr>
nmap <leader>s<down>   :rightbelow new<cr>

" Tab between buffers
noremap <tab> <c-w><c-w>

" Switch between last two buffers
nnoremap <leader><leader> <C-^>

" Resize buffers
if bufwinnr(1)
  nmap Ä <C-W><<C-W><
  nmap Ö <C-W>><C-W>>
  nmap ö <C-W>-<C-W>-
  nmap ä <C-W>+<C-W>+
endif

" NERDTree
nmap <leader>n :NERDTreeToggle<CR>
let NERDTreeHighlightCursorline=1
let NERDTreeIgnore = ['tmp', '.yardoc', 'pkg']
let NERDTreeQuitOnOpen = 1
"nmap <silent> <C-D> :NERDTreeToggle<CR>
nmap <silent> <C-D> :call g:WorkaroundNERDTreeToggle()<CR>

function! g:WorkaroundNERDTreeToggle()
    try | :NERDTreeToggle | catch | :NERDTree | endtry
  endfunction

autocmd vimenter * if !argc() | NERDTree | endif
autocmd bufenter * if (winnr("$") == 1 && exists("b:NERDTreeType") && b:NERDTreeType == "primary") | quit | endif

" Syntastic
"let g:syntastic_mode_map = { 'mode': 'active' }
let g:syntastic_mode_map = {
    \ "mode": "active",
    \ "passive_filetypes": ["haml", "scss", "sass"] }
"let g:syntastic_ruby_exec = '~/.rvm/rubies/ruby-2.1.5/bin/ruby'
let g:syntastic_check_on_open=1
let g:syntastic_enable_signs=1
"let g:syntastic_auto_jump=3
""let g:syntastic_ruby_mri_exec = '/Users/pragone/.rvm/rubies/ruby-2.1.5/bin/ruby'

" CtrlP
nnoremap <silent> t :CtrlP<cr>
let g:ctrlp_working_path_mode = 2
let g:ctrlp_by_filename = 1
let g:ctrlp_max_files = 600
let g:ctrlp_max_depth = 5

" Buffergator
let g:buffergator_suppress_keymaps = "1"
nmap <Leader>d :BuffergatorToggle<CR>
nmap fg :BuffergatorMruCyclePrev<CR>
" nnoremap <silent> <M-b> :BuffergatorMruCyclePrev<CR>
" nnoremap <silent> <M-S-b> :BuffergatorMruCycleNext<CR>
" nnoremap <silent> [b :BuffergatorMruCyclePrev<CR>
" nnoremap <silent> ]b :BuffergatorMruCycleNext<CR>

" RSpec
"map <Leader>t :call RunCurrentSpecFile()<CR>
"map <Leader>s :call RunNearestSpec()<CR>
"map <Leader>l :call RunLastSpec()<CR>
"map <Leader>a :call RunAllSpecs()<CR>
"let g:rspec_runner = "os_x_iterm"
"let g:rspec_command = 'call VimuxRunCommand("zeus rspec {spec}\n")'
let g:turbux_command_prefix = 'zeus '
let g:no_turbux_mappings = 1
nmap <leader><leader>tr <Plug>SendTestToTmux
nmap <leader><leader>TR <Plug>SendFocusedTestToTmux
nmap <leader><leader>tt <Plug>StoreTmuxLastCommand
nmap <leader><leader>TT <Plug>StoreTmuxLastFocusedCommand
nmap <leader>t <Plug>SendLastTestToTmux
nmap <leader>T <Plug>SendLastFocusedTestToTmux

" Go programming
set rtp+=/usr/local/Cellar/go/1.0.3/misc/vim

" Copy the current line
imap <Leader>d <ESC>yypi
" Put cursor back where it was
"imap <Leader>d <ESC>mzyyp`zi

" Vimux
let g:VimuxUseNearest = 0
map <Leader>vi :VimuxInspectRunner<CR>
map <Leader>vq :VimuxCloseRunner<CR>

" Vimux-Zeus
map <Leader>zc :ZeusConsole<CR>
"map <Leader>zr :ZeusRake spec<CR>
map <Leader>zr :ZeusRake<space>
map <Leader>zg :ZeusGenerate<space>

" Rails

noremap <silent> <Space> :silent noh<Bar>echo<CR>

" Quit with :Q
command -nargs=0 Quit :qa!
cnoreabbrev wq w<bar>bd
cnoreabbrev q bd
cnoreabbrev qa :bufdo bdelete

set tags+=gems.tags

nmap <silent> ]t :tnext<CR>
nmap <silent> [t :tprev<CR>

" SnipMate
imap <C-/> <Plug>snipMateNextOrTrigger
smap <C-/> <Plug>snipMateNextOrTrigger

let g:rails_projections = {
      \ "config/projections.json": {
      \   "command": "projections"
      \ },
      \ "spec/features/*_spec.rb": {
      \   "command": "feature",
      \   "template": "require 'spec_helper'\n\nfeature '%h' do\n\nend",
      \ }}
 
let g:rails_gem_projections = {
      \ "active_model_serializers": {
      \   "app/serializers/*_serializer.rb": {
      \     "command": "serializer",
      \     "affinity": "model",
      \     "test": "spec/serializers/%s_spec.rb",
      \     "related": "app/models/%s.rb",
      \     "template": "class %SSerializer < ActiveModel::Serializer\nend"
      \   }
      \ },
      \ "draper": {
      \   "app/decorators/*_decorator.rb": {
      \     "command": "decorator",
      \     "affinity": "model",
      \     "test": "spec/decorators/%s_spec.rb",
      \     "related": "app/models/%s.rb",
      \     "template": "class %SDecorator < Draper::Decorator\nend"
      \   }
      \ },
      \ "factory_girl_rails": {
      \   "spec/factories.rb": {
      \     "command": "factory",
      \     "affinity": "collection",
      \     "alternate": "app/models/%i.rb",
      \     "related": "db/schema.rb#%s",
      \     "test": "spec/models/%i_test.rb",
      \     "template": "FactoryGirl.define do\n  factory :%i do\n  end\nend",
      \     "keywords": "factory sequence"
      \   }
      \ }}
map <F11> :echo "hi<" . synIDattr(synID(line("."),col("."),1),"name") . '> trans<'
      \ . synIDattr(synID(line("."),col("."),0),"name") . "> lo<"
      \ . synIDattr(synIDtrans(synID(line("."),col("."),1)),"name") . ">"<CR>


" Tabs/buffers
" nmap <leader>T :enew<CR>
nmap <leader>l :bnext<CR>
nmap <leader>h :bprevious<CR>
nmap <leader>bq :bp <BAR> bd #<CR>
nmap <leader>bl :ls<CR>
nmap ]b :bnext<CR>
nmap [b :bprevious<CR>

" vim-airline
let g:airline#extensions#tabline#enabled = 1
let g:airline#extensions#tabline#fnamemod = ':t'

" vim-togglelist
let g:toggle_list_no_mappings = 1
nmap <script> <silent> <leader>L :call ToggleLocationList()<CR>
nmap <script> <silent> <leader>Q :call ToggleQuickfixList()<CR>

" Tabular.vim
if exists(":Tabularize")
  nmap <Leader>a= :Tabularize /=<CR>
  vmap <Leader>a= :Tabularize /=<CR>
  nmap <Leader>a: :Tabularize /:\zs<CR>
  vmap <Leader>a: :Tabularize /:\zs<CR>
endif

nnoremap <leader>. :CtrlPTag<cr>
nnoremap <silent> <F8> :TagbarToggle<CR>

" Splits
nnoremap <C-J> <C-W><C-J>
nnoremap <C-K> <C-W><C-K>
nnoremap <C-L> <C-W><C-L>
nnoremap <C-H> <C-W><C-H>
set splitbelow
set splitright
" "Max out the height of the current split
" ctrl + w _
" "Max out the width of the current split
" ctrl + w |
" "Normalize all split sizes, which is very handy when resizing terminal
" ctrl + w =
" "Swap top/bottom or left/right split
" Ctrl+W R
" "Break out current window into a new tabview
" Ctrl+W T
" "Close every window in the current tabview but the current one
" Ctrl+W o
