local fn = vim.fn

local M = {}

function M.executable(name)
  if fn.executable(name) > 0 then
    return true
  end

  return false
end

--- check whether a feature exists in Nvim
--- @param feat string the feature name, like `nvim-0.7` or `unix`.
--- @return boolean
M.has = function(feat)
  if fn.has(feat) == 1 then
    return true
  end

  return false
end

--- Create a dir if it does not exist
function M.may_create_dir(dir)
  local res = fn.isdirectory(dir)

  if res == 0 then
    fn.mkdir(dir, "p")
  end
end

--- Generate random integers in the range [Low, High], inclusive,
--- adapted from https://stackoverflow.com/a/12739441/6064933
--- @param low integer the lower value for this range
--- @param high integer the upper value for this range
--- @return integer
function M.rand_int(low, high)
  -- Use lua to generate random int, see also: https://stackoverflow.com/a/20157671/6064933
  math.randomseed(os.time())

  return math.random(low, high)
end

--- Select a random element from a sequence/list.
--- @param seq any[] the sequence to choose an element
function M.rand_element(seq)
  local idx = M.rand_int(1, #seq)

  return seq[idx]
end

function M.zcd(path)
  -- uv.chdir (no event?), fn.chdir, cmd.cd
  vim.api.nvim_set_current_dir(path)
  if vim.fn.executable("zoxide") == 1 then
    vim.system({ "zoxide", "add", path })
  end
end
local function is_directory(path)
  local stat = vim.uv.fs_stat(path)
  if stat then
    return stat.type == "directory"
  end
  return false
end

local function is_file(path)
  local stat = vim.uv.fs_stat(path)
  if stat then
    return stat.type == "file"
  end
  return false
end
-- 检查一下路径是文件还是文件名
function M.check_path_type(path)
  if is_directory(path) then
    return 1
  end

  if is_file(path) then
    return 2
  end

  return -1
end
function M.get_parent_directory(path)
  local parent_dir = vim.fn.fnamemodify(path, ":h")
  return parent_dir
end

local hf_event_notify = function(mod, msg, level, opts)
  if vim.in_fast_event() then
    vim.schedule(function()
      vim.notify(string.format("[%s] %s", mod, msg), level, opts)
    end)
  else
    vim.notify(string.format("[%s] %s", mod, msg), level, opts)
  end
end

function M.info(mod, msg)
  hf_event_notify(mod, msg, vim.log.levels.INFO, {})
end

function M.warn(mod, msg)
  hf_event_notify(mod, msg, vim.log.levels.WARN, {})
end

function M.err(mod, msg)
  hf_event_notify(mod, msg, vim.log.levels.ERROR, {})
end
return M
