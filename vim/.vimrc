if(has("win32") || has("win95") || has("win64") || has("win16")) "判定当前操作系统类型
	let g:iswindows=1
else
	let g:iswindows=0
endif
autocmd BufEnter * lcd %:p:h
set nocompatible "不要vim模仿vi模式，建议设置，否则会有很多不兼容的问题
syntax on	"打开高亮
imap aa <esc>	"map aa to esc key
lang message zh_CN.UTF-8 "deal console 
set encoding=utf-8
set fileencoding=utf-8
set fileencodings=ucs-bom,utf-8,chinese,latinl
language messages zh_CN.utf-8
filetype plugin indent on "根据文件进行缩进
set autoindent " always set autoindenting on 
set cindent
set tabstop=4 "让一个tab等于4个空格
set softtabstop=4
set shiftwidth=4
"set noexpandtab
"set expandtab
"set vb t_vb=
set number
set title
"set nowrap "不自动换行
set hlsearch "高亮显示结果
set incsearch "在输入要搜索的文字时，vim会实时匹配
set backspace=indent,eol,start whichwrap+=<,>,[,] "允许退格键的使用
if(g:iswindows==1) "允许鼠标的使用
	"防止linux终端下无法拷贝
	if has('mouse')
		set mouse=a
	endif
	au GUIEnter * simalt ~x
endif
"字体的设置
set guifont=Bitstream_Vera_Sans_Mono:h9:cANSI "记住空格用下划线代替哦
set gfw=幼圆:h10:cGB2312

"press F12 to update cscope.out's tags for taglist
map <F12> :call Do_CsTag()<CR>
nmap <C-@>s :cs find s <C-R>=expand("<cword>")<CR><CR>:copen<CR>
nmap <C-@>g :cs find g <C-R>=expand("<cword>")<CR><CR>
nmap <C-@>c :cs find c <C-R>=expand("<cword>")<CR><CR>:copen<CR>
nmap <C-@>t :cs find t <C-R>=expand("<cword>")<CR><CR>:copen<CR>
nmap <C-@>e :cs find e <C-R>=expand("<cword>")<CR><CR>:copen<CR>
nmap <C-@>f :cs find f <C-R>=expand("<cfile>")<CR><CR>:copen<CR>
nmap <C-@>i :cs find i ^<C-R>=expand("<cfile>")<CR>$<CR>:copen<CR>
nmap <C-@>d :cs find d <C-R>=expand("<cword>")<CR><CR>:copen<CR>
function Do_CsTag()
	let dir = getcwd()
	if filereadable("tags")
		if(g:iswindows==1)
			let tagsdeleted=delete(dir."\\"."tags")
		else
			let tagsdeleted=delete("./"."tags")
		endif
		if(tagsdeleted!=0)
			echohl WarningMsg | echo "Fail to do tags! I cannot delete the tags" | echohl None
			return
		endif
	endif
	if has("cscope")
		silent! execute "cs kill -1"
	endif
	if filereadable("cscope.files")
		if(g:iswindows==1)
			let csfilesdeleted=delete(dir."\\"."cscope.files")
		else
			let csfilesdeleted=delete("./"."cscope.files")
		endif
		if(csfilesdeleted!=0)
			echohl WarningMsg | echo "Fail to do cscope! I cannot delete the cscope.files" | echohl None
			return
		endif
	endif
	if filereadable("cscope.out")
		if(g:iswindows==1)
			let csoutdeleted=delete(dir."\\"."cscope.out")
		else
			let csoutdeleted=delete("./"."cscope.out")
		endif
		if(csoutdeleted!=0)
			echohl WarningMsg | echo "Fail to do cscope! I cannot delete the cscope.out" | echohl None
			return
		endif
	endif
	if(executable('ctags'))
		"silent!
		"execute
		""!ctags
		-R --c-types=+p --fields=+S *"
		silent! execute "!ctags -R --c++-kinds=+p --fields=+iaS --extra=+q ."
	endif
	if(executable('cscope') && has("cscope") )
		if(g:iswindows!=1)
			silent! execute "!find . -name '*.h' -o -name '*.c' -o -name '*.cpp' -o -name '*.java' -o -name '*.cs' > cscope.files"
		else
			silent! execute "!dir /s/b *.c,*.cpp,*.h,*.java,*.cs >> cscope.files"
		endif
		silent! execute "!cscope -b"
		execute "normal :"
		if filereadable("cscope.out")
			execute "cs add cscope.out"
		endif
	endif
