command! RtagsFollowSymbolUnderCursor call <SID>Rtags_query('--follow-location '.s:Rtags_get_current_location())
command! RtagsFindRefsToSymbolUnderCursor call <SID>Rtags_query('--references '.s:Rtags_get_current_location())
command! RtagsGetTypeOfSymbolUnderCursor call <SID>Rtags_get_type_of_symbol_under_cursor()

command! -nargs=1 RtagsFind call <SID>Rtags_query('--match-icase --find-symbols '.<f-args>)
command! -nargs=1 RtagsRegexFind call <SID>Rtags_query('--match-icase --match-regexp --find-symbols '.<f-args>)


function! s:Rtags_query(arguments)
    let location_list = []
    let rc_output = system('rc --absolute-path '.a:arguments)
    if ! v:shell_error
        for ref in split(rc_output, '\n')
            let ANY='.\{-}'
            let matches = matchlist(ref, '\('.ANY.'\):\('.ANY.'\):'.ANY.':\t\(.*\)')
            if len(matches) == 0
                call s:Echo_error(ref)
                continue
            endif
            let [ref, pathname, line_number, line_text; unused_elements] = matches
            let location_list += [{'filename':pathname, 'lnum':line_number, 'text':line_text}]
        endfor
    else
        call s:Echo_error("Failed with error code ".v:shell_error.". ".rc_output)
    endif

    lclose
    call setloclist(0, location_list)
    lwindow
endfunction

function! s:Rtags_get_type_of_symbol_under_cursor()
    let l:rc_output = system('rc --absolute-path --symbol-info '.s:Rtags_get_current_location())
    if ! v:shell_error
        let l:lines = split(l:rc_output, '\n')
        let l:lnindex = match(l:lines, '^Type: .*')
        if l:lnindex == -1
            call s:Echo_error("Unknown error")
        else
            echomsg l:lines[l:lnindex]
        endif
    else
        call s:Echo_error("Failed with error code ".v:shell_error.". ".l:rc_output)
    endif
endfunction

function! s:Rtags_get_current_location()
    return bufname('%').':'.line('.').':'.col('.')
endfunction

function! s:Echo_error(msg)
    echohl WarningMsg
    echomsg a:msg
    echohl None
endfunction
