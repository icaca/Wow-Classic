local _, ns = ...
local B, C, L, DB = unpack(ns)

tinsert(C.defaultThemes, function()
	local restyled = false

	InterfaceOptionsFrame:HookScript("OnShow", function()
		if restyled then return end

		B.StripTextures(InterfaceOptionsFrame)
		B.StripTextures(InterfaceOptionsFrameCategories)
		B.StripTextures(InterfaceOptionsFramePanelContainer)
		B.StripTextures(InterfaceOptionsFrameAddOns)
		for i = 1, 2 do
			B.StripTextures(_G["InterfaceOptionsFrameTab"..i])
		end
		B.SetBD(InterfaceOptionsFrame)

		InterfaceOptionsFrameHeader:SetTexture("")
		InterfaceOptionsFrameHeader:ClearAllPoints()
		InterfaceOptionsFrameHeader:SetPoint("TOP", InterfaceOptionsFrame, 0, 0)

		local line = InterfaceOptionsFrame:CreateTexture(nil, "ARTWORK")
		line:SetSize(C.mult, 546)
		line:SetPoint("LEFT", 205, 10)
		line:SetColorTexture(1, 1, 1, .25)

		local buttons = {
			InterfaceOptionsFrameDefaults,
			InterfaceOptionsFrameOkay,
			InterfaceOptionsFrameCancel,
			InterfaceOptionsSocialPanelRedockChat,
			InterfaceOptionsSocialPanelTwitterLoginButton,
			InterfaceOptionsDisplayPanelResetTutorials,
		}
		for _, button in next, buttons do
			B.Reskin(button)
		end

		local checkboxes = {
			InterfaceOptionsControlsPanelStickyTargeting,
			InterfaceOptionsControlsPanelAutoDismount,
			InterfaceOptionsControlsPanelAutoClearAFK,
			InterfaceOptionsControlsPanelAutoLootCorpse,
			InterfaceOptionsControlsPanelInteractOnLeftClick,
			InterfaceOptionsControlsPanelLootAtMouse,
			InterfaceOptionsCombatPanelTargetOfTarget,
			InterfaceOptionsCombatPanelFlashLowHealthWarning,
			InterfaceOptionsCombatPanelLossOfControl,
			InterfaceOptionsCombatPanelEnableFloatingCombatText,
			InterfaceOptionsCombatPanelAutoSelfCast,
			InterfaceOptionsDisplayPanelRotateMinimap,
			InterfaceOptionsDisplayPanelAJAlerts,
			InterfaceOptionsDisplayPanelShowTutorials,
			InterfaceOptionsSocialPanelProfanityFilter,
			InterfaceOptionsSocialPanelSpamFilter,
			InterfaceOptionsSocialPanelGuildMemberAlert,
			InterfaceOptionsSocialPanelBlockTrades,
			InterfaceOptionsSocialPanelBlockGuildInvites,
			InterfaceOptionsSocialPanelBlockChatChannelInvites,
			InterfaceOptionsSocialPanelShowAccountAchievments,
			InterfaceOptionsSocialPanelOnlineFriends,
			InterfaceOptionsSocialPanelOfflineFriends,
			InterfaceOptionsSocialPanelBroadcasts,
			InterfaceOptionsSocialPanelFriendRequests,
			InterfaceOptionsSocialPanelShowToastWindow,
			InterfaceOptionsSocialPanelEnableTwitter,
			InterfaceOptionsSocialPanelAutoAcceptQuickJoinRequests,
			InterfaceOptionsActionBarsPanelBottomLeft,
			InterfaceOptionsActionBarsPanelBottomRight,
			InterfaceOptionsActionBarsPanelRight,
			InterfaceOptionsActionBarsPanelRightTwo,
			InterfaceOptionsActionBarsPanelStackRightBars,
			InterfaceOptionsActionBarsPanelLockActionBars,
			InterfaceOptionsActionBarsPanelAlwaysShowActionBars,
			InterfaceOptionsActionBarsPanelCountdownCooldowns,
			InterfaceOptionsNamesPanelMyName,
			InterfaceOptionsNamesPanelGuildNames,
			InterfaceOptionsNamesPanelNonCombatCreature,
			InterfaceOptionsNamesPanelFriendlyPlayerNames,
			InterfaceOptionsNamesPanelFriendlyMinions,
			InterfaceOptionsNamesPanelEnemyPlayerNames,
			InterfaceOptionsNamesPanelEnemyMinions,
			InterfaceOptionsNamesPanelUnitNameplatesPersonalResource,
			InterfaceOptionsNamesPanelUnitNameplatesPersonalResourceOnEnemy,
			InterfaceOptionsNamesPanelUnitNameplatesMakeLarger,
			InterfaceOptionsNamesPanelUnitNameplatesShowAll,
			InterfaceOptionsNamesPanelUnitNameplatesAggroFlash,
			InterfaceOptionsNamesPanelUnitNameplatesFriendlyMinions,
			InterfaceOptionsNamesPanelUnitNameplatesEnemyMinions,
			InterfaceOptionsNamesPanelUnitNameplatesEnemyMinus,
			InterfaceOptionsNamesPanelUnitNameplatesEnemies,
			InterfaceOptionsNamesPanelUnitNameplatesFriends,
			InterfaceOptionsCameraPanelWaterCollision,
			InterfaceOptionsMousePanelInvertMouse,
			InterfaceOptionsMousePanelEnableMouseSpeed,
			InterfaceOptionsMousePanelClickToMove,
			InterfaceOptionsMousePanelLockCursorToScreen,
			InterfaceOptionsAccessibilityPanelMovePad,
			InterfaceOptionsAccessibilityPanelCinematicSubtitles,
			InterfaceOptionsAccessibilityPanelColorblindMode,
			InterfaceOptionsCombatPanelCombatTextLowManaHealth,
			InterfaceOptionsCombatPanelCombatTextAuras,
			InterfaceOptionsCombatPanelCombatTextAuraFade,
			InterfaceOptionsCombatPanelCombatTextState,
			InterfaceOptionsCombatPanelCombatTextParryDodgeMiss,
			InterfaceOptionsCombatPanelCombatTextResistances,
			InterfaceOptionsCombatPanelCombatTextReputation,
			InterfaceOptionsCombatPanelCombatTextReactives,
			InterfaceOptionsCombatPanelCombatTextFriendlyNames,
			InterfaceOptionsCombatPanelCombatTextComboPoints,
			InterfaceOptionsCombatPanelCombatTextEnergyGains,
			InterfaceOptionsCombatPanelCombatTextHonorGains,
			InterfaceOptionsCombatPanelEnableCombatDamageText,
			InterfaceOptionsCombatPanelEnablePeriodicDamage,
			InterfaceOptionsCombatPanelEnablePetDamage,
			InterfaceOptionsDisplayPanelShowHelm,
			InterfaceOptionsDisplayPanelShowCloak,
			InterfaceOptionsDisplayPanelInstantQuestText,
			InterfaceOptionsDisplayPanelAutoQuestWatch,
			InterfaceOptionsDisplayPanelHideOutdoorWorldState,
			InterfaceOptionsDisplayPanelShowMinimapClock,
			InterfaceOptionsDisplayPanelShowDetailedTooltips,
			InterfaceOptionsDisplayPanelShowLoadingScreenTip,
			InterfaceOptionsSocialPanelShowLootSpam,
			InterfaceOptionsNamesPanelNPCNames,
			InterfaceOptionsNamesPanelTitles,
			InterfaceOptionsCameraPanelFollowTerrain,
			InterfaceOptionsCameraPanelHeadBob,
			InterfaceOptionsCameraPanelSmartPivot,
		}
		for _, checkbox in next, checkboxes do
			B.ReskinCheck(checkbox)
		end

		local dropdowns = {
			InterfaceOptionsControlsPanelAutoLootKeyDropDown,
			InterfaceOptionsCombatPanelFocusCastKeyDropDown,
			InterfaceOptionsCombatPanelSelfCastKeyDropDown,
			InterfaceOptionsDisplayPanelOutlineDropDown,
			InterfaceOptionsDisplayPanelSelfHighlightDropDown,
			InterfaceOptionsDisplayPanelDisplayDropDown,
			InterfaceOptionsDisplayPanelChatBubblesDropDown,
			InterfaceOptionsSocialPanelChatStyle,
			InterfaceOptionsSocialPanelTimestamps,
			InterfaceOptionsSocialPanelWhisperMode,
			InterfaceOptionsActionBarsPanelPickupActionKeyDropDown,
			InterfaceOptionsNamesPanelNPCNamesDropDown,
			InterfaceOptionsNamesPanelUnitNameplatesMotionDropDown,
			InterfaceOptionsCameraPanelStyleDropDown,
			InterfaceOptionsMousePanelClickMoveStyleDropDown,
			InterfaceOptionsAccessibilityPanelColorFilterDropDown,
			InterfaceOptionsCombatPanelCombatTextFloatModeDropDown,
		}
		for _, dropdown in next, dropdowns do
			B.ReskinDropDown(dropdown)
		end

		local sliders = {
			InterfaceOptionsCombatPanelSpellAlertOpacitySlider,
			InterfaceOptionsCameraPanelFollowSpeedSlider,
			InterfaceOptionsMousePanelMouseSensitivitySlider,
			InterfaceOptionsMousePanelMouseLookSpeedSlider,
			InterfaceOptionsAccessibilityPanelColorblindStrengthSlider,
			InterfaceOptionsCameraPanelMaxDistanceSlider,
		}
		for _, slider in next, sliders do
			B.ReskinSlider(slider)
		end

		if IsAddOnLoaded("Blizzard_CUFProfiles") then
			CompactUnitFrameProfilesGeneralOptionsFrameAutoActivateBG:Hide()

			local boxes = {
				CompactUnitFrameProfilesRaidStylePartyFrames,
				CompactUnitFrameProfilesGeneralOptionsFrameKeepGroupsTogether,
				CompactUnitFrameProfilesGeneralOptionsFrameHorizontalGroups,
				CompactUnitFrameProfilesGeneralOptionsFrameDisplayIncomingHeals,
				CompactUnitFrameProfilesGeneralOptionsFrameDisplayPowerBar,
				CompactUnitFrameProfilesGeneralOptionsFrameDisplayAggroHighlight,
				CompactUnitFrameProfilesGeneralOptionsFrameUseClassColors,
				CompactUnitFrameProfilesGeneralOptionsFrameDisplayPets,
				CompactUnitFrameProfilesGeneralOptionsFrameDisplayMainTankAndAssist,
				CompactUnitFrameProfilesGeneralOptionsFrameDisplayBorder,
				CompactUnitFrameProfilesGeneralOptionsFrameShowDebuffs,
				CompactUnitFrameProfilesGeneralOptionsFrameDisplayOnlyDispellableDebuffs,
				CompactUnitFrameProfilesGeneralOptionsFrameAutoActivate2Players,
				CompactUnitFrameProfilesGeneralOptionsFrameAutoActivate3Players,
				CompactUnitFrameProfilesGeneralOptionsFrameAutoActivate5Players,
				CompactUnitFrameProfilesGeneralOptionsFrameAutoActivate10Players,
				CompactUnitFrameProfilesGeneralOptionsFrameAutoActivate15Players,
				CompactUnitFrameProfilesGeneralOptionsFrameAutoActivate20Players,
				CompactUnitFrameProfilesGeneralOptionsFrameAutoActivate40Players,
				CompactUnitFrameProfilesGeneralOptionsFrameAutoActivateSpec1,
				CompactUnitFrameProfilesGeneralOptionsFrameAutoActivateSpec2,
				CompactUnitFrameProfilesGeneralOptionsFrameAutoActivateSpec3,
				CompactUnitFrameProfilesGeneralOptionsFrameAutoActivateSpec4,
				CompactUnitFrameProfilesGeneralOptionsFrameAutoActivatePvP,
				CompactUnitFrameProfilesGeneralOptionsFrameAutoActivatePvE
			}

			for _, box in next, boxes do
				B.ReskinCheck(box)
			end

			B.Reskin(CompactUnitFrameProfilesSaveButton)
			B.Reskin(CompactUnitFrameProfilesDeleteButton)
			B.Reskin(CompactUnitFrameProfilesGeneralOptionsFrameResetPositionButton)
			B.ReskinDropDown(CompactUnitFrameProfilesProfileSelector)
			B.ReskinDropDown(CompactUnitFrameProfilesGeneralOptionsFrameSortByDropdown)
			B.ReskinDropDown(CompactUnitFrameProfilesGeneralOptionsFrameHealthTextDropdown)
			B.ReskinSlider(CompactUnitFrameProfilesGeneralOptionsFrameHeightSlider)
			B.ReskinSlider(CompactUnitFrameProfilesGeneralOptionsFrameWidthSlider)
		end

		restyled = true
	end)

	hooksecurefunc("InterfaceOptions_AddCategory", function()
		local num = #INTERFACEOPTIONS_ADDONCATEGORIES
		for i = 1, num do
			local bu = _G["InterfaceOptionsFrameAddOnsButton"..i.."Toggle"]
			if bu and not bu.reskinned then
				B.ReskinExpandOrCollapse(bu)
				bu:SetPushedTexture("")
				bu.SetPushedTexture = B.Dummy
				bu.reskinned = true
			end
		end
	end)
end)