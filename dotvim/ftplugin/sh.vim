set makeprg=shellcheck\ -f\ gcc\ %
"au BufWritePost * :silent make | redraw!
"au QuickFixCmdPost [^l]* nested cwindow
"au QuickFixCmdPost    l* nested lwindow
