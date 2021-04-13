if !has('gui_running') && &t_Co < 256
  finish
endif

hi clear
if exists('syntax_on')
  syntax reset
endif

let g:colors_name = expand ('<sfile>:t:r')

if &background ==# 'dark'
  hi Normal ctermbg=none ctermfg=white guibg=none guifg=white
  hi LineNr cterm=NONE ctermbg=none ctermfg=darkgray gui=NONE guibg=none guifg=darkgray
  hi CursorLineNr cterm=bold ctermbg=black ctermfg=225 gui=bold guibg=black guifg=#ffd7ff
  hi Cursor cterm=reverse ctermbg=none ctermfg=225 gui=reverse guibg=none guifg=#ffd7ff
  hi CursorLine cterm=NONE ctermbg=black gui=NONE guibg=black
  hi CursorColumn ctermbg=black guibg=black
  hi ColorColumn ctermbg=225 guibg=#ffd7ff
  hi CocHighlightText cterm=underline gui=underline
  hi StatusLine cterm=bold ctermbg=yellow ctermfg=black gui=bold guibg=yellow guifg=black
  hi StatusLineNC cterm=NONE ctermbg=darkgray ctermfg=black gui=NONE guibg=darkgray guifg=black
  hi Question ctermbg=none ctermfg=225 guibg=none guifg=#ffd7ff
  hi ModeMsg cterm=bold ctermbg=none ctermfg=225 gui=bold guibg=none guifg=#ffd7ff
  hi MoreMsg cterm=bold ctermbg=none ctermfg=225 gui=bold guibg=none guifg=#ffd7ff
  hi ErrorMsg cterm=bold ctermbg=none ctermfg=red gui=bold guibg=none guifg=red
  hi WarningMsg cterm=bold ctermbg=none ctermfg=226 gui=bold guibg=none guifg=#ffff00
  hi Pmenu cterm=NONE ctermbg=black ctermfg=white gui=NONE guibg=black guifg=white
  hi PmenuSel cterm=reverse ctermbg=black ctermfg=225 gui=reverse guibg=black guifg=#ffd7ff
  hi PmenuSbar ctermbg=darkgray ctermfg=none guibg=darkgray guifg=none
  hi PmenuThumb ctermbg=225 ctermfg=none guibg=#ffd7ff guifg=none
  hi Directory ctermfg=blue guifg=blue
  hi Visual ctermbg=225 ctermfg=black guibg=#ffd7ff guifg=black
  hi WildMenu cterm=bold,reverse ctermbg=black ctermfg=225 gui=bold,reverse guibg=black guifg=#ffd7ff
  hi Comment ctermfg=243 guifg=#767676
  hi Constant ctermfg=red guifg=red
  hi String ctermfg=red guifg=red
  hi Identifier cterm=NONE ctermfg=blue gui=NONE guifg=blue
  hi Function ctermfg=blue guifg=blue
  hi Statement cterm=bold ctermfg=magenta gui=bold guifg=magenta
  hi Label ctermfg=magenta guifg=magenta
  hi Operator cterm=bold ctermfg=magenta gui=bold guifg=magenta
  hi PreProc ctermfg=magenta guifg=magenta
  hi Type cterm=bold ctermfg=yellow gui=bold guifg=yellow
  hi Special cterm=bold ctermfg=225 gui=bold guifg=#ffd7ff
  hi Error cterm=bold ctermbg=red ctermfg=black gui=bold guibg=red guifg=black
  hi Todo cterm=bold ctermbg=226 ctermfg=black gui=bold guibg=#ffff00 guifg=black
  hi Conceal ctermfg=225 guifg=#ffd7ff
  hi TabLine cterm=NONE ctermbg=black ctermfg=white gui=NONE guibg=black guifg=white
  hi TabLineSel cterm=NONE ctermbg=225 ctermfg=black gui=NONE guibg=#ffd7ff guifg=black
  hi TabLineFill cterm=NONE ctermbg=none ctermfg=none gui=NONE guibg=none guifg=none
  hi SpecialKey cterm=NONE ctermfg=225 gui=NONE guifg=#ffd7ff
  hi NonText cterm=NONE ctermfg=225 gui=NONE guifg=#ffd7ff
  hi VertSplit cterm=NONE ctermbg=none ctermfg=darkgray gui=NONE guibg=none guifg=darkgray
  hi IncSearch cterm=bold,reverse ctermbg=none ctermfg=yellow gui=bold,reverse guibg=none guifg=yellow
  hi Search cterm=bold,reverse ctermbg=none ctermfg=yellow gui=bold,reverse guibg=none guifg=yellow
  hi MatchParen ctermbg=white ctermfg=black guibg=white guifg=black
  hi Folded ctermbg=none ctermfg=225 guibg=none guifg=#ffd7ff
  hi FoldColumn ctermbg=none ctermfg=225 guibg=none guifg=#ffd7ff
  hi SignColumn ctermbg=none ctermfg=225 guibg=none guifg=#ffd7ff
  hi SpellBad ctermbg=red ctermfg=black guibg=red guifg=black
  hi SpellCap ctermbg=blue ctermfg=black guibg=blue guifg=black
  hi SpellLocal ctermbg=cyan ctermfg=black guibg=cyan guifg=black
  hi SpellRare ctermbg=magenta ctermfg=black guibg=magenta guifg=black
  hi DiffAdd ctermbg=green ctermfg=black guibg=green guifg=black
  hi DiffChange ctermbg=none guibg=none
  hi DiffText ctermbg=yellow ctermfg=black guibg=yellow guifg=black
  hi DiffDelete ctermbg=red ctermfg=black guibg=red guifg=black
