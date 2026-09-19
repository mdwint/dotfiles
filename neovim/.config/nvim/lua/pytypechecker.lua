-- Detects the type checker a Python project uses, such that the
-- ty LSP and mypy ALE linter don't both report on the same buffer.
local M = {}

local cache = {}

local function detect(root)
  local pyproject = io.open(root .. "/pyproject.toml")
  if not pyproject then return "none" end

  local contents = "\n" .. pyproject:read("a")
  pyproject:close()

  if contents:find("\n%[tool%.ty[%.%]]") then return "ty" end
  if contents:find("\n%[%[?tool%.mypy[%.%]]") then return "mypy" end
  return "none"
end

--- @param bufnr integer
--- @return string checker One of "ty", "mypy" or "none"
--- @return string? root Project root the answer was derived from
function M.get(bufnr)
  local root = vim.fs.root(bufnr, "pyproject.toml")
  if not root then return "none", nil end

  if not cache[root] then cache[root] = detect(root) end
  return cache[root], root
end

return M
