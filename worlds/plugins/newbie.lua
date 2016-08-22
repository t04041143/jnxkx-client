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

function player.eatYeguo()
    wait.make(function()
        while true do
            Execute("get ye guo")
            local line = wait.regexp("^[> ]*你身上已经有野果了，拿多了也是浪费。")
            if line ~= nil then
                break
            else
                line = wait.regexp("^[> ]*你捡起一枚野果.*", 5)
                if line ~= nil then
                    break
                end
            end
        end

        Execute("eat ye guo")
    end)
end

function player.getHulu()
    wait.make(function()
        while true do
            Execute("get hulu")
            local line = wait.regexp(".*你捡起一个葫芦.*", 5)
            if line ~= nil then
                break
            end
        end
    end)
end