endif
hi! link EndOfBuffer Ignore
hi! link TermCursor Cursor
hi! link ToolbarButton TabLineSel
hi! link ToolbarLine TabLineFill
hi! link cssBraces Delimiter
hi! link cssClassName Special
hi! link cssClassNameDot Normal
hi! link cssPseudoClassId Special
hi! link cssTagName Statement
hi! link helpHyperTextJump Constant
hi! link htmlArg Constant
hi! link htmlEndTag Statement
hi! link htmlTag Statement
hi! link jsonQuote Normal
hi! link phpVarSelector Identifier
hi! link pythonFunction Title
hi! link rubyDefine Statement
hi! link rubyFunction Title
hi! link rubyInterpolationDelimiter String
hi! link rubySharpBang Comment
hi! link rubyStringDelimiter String
hi! link rustFuncCall Normal
hi! link rustFuncName Title
hi! link rustType Constant
hi! link sassClass Special
hi! link shFunction Normal
hi! link vimContinue Comment
hi! link vimFuncSID vimFunction
hi! link vimFuncVar Normal
hi! link vimFunction Title
hi! link vimGroup Statement
hi! link vimHiGroup Statement
hi! link vimHiTerm Identifier
hi! link vimMapModKey Special
hi! link vimOption Identifier
hi! link vimVar Normal
hi! link xmlAttrib Constant
hi! link xmlAttribPunct Statement
hi! link xmlEndTag Statement
hi! link xmlNamespace Statement
hi! link xmlTag Statement
hi! link xmlTagName Statement
hi! link yamlKeyValueDelimiter Delimiter
hi! link CtrlPPrtCursor Cursor
hi! link CtrlPMatch Title
hi! link CtrlPMode2 StatusLine
hi! link deniteMatched Normal
hi! link deniteMatchedChar Title
hi! link elixirBlockDefinition Statement
hi! link elixirDefine Statement
hi! link elixirDocSigilDelimiter String
hi! link elixirDocTest String
hi! link elixirExUnitMacro Statement
hi! link elixirExceptionDefine Statement
hi! link elixirFunctionDeclaration Title
hi! link elixirKeyword Statement
hi! link elixirModuleDeclaration Normal
hi! link elixirModuleDefine Statement
hi! link elixirPrivateDefine Statement
hi! link elixirStringDelimiter String
hi! link jsFlowMaybe Normal
hi! link jsFlowObject Normal
hi! link jsFlowType PreProc
hi! link graphqlName Normal
hi! link graphqlOperator Normal
hi! link gitmessengerHash Comment
hi! link gitmessengerHeader Statement
hi! link gitmessengerHistory Constant
hi! link jsArrowFunction Operator
hi! link jsClassDefinition Normal
hi! link jsClassFuncName Title
hi! link jsExport Statement
hi! link jsFuncName Title
hi! link jsFutureKeys Statement
hi! link jsFuncCall Normal
hi! link jsGlobalObjects Statement
hi! link jsModuleKeywords Statement
hi! link jsModuleOperators Statement
hi! link jsNull Constant
hi! link jsObjectFuncName Title
hi! link jsObjectKey Identifier
hi! link jsSuper Statement
hi! link jsTemplateBraces Special
hi! link jsUndefined Constant
hi! link markdownBold Special
hi! link markdownCode String
hi! link markdownCodeDelimiter String
hi! link markdownHeadingDelimiter Comment
hi! link markdownRule Comment
hi! link ngxDirective Statement
hi! link plug1 Normal
hi! link plug2 Identifier
hi! link plugDash Comment
hi! link plugMessage Special
hi! link SignifySignAdd GitGutterAdd
hi! link SignifySignChange GitGutterChange
hi! link SignifySignChangeDelete GitGutterChangeDelete
hi! link SignifySignDelete GitGutterDelete
hi! link SignifySignDeleteFirstLine SignifySignDelete
hi! link StartifyBracket Comment
hi! link StartifyFile Identifier
hi! link StartifyFooter Constant
hi! link StartifyHeader Constant
hi! link StartifyNumber Special
hi! link StartifyPath Comment
hi! link StartifySection Statement
hi! link StartifySlash Comment
hi! link StartifySpecial Normal
hi! link svssBraces Delimiter
hi! link swiftIdentifier Normal
hi! link typescriptAjaxMethods Normal
hi! link typescriptBraces Normal
hi! link typescriptEndColons Normal
hi! link typescriptFuncKeyword Statement
hi! link typescriptGlobalObjects Statement
hi! link typescriptHtmlElemProperties Normal
hi! link typescriptIdentifier Statement
hi! link typescriptMessage Normal
hi! link typescriptNull Constant
hi! link typescriptParens Normal

