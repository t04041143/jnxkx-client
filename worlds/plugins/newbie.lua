require "wait"

player = {
    gender = 1, -- 1ÄĞ    2Å®
    currQuest = '',
}

function player.setGender(gender)
    if gender == "Å®" then
        player.gender = 2
    end
end