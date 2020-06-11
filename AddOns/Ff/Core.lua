Ff = LibStub("AceAddon-3.0"):NewAddon("Ff", "AceConsole-3.0","AceEvent-3.0","AceTimer-3.0","AceHook-3.0")
local loader = CreateFrame("Frame")
local f

function Ff:OnInitialize()

end

function Ff:ChatCommand(input)
    if not input or input:trim() == "" then
        InterfaceOptionsFrame_OpenToCategory(self.optionsFrame)
    else
        LibStub("AceConfigCmd-3.0"):HandleCommand("ff", "WelcomeHome", input)
    end
end

function Ff:OnEnable()
    self:Print("Hello World!")
	f = CreateFrame("Frame", "NDuiGUI")
	f:SetSize(800, 600)
	f:SetPoint("CENTER")
	f:SetFrameStrata("HIGH")
	f:SetFrameLevel(10)
	f:Show()
end

