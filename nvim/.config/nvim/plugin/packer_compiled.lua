-- Automatically generated packer.nvim plugin loader code

if vim.api.nvim_call_function('has', {'nvim-0.5'}) ~= 1 then
  vim.api.nvim_command('echohl WarningMsg | echom "Invalid Neovim version for packer.nvim! | echohl None"')
  return
end

vim.api.nvim_command('packadd packer.nvim')

local no_errors, error_msg = pcall(function()

_G._packer = _G._packer or {}
_G._packer.inside_compile = true

local time
local profile_info
local should_profile = false
if should_profile then
  local hrtime = vim.loop.hrtime
  profile_info = {}
  time = function(chunk, start)
    if start then
      profile_info[chunk] = hrtime()
    else
      profile_info[chunk] = (hrtime() - profile_info[chunk]) / 1e6
    end
  end
else
  time = function(chunk, start) end
end

local function save_profiles(threshold)
  local sorted_times = {}
  for chunk_name, time_taken in pairs(profile_info) do
    sorted_times[#sorted_times + 1] = {chunk_name, time_taken}
  end
  table.sort(sorted_times, function(a, b) return a[2] > b[2] end)
  local results = {}
  for i, elem in ipairs(sorted_times) do
    if not threshold or threshold and elem[2] > threshold then
      results[i] = elem[1] .. ' took ' .. elem[2] .. 'ms'
    end
  end
  if threshold then
    table.insert(results, '(Only showing plugins that took longer than ' .. threshold .. ' ms ' .. 'to load)')
  end

  _G._packer.profile_output = results
end

time([[Luarocks path setup]], true)
local package_path_str = "/Users/nathan/.cache/nvim/packer_hererocks/2.1.1710088188/share/lua/5.1/?.lua;/Users/nathan/.cache/nvim/packer_hererocks/2.1.1710088188/share/lua/5.1/?/init.lua;/Users/nathan/.cache/nvim/packer_hererocks/2.1.1710088188/lib/luarocks/rocks-5.1/?.lua;/Users/nathan/.cache/nvim/packer_hererocks/2.1.1710088188/lib/luarocks/rocks-5.1/?/init.lua"
local install_cpath_pattern = "/Users/nathan/.cache/nvim/packer_hererocks/2.1.1710088188/lib/lua/5.1/?.so"
if not string.find(package.path, package_path_str, 1, true) then
  package.path = package.path .. ';' .. package_path_str
end

if not string.find(package.cpath, install_cpath_pattern, 1, true) then
  package.cpath = package.cpath .. ';' .. install_cpath_pattern
end

time([[Luarocks path setup]], false)
time([[try_loadstring definition]], true)
local function try_loadstring(s, component, name)
  local success, result = pcall(loadstring(s), name, _G.packer_plugins[name])
  if not success then
    vim.schedule(function()
      vim.api.nvim_notify('packer.nvim: Error running ' .. component .. ' for ' .. name .. ': ' .. result, vim.log.levels.ERROR, {})
    end)
  end
  return result
end

time([[try_loadstring definition]], false)
time([[Defining packer_plugins]], true)
_G.packer_plugins = {
  ["alpha-nvim"] = {
    loaded = true,
    path = "/Users/nathan/.local/share/nvim/site/pack/packer/start/alpha-nvim",
    url = "https://github.com/goolord/alpha-nvim"
  },
  ["gitsigns.nvim"] = {
    loaded = true,
    path = "/Users/nathan/.local/share/nvim/site/pack/packer/start/gitsigns.nvim",
    url = "https://github.com/lewis6991/gitsigns.nvim"
  },
  ["nvim-web-devicons"] = {
    loaded = true,
    path = "/Users/nathan/.local/share/nvim/site/pack/packer/start/nvim-web-devicons",
    url = "https://github.com/kyazdani42/nvim-web-devicons"
  },
  ["packer.nvim"] = {
    loaded = true,
    path = "/Users/nathan/.local/share/nvim/site/pack/packer/start/packer.nvim",
    url = "https://github.com/wbthomason/packer.nvim"
  },
  ["plenary.nvim"] = {
    loaded = true,
    path = "/Users/nathan/.local/share/nvim/site/pack/packer/start/plenary.nvim",
    url = "https://github.com/nvim-lua/plenary.nvim"
  },
  ["sessions.nvim"] = {
    config = { "\27LJ\2\n\\\0\0\3\0\4\0\a6\0\0\0'\2\1\0B\0\2\0029\0\2\0005\2\3\0B\0\2\1K\0\1\0\1\0\1\21session_filepath\18.nvim/session\nsetup\rsessions\frequire\0" },
    loaded = true,
    path = "/Users/nathan/.local/share/nvim/site/pack/packer/start/sessions.nvim",
    url = "/Users/nathan/code/nvim/sessions.nvim/"
  },
  ["telescope-zf-native.nvim"] = {
    loaded = true,
    path = "/Users/nathan/.local/share/nvim/site/pack/packer/start/telescope-zf-native.nvim",
    url = "/Users/nathan/code/nvim/telescope-zf-native.nvim/"
  },
  ["telescope.nvim"] = {
    config = { "\27LJ\2\n.\0\0\3\0\2\0\0046\0\0\0'\2\1\0B\0\2\1K\0\1\0\19user.telescope\frequire\0" },
    loaded = false,
    needs_bufread = true,
    only_cond = false,
    path = "/Users/nathan/.local/share/nvim/site/pack/packer/opt/telescope.nvim",
    url = "https://github.com/nvim-telescope/telescope.nvim"
  },
  ["vim-commentary"] = {
    loaded = true,
    path = "/Users/nathan/.local/share/nvim/site/pack/packer/start/vim-commentary",
    url = "https://github.com/tpope/vim-commentary"
  },
  ["vim-lastplace"] = {
    loaded = true,
    path = "/Users/nathan/.local/share/nvim/site/pack/packer/start/vim-lastplace",
    url = "https://github.com/farmergreg/vim-lastplace"
  },
  ["vim-sleuth"] = {
    loaded = true,
    path = "/Users/nathan/.local/share/nvim/site/pack/packer/start/vim-sleuth",
    url = "https://github.com/tpope/vim-sleuth"
  },
  ["vim-sneak"] = {
    loaded = true,
    path = "/Users/nathan/.local/share/nvim/site/pack/packer/start/vim-sneak",
    url = "https://github.com/justinmk/vim-sneak"
  },
  ["vim-surround"] = {
    loaded = true,
    path = "/Users/nathan/.local/share/nvim/site/pack/packer/start/vim-surround",
    url = "https://github.com/tpope/vim-surround"
  },
  ["vim-unimpaired"] = {
    loaded = true,
    path = "/Users/nathan/.local/share/nvim/site/pack/packer/start/vim-unimpaired",
    url = "https://github.com/tpope/vim-unimpaired"
  },
  ["workspaces.nvim"] = {
    config = { "\27LJ\2\n/\0\0\3\0\3\0\0056\0\0\0009\0\1\0'\2\2\0B\0\2\1K\0\1\0\16startinsert\bcmd\bvimº\1\1\2\6\0\n\0\0206\2\0\0'\4\1\0B\2\2\0029\2\2\2+\4\0\0005\5\3\0B\2\3\2\14\0\2\0X\2\n€6\2\0\0'\4\4\0B\2\2\0029\2\5\0025\4\6\0B\2\2\0016\2\a\0009\2\b\0023\4\t\0B\2\2\1K\0\1\0\0\rschedule\bvim\1\0\1\17initial_mode\vinsert\15find_files\22telescope.builtin\1\0\1\vsilent\2\tload\rsessions\frequire¶\1\1\0\6\0\n\0\0156\0\0\0'\2\1\0B\0\2\0029\0\2\0005\2\3\0005\3\5\0005\4\4\0=\4\6\0034\4\3\0003\5\a\0>\5\1\4=\4\b\3=\3\t\2B\0\2\1K\0\1\0\nhooks\topen\0\ropen_pre\1\0\2\topen\0\ropen_pre\0\1\2\0\0\17SessionsStop\1\0\3\fcd_type\btab\nhooks\0\14auto_open\2\nsetup\15workspaces\frequire\0" },
    loaded = true,
    path = "/Users/nathan/.local/share/nvim/site/pack/packer/start/workspaces.nvim",
    url = "/Users/nathan/code/nvim/workspaces.nvim/"
  },
  ["zf.vim"] = {
    loaded = true,
    path = "/Users/nathan/.local/share/nvim/site/pack/packer/start/zf.vim",
    url = "https://github.com/ratfactor/zf.vim"
  },
  ["zig.vim"] = {
    loaded = true,
    path = "/Users/nathan/.local/share/nvim/site/pack/packer/start/zig.vim",
    url = "https://github.com/ziglang/zig.vim"
  }
}

time([[Defining packer_plugins]], false)
local module_lazy_loads = {
  ["^telescope"] = "telescope.nvim"
}
local lazy_load_called = {['packer.load'] = true}
local function lazy_load_module(module_name)
  local to_load = {}
  if lazy_load_called[module_name] then return nil end
  lazy_load_called[module_name] = true
  for module_pat, plugin_name in pairs(module_lazy_loads) do
    if not _G.packer_plugins[plugin_name].loaded and string.match(module_name, module_pat) then
      to_load[#to_load + 1] = plugin_name
    end
  end

  if #to_load > 0 then
    require('packer.load')(to_load, {module = module_name}, _G.packer_plugins)
    local loaded_mod = package.loaded[module_name]
    if loaded_mod then
      return function(modname) return loaded_mod end
    end
  end
end

if not vim.g.packer_custom_loader_enabled then
  table.insert(package.loaders, 1, lazy_load_module)
  vim.g.packer_custom_loader_enabled = true
end

-- Config for: workspaces.nvim
time([[Config for workspaces.nvim]], true)
try_loadstring("\27LJ\2\n/\0\0\3\0\3\0\0056\0\0\0009\0\1\0'\2\2\0B\0\2\1K\0\1\0\16startinsert\bcmd\bvimº\1\1\2\6\0\n\0\0206\2\0\0'\4\1\0B\2\2\0029\2\2\2+\4\0\0005\5\3\0B\2\3\2\14\0\2\0X\2\n€6\2\0\0'\4\4\0B\2\2\0029\2\5\0025\4\6\0B\2\2\0016\2\a\0009\2\b\0023\4\t\0B\2\2\1K\0\1\0\0\rschedule\bvim\1\0\1\17initial_mode\vinsert\15find_files\22telescope.builtin\1\0\1\vsilent\2\tload\rsessions\frequire¶\1\1\0\6\0\n\0\0156\0\0\0'\2\1\0B\0\2\0029\0\2\0005\2\3\0005\3\5\0005\4\4\0=\4\6\0034\4\3\0003\5\a\0>\5\1\4=\4\b\3=\3\t\2B\0\2\1K\0\1\0\nhooks\topen\0\ropen_pre\1\0\2\topen\0\ropen_pre\0\1\2\0\0\17SessionsStop\1\0\3\fcd_type\btab\nhooks\0\14auto_open\2\nsetup\15workspaces\frequire\0", "config", "workspaces.nvim")
time([[Config for workspaces.nvim]], false)
-- Config for: sessions.nvim
time([[Config for sessions.nvim]], true)
try_loadstring("\27LJ\2\n\\\0\0\3\0\4\0\a6\0\0\0'\2\1\0B\0\2\0029\0\2\0005\2\3\0B\0\2\1K\0\1\0\1\0\1\21session_filepath\18.nvim/session\nsetup\rsessions\frequire\0", "config", "sessions.nvim")
time([[Config for sessions.nvim]], false)
vim.cmd [[augroup packer_load_aucmds]]
vim.cmd [[au!]]
  -- Event lazy-loads
time([[Defining lazy-load event autocommands]], true)
vim.cmd [[au VimEnter * ++once lua require("packer.load")({'telescope.nvim'}, { event = "VimEnter *" }, _G.packer_plugins)]]
time([[Defining lazy-load event autocommands]], false)
vim.cmd("augroup END")

_G._packer.inside_compile = false
if _G._packer.needs_bufread == true then
  vim.cmd("doautocmd BufRead")
end
_G._packer.needs_bufread = false

if should_profile then save_profiles() end

end)

if not no_errors then
  error_msg = error_msg:gsub('"', '\\"')
  vim.api.nvim_command('echohl ErrorMsg | echom "Error in packer_compiled: '..error_msg..'" | echom "Please check your config for correctness" | echohl None')
end