endfunction

"Setting Tlist
"TlistUpdate trigger tags update
"press F3 to show/hide taglist
map <F3> :silent! Tlist<CR> "按下F3就可以呼出了
let Tlist_Ctags_Cmd='ctags' "因为我们放在环境变量里，所以可以直接执行
let Tlist_Use_Right_Window=0 "让窗口显示在右边，0的话就是显示在左边
let Tlist_Show_One_File=0 "让taglist可以同时展示多个文件的函数列表，如果想只有1个，设置为1
let Tlist_File_Fold_Auto_Close=1 "非当前文件，函数列表折叠隐藏
let Tlist_Exit_OnlyWindow=1 "当taglist是最后一个分割窗口时，自动推出vim
let Tlist_Process_File_Always=0 "是否一直处理tags.1:处理;0:不处理。不是一直实时更新tags，因为没有必要
let Tlist_Inc_Winwidth=0
let Tlist_Show_Menu=1 "show taglist menu

"禁用omnicppcomplete的预览窗口
set completeopt=menu

"对NERD_commenter的设置
let NERDShutUp=1
"setting nerdcommenter shortcuts
"<leader> +cc comment set
"<leader> +cu comment unset
let mapleader="`"

"doxygen toolkit 
":Dox to comment a function
":DoxAuthor to comment a file
"let g:DoxygenToolkit_authorName="qingluo"
"let g:DoxygenToolkit_briefTag_pre="@brief\t"
"let g:DoxygenToolkit_paramTag_pre="@param\t"
"let g:DoxygenToolkit_returnTag="@return\t"
"let g:DoxygenToolkit_blockHeader="**************************************************************************"
"let g:DoxygenToolkit_blockFooter="**************************************************************************"
""license can be GPL2.0, BSD, corporation license, owner self license
""let g:DoxygenToolkit_licenseTag="GPL2.0"
"
"let g:DoxygenToolkit_authorName="qingluo,eagleqingluo@gmail.com"
"let s:licenseTag = '"****************************************************"
"let s:licenseTag = s:licenseTag."\<enter>Copyright(C)2009,T-CHIP Co.,Ltd.All Rights Reserved."
"let g:DoxygenToolkit_licenseTag = s:licenseTag
"let g:DoxygenToolkit_briefTag_funcName="yes"
"let g:doxygen_enhanced_color=1

"new doxygen notes
let g:DoxygenToolkit_startCommentTag="/*******************************************************"
let g:DoxygenToolkit_startCommentBlock="/*******************************************************"
let g:DoxygenToolkit_endCommentTag="*******************************************************/"
let g:DoxygenToolkit_endCommentBlock="*******************************************************/"
let g:DoxygenToolkit_authorTag="Author: "
let g:DoxygenToolkit_authorName="qingluo,eagleqingluo@gmail.com"
let g:DoxygenToolkit_fileTag="File: "
let g:DoxygenToolkit_dateTag="Date: "
let g:DoxygenToolkit_licenseTag="Copyright(C)2009,T-CHIP Co.,Ltd.All Rights Reserved."
let g:DoxygenToolkit_briefTag_funcName="yes"
let g:DoxygenToolkit_compactDoc="yes"
let g:DoxygenToolkit_paramTag_pre="Parameter: "
let g:DoxygenToolkit_returnTag="Return: "

"setting ctags files 
set tags=tags,./tags;
set autochdir 

"color settings
"hi Normal ctermfg=darkcyan
"set t_Co=256
"let g:solarized_termcolors= 256
"colorscheme solarized
"if has('gui_running')
"	set background=light
"else
"	set background=dark
"endif
