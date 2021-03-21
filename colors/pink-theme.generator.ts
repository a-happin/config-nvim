type Color = {
  cui: number | string,
  gui: number | string
}
const HighlightAttribute = {
  NONE: 'NONE',
  bold: 'bold',
  underline: 'underline',
  undercurl: 'undercurl',
  reverse: 'reverse',
  inverse: 'inverse',
  italic: 'italic',
  standout: 'standout',
  strikethough: 'strikethough'
} as const
type HighlightAttribute = typeof HighlightAttribute[keyof typeof HighlightAttribute]

type HighlightArgument = {
  fg?: Color,
  bg?: Color,
  attrs?: HighlightAttribute[],
  guisp?: Color
}

const none = {cui: 'none', gui: 'none'}
const black = {cui: 'black', gui: 'black'}
const white = {cui: 'white', gui: 'white'}
const darkgray = {cui: 'darkgray', gui: 'darkgray'}
const gray = {cui: 'gray', gui: 'gray'}
const red = {cui: 'red', gui: 'red'}
const darkred = {cui: 'darkred', gui: 'darkred'}
const blue = {cui: 'blue', gui: 'blue'}
const green = {cui: 'green', gui: 'green'}
const cyan = {cui: 'cyan', gui: 'cyan'}
const purple = {cui: 'magenta', gui: 'magenta'}
const magenta = {cui: 'magenta', gui: 'magenta'}
const yellow = {cui: 'yellow', gui: 'yellow'}
const orange = {cui: 'darkyellow', gui: 'darkyellow'}
const lime = {cui: 'green', gui: 'green'}
const pink = {cui: 225, gui: '#ffd7ff'}


const accent_color = pink
const accent_bg = black
const sub_color = yellow
const normal = white
const normal_bg = none
const cursorline_color = black
const directory_color = blue
const comment_color = {cui: 243, gui: '#767676'}
const constant_color = red
const identifier_color = blue
const statement_color = magenta
const type_color = yellow
const special_color = accent_color
/* const sub = magenta */
/* const sub2 = {cui: 117, gui: '#87d7ff'} // skyblue */
/* const orange2 = {cui: 208, gui: '#ff8700'} */

const error_red = red//196 // #FF0000
const warning_yellow = {cui: 226, gui: '#ffff00'}

const header = () => console.log (
`if !has('gui_running') && &t_Co < 256
  finish
endif

hi clear
if exists('syntax_on')
  syntax reset
endif

let g:colors_name = expand ('<sfile>:t:r')
`
)

const highlight = (name: string, arg: HighlightArgument) => {
  const opts = []
  if (arg.attrs !== undefined && arg.attrs.length > 0)
  {
    opts.push (`cterm=${arg.attrs.join (',')}`)
  }
  if (arg.bg !== undefined)
  {
    opts.push (`ctermbg=${arg.bg.cui}`)
  }
  if (arg.fg !== undefined)
  {
    opts.push (`ctermfg=${arg.fg.cui}`)
  }
  if (arg.attrs !== undefined && arg.attrs.length > 0)
  {
    opts.push (`gui=${arg.attrs.join (',')}`)
  }
  if (arg.bg !== undefined)
  {
    opts.push (`guibg=${arg.bg.gui}`)
  }
  if (arg.fg !== undefined)
  {
    opts.push (`guifg=${arg.fg.gui}`)
  }
  if (opts.length > 0)
  {
    console.log (`  hi ${name} ${opts.join (' ')}`)
  }
}

