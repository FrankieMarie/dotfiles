local autopairs = require("nvim-autopairs")
local Rule = require("nvim-autopairs.rule")
local cond = require("nvim-autopairs.conds")

autopairs.setup({
  check_ts = true,
})

-- Pair < > for TS/TSX generics, but only after an identifier (e.g. `Foo<`),
-- so plain `a < b` comparisons aren't auto-paired.
autopairs.add_rule(
  Rule("<", ">", { "typescript", "typescriptreact", "tsx" })
    :with_pair(cond.before_regex("[%w_$]", 1))
    :with_move(function(opts) return opts.char == ">" end)
)

