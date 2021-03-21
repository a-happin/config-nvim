

syn keyword cppStatement	rep
syn keyword cppType		basic_string basic_string_view string string_view Iterator ll
syn match cppType		/\v<\k*_t>/
syn keyword cppConstant		nullopt
syn match cppOperatorSymbols	/\v[-+*~&!?:%=<>^|\[\]]|\zs\/\ze[^/*]/
syn match cppUserLiteral	display /\v<\d+_\k+>/

hi def link cppCast Operator
hi def link cppOperatorSymbols Operator
hi def link cppUserLiteral Number