header ()
console.log (`if &background ==# 'dark'`)
  // 通常色
  highlight ('Normal', {fg: normal, bg: normal_bg})

  // 通常行番号
  highlight ('LineNr', {fg: darkgray, bg: normal_bg, attrs: ['NONE']})

  // カーソル行番号
  highlight ('CursorLineNr', {fg: accent_color, bg: cursorline_color, attrs: ['bold']})

  // カーソル (効かない…)
  highlight ('Cursor', {fg: accent_color, bg: none, attrs: ['reverse']})

  // カーソル行
  highlight ('CursorLine', {bg: cursorline_color, attrs: ['NONE']})

  // カーソル列
  highlight ('CursorColumn', {bg: cursorline_color})

  // set colorcolumn=80
  highlight ('ColorColumn', {bg: accent_color})

  // coc 単語の上にカーソルを乗せたとき
  highlight ('CocHighlightText', {attrs: ['underline']})


  // ステータスライン
  highlight ('StatusLine', {fg: black, bg: sub_color, attrs: ['bold']})
  // ステータスライン（非アクティブ）
  highlight ('StatusLineNC', {fg: black, bg: darkgray, attrs: ['NONE']})
  // プロンプトメッセージ
  highlight ('Question', {fg: accent_color, bg: normal_bg})
  // -- INSERT --
  highlight ('ModeMsg', {fg: accent_color, bg: normal_bg, attrs: ['bold']})
  // -- More --
  highlight ('MoreMsg', {fg: accent_color, bg: normal_bg, attrs: ['bold']})
  // error
  highlight ('ErrorMsg', {fg: error_red, bg: normal_bg, attrs: ['bold']})
  // warning
  highlight ('WarningMsg', {fg: warning_yellow, bg: normal_bg, attrs: ['bold']})


  // 補完ポップアップ
  highlight ('Pmenu', {fg: white, bg: black, attrs: ['NONE']})
  // 補完ポップアップ選択中アイテム
  highlight ('PmenuSel', {fg: accent_color, bg: accent_bg, attrs: ['reverse']})
  // ポップアップメニューのスクロールバー
  highlight ('PmenuSbar', {fg: none, bg: darkgray})
  // ポップアップメニューのスクロールバーのつまみ
  highlight ('PmenuThumb', {fg: none, bg: accent_color})

  // ディレクトリ
  highlight ('Directory', {fg: directory_color})


  // 選択中
  highlight ('Visual', {fg: accent_bg, bg: accent_color})

  // コマンドライン選択中補完候補
  highlight ('WildMenu', {fg: accent_color, bg: accent_bg, attrs: ['bold', 'reverse']})

  // コメント
  highlight ('Comment', {fg: comment_color})

  // 定数
  highlight ('Constant', {fg: constant_color})

  // 文字列
  highlight ('String', {fg: constant_color})

  // 変数名
  highlight ('Identifier', {fg: identifier_color, attrs: ['NONE']})

  // 関数 クラスメソッドも含む
  highlight ('Function', {fg: identifier_color})

  // 文(ifなど)
  highlight ('Statement', {fg: statement_color, attrs: ['bold']})

  // ラベル
  highlight ('Label', {fg: statement_color})

  // 演算子
  highlight ('Operator', {fg: statement_color, attrs: ['bold']})

  // プリプロセッサ
  highlight ('PreProc', {fg: statement_color})

  // 型
  highlight ('Type', {fg: type_color})

  // 特殊記号? vimの<CR>や行継続\が対応していた
  highlight ('Special', {fg: special_color})

  // エラー　確認できず
  highlight ('Error', {fg: black, bg: error_red, attrs: ['bold']})

  // TODO:
  highlight ('Todo', {fg: black, bg: warning_yellow, attrs: ['bold']})

  // Conceal
  highlight ('Conceal', {fg: accent_color})

  // タブ(非アクティブ)
  highlight ('TabLine', {fg: white, bg: black, attrs: ['NONE']})
  // タブ（アクティブ）
  highlight ('TabLineSel', {fg: accent_bg, bg: accent_color, attrs: ['NONE']})
  // タブ(タブがない部分)
  highlight ('TabLineFill', {fg: none, bg: normal_bg, attrs: ['NONE']})

  // 特殊記号? \V(Ctrl-V押したときに出るやつ)が対応していた
  highlight ('SpecialKey', {fg: accent_color, attrs: ['NONE']})

  // テキストではない? listchars(末尾空白やTab文字)が対応していた
  highlight ('NonText', {fg: accent_color, attrs: ['NONE']})

  // EOF後の~
  /* highlight ('EndOfBuffer', {fg: none, bg: none, attrs: none}) */

  // vsplitしたときの区切り線
  highlight ('VertSplit', {fg: darkgray, bg: none, attrs: ['NONE']})

  // 非表示にするためのグループ？
  // デフォルトのままがいいかも
  /* highlight ('Ignore', {fg: black, bg: none}) */

  // 検索結果
  // インクリメンタル検索中かつ最初にマッチした場所
  highlight ('IncSearch', {fg: sub_color, bg: none, attrs: ['bold', 'reverse']})
  // 上記以外
  highlight ('Search', {fg: sub_color, bg: none, attrs: ['bold', 'reverse']})


  // 対応する括弧
  highlight ('MatchParen', {fg: black, bg: white})

  // 折りたたみ表示
  highlight ('Folded', {fg: accent_color, bg: none})
  // 折りたたみ表示カラム(set foldcolumn=1以上)
  highlight ('FoldColumn', {fg: accent_color, bg: none})

  // 印用カラム? cocがエラー位置表示用に使ってるっぽい
  highlight ('SignColumn', {fg: accent_color, bg: normal_bg})

  // スペル間違い
  highlight ('SpellBad', {fg: black, bg: red})
  // 大文字でなければならない？
  highlight ('SpellCap', {fg: black, bg: blue})
  // ?
  highlight ('SpellLocal', {fg: black, bg: cyan})
  // ?
  highlight ('SpellRare', {fg: black, bg: magenta})

  // vimdiff
  // 追加
  highlight ('DiffAdd', {fg: black, bg: green})
  // 変更した行の文字以外
  highlight ('DiffChange', {bg: none})
  // 変更した行の文字
  highlight ('DiffText', {fg: black, bg: yellow})
  // 削除
  highlight ('DiffDelete', {fg: black, bg: red})

console.log (`endif`)
console.log (
`hi! link EndOfBuffer Ignore
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
`)
