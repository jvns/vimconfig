" Vim syntax file
" Language: twee
" Maintainer: thricedotted@gmail.com / who even knows
" Latest Revision: 16 Sep 2013
" Version: 0.1
"
" TODO:
"   - numbers in <<macros>> could be way more robust
"   - different highlighting for choices and actions?
"   - folding stuff???
"   - gui colors/formatting
"   - ugh, probably a lot of things

if !exists("main_syntax")
  if version < 600
    syntax clear
  elseif exists("b:current_syntax")
    finish
  endif
  let main_syntax = 'twee'
endif

" special wordz???
syn keyword     tweeBuiltin         if else endif choice actions set remember print silently endsilently contained
syn keyword     tweeKeywords        lt lte gt gte eq not and or contained
syn keyword     tweeToDo            TODO XXX FIXME

" stuff inside macros
syn match       tweeArithmetic      '[=+-/\*\.]' contained
syn match       tweeVariable        '\$[A-Za-z0-9_]*' contained
syn match       tweeNumber          '[0-9]' contained 
syn match       tweeString          '\".\{-}\"' contained 

" twee code things
syn match       tweeTitle           '^::.*$' contains=tweeTags
syn match       tweeMacro           '<<.\{-}>>' contains=tweeNumber,tweeBuiltin,tweeVariable,tweeString,tweeKeywords,tweeArithmetic
syn region      tweeLink            start="\[\[" end="\]\]"
syn match       tweeTags            '\[.*\]' contained
syn region      tweeComment         start="/%" end="%/"

" line break escape character -- see http://www.glorioustrainwrecks.com/node/5400
syn match       tweeEOL             '\\$'

" other text formatting 
syn region      tweeHTML            start="<html>" end="</html>" 
syn match       tweeItalic          '//.\{-}//'
syn match       tweeUnderline       '__.\{-}__'
syn match       tweeBold            "''.\{-}''"
syn match       tweeList            '^[*#]'

hi def link tweeTitle           Type
hi def link tweeKeywords        Ignore

hi def link tweeToDo            ToDo
hi def link tweeBuiltin         Conditional
hi def link tweeVariable        Identifier
hi def link tweeHTML            Constant

hi def link tweeNumber          Number
hi def link tweeString          String

hi def link tweeTags            Type
hi def link tweeEOL             Comment
hi def link tweeKeywords        Ignor
hi def link tweeMacro           Function
hi def link tweeComment         Comment

" hi def tweeLink                 term=underline cterm=underline ctermfg=red
hi def link tweeLink            Number
hi def tweeItalic               term=italic cterm=italic
hi def tweeUnderline            term=underline cterm=underline
hi def tweeBold                 term=bold cterm=bold
hi def tweeList                 term=bold cterm=bold

let b:current_syntax = "twee"
if main_syntax == 'twee'
  unlet main_syntax
endif
