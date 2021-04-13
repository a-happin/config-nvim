

syn keyword cppStatement	rep co_yeild co_await co_return
syn keyword cppStorageClass	consteval requires
syn keyword cppType		byte string string_view Iterator ll regex array vector optional variant tuple
syn match cppType		/\v<\k*_t>/
syn keyword cppStructure	concept
syn keyword cppConstant		nullopt
syn match cppOperatorSymbols	/\v[-+*~&!?:%=<>^|\[\]]|\zs\/\ze[^/*]/
syn match cppUserLiteral	display /\v<\d+_\k+>/

hi def link cppCast Operator
hi def link cppOperatorSymbols Operator
hi def link cppUserLiteral Number
