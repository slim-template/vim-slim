" Vim syntax file
" Language: Slim
" Maintainer: Andrew Stone <andy@stonean.com>
" Version:  1
" Last Change:  2010 Sep 25
" TODO: Feedback is welcomed.

" Quit when a syntax file is already loaded.
if exists("b:current_syntax")
  finish
endif

if !exists("main_syntax")
  let main_syntax = 'slim'
endif

" Allows a per line syntax evaluation.
let b:ruby_no_expensive = 1

" Include Ruby syntax highlighting
syn include @slimRubyTop syntax/ruby.vim
unlet! b:current_syntax
" Include Haml syntax highlighting
syn include @slimHaml syntax/haml.vim
unlet! b:current_syntax
" Include Sass syntax highlighting
syn include @slimSass syntax/sass.vim
unlet! b:current_syntax
" Include Scss syntax highlighting
syn include @slimScss syntax/scss.vim
unlet! b:current_syntax
" Include Erb syntax highlighting
syn include @slimErb syntax/eruby.vim
unlet! b:current_syntax
" Include Coffeescript syntax highlighting, ignoring errors if it's missing
silent! syn include @slimCoffee syntax/coffee.vim
unlet! b:current_syntax

" Include HTML
runtime! syntax/html.vim
unlet! b:current_syntax

setlocal iskeyword+=:

syn match slimBegin  "^\s*\(&[^= ]\)\@!" nextgroup=slimTag,slimClassChar,slimIdChar,slimRuby

syn region  rubyCurlyBlock   start="{" end="}" contains=@slimRubyTop contained
syn cluster slimRubyTop add=rubyCurlyBlock

syn cluster slimComponent  contains=slimClassChar,slimIdChar,slimAttributes,slimRuby,slimOpenAttribute
syn cluster slimAttributeComponents contains=htmlArg,slimAttributeString,htmlEvent,htmlCssDefinition

syn keyword slimDocType contained html 5 1.1 strict frameset mobile basic transitional
syn match slimDocTypeKeyword "^\s*\(doctype\)\s\+" nextgroup=slimDocType

syn match slimTag          "\w\+\(:\w\+\)\="  contained contains=htmlTagName,htmlSpecialTagName nextgroup=@slimComponent
syn match slimIdChar       "#{\@!"            contained nextgroup=slimId
syn match slimId           "\%(\w\|-\)\+"     contained nextgroup=@slimComponent
syn match slimClassChar    "\."               contained nextgroup=slimClass
syn match slimClass        "\%(\w\|-\)\+"     contained nextgroup=@slimComponent

syn region  slimAttributes  matchgroup=slimAttributesDelimiter start="{" end="}" contained contains=@slimAttributeComponents nextgroup=slimRuby
syn region  slimAttributes  matchgroup=slimAttributesDelimiter start="\[" end="\]" contained contains=@slimAttributeComponents nextgroup=slimRuby
syn region  slimAttributes  matchgroup=slimAttributesDelimiter start="(" end=")" contained contains=@slimAttributeComponents nextgroup=slimRuby

syn match   slimAttribute "\(\%(\w\|-\)\+\s*=\s*\%([^\s=]\)\+\)" contains=@slimAttributeComponents nextgroup=slimOpenAttribute,slimRuby

syn region  slimAttributeString start=+\%(=\s*\)\@<='+ skip=+\%(\\\\\)*\\'+ end=+'+ contained contains=slimInterpolation,slimInterpolationEscape
syn region  slimAttributeString start=+\%(=\s*\)\@<="+ skip=+\%(\\\\\)*\\"+ end=+"+ contained contains=slimInterpolation,slimInterpolationEscape

syn region  slimInterpolation matchgroup=slimInterpolationDelimiter start="#{" end="}" contains=@hamlRubyTop containedin=javascriptStringS,javascriptStringD
syn match   slimInterpolationEscape "\\\@<!\%(\\\\\)*\\\%(\\\ze#{\|#\ze{\)"

syn region  slimRuby   matchgroup=slimRubyOutputChar start="[=]\==[']\=" skip=",\s*$" end="$" contained contains=@slimRubyTop keepend
syn region  slimRuby   matchgroup=slimRubyChar       start="-"           skip=",\s*$" end="$" contained contains=@slimRubyTop keepend

syn match slimComment /^\(\s*\)[/].*\(\n\1\s.*\)*/
syn match slimText /^\(\s*\)[`|'].*\(\n\1\s.*\)*/

syn match slimFilter /\s*\w\+:\s*/ contained
syn match slimJs /^\(\s*\)\<javascript:\>.*\(\n\1\s.*\)*/ contains=@htmlJavaScript,slimFilter
syn match slimCoffee /^\(\s*\)\<coffee:\>.*\(\n\1\s.*\)*/ contains=@slimCoffee,slimFilter
syn match slimHaml /^\(\s*\)\<haml:\>.*\(\n\1\s.*\)*/ contains=@slimHaml,slimFilter
syn match slimHaml /^\(\s*\)\<sass:\>.*\(\n\1\s.*\)*/ contains=@slimSass,slimFilter
syn match slimHaml /^\(\s*\)\<scss:\>.*\(\n\1\s.*\)*/ contains=@slimScss,slimFilter
syn match slimErb  /^\(\s*\)\<erb:\>.*\(\n\1\s.*\)*/ contains=@slimErb,slimFilter

syn match slimIEConditional "\%(^\s*/\)\@<=\[\s*if\>[^]]*]" contained containedin=slimComment

hi def link slimBegin                  String
hi def link slimTag                    Special
hi def link slimClassChar              Type
hi def link slimClass                  Type
hi def link slimId                     Identifier
hi def link slimIdChar                 Identifier
hi def link slimAttributeString        String
hi def link slimAttributesDelimiter    Delimiter
hi def link slimInterpolationDelimiter Delimiter
hi def link slimAttributeVariable      Identifier
hi def link slimRubyOutputChar         slimRubyChar
hi def link slimRubyChar               Special
hi def link slimText                   String
hi def link slimComment                Comment
hi def link slimFilter                 Keyword
hi def link slimDocType                Identifier
hi def link slimDocTypeKeyword         Keyword
hi def link slimInterpolationDelimiter Delimiter
hi def link slimIEConditional          SpecialComment
hi def link slimOpenAttribute          Delimiter

let b:current_syntax = "slim"
