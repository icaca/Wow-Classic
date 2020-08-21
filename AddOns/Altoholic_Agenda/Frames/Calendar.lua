local addonName = "Altoholic"
local addon = _G[addonName]

local CALENDAR_WEEKDAY_NORMALIZED_TEX_LEFT	= 0.0
local CALENDAR_WEEKDAY_NORMALIZED_TEX_TOP		= 180 / 256
local CALENDAR_WEEKDAY_NORMALIZED_TEX_WIDTH	= 90 / 256 - 0.001		-- fudge factor to prevent texture seams
local CALENDAR_WEEKDAY_NORMALIZED_TEX_HEIGHT	= 28 / 256 - 0.001		-- fudge factor to prevent texture seams

local CALENDAR_MAX_DAYS_PER_MONTH			= 42	-- 6 weeks
local CALENDAR_MONTH_NAMES = {
	MONTH_JANUARY,
	MONTH_FEBRUARY,
	MONTH_MARCH,
	MONTH_APRIL,
	MONTH_MAY,
	MONTH_JUNE,
	MONTH_JULY,
	MONTH_AUGUST,
	MONTH_SEPTEMBER,
	MONTH_OCTOBER,
	MONTH_NOVEMBER,
	MONTH_DECEMBER,
}

local CALENDAR_WEEKDAY_NAMES = {
	WEEKDAY_SUNDAY,
	WEEKDAY_MONDAY,
	WEEKDAY_TUESDAY,
	WEEKDAY_WEDNESDAY,
	WEEKDAY_THURSDAY,
	WEEKDAY_FRIDAY,
	WEEKDAY_SATURDAY,
}

local CALENDAR_FULLDATE_MONTH_NAMES = {
	-- month names show up differently for full date displays in some languages
	FULLDATE_MONTH_JANUARY,
	FULLDATE_MONTH_FEBRUARY,
	FULLDATE_MONTH_MARCH,
	FULLDATE_MONTH_APRIL,
	FULLDATE_MONTH_MAY,
	FULLDATE_MONTH_JUNE,
	FULLDATE_MONTH_JULY,
	FULLDATE_MONTH_AUGUST,
	FULLDATE_MONTH_SEPTEMBER,
	FULLDATE_MONTH_OCTOBER,
	FULLDATE_MONTH_NOVEMBER,
	FULLDATE_MONTH_DECEMBER,
};

-- If you're reading this in the year 2052, change this to actually use the leap year formula (year / 4 but not 100 but not 400)
local LEAP_YEAR_LIST = {[2000] = true, [2004] = true, [2008] = true, [2012] = true, [2016] = true, [2020] = true, [2024] = true, [2028] = true, [2032] = true, [2036] = true, [2040] = true, [2044] = true, [2048] = true}

local function getNumDays(month, year)
    assert(month > 0)
    assert(month < 13)
    
    local num_days_list = {31, 0, 31, 30, 31, 30, 31, 31, 30, 31, 30, 31}
    
    if month == 2 then
        if LEAP_YEAR_LIST[year] then 
            return 29
        else
            return 28
        end
    end
    
    return num_days_list[month]
end

local offset = 0

-- recreating C_Calendar.GetMonthInfo() here
function addon:getMonthInfo(offsetMonths)
    local info = {}
    if not offsetMonths then offsetMonths = 0 end
    
    local DateInfo = C_DateAndTime.GetTodaysDate()
	local presentWeekday, presentMonth, presentDay, presentYear = DateInfo.weekday, DateInfo.month, DateInfo.day, DateInfo.year
    
    presentMonth = presentMonth + offsetMonths + offset
    
    while presentMonth < 1 do
        presentYear = presentYear - 1
        presentMonth = presentMonth + 12
    end
    while presentMonth > 12 do
        presentYear = presentYear + 1
        presentMonth = presentMonth - 12
    end
    
    info.year = presentYear
    info.month = presentMonth
    info.numDays = getNumDays(presentMonth, presentYear)
    
    -- now to work out the first day of the month, given the offset
    -- going to get the unixtime of the first day of the month, then extract it using date()
    -- first, get current time
    local unixTime = time()
    -- cut it back to the first day of the month
    unixTime = unixTime - ((presentDay - 1) * 60 * 60 * 24)
    
    -- apply the offset
    presentMonth = DateInfo.month
    presentYear = DateInfo.year
    
    while offsetMonths < 0 do
        offsetMonths = offsetMonths + 1
        presentMonth = presentMonth - 1
        if presentMonth < 1 then
            presentMonth = presentMonth + 12
            presentYear = presentYear - 1
        end
        -- remove the number of days in that month
        unixTime = unixTime - (getNumDays(presentMonth, presentYear) * 24 * 60 * 60)
    end
    
    while offsetMonths > 0 do
        offsetMonths = offsetMonths - 1
        -- add the number of days in this month
        unixTime = unixTime + (getNumDays(presentMonth, presentYear) * 24 * 60 * 60)
        presentMonth = presentMonth + 1
        if presentMonth > 12 then
            presentMonth = presentMonth - 12
            presentYear = presentYear + 1
        end
    end
    
    local offset2 = offset
    
    while offset2 < 0 do
        offset2 = offset2 + 1
        presentMonth = presentMonth - 1
        if presentMonth < 1 then
            presentMonth = presentMonth + 12
            presentYear = presentYear - 1
        end
        unixTime = unixTime - (getNumDays(presentMonth, presentYear) * 24 * 60 * 60)
    end
    
    while offset2 > 0 do
        offset2 = offset2 - 1
        unixTime = unixTime + (getNumDays(presentMonth, presentYear) * 24 * 60 * 60)
        presentMonth = presentMonth + 1
        if presentMonth > 12 then
            presentMonth = presentMonth - 12
            presentYear = presentYear + 1
        end
    end
    
    -- extract the weekday
    -- date %w uses 0-6, but we want 1-7 to match the original function
    info.firstWeekday = tonumber(date("%w", unixTime)) + 1
    
    return info
