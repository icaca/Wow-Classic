local GSE = GSE

local Statics = GSE.Static

local L = GSE.L

local AceGUI = LibStub("AceGUI-3.0")


local PreviewFrame = AceGUI:Create("Frame")
GSE.MacroPreviewFrame = PreviewFrame

local transSequencevalue = ""

PreviewFrame:SetTitle(L["Compiled Template"])
PreviewFrame:SetCallback("OnClose", function(widget) PreviewFrame:Hide() end)
PreviewFrame:SetLayout("List")
PreviewFrame:SetWidth(290)
PreviewFrame:SetHeight(700)
PreviewFrame:Hide()


local PreviewLabel = AceGUI:Create("MultiLineEditBox")
--SequenceListbox:SetLabel(L["Load Sequence"])
PreviewLabel:SetWidth(250)
PreviewLabel:SetNumLines(40)
PreviewLabel:DisableButton(true)

PreviewFrame.PreviewLabel = PreviewLabel
PreviewFrame:AddChild(PreviewLabel)



function GSE.GUIShowCompiledMacroGui(label, title)
  PreviewFrame.text = table.concat(label, "\n--------------------------------------\n")

  if GSE.GUIViewFrame:IsVisible() then
    local point, relativeTo, relativePoint, xOfs, yOfs = GSE.GUIViewFrame:GetPoint()
    --	GSE.GUIPreviewFrame:SetPoint("CENTRE" , (left/2)+(width/2), bottom )
    PreviewFrame:SetPoint(point, xOfs + 150 + (GSE.GUIViewFrame:GetWidth() / 2), yOfs)

  end
  if GSE.GUIEditFrame:IsVisible() then
    local point, relativeTo, relativePoint, xOfs, yOfs = GSE.GUIEditFrame:GetPoint()
    --	GSE.GUIPreviewFrame:SetPoint("CENTRE" , (left/2)+(width/2), bottom )
    PreviewFrame:SetPoint(point, xOfs + 150 + (GSEOptions.editorWidth / 2), yOfs)

  end

  if not GSE.isEmpty(label) then
    PreviewLabel:SetText(PreviewFrame.text)
  end
  PreviewLabel:SetCallback("OnTextChanged", function()
    PreviewLabel:SetText(PreviewFrame.text)
  end)
  PreviewFrame:Show()
  PreviewFrame:SetStatusText(title)
end



