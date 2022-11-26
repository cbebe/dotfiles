" https://forum.rescript-lang.org/t/formatting-with-neoformat/2444
function! neoformat#formatters#rescript#enabled() abort
    return ['rescript']
endfunction

function! neoformat#formatters#rescript#rescript() abort
    return {
        \ 'exe': 'rescript',
        \ 'args': ['format', '-stdin', '.res'],
        \ 'stdin': 1,
        \ 'try_node_exe': 1,
        \ }
endfunction
