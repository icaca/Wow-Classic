notificationTimes = {30, 15, 5, 1}
notificationIndex = 1
hourNotified = -1

function checkWintergrasp()
    local hour, minute = GetGameTime()
    local minutesElapsedToday = hour * 60 + minute

    local nextWintergraspHour = hour
    while nextWintergraspHour % 3 ~= 0 or hour == nextWintergraspHour do
        nextWintergraspHour = nextWintergraspHour + 1
    end

    if minute == 0 and nextWintergraspHour - hour == 3 then
        print("Next Wintergrasp starts at " .. nextWintergraspHour .. ":00")
    end

    local diff = nextWintergraspHour * 60 - minutesElapsedToday;

    if diff <= notificationTimes[notificationIndex] and hourNotified ~= nextWintergraspHour then
        local timeString = diff == 1 and diff .. " minute." or diff .. " minutes."
        RaidNotice_AddMessage(RaidWarningFrame, "Wintergrasp starting in " .. timeString, ChatTypeInfo["RAID_WARNING"]);
        PlaySound(8959, "Master")
        FlashClientIcon()

        if notificationIndex == 4 then
            hourNotified = nextWintergraspHour
        end

        for i = 1, 4, 1 do
            if notificationTimes[i] < diff then
                notificationIndex = i
                break
            end
        end
    end

    return nextWintergraspHour;
end

local function OnEvent(self, event, isLogin, isReload)
    if isLogin or isReload then
        local nextWintergraspHour = checkWintergrasp();
        print("Next Wintergrasp starts at " .. nextWintergraspHour .. ":00")
        C_Timer.NewTicker(30, checkWintergrasp)
    end
end

local f = CreateFrame("Frame")
f:RegisterEvent("PLAYER_ENTERING_WORLD")
f:SetScript("OnEvent", OnEvent)
