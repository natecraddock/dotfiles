local utils = {}

local maps = {}

function utils.register_mapping(fn)
  table.insert(maps, fn)
  return #maps
end

function utils.run_mapping(num)
  local fn = maps[num]
  fn()
end

return utils