end

addon:Controller("AltoholicUI.Calendar", {
	OnBind = function(frame)
		-- by default, the week starts on Sunday, adjust first day of the week if necessary
		if addon:GetOption("UI.Calendar.WeekStartsOnMonday") then
			addon:SetFirstDayOfWeek(2)
		end
		
		local band = bit.band
		
		-- initialize weekdays
		for i = 1, 7 do
			local bg =  frame["Weekday"..i.."Background"]
			local left = (band(i, 1) * CALENDAR_WEEKDAY_NORMALIZED_TEX_WIDTH) + CALENDAR_WEEKDAY_NORMALIZED_TEX_LEFT		-- mod(index, 2) * width
			local right = left + CALENDAR_WEEKDAY_NORMALIZED_TEX_WIDTH
			local top = CALENDAR_WEEKDAY_NORMALIZED_TEX_TOP
			local bottom = top + CALENDAR_WEEKDAY_NORMALIZED_TEX_HEIGHT
			bg:SetTexCoord(left, right, top, bottom)
			bg:Show()
		end

		frame:Update()
	end,
    SetMonth = function(frame, diff)
        offset = offset + diff
    end,
	Update = function(frame)
		-- taken from CalendarFrame_Update() in Blizzard_Calendar.lua, adjusted for my needs.
		
		local DateInfo = C_DateAndTime.GetTodaysDate()
        local offsetDateInfo = addon:getMonthInfo()
		local presentWeekday, presentMonth, presentDay, presentYear = offsetDateInfo.weekday, offsetDateInfo.month, offsetDateInfo.day, offsetDateInfo.year
		
		local CurMonthInfo = addon:getMonthInfo()
		local PrevMonthInfo = addon:getMonthInfo(-1)
		local NextMonthInfo = addon:getMonthInfo(1)
		local prevMonth, prevYear, prevNumDays = PrevMonthInfo.month, PrevMonthInfo.year, PrevMonthInfo.numDays
		local nextMonth, nextYear, nextNumDays = NextMonthInfo.month, NextMonthInfo.year, NextMonthInfo.numDays
		local month, year, numDays, firstWeekday = CurMonthInfo.month, CurMonthInfo.year, CurMonthInfo.numDays, CurMonthInfo.firstWeekday
		
		-- set title
		frame.MonthYear:SetText(format("%s %s", CALENDAR_MONTH_NAMES[month], year))
		
		-- initialize weekdays
		for i = 1, 7 do
			frame["Weekday"..i.."Name"]:SetText(string.sub(CALENDAR_WEEKDAY_NAMES[frame:GetWeekdayIndex(i)], 1, 3))
		end

		local buttonIndex = 1
		local isDarkened = true
		local day

		-- set the previous month's days before the first day of the week
		local viewablePrevMonthDays = mod((firstWeekday - addon:GetFirstDayOfWeek() - 1) + 7, 7)
		day = prevNumDays - viewablePrevMonthDays

		while ( frame:GetWeekdayIndex(buttonIndex) ~= firstWeekday ) do
			frame["Day"..buttonIndex]:Update(day, prevMonth, prevYear, isDarkened)
			day = day + 1
			buttonIndex = buttonIndex + 1
		end

		-- set the days of this month
		day = 1
		isDarkened = false
		while ( day <= numDays ) do
			frame["Day"..buttonIndex]:Update(day, month, year, isDarkened)
			day = day + 1
			buttonIndex = buttonIndex + 1
		end
		
		-- set the first days of the next month
		day = 1
		isDarkened = true
		while ( buttonIndex <= CALENDAR_MAX_DAYS_PER_MONTH ) do
			frame["Day"..buttonIndex]:Update(day, nextMonth, nextYear, isDarkened)

			day = day + 1
			buttonIndex = buttonIndex + 1
		end

		frame.EventList:Update()
		frame:Show()
	end,
	InvalidateView = function(frame)
		isViewValid = nil
		if frame:IsVisible() then
			frame:Update()
		end
	end,
	GetWeekdayIndex = function(frame, index)
		-- GetWeekdayIndex takes an index in the range [1, n] and maps it to a weekday starting
		-- at CALENDAR_FIRST_WEEKDAY. For example,
		-- CALENDAR_FIRST_WEEKDAY = 1 => [SUNDAY, MONDAY, TUESDAY, WEDNESDAY, THURSDAY, FRIDAY, SATURDAY]
		-- CALENDAR_FIRST_WEEKDAY = 2 => [MONDAY, TUESDAY, WEDNESDAY, THURSDAY, FRIDAY, SATURDAY, SUNDAY]
		-- CALENDAR_FIRST_WEEKDAY = 6 => [FRIDAY, SATURDAY, SUNDAY, MONDAY, TUESDAY, WEDNESDAY, THURSDAY]
		
		-- the expanded form for the left input to mod() is:
		-- (index - 1) + (CALENDAR_FIRST_WEEKDAY - 1)
		-- why the - 1 and then + 1 before return? because lua has 1-based indexes! awesome!
		return mod(index - 2 + addon:GetFirstDayOfWeek(), 7) + 1
	end,
	GetFullDate = function(frame, weekday, month, day, year)
		local weekdayName = CALENDAR_WEEKDAY_NAMES[weekday]
		local monthName = CALENDAR_FULLDATE_MONTH_NAMES[month]
		
		return weekdayName, monthName, day, year, month
	end,
})
