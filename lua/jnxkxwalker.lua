------------------------------------------
-- 行走模块
------------------------------------------

require 'jnxkxmapper'
require 'tprint'

module(..., package.seeall)

-- 载入地图数据
local mapperStatus = mapper.open(GetInfo(66) .. 'rooms_all.h')
if (mapperStatus == 0) then
    print "地图数据载入失败"
end

local currentPath = {}

local convertToTable = function(path)
    local i=0
    _convpath={}
    re = rex.new("([^;]+)")
    n=re:gmatch(path,function (m, t)
        i=i+1
        _convpath[i]=m
    end)
    return _convpath
end

function doWalk(from,to,fly)
     local pathString = mapper.getpath(from,to,fly)
     if pathString == '' then
        print('未找到合适的路径！')
        return false
     else
        currentPath = convertToTable(pathString)
        tprint(currentPath)
        return true
     end
end
