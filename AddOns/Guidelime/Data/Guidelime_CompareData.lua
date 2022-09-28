local addonName, addon = ...

local function matchObjective(o1, o2)
	if o1.type ~= o2.type then return false end
	local list1 = o1.ids[o1.type == "monster" and "npc" or o1.type] or {}
	local list2 = o2.ids[o1.type == "monster" and "npc" or o1.type] or {}
	if #list1 ~= #list2 then return false end
	for i, id in ipairs(list1) do
		if id ~= list2[i] then return false end
	end
	return true
end

function addon.compareCodexQuestieQuests(min, max)
	if GuidelimeData.correctionsObjectiveOrder == nil then GuidelimeData.correctionsObjectiveOrder = {} end
	local ids = addon.getQuestIDsClassicCodex()
	if max > #ids then max = #ids end
	for i = min, max do
		GuidelimeData.correctionsObjectiveOrder[ids[i]] = addon.compareCodexQuestieObjectives(ids[i])
	end
end

function addon.compareCodexQuestieObjectives(id)
	local q = addon.getQuestObjectivesQuestie(id, "COMPLETE") or {}
	local c = addon.getQuestObjectivesClassicCodex(id, "COMPLETE") or {}
	
	local order = {}
	local match = #q == #c
	for i, o in ipairs(q) do
		local found = false
		for j, o2 in ipairs(c) do
			if matchObjective(o, o2) then
				if i ~= j then match = false end
				order[j] = i
				found = true
				break
			end
		end
		if not found then 
			--table.insert(order, 0)
			--error("not found " .. id)
			match = false
		end
	end
	
	if not match then return order end
end

function addon.listKillCreditQuestie()
	local list = {}
	for _, id in ipairs(addon.getQuestIDsClassicCodex()) do
		for i, o in ipairs(addon.getQuestObjectivesQuestie(id, "COMPLETE") or {}) do
			if o.type == "monster" and #(o.ids.npc) > 1 then
				if list[id] == nil then list[id] = {} end
				list[id][i] = o
			end
		end
	end
	return list
end