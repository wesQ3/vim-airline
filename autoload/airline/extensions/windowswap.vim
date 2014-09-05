" vim: et ts=2 sts=2 sw=2

if !exists('g:loaded_windowswap')
  finish
endif

let s:spc = g:airline_symbols.space

" First we define an init function that will be invoked from extensions.vim
function! airline#extensions#windowswap#init(ext)
  " Here we define a new part for the plugin.  This allows users to place this
  " extension in arbitrary locations.
  " call airline#parts#define_raw('windowswap', '%{airline#extensions#windowswap#get_status()}')
  call airline#parts#define_function('windowswap', 'airline#extensions#windowswap#get_status')

  " Next up we add a funcref so that we can run some code prior to the
  " statusline getting modifed.
  call a:ext.add_statusline_func('airline#extensions#windowswap#apply')

  " You can also add a funcref for inactive statuslines.
  " call a:ext.add_inactive_statusline_func('airline#extensions#windowswap#unapply')
endfunction

" This function will be invoked just prior to the statusline getting modified.
function! airline#extensions#windowswap#apply(...)
  " first we check if there's already a window-local override,
  " and if not, create it off of the global section.
  let w:airline_section_z = get(w:, 'airline_section_z', g:airline_section_z)

  " Then we just append this extenion to it, optionally using separators.
  let w:airline_section_z = '%{airline#extensions#windowswap#get_status()}'.s:spc.w:airline_section_z
endfunction

" Finally, this function will be invoked from the statusline.
function! airline#extensions#windowswap#get_status()
  if WindowSwap#HasMarkedWindow() && WindowSwap#GetMarkedWindowNum() == winnr()
    return 'WS Marked'
  endif
  return ''
endfunction

