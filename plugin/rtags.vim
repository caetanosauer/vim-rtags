function! Rtags_references_to_symbol_under_cursor()
    call s:Rtags_query('--references '.bufname('%').':'.line(".").':'.col("."))
endfunction

function! Rtags_follow_symbol_under_cursor()
    call s:Rtags_query('--follow-location '.bufname('%').':'.line(".").':'.col("."))
endfunction

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

    call setloclist(0, location_list)
    lwindow
endfunction

function! s:Echo_error(msg)
    echohl WarningMsg
    echomsg a:msg
    echohl None
endfunction
