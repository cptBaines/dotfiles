function! GetUniquePropList(propName)
	let hits = execute('g/\W\+;' . a:propName . '\W\+')
	let data = substitute(hits, '[\r\n]*\s\+;' . a:propName, '', 'g')
	return uniq(sort(split(data, ',*\s\+')))
endfunction

function! GetLineIndentLevel(...)
	if a:0 > 0
		let l = a:1
	else 
		let l = line('.')
	endif
	return indent(l)/&tabstop
endfunction

function! GetBranchBound(context, lineno, level, dir)
	if a:dir == 'b'
		let l = a:lineno - 1
		let halt = a:context[0]
		while l > halt && GetLineIndentLevel(l) >= a:level
			let l -= 1
		endwhile
	else 
		let l = a:lineno + 1
		let halt = a:context[1]
		while l < halt && GetLineIndentLevel(l) >= a:level
			let l += 1
		endwhile
	endif
	return l
endfunction	

function! GetWindowIDForBuf(bufnr)
	let winfo = getwininfo()
	for w in winfo
		if w['bufnr'] == a:bufnr
			return w['winnr']
		endif	
	endfor
	return -1	
endfunction	

function! ActivateBuf(bufName, bufType)
	let binfo = getbufinfo(a:bufName)
	if empty(binfo) || binfo[0]['loaded'] == 0
		" Buffer does not exist yet
		exe 'split '.a:bufName
		set ts=4 sw=4
		if a:bufType != ''
			exec 'set buftype='.a:bufType
		endif
	elseif binfo[0]['hidden'] == 1
		exe 'split '.a:bufName
	else
		let wid = GetWindowIDForBuf(binfo[0]['bufnr']) 
		exe wid . 'wincmd w' 
	endif
endfunction

function! ShowMyActions(actions)
	call ActivateBuf('__My_Actions__', 'nofile')
	normal! ggdG
	let l = 0
	for loc in keys(a:actions)
		let r = append('$', loc)
		let r = append('$', a:actions[loc])
	endfor
	let r = append(0, 'GENERATED -- ' . strftime('%F %T'))
endfunction

function! CollectActions(tag, context)
	let actions=[]
	if cursor(a:context[0],1) == -1
		return actions 
	endif
	let tl = search(a:tag, '', a:context[1], 'W')	
	while tl != 0
		let pl = GetBranchBound(a:context, tl, GetLineIndentLevel(tl), 'b') 
		" let pl = FindParentLine(tl)
		if pl != a:context[0] 
			let parent = getline(pl)
			if parent =~ '\t\+\[[^X].*'
				let task = substitute(parent, '^\t\+\(\[.*\)', '\t\1','')
					let p = add(actions, task)	
				endif
			endif
			if cursor(tl+1,1) == -1
				let tl = 0
			endif
			let tl = search(a:tag, '', a:context[1], 'W')	
		endwhile
		return actions 
endfunction

function! ArchiveAll()
	exe 'normal! gg'
	let context = [0,line('$')]
	let context[0] = search('^PROJECTS')
	let context[1] = GetBranchBound(context, context[0], 1, '') 
	let archived = 0
	let fname = expand('%')

	let l = search('^\t\+\[X\] .*','', context[1])
	while l != 0
		let archived = 1
	 	call Archive(fname, context, l)
		let l = search('^\t\+\[X\] .*','', context[1])
	endwhile
	if archived == 1
		call ActivateBuf(fname.'.arch','')
		exe 'wq'
		exe 'w'
		" call ActivateBuf(fname,'')
	endif

endfunction

function! GetNodePath(context, lineno, ident)
	let l = a:lineno 
	let i = a:ident
	let nodePath = ""
	let pat = '^\t*\([^\t].*\)'
	let l = GetBranchBound(a:context, l, i, 'b')
	while l > a:context[0]
		let nodePath = substitute(getline(l), pat,'\1', '').'/'.nodePath
		let i -= 1
		let l = GetBranchBound(a:context, l, i, 'b')
	endwhile
	exe a:lineno
	return nodePath
endfunction

" observ the CTRL_V + CTRL_T  in the strings they 
" are there to produce that indentation
function! GetArchiveNode(context, lineno, ident)
	let an = []
	let l = add(an, '	ARCH')
	let l = add(an, '		;ARCH_TIME: ' . strftime('%F %T'))
	let l = add(an, '		;ARCH_FILE: ' . expand('%'))
	let l = add(an, '		;ARCH_NODEPATH: '
\			. GetNodePath(a:context, a:lineno, a:ident))
	return an
endfunction

function! Archive(fname, context, lineno)
	let ident = GetLineIndentLevel(a:lineno)
	let endOfBranch = GetBranchBound(a:context, a:lineno, (ident+1), '') 
	let scount = endOfBranch - a:lineno 
	if scount < 1
		return
	endif
  let strcnt = (scount == 1 ?  "" : scount - 1)

	let original = getreg('"')
 	let otype	= getregtype('"')
	call setreg('"',"")

	" Extract node to arcive and create metadata
	exe a:lineno
	exe 'normal! ' . strcnt	.'dj'
	" we have removed lines from buf so reduce context
	let a:context[1] = a:context[1] - strcnt
	let archbranch = getreg('"')
	let archInfo = GetArchiveNode(a:context, a:lineno, ident)

	let arch = substitute(archbranch, '\t\{'.ident.'\}\(\t*[^\t\n\r]\+\)', '\1', 'g')

	" Insert Archive data into archive buffer
	call ActivateBuf(a:fname.'.arch','')
	let l = append(0,split(arch, '\v\n'))
	let l = append(1,archInfo)
	call setreg('"', original, otype)	

	" Jump back to GDT buffer
	call ActivateBuf(expand('#'),'')
endfunction

function! ShowActions()
	exe 'normal! gg'
	let context = [0,line('$')]
	let context[0] = search('^PROJECTS')
	let context[1] = GetBranchBound(context, context[0], 1, '') 
	let actions = {} 

	for item in GetUniquePropList('TAGS:')
		let actions[item] = CollectActions(item, context)
	endfor	
	call ShowMyActions(actions)
endfunction

" mapgings {{{1
nnoremap <localleader>aa :call ArchiveAll()<cr>
nnoremap <localleader>sa :call ShowActions()<cr>
" }}}1
