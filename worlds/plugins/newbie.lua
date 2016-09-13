require "wait"

player = {
    gender = 1, -- 1男    2女
    currQuest = '',
}

function player.setGender(gender)
    if gender == "女" then
        player.gender = 2
    end
end

--require "jnxkxmapper"

--local mapData = mapper.open(GetInfo(66) .. 'rooms_all.h')

-- 从0号房间到1号房间
-- local path = mapper.getpath(0,1,0)

--local path = mapper.getpath(0,555,0)
--Note('path no fly ---->>>',path)