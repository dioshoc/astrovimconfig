local ls = require("luasnip")
local s = ls.snippet
local sn = ls.snippet_node
local isn = ls.indent_snippet_node
local t = ls.text_node
local i = ls.insert_node
local f = ls.function_node
local c = ls.choice_node
local d = ls.dynamic_node
local r = ls.restore_node
local events = require("luasnip.util.events")
local ai = require("luasnip.nodes.absolute_indexer")
local extras = require("luasnip.extras")
local l = extras.lambda
local rep = extras.rep
local p = extras.partial
local m = extras.match
local n = extras.nonempty
local dl = extras.dynamic_lambda
local fmt = require("luasnip.extras.fmt").fmt
local fmta = require("luasnip.extras.fmt").fmta
local conds = require("luasnip.extras.expand_conditions")
local postfix = require("luasnip.extras.postfix").postfix
local types = require("luasnip.util.types")
local parse = require("luasnip.util.parser").parse_snippet
local ms = ls.multi_snippet
local k = require("luasnip.nodes.key_indexer").new_key


return { 
  ls.add_snippets( 
    "typescriptreact",
    { s("cb", {
      t"<Components.Block templateName='", i(1), t"'>", i(2), t"</Components.Block>"
    })}
  ),
    ls.add_snippets( 
    "typescriptreact",
    { s("cb", {
      t"<Components.Button templateName='", i(1), t"'>", i(2), t"</Components.Button>"
    })}
  ),
  ls.add_snippets( 
    "typescriptreact",
    { s("ci", {
      t"<Components.Icon name='", i(1), t"'/>"
    })}
  ),
  ls.add_snippets( 
    "typescriptreact",
    { s("ci", {
      t"<Components.Image src={utils.getPublicUrl(", i(1), t")} className={`${mainClass}__img`}/>"
    })}
  ),
  ls.add_snippets(
    "typescriptreact",
    { s("cs", {
      t"<Components.Snippet templateName='", i(1), t"'>", i(2), t"</Components.Snippet>"
    })}
  ),
  -------- media query start --------
  ls.add_snippets(
    "scss",
    { s("mxs", {
      t"@media (min-width: $screen-xs) {", i(1), t"}"
    })}
  ),
  ls.add_snippets(
    "scss",
    { s("msm", {
      t"@media (min-width: $screen-sm) {", i(1), t"}"
    })}
  ),
  ls.add_snippets(
    "scss",
    { s("mmd", {
      t"@media (min-width: $screen-md) {", i(1), t"}"
    })}
  ),
  ls.add_snippets(
    "scss",
    { s("mlg", {
      t"@media (min-width: $screen-lg) {", i(1), t"}"
    })}
  ),
  ls.add_snippets(
    "scss",
    { s("mxl", {
      t"@media (min-width: $screen-xl) {", i(1), t"}"
    })}
  ),
  ls.add_snippets(
    "scss",
    { s("mxxl", {
      t"@media (min-width: $screen-xxl) {", i(1), t"}"
    })}
  ),
  ls.add_snippets(
    "scss",
    { s("mxxs", {
      t"@media (max-width: $screen-xs) {", i(1), t"}"
    })}
  ),
  ls.add_snippets(
    "scss",
    { s("mxsm", {
      t"@media (max-width: $screen-sm) {", i(1), t"}"
    })}
  ),
  ls.add_snippets(
    "scss",
    { s("mxmd", {
      t"@media (max-width: $screen-md) {", i(1), t"}"
    })}
  ),
  ls.add_snippets(
    "scss",
    { s("mxlg", {
      t"@media (max-width: $screen-lg) {", i(1), t"}"
    })}
  ),
  ls.add_snippets(
    "scss",
    { s("mxxl", {
      t"@media (max-width: $screen-xl) {", i(1), t"}"
    })}
  ),
  ls.add_snippets(
    "scss",
    { s("mxxxl", {
      t"@media (max-width: $screen-xxl) {", i(1), t"}"
    })}
  ),
  ls.add_snippets(
    "scss",
    { s("_576", {
      t"@media (min-width: $screen-xs) {", i(1), t"}"
    })}
  ),
  ls.add_snippets(
    "scss",
    { s("_768", {
      t"@media (min-width: $screen-sm) {", i(1), t"}"
    })}
  ),
  ls.add_snippets(
    "scss",
    { s("_960", {
      t"@media (min-width: $screen-md) {", i(1), t"}"
    })}
  ),
  ls.add_snippets(
    "scss",
    { s("_1248", {
      t"@media (min-width: $screen-lg) {", i(1), t"}"
    })}
  ),
  ls.add_snippets(
    "scss",
    { s("_1632", {
      t"@media (min-width: $screen-xl) {", i(1), t"}"
    })}
  ),
  ls.add_snippets(
    "scss",
    { s("_1920", {
      t"@media (min-width: $screen-xxl) {", i(1), t"}"
    })}
  ),
  ls.add_snippets(
    "scss",
    { s("_m576", {
      t"@media (max-width: $screen-xs) {", i(1), t"}"
    })}
  ),
  ls.add_snippets(
    "scss",
    { s("_m768", {
      t"@media (max-width: $screen-sm) {", i(1), t"}"
    })}
  ),
  ls.add_snippets(
    "scss",
    { s("_m960", {
      t"@media (max-width: $screen-md) {", i(1), t"}"
    })}
  ),
  ls.add_snippets(
    "scss",
    { s("_m1248", {
      t"@media (max-width: $screen-lg) {", i(1), t"}"
    })}
  ),
  ls.add_snippets(
    "scss",
    { s("_m1632", {
      t"@media (max-width: $screen-xl) {", i(1), t"}"
    })}
  ),
  ls.add_snippets(
    "scss",
    { s("_m1920", {
      t"@media (max-width: $screen-xxl) {", i(1), t"}"
    })}
  ),
  -------- media query end --------
  ------ border radius start ------
  ls.add_snippets(
    "scss",
    { s("brm", {
      t"border-radius: map-get($radius, main);"
    })}
  ),
  ls.add_snippets(
    "scss",
    { s("brp", {
      t"border-radius: map-get($radius, primary);"
    })}
  ),
  ls.add_snippets(
    "scss",
    { s("brs", {
      t"border-radius: map-get($radius, secondary);"
    })}
  ),
  ls.add_snippets(
    "scss",
    { s("brsm", {
      t"border-radius: map-get($radius, small);"
    })}
  ),
  ------- border radius end -------
  ------- text color start  -------
  ls.add_snippets(
    "scss",
    { s("tcp", {
      t"color: var(--text-color-primary);"
    })}
  ),
  ls.add_snippets(
    "scss",
    { s("tcs", {
      t"color: var(--text-color-secondary);"
    })}
  ),
  ls.add_snippets(
    "scss",
    { s("tcc", {
      t"color: var(--text-color-contrast);"
    })}
  )
  ------- text color end --------
 }
