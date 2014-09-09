" vim: et ts=2 sts=2 sw=2

if !exists('g:loaded_windowswap')
  finish
endif

let s:spc = g:airline_symbols.space

function! airline#extensions#windowswap#init(ext)
  call airline#parts#define_function('windowswap', 'airline#extensions#windowswap#get_status')
endfunction

" Finally, this function will be invoked from the statusline.
function! airline#extensions#windowswap#get_status()
  if WindowSwap#HasMarkedWindow() && WindowSwap#GetMarkedWindowNum() == winnr()
    return 'WS'.s:spc
  endif
  return ''
endfunction

