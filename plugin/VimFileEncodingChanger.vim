
if exists('g:loaded_fec ')
    finish
endif
let g:loaded_fec = 1


command! -nargs=* -range EncodingCp932 call VimFileEncodingChanger#open(<line1>,<line2>,<f-args>)


function! VimFileEncodingChanger#open( ... ) abort
    "echo a:0
    "echo a:1
    "echo a:2
    exec('python3 ' . 'encoding(' . a:1 . ',' . a:2 . ' )')
endfunction

python3 << EOF
# -*- coding: utf-8 -*-
import vim

BUFFER_NAME = 'FileEncoding://'
def encoding(start,end):

    vim.command( 'setl enc=utf-8' )
    vim.command( ':e ' + BUFFER_NAME )

    vim.command( 'setl enc=cp932' )
    vim.command( 'autocmd! BufEnter ' + BUFFER_NAME + ' :set enc=cp932')
    vim.command( 'autocmd! BufLeave ' + BUFFER_NAME + ' :set enc=utf-8')
    #bufferが隠れたら削除
    vim.command( 'setl bufhidden=delete' )
    #削除時に保存するか聞かない
    vim.command( 'setl buftype=nowrite' )
EOF
