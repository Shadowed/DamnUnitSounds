--[[
	Shadow, Mal'Ganis (US)
]]

local Sounds = select(2, ...)

-- Focus sounds
function Sounds:PLAYER_FOCUS_CHANGED()
	if( UnitExists("focus") ) then
		if( UnitIsEnemy("focus", "player") ) then
			PlaySound("igCreatureAggroSelect")
		elseif( UnitIsFriend("player", "focus") ) then
			PlaySound("igCharacterNPCSelect")
		else
			PlaySound("igCreatureNeutralSelect")
		end
	else
		PlaySound("INTERFACESOUND_LOSTTARGETUNIT")
	end
end

-- Target sounds
function Sounds:PLAYER_TARGET_CHANGED()
	if( UnitExists("target") ) then
		if( UnitIsEnemy("target", "player") ) then
			PlaySound("igCreatureAggroSelect")
		elseif( UnitIsFriend("player", "target") ) then
			PlaySound("igCharacterNPCSelect")
		else
			PlaySound("igCreatureNeutralSelect")
		end
	else
		PlaySound("INTERFACESOUND_LOSTTARGETUNIT")
	end
end

-- PVP flag sounds
local announcedPVP
function Sounds:UNIT_FACTION(unit, ...)
	if( unit ~= "player" ) then return end

	if( UnitIsPVPFreeForAll("player") or UnitIsPVP("player") ) then
		if( not announcedPVP ) then
			announcedPVP = true
			PlaySound("igPVPUpdate")
		end
	else
		announcedPVP = nil
	end
end


local frame = CreateFrame("Frame")
frame:RegisterEvent("PLAYER_FOCUS_CHANGED")
frame:RegisterEvent("PLAYER_TARGET_CHANGED")
frame:RegisterEvent("UNIT_FACTION")
frame:SetScript("OnEvent", function(self, event, ...)
	Sounds[event](Sounds, ...)
end)