vim9script

# directory where plugins will be stored
var plugin_dir = expand('~/.vim/pack/plugins/opt')

# list of plugins in "user/repo" format
var plugins = [
  'greeschenko/cyberpunk99.vim',
  'yegappan/lsp',
  'liuchengxu/vim-which-key',
  'mg979/vim-visual-multi',
  'SirVer/ultisnips',
  'honza/vim-snippets',
  'girishji/scope.vim',
  #'vim-fuzzbox/fuzzbox.vim',
  'greeschenko/vim9-ollama',
  #'habamax/vim-dir',
]

# -----------------------------
# helper functions
# -----------------------------

def CheckGit()
  if !executable('git')
    echoerr 'Git is required to install plugins'
  endif
enddef

def EnsurePluginDir()
  if !isdirectory(plugin_dir)
    mkdir(plugin_dir, 'p')
  endif
enddef

def PluginName(repo: string): string
  return fnamemodify(repo, ':t')
enddef

def PluginPath(repo: string): string
  return plugin_dir .. '/' .. PluginName(repo)
enddef

# -----------------------------
# install plugin
# -----------------------------

def InstallPlugin(repo: string)
  var path = PluginPath(repo)

  if !isdirectory(path)
    var url = 'https://github.com/' .. repo .. '.git'
    echom 'Installing ' .. repo
    system('git clone --depth 1 ' .. shellescape(url) .. ' ' .. shellescape(path))
  endif
enddef

# -----------------------------
# update plugin
# -----------------------------

def UpdatePlugin(repo: string)
  var path = PluginPath(repo)

  if isdirectory(path)
    echom 'Updating ' .. repo
    system('git -C ' .. shellescape(path) .. ' pull --ff-only')
  endif
enddef

# -----------------------------
# load plugin
# -----------------------------

def LoadPlugin(repo: string)
  var name = PluginName(repo)
  execute 'packadd ' .. name
enddef


# -----------------------------
# load dev plugin
# -----------------------------

packadd vimsidian

g:vimsidian_vault_path = '~/prodev/MIND_VAULT'

# -----------------------------
# install missing plugins and load them
# -----------------------------

def SetupPlugins()
  CheckGit()
  EnsurePluginDir()

  for repo in plugins
    InstallPlugin(repo)
    LoadPlugin(repo)
  endfor
enddef

# -----------------------------
# update all installed plugins
# -----------------------------

def UpdatePlugins()
  CheckGit()

  for repo in plugins
    UpdatePlugin(repo)
  endfor
enddef

# -----------------------------
# user commands
# -----------------------------

command! PluginsInstall SetupPlugins()
command! PluginsUpdate UpdatePlugins()

# -----------------------------
# automatically install and load plugins on startup
# -----------------------------

SetupPlugins()

### CONFIG

g:UltiSnipsExpandTrigger = "<tab>"
g:UltiSnipsJumpForwardTrigger = "<tab>"
g:UltiSnipsJumpBackwardTrigger = "<s-tab>"
g:UltiSnipsListSnippets = "<leader><tab>"
g:UltiSnipsSnippetsDir = "~/.vim/UltiSnips/"
g:UltiSnipsSnippetDirectories = ["UltiSnips"]

call LspOptionsSet({
	aleSupport: v:false,
	autoComplete: v:true,
	autoHighlight: v:false,
	autoHighlightDiags: v:true,
	autoPopulateDiags: v:true,
	completionMatcher: 'case',
	completionMatcherValue: 1,
	diagSignErrorText: '●',
	diagSignHintText: '●',
	diagSignInfoText: '●',
	diagSignWarningText: '●',
	echoSignature: v:false,
	hideDisabledCodeActions: v:false,
	highlightDiagInline: v:true,
	hoverInPreview: v:true,
	completionInPreview: v:false,
	closePreviewOnComplete: v:true,
	ignoreMissingServer: v:false,
	keepFocusInDiags: v:true,
	keepFocusInReferences: v:true,
	completionTextEdit: v:true,
	diagVirtualTextAlign: 'after',
	diagVirtualTextWrap: 'default',
	noNewlineInCompletion: v:false,
	omniComplete: v:null,
	omniCompleteAllowBare: v:false,
	outlineOnRight: v:true,
	outlineWinSize: 20,
	popupBorder: v:true,
	popupBorderHighlight: 'Title',
	popupBorderHighlightPeek: 'Special',
	popupBorderSignatureHelp: v:false,
	popupHighlightSignatureHelp: 'Pmenu',
	popupHighlight: 'Normal',
	semanticHighlight: v:true,
	showDiagInBalloon: v:true,
	showDiagInPopup: v:true,
	showDiagOnStatusLine: v:false,
	showDiagWithSign: v:true,
	showDiagWithVirtualText: v:true,
	showInlayHints: v:false,
	showSignature: v:true,
	snippetSupport: v:true,
	ultisnipsSupport: v:true,
	useBufferCompletion: v:true,
	usePopupInCodeAction: v:false,
	useQuickfixForLocations: v:false,
	vsnipSupport: v:false,
	bufferCompletionTimeout: 100,
	customCompletionKinds: v:false,
	completionKinds: {},
	filterCompletionDuplicates: v:true,
	condensedCompletionMenu: v:true,
    maxDiagnostics: 200,
    showSignatureDocs: v:true,
    documentationFormat: ['markdown', 'plaintext'],
})

var lspServers = [
    {
        name: 'typescriptlang',
        filetype: ['javascript', 'typescript'],
        path: 'typescript-language-server',
        args: ['--stdio'],

    },
    {
        filetype: ['go', 'gomod'],
        path: '/home/olex/prodev/go/bin/gopls',
        args: [],
    }
]

call LspAddServer(lspServers)

#### SETTINGS
set nowrap                 #off wrap logn lines
set wildmenu               #visual autocomplete for command menu
set autoread               #auto reread file after change
set nobackup               #no backups files
set noswapfile             #no swap files
set termencoding=utf-8     #default terminal encoding
set encoding=utf8          #default encoding
set clipboard=unnamed      #use vim clipboard for all terminals
set clipboard+=unnamedplus #use vim clipboard for Xorg(global) clipboard
set incsearch              #on search by typing
set hlsearch               #on search result highlite
set ignorecase
set smartcase
set expandtab              #use spaces to insert <Tab>
set shiftwidth=4           #default tabulation spaces number for indentation
set softtabstop=4          #default tabulation spaces number for <Tab> or <BS>
set tabstop=4              #default tabulation staces for auto indentation
set ttyfast                #on fast terminal
set laststatus=2           #status line alveys on
set statusline=%f\ %h%m%r\ %=%-14.(%l,%c%V%)\ %P
##
set background=dark
if (has("termguicolors"))
   set termguicolors
endif
syntax enable
colorscheme cyberpunk99
set timeoutlen=100
set smoothscroll
##OFF SETTINGS
##
##   set nocompatible
set smartindent
set autoindent
##   set cindent
##   set signcolumn=yes         #Whether or not to draw the signcolumn.
##   set lazyredraw             #on lazy redraw screen
set nocursorcolumn           #on cursor column
set nocursorline             #on cursor column
set colorcolumn=             #is a comma-separated list of screen columns that are highlighted with ColorColumn
set updatetime=300          # Having longer updatetime (default is 4000 ms = 4 s) leads to noticeable
set hidden                  #do not unload buffer then select enother
set maxmempattern=5000
##   set modifiable             #switching from an unsaved buffer
##   set mmp=5000               #Maximum amount of memory (in Kbyte) to use for pattern matching.
##   set nu                     #on line numbers
##   set relativenumber         #on relative numbers by default
##   set showmatch              #on show match breakets
##   set showtabline=1          #on tabline alveys show
##   set complete=
##   set complete+=. #from current buffer
##   set complete+=k #from dictionary
##   set complete+=b #from other buffers
##   set completeopt=menuone,noinsert,noselect,preview
##
set splitright
set splitbelow
set mouse=a
set scrolloff=8

highlight link Extra Comment

###HIGHLITE

highlight Git guibg=#F34F29 guifg=#FFFFFF ctermbg=202 ctermfg=231
##highlight link LspDiagLine NONE
highlight link LspDiagVirtualText WarningMsg
highlight link LspDiagVirtualTextError WarningMsg
highlight link LspDiagVirtualTextWarning MoreMsg
highlight link LspDiagVirtualTextInfo Comment
highlight link LspDiagVirtualTextHint MoreMsg

highlight link LspDiagSignErrorText WarningMsg
highlight link LspDiagSignWarningText MoreMsg
highlight link LspDiagSignInfoText Comment
highlight link LspDiagSignHintText MoreMsg

highlight link LspDiagInlineError WarningMsg
highlight link LspDiagInlineWarning MoreMsg
highlight link LspDiagInlineInfo Comment
highlight link LspDiagInlineHint NONE


###KEYMAPS
g:mapleader = "\<Space>"
g:maplocalleader = ','
nnoremap <silent> <leader>      :<c-u>WhichKey '<Space>'<CR>
vnoremap <silent> <leader>      :<c-u>WhichKeyVisual '<Space>'<CR>

which_key#register('<Space>', "g:which_key_map", "n")
which_key#register('<Space>', "g:which_key_map_visual", "v")

g:which_key_map =  {}
g:which_key_map.f = { 'name': '+FZF' }
g:which_key_map.c = { 'name': '+COMMENT' }
g:which_key_map.g = { 'name': '+GIT' }
g:which_key_map.l = { 'name': '+LSP'}
g:which_key_map.l.e = { 'name': '+Diag'}
g:which_key_map.s = { 'name': '+STARGATE' }
g:which_key_map.s.f = 'for 1 character search'
g:which_key_map.s.F = 'for 2 character search'
g:which_key_map.s.w = 'for the start of a word'
g:which_key_map.s.e = 'for the end of a word'
g:which_key_map.s.l = 'for the start of a line'
g:which_key_map.s.E = 'for the last character on the line'
g:which_key_map.s['$'] = 'for the end of a line'
g:which_key_map.s['['] = 'for the any bracket'
g:which_key_map.n = { 'name': '+TREE' }
g:which_key_map.v = { 'name': '+SELECT' }
g:which_key_map.v.l = 'line text'

g:which_key_map_visual = {}

nmap <leader>q ZZ
nmap <C-s> :w<cr>

nmap <C-h> <C-w>h
nmap <C-l> <C-w>l
nmap <C-j> <C-w>j
nmap <C-k> <C-w>k

#all line selected without whitespaces
nmap <leader>vl ^v$h

nmap <silent> <esc> :nohlsearch<return>

vmap < <gv
vmap > >gv
nmap > :bn<CR>
nmap < :bp<CR>

#nmap <leader>c :bd<CR>
##nmap <leader>/  :FuzzyInBuffer<CR>
##nmap <leader>b  :FuzzyBuffers<CR>
##nmap <leader>;  :FuzzyRegisters<CR>
##nmap <leader>.  :FuzzyFiles<cr>
##nmap <leader>fo :FuzzyMru<cr>
##nmap <leader>fg :FuzzyGrep<cr>
##nmap <leader>fm :FuzzyMarks<cr>
nmap <leader>/  :Scope BufSearch<CR>
nmap <leader>b  :Scope Buffer<CR>
nmap <leader>;  :Scope Register<CR>
nmap <leader>.  :Scope File<cr>
nmap <leader>fo :Scope MRU<cr>
nmap <leader>fg :Scope Grep<cr>
nmap <leader>fm :Scope Mark<cr>
nmap <leader>fh :Scope CmdHistory<cr>

nmap <silent> <leader>lD :LspGotoDeclaration<CR>
nmap <silent> <leader>ld :LspGotoDefinition<CR>
nmap <leader>li          :LspGotoImpl<CR>
nmap <leader>lt          :LspGotoTypeDef<CR>
nmap <leader>lr          :LspShowReferences<CR>
nmap <leader>la          :LspCodeAction<CR>
nmap <leader>ln          :LspRename<CR>
nmap <leader>K           :LspHover<CR>
nmap <leader>len         :LspDiagNext<CR>
nmap <leader>lep         :LspDiagPrev<CR>
nmap <leader>lel         :LspDiagShow<CR>
nmap <leader>lf          :LspFormat<CR>

nmap <leader>e           :Explore<CR>

nmap <leader>mt 0eviwyeea `json:"ýapbvuea,omitemptyýa^[0j

def g:SynStack()
  if !exists("*synstack")
    return
  endif
  echo map(synstack(line('.'), col('.')), 'synIDattr(v:val, "name")')
enddef
