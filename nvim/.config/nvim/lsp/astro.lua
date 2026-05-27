return {
  cmd = { "astro-ls", "--stdio" },
  filetypes = { "astro" },
  root_markers = { "package.json", "tsconfig.json", "jsconfig.json", ".git" },
  init_options = {
    typescript = {},
  },
  before_init = function(_, config)
    if config.init_options.typescript.tsdk then return end
    local node_modules = vim.fs.find("node_modules", {
      path = config.root_dir,
      upward = true,
      limit = math.huge,
    })
    for _, nm in ipairs(node_modules) do
      local ts = nm .. "/typescript"
      local stat = vim.uv.fs_stat(ts)
      if stat and stat.type == "directory" then
        config.init_options.typescript.tsdk = ts .. "/lib"
        return
      end
    end
  end,
}
