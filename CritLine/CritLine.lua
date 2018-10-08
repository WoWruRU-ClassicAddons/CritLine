function CritLine_OnLoad()
	this:RegisterEvent("CHAT_MSG_COMBAT_SELF_HITS")
	this:RegisterEvent("CHAT_MSG_SPELL_SELF_DAMAGE")
	this:RegisterEvent("CHAT_MSG_SPELL_SELF_BUFF")
	this:RegisterEvent("PLAYER_ENTERING_WORLD")
	
	SlashCmdList["CRITLINE"] = CritLineCommand
	SLASH_CRITLINE1 = "/critline"
	SLASH_CRITLINE2 = "/cl"
	
	HEADER_TEXT_COLOR  = "|cffffffff" --White
	SUBHEADER_TEXT_COLOR  = "|cffCEA208" --Gold
	BODY_TEXT_COLOR  = "|cffffffff" --?White?
	HINT_TEXT_COLOR  = "|cff00ff00" --Green
	
	DAMAGE_TYPE_NONHEAL = "0"
	DAMAGE_TYPE_HEAL =  "1"
	
	CritAttack = "0"
end

function CritLine_OnEvent(event, arg1)
	if event == "PLAYER_ENTERING_WORLD" then
		CritLinePlayer = UnitName("player")
		CritLineRealm = GetRealmName()
		Percent = "CLPercent"
		CritLine_Init()
		CritLine_GetSummaryRichText()
		if CritLineData[CritLineRealm][CritLinePlayer]["Settings"]["Hidden"] == "1" then
			CritLineFrameMini:Hide()
			CritLineFrame:Hide()
		end
		if CritLineData[CritLineRealm][CritLinePlayer]["Settings"]["SummaryHidden"] == "1" then
			CritLineFrameSummary:Hide()
		end		
	elseif event == "CHAT_MSG_SPELL_SELF_BUFF" then
		CritAttack = "0"
		if CritLineData[CritLineRealm][CritLinePlayer]["Settings"]["FilterHeals"] == "0" then
			for attacktype, creaturename, damage in string.gfind(arg1, SPELL_CRIT_HEAL) do
				if attacktype ~= HEALINGPOTIONS then
					CritLine_RecordHit(attacktype, "CRIT", tonumber(damage), creaturename, DAMAGE_TYPE_HEAL)
					CritAttack = "1"
					if CritLineData[CritLineRealm][CritLinePlayer]["Settings"]["SplashCrit"] == "1" then
						CritLineSplashFrame:AddMessage(CRITLINE_CRITICAL, 1, 0, 0, 1, 3)
					end
				end
			end
			for attacktype, creaturename, damage in string.gfind(arg1, SPELL_HIT_HEAL) do
				if attacktype ~= HEALINGPOTIONS then
					if CritAttack == "0" then
						CritLine_RecordHit(attacktype, "NORMAL", tonumber(damage), creaturename, DAMAGE_TYPE_HEAL)
					end
				end
			end
		end
	elseif event == "CHAT_MSG_COMBAT_SELF_HITS" then
		if CritLineData[CritLineRealm][CritLinePlayer]["Settings"]["FilterAttacks"] == "0" then
			for creaturename, damage in string.gfind(arg1, COMBAT_CRIT)do
				CritLine_RecordHit(CRIT_TEXT, "CRIT", tonumber(damage), creaturename, DAMAGE_TYPE_NONHEAL)			
			end
			
			for creaturename, damage in string.gfind(arg1, COMBAT_HIT) do
				CritLine_RecordHit(NORMAL_HIT_TEXT, "NORMAL", tonumber(damage), creaturename, DAMAGE_TYPE_NONHEAL)
			end
		end
	elseif event == "CHAT_MSG_SPELL_SELF_DAMAGE" then
		CritAttack = "0"
		if CritLineData[CritLineRealm][CritLinePlayer]["Settings"]["FilterAttacks"] == "0" then
			for i = 1, 3 do
				if getglobal("SPELL_CRIT"..i) ~= "empty" then
					_, _, attacktype, creaturename, damage = string.find(arg1, getglobal("SPELL_CRIT"..i))
					if attacktype then
						CritLine_RecordHit(attacktype, "CRIT", tonumber(damage), creaturename, 	DAMAGE_TYPE_NONHEAL)
						CritAttack = "1"
						if CritLineData[CritLineRealm][CritLinePlayer]["Settings"]["SplashCrit"] == "1" then
							CritLineSplashFrame:AddMessage(CRITLINE_CRITICAL, 1, 0, 0, 1, 3)
						end
					end
				end
				if getglobal("SPELL_HIT"..i) ~= "empty" then
					_, _, attacktype, creaturename, damage = string.find(arg1, getglobal("SPELL_HIT"..i))
					if attacktype and CritAttack == "0" then
						CritLine_RecordHit(attacktype, "NORMAL", tonumber(damage), creaturename, DAMAGE_TYPE_NONHEAL)
					end
				end
			end
		end
	end
end

function CritLine_RecordHit(AttackType, HitType, Damage, uname, IsHealing)
	
	if CritLineData[CritLineRealm][CritLinePlayer]["Data"][HitType.."Count"] == nil then
		CritLineData[CritLineRealm][CritLinePlayer]["Data"][HitType.."Count"] = 0
	end
	
	CritLineData[CritLineRealm][CritLinePlayer]["Data"][HitType.."Count"] = CritLineData[CritLineRealm][CritLinePlayer]["Data"][HitType.."Count"]+1
	
	if CritLineData[CritLineRealm][CritLinePlayer]["Data"]["NORMALCount"] == nil or CritLineData[CritLineRealm][CritLinePlayer]["Data"]["CRITCount"] == nil then
		
	else
		local AllHitsSummary
		local OnePercentSummary
		
		AllHitsSummary = tonumber(CritLineData[CritLineRealm][CritLinePlayer]["Data"]["NORMALCount"])+tonumber(CritLineData[CritLineRealm][CritLinePlayer]["Data"]["CRITCount"])
		OnePercentSummary = 100/AllHitsSummary
		CritPercentSummary = OnePercentSummary*tonumber(CritLineData[CritLineRealm][CritLinePlayer]["Data"]["CRITCount"])
		CritLineData[CritLineRealm][CritLinePlayer]["Data"]["CritPercent"] = CritPercentSummary
	end
	
	if CritLineData[CritLineRealm][CritLinePlayer]["Data"][AttackType] == nil then
		CritLineData[CritLineRealm][CritLinePlayer]["Data"][AttackType] = {}
	end
	
	if CritLineData[CritLineRealm][CritLinePlayer]["Data"][AttackType][HitType.."Count"] == nil then
		CritLineData[CritLineRealm][CritLinePlayer]["Data"][AttackType][HitType.."Count"] = 0
	end
	
	CritLineData[CritLineRealm][CritLinePlayer]["Data"][AttackType][HitType.."Count"] = CritLineData[CritLineRealm][CritLinePlayer]["Data"][AttackType][HitType.."Count"]+1
	
	if CritLineData[CritLineRealm][CritLinePlayer]["Data"][AttackType]["NORMALCount"] == nil or CritLineData[CritLineRealm][CritLinePlayer]["Data"][AttackType]["CRITCount"] == nil then
		
	else
		local AllHits
		local OnePercent
		
		AllHits = tonumber(CritLineData[CritLineRealm][CritLinePlayer]["Data"][AttackType]["NORMALCount"])+tonumber(CritLineData[CritLineRealm][CritLinePlayer]["Data"][AttackType]["CRITCount"])
		OnePercent = 100/AllHits
		CritPercent = OnePercent*tonumber(CritLineData[CritLineRealm][CritLinePlayer]["Data"][AttackType]["CRITCount"])
		
		CritLineData[CritLineRealm][CritLinePlayer]["Data"][AttackType]["CritPercent"] = CritPercent
	end
	
	local targetlvl = UnitLevel("target") or 0
	
	if uname == nil then uname = "??" end
	
	local leveldiff = 0
	if UnitLevel("player") < UnitLevel("target") then
		leveldiff = (UnitLevel("target") - UnitLevel("player"))
	else
		leveldiff = (UnitLevel("player") - UnitLevel("target"))
	end
	
	if tonumber(CritLineData[CritLineRealm][CritLinePlayer]["Settings"]["LVLADJ"]) ~= 0 and tonumber(CritLineData[CritLineRealm][CritLinePlayer]["Settings"]["LVLADJ"]) < leveldiff then
		
	else
		if CritLineData[CritLineRealm][CritLinePlayer]["Data"][AttackType] == nil then
			CritLineData[CritLineRealm][CritLinePlayer]["Data"][AttackType] = {}
		end
		
		if CritLineData[CritLineRealm][CritLinePlayer]["Data"][AttackType][HitType] == nil then
			CritLineData[CritLineRealm][CritLinePlayer]["Data"][AttackType][HitType] = {}
		end
		
		if CritLineData[CritLineRealm][CritLinePlayer]["Data"][AttackType][HitType]["Damage"] == nil or CritLineData[CritLineRealm][CritLinePlayer]["Data"][AttackType][HitType]["Damage"] < Damage then
			
			CritLineData[CritLineRealm][CritLinePlayer]["Data"][AttackType][HitType]["Damage"] = Damage
			CritLineData[CritLineRealm][CritLinePlayer]["Data"][AttackType][HitType]["Target"] = uname
			CritLineData[CritLineRealm][CritLinePlayer]["Data"][AttackType][HitType]["Level"] = targetlvl
			CritLineData[CritLineRealm][CritLinePlayer]["Data"][AttackType][HitType]["Date"] = date()
			CritLineData[CritLineRealm][CritLinePlayer]["Data"][AttackType][HitType]["IsHeal"] = IsHealing
			
			if CritLineData[CritLineRealm][CritLinePlayer]["Settings"]["Splash"] == "1" then
				CritLineSplashFrame:AddMessage(Damage, 1, 1, 1, 1, 3)
				CritLineSplashFrame:AddMessage(format(CRITLINE_NEW_RECORD_MSG, AttackType), 1, 1, 0, 1, 3)
			end
			--Play Sound?
			if CritLineData[CritLineRealm][CritLinePlayer]["Settings"]["Sound"] == "1" then 
				PlaySound("LEVELUP", 1, 1, 0, 1, 3)
			end
			--ScreenShot?
			if CritLineData[CritLineRealm][CritLinePlayer]["Settings"]["ScreenShot"] == "1" then 
				TakeScreenshot()
			end
		end
	end
	CritLine_GetSummaryRichText()
end

function CritLine_GetSummaryRichText()
	--build the SummaryDisplay rich text and return it instead of displaying it.
	--this is used for displaying as a tooltip.
	
	local hidmg = 0
	for k,v in pairs(CritLineData[CritLineRealm][CritLinePlayer]["Data"]) do
		if k ~= "CRITCount" and k ~= "NORMALCount" and k ~= "CritPercent" then
			if CritLineData[CritLineRealm][CritLinePlayer]["Data"][k]["CRIT"] then
				if CritLineData[CritLineRealm][CritLinePlayer]["Data"][k]["CRIT"]["IsHeal"] == "0" then
					if CritLineData[CritLineRealm][CritLinePlayer]["Data"][k]["CRIT"]["Damage"] > hidmg then
						hidmg = CritLineData[CritLineRealm][CritLinePlayer]["Data"][k]["CRIT"]["Damage"]
					end
				end
			end
		end
	end
	hicrit = hidmg
	
	local hidmg = 0
	for k,v in pairs(CritLineData[CritLineRealm][CritLinePlayer]["Data"]) do
		if k ~= "CRITCount" and k ~= "NORMALCount" and k ~= "CritPercent" then
			if CritLineData[CritLineRealm][CritLinePlayer]["Data"][k]["CRIT"] then
				if CritLineData[CritLineRealm][CritLinePlayer]["Data"][k]["CRIT"]["IsHeal"] == "1" then
					if CritLineData[CritLineRealm][CritLinePlayer]["Data"][k]["CRIT"]["Damage"] > hidmg then
						hidmg = CritLineData[CritLineRealm][CritLinePlayer]["Data"][k]["CRIT"]["Damage"]
					end
				end
			end
		end
	end
	hihealcrit = hidmg
	
	local hidmg = 0
	for k,v in pairs(CritLineData[CritLineRealm][CritLinePlayer]["Data"]) do
		if k ~= "CRITCount" and k ~= "NORMALCount" and k ~= "CritPercent" then
			if CritLineData[CritLineRealm][CritLinePlayer]["Data"][k]["NORMAL"] then
				if CritLineData[CritLineRealm][CritLinePlayer]["Data"][k]["NORMAL"]["IsHeal"] == "0" then
					if CritLineData[CritLineRealm][CritLinePlayer]["Data"][k]["NORMAL"]["Damage"] > hidmg then
						hidmg = CritLineData[CritLineRealm][CritLinePlayer]["Data"][k]["NORMAL"]["Damage"]
					end
				end
			end
		end
	end
	highdmg = hidmg
	
	
	local hidmg = 0
	for k,v in pairs(CritLineData[CritLineRealm][CritLinePlayer]["Data"]) do
		if k ~= "CRITCount" and k ~= "NORMALCount" and k ~= "CritPercent" then
			if CritLineData[CritLineRealm][CritLinePlayer]["Data"][k]["NORMAL"] then
				if CritLineData[CritLineRealm][CritLinePlayer]["Data"][k]["NORMAL"]["IsHeal"] == "1" then
					if CritLineData[CritLineRealm][CritLinePlayer]["Data"][k]["NORMAL"]["Damage"] > hidmg then
						hidmg = CritLineData[CritLineRealm][CritLinePlayer]["Data"][k]["NORMAL"]["Damage"]
					end
				end
			end
		end
	end
	hihealdmg = hidmg
	
	local rtfAttack=""
	local rtfSummary=""
	local spacer=""
	local i=0
	for k,v in pairs(CritLineData[CritLineRealm][CritLinePlayer]["Data"]) do
		if k ~= "CRITCount" and k ~= "NORMALCount" and k ~= "CritPercent" then
			attacktype = k
			rtfAttack = rtfAttack.."---------------------------------------------------------\n"..Critline_Color(HEADER_TEXT_COLOR, attacktype).."\n"
			
			for k,v in pairs(CritLineData[CritLineRealm][CritLinePlayer]["Data"][attacktype]) do
				if k ~= "CRITCount" and k ~= "NORMALCount" and k ~= "CritPercent" then
					if k == "NORMAL" then
						rtfAttack = rtfAttack.." "..Critline_Color(SUBHEADER_TEXT_COLOR, NORMAL_TEXT).."["
						spacer = " "..NORMAL_TEXT.."["..CritLineData[CritLineRealm][CritLinePlayer]["Data"][attacktype][k]["Damage"]
					else
						rtfAttack = rtfAttack.." "..Critline_Color(SUBHEADER_TEXT_COLOR, CRIT_TEXT).."["
						spacer = " "..CRIT_TEXT.."["..CritLineData[CritLineRealm][CritLinePlayer]["Data"][attacktype][k]["Damage"]
					end
					
					if k == "CRIT" then
						if CritLineData[CritLineRealm][CritLinePlayer]["Data"][attacktype][k]["IsHeal"] == "0" then
							if CritLineData[CritLineRealm][CritLinePlayer]["Data"][attacktype][k]["Damage"] == hicrit then
								rtfAttack = rtfAttack..Critline_Color(HINT_TEXT_COLOR, CritLineData[CritLineRealm][CritLinePlayer]["Data"][attacktype][k]["Damage"]).."]\t"
								rtfSummaryCrit = "\nCritical:\n"..Critline_Color(HEADER_TEXT_COLOR, attacktype).."\n"..Critline_Color(HINT_TEXT_COLOR, CritLineData[CritLineRealm][CritLinePlayer]["Data"][attacktype][k]["Damage"]).."\n"
							else
								rtfAttack = rtfAttack..Critline_Color(BODY_TEXT_COLOR, CritLineData[CritLineRealm][CritLinePlayer]["Data"][attacktype][k]["Damage"]).."]\t"
							end
						else
							if CritLineData[CritLineRealm][CritLinePlayer]["Data"][attacktype][k]["Damage"] == hihealcrit then
								rtfAttack = rtfAttack..Critline_Color(HINT_TEXT_COLOR, CritLineData[CritLineRealm][CritLinePlayer]["Data"][attacktype][k]["Damage"]).."]\t"
								rtfSummaryCritHeal = "\nCritHeal:\n"..Critline_Color(HEADER_TEXT_COLOR, attacktype).."\n"..Critline_Color(HINT_TEXT_COLOR, CritLineData[CritLineRealm][CritLinePlayer]["Data"][attacktype][k]["Damage"]).."\n"
							else
								rtfAttack = rtfAttack..Critline_Color(BODY_TEXT_COLOR, CritLineData[CritLineRealm][CritLinePlayer]["Data"][attacktype][k]["Damage"]).."]\t"
							end
						end
						--CRIT %
						if CritLineData[CritLineRealm][CritLinePlayer]["Data"][attacktype]["CritPercent"] == nil then
							
						else
							mypercent = tonumber( string.format("%.2f", CritLineData[CritLineRealm][CritLinePlayer]["Data"][attacktype]["CritPercent"] ) )
							rtfAttack = rtfAttack.."["..Critline_Color(BODY_TEXT_COLOR, mypercent).."%]"
							spacer = spacer.."["..mypercent.."%]"
						end
						if CritLineData[CritLineRealm][CritLinePlayer]["Data"]["CritPercent"] == nil then
							rtfSummaryPercent = "\nChance to Crit:\n"..Critline_Color(BODY_TEXT_COLOR, "0").."%"
						else
							mypercentsummary = tonumber( string.format("%.2f", CritLineData[CritLineRealm][CritLinePlayer]["Data"]["CritPercent"] ) )
							rtfSummaryPercent = "\nChance to Crit:\n"..Critline_Color(BODY_TEXT_COLOR, mypercentsummary).."%"	
						end
					else
						if CritLineData[CritLineRealm][CritLinePlayer]["Data"][attacktype][k]["IsHeal"] == "0" then
							if CritLineData[CritLineRealm][CritLinePlayer]["Data"][attacktype][k]["Damage"] == highdmg then
								rtfAttack = rtfAttack..Critline_Color(HINT_TEXT_COLOR, CritLineData[CritLineRealm][CritLinePlayer]["Data"][attacktype][k]["Damage"]).."]"
								rtfSummaryDmg = "\nNormal:\n"..Critline_Color(HEADER_TEXT_COLOR, attacktype).."\n"..Critline_Color(HINT_TEXT_COLOR, CritLineData[CritLineRealm][CritLinePlayer]["Data"][attacktype][k]["Damage"]).."\n"
							else
								rtfAttack = rtfAttack..Critline_Color(BODY_TEXT_COLOR, CritLineData[CritLineRealm][CritLinePlayer]["Data"][attacktype][k]["Damage"]).."]"
							end
						else
							if CritLineData[CritLineRealm][CritLinePlayer]["Data"][attacktype][k]["Damage"] == hihealdmg then
								rtfAttack = rtfAttack..Critline_Color(HINT_TEXT_COLOR, CritLineData[CritLineRealm][CritLinePlayer]["Data"][attacktype][k]["Damage"]).."]\t\t\t\t"
								rtfSummaryHeal = "\nHeal:\n"..Critline_Color(HEADER_TEXT_COLOR, attacktype).."\n"..Critline_Color(HINT_TEXT_COLOR, CritLineData[CritLineRealm][CritLinePlayer]["Data"][attacktype][k]["Damage"]).."\n"
							else
								rtfAttack = rtfAttack..Critline_Color(BODY_TEXT_COLOR, CritLineData[CritLineRealm][CritLinePlayer]["Data"][attacktype][k]["Damage"]).."]"
							end
						end
					end
					--ADDS TARGET AND LEVEL
					if CritLineData[CritLineRealm][CritLinePlayer]["Data"][attacktype][k]["Level"] == -1 then
						spacer = spacer..CritLineData[CritLineRealm][CritLinePlayer]["Data"][attacktype][k]["Target"].." [??]"
						i=(56 - string.len(spacer))
						while i>0 do
							rtfAttack = rtfAttack.." "
							i=i-1
						end
						rtfAttack = rtfAttack..Critline_Color(BODY_TEXT_COLOR, CritLineData[CritLineRealm][CritLinePlayer]["Data"][attacktype][k]["Target"]).." ["..Critline_Color(BODY_TEXT_COLOR, "??").."]\n"
					else
						spacer = spacer..CritLineData[CritLineRealm][CritLinePlayer]["Data"][attacktype][k]["Target"].." ["..CritLineData[CritLineRealm][CritLinePlayer]["Data"][attacktype][k]["Level"].."]"
						i=(56 - string.len(spacer))
						while i>0 do
							rtfAttack = rtfAttack.." "
							i=i-1
						end
						rtfAttack = rtfAttack..Critline_Color(BODY_TEXT_COLOR, CritLineData[CritLineRealm][CritLinePlayer]["Data"][attacktype][k]["Target"]).." ["..Critline_Color(BODY_TEXT_COLOR, CritLineData[CritLineRealm][CritLinePlayer]["Data"][attacktype][k]["Level"]).."]\n"
					end
				end
			end
		end
	end
	local CritLineText2 = getglobal("CritLineText2")
	local CritLineSummaryText2 = getglobal("CritLineSummaryText2")
	
	if highdmg == nil then
		highdmg = "0"
	end
	if hicrit == nil then
		hicrit = "0"
	end
	if hihealdmg == nil then
		hihealdmg = "0"
	end
	if hihealcrit == nil then
		hihealcrit = "0"
	end
	if mypercentsummary == nil then
		mypercentsummary = "0"
	end
	
	CritLine_Normal = Critline_Color(BODY_TEXT_COLOR, highdmg)
	CritLine_Crit = Critline_Color(BODY_TEXT_COLOR, hicrit)
	CritLine_Heal = Critline_Color(BODY_TEXT_COLOR, hihealdmg)
	CritLine_CritHeal = Critline_Color(BODY_TEXT_COLOR, hihealcrit)
	CritLine_CritChance = Critline_Color(BODY_TEXT_COLOR, mypercentsummary)
	
	if rtfSummaryDmg == nil then
		rtfSummaryDmg = "\nNormal:\n"..Critline_Color(BODY_TEXT_COLOR, "0\n")
	end
	if rtfSummaryCrit == nil then
		rtfSummaryCrit = "\nCritical:\n"..Critline_Color(BODY_TEXT_COLOR, "0\n")
	end
	if rtfSummaryHeal == nil then
		rtfSummaryHeal = "\nHeal:\n"..Critline_Color(BODY_TEXT_COLOR, "0\n")
	end
	if rtfSummaryCritHeal == nil then
		rtfSummaryCritHeal = "\nCritHeal:\n"..Critline_Color(BODY_TEXT_COLOR, "0\n")
	end
	if rtfSummaryPercent == nil then
		rtfSummaryPercent = "\nCritHeal:\n"..Critline_Color(BODY_TEXT_COLOR, "0\n")
	end
	
	rtfSummary = rtfSummaryDmg..rtfSummaryCrit..rtfSummaryHeal..rtfSummaryCritHeal..rtfSummaryPercent
	CritLineText2:SetFont("Interface\\AddOns\\CritLine\\courbd.ttf",11)
	CritLineText2:SetText(rtfAttack)
	CritLineSummaryText2:SetText(rtfSummary)
end

function CritLine_ToolTipSummary()
	if CritLineData[CritLineRealm][CritLinePlayer]["Settings"]["ToolTip"] == "1" then
		GameTooltip:SetText(CRITLINE_RECORDS..":")
		GameTooltip:AddLine("")
		GameTooltip:AddDoubleLine(CRITLINE_NORMAL..":", CritLine_Normal)
		GameTooltip:AddDoubleLine(CRITLINE_CRIT..":", CritLine_Crit)
		GameTooltip:AddDoubleLine(CRITLINE_HEAL..":", CritLine_Heal)
		GameTooltip:AddDoubleLine(CRITLINE_CRITHEAL..":", CritLine_CritHeal)
		GameTooltip:AddDoubleLine(CRITLINE_CHANCECRIT..":", CritLine_CritChance.." %")
		GameTooltip:Show()
	end
end

function CritLine_Init()
	if CritLineData == nil then
		CritLineData = {}
	end
	
	if CritLineData[CritLineRealm] == nil then
		CritLineData[CritLineRealm] = {}
	end
	
	if CritLineData[CritLineRealm][CritLinePlayer] == nil then
		CritLineData[CritLineRealm][CritLinePlayer] = {}
		CritLineData[CritLineRealm][CritLinePlayer]["Settings"] = {}
		CritLineData[CritLineRealm][CritLinePlayer]["Settings"]["FilterAttacks"] = "0"
		CritLineData[CritLineRealm][CritLinePlayer]["Settings"]["FilterHeals"] = "0"
		CritLineData[CritLineRealm][CritLinePlayer]["Settings"]["Sound"] = "1"
		CritLineData[CritLineRealm][CritLinePlayer]["Settings"]["Splash"] = "1"
		CritLineData[CritLineRealm][CritLinePlayer]["Settings"]["SplashCrit"] = "1"
		CritLineData[CritLineRealm][CritLinePlayer]["Settings"]["ScreenShot"] = "0"
		CritLineData[CritLineRealm][CritLinePlayer]["Settings"]["Hidden"] = "0"
		CritLineData[CritLineRealm][CritLinePlayer]["Settings"]["SummaryHidden"] = "1"
		CritLineData[CritLineRealm][CritLinePlayer]["Settings"]["LVLADJ"] = "0"
		CritLineData[CritLineRealm][CritLinePlayer]["Settings"]["CritLineButtonPosition"] = 30
		CritLineData[CritLineRealm][CritLinePlayer]["Settings"]["ToolTip"] = "1"
		CritLineData[CritLineRealm][CritLinePlayer]["Data"] = {}
	end
	
	if CritLineData[CritLineRealm][CritLinePlayer]["Settings"]["ToolTip"] == nil then
		CritLineData[CritLineRealm][CritLinePlayer]["Settings"]["ToolTip"] = "1"
	end
	
	if CritLineData[CritLineRealm][CritLinePlayer]["Settings"]["CritLineButtonPosition"] == nil then
		CritLineData[CritLineRealm][CritLinePlayer]["Settings"]["CritLineButtonPosition"] = 30
	end
	
	rtfSummaryDmg = "\nNormal:\n"..Critline_Color(BODY_TEXT_COLOR, "0\n")
	rtfSummaryCrit = "\nCritical:\n"..Critline_Color(BODY_TEXT_COLOR, "0\n")
	rtfSummaryHeal = "\nHeal:\n"..Critline_Color(BODY_TEXT_COLOR, "0\n")
	rtfSummaryCritHeal = "\nCritHeal:\n"..Critline_Color(BODY_TEXT_COLOR, "0\n")
	rtfSummaryPercent = "\nCritHeal:\n"..Critline_Color(BODY_TEXT_COLOR, "0\n")
	
	CritLineButtonPosition = CritLineData[CritLineRealm][CritLinePlayer]["Settings"]["CritLineButtonPosition"]
	CritLineButton_UpdatePosition()
end

function CritLineCommand(msg)
	if msg == "resetall" then
		CritLine_ResetAll()
	elseif msg == "reset" then
		CritLine_Reset()
	elseif msg == "show" then
		CritLineFrameMini:Show()
		CritLineData[CritLineRealm][CritLinePlayer]["Settings"]["Hidden"] = "0"
	elseif msg == "hide" then
		CritLineFrameMini:Hide()
		CritLineFrame:Hide()
		CritLineData[CritLineRealm][CritLinePlayer]["Settings"]["Hidden"] = "1"
	elseif msg == "open" then
		CritLine_ShowFrame()
	end
end

function CritLine_ResetAll()
	CritLineData = {}
	CritLineData[CritLineRealm] = {}
	CritLineData[CritLineRealm][CritLinePlayer] = {}
	CritLineData[CritLineRealm][CritLinePlayer]["Settings"] = {}
	CritLineData[CritLineRealm][CritLinePlayer]["Settings"]["FilterAttacks"] = "0"
	CritLineData[CritLineRealm][CritLinePlayer]["Settings"]["FilterHeals"] = "0"
	CritLineData[CritLineRealm][CritLinePlayer]["Settings"]["Sound"] = "1"
	CritLineData[CritLineRealm][CritLinePlayer]["Settings"]["Splash"] = "1"
	CritLineData[CritLineRealm][CritLinePlayer]["Settings"]["SplashCrit"] = "1"
	CritLineData[CritLineRealm][CritLinePlayer]["Settings"]["ScreenShot"] = "0"
	CritLineData[CritLineRealm][CritLinePlayer]["Settings"]["Hidden"] = "0"
	CritLineData[CritLineRealm][CritLinePlayer]["Settings"]["SummaryHidden"] = "1"
	CritLineData[CritLineRealm][CritLinePlayer]["Settings"]["LVLADJ"] = "0"
	CritLineData[CritLineRealm][CritLinePlayer]["Settings"]["CritLineButtonPosition"] = 30
	CritLineData[CritLineRealm][CritLinePlayer]["Settings"]["ToolTip"] = "1"
	CritLineData[CritLineRealm][CritLinePlayer]["Data"] = {}
	rtfSummaryDmg = "\nNormal:\n"..Critline_Color(BODY_TEXT_COLOR, "0\n")
	rtfSummaryCrit = "\nCritical:\n"..Critline_Color(BODY_TEXT_COLOR, "0\n")
	rtfSummaryHeal = "\nHeal:\n"..Critline_Color(BODY_TEXT_COLOR, "0\n")
	rtfSummaryCritHeal = "\nCritHeal:\n"..Critline_Color(BODY_TEXT_COLOR, "0\n")
	rtfSummaryPercent = "\nCritHeal:\n"..Critline_Color(BODY_TEXT_COLOR, "0\n")
	CritLine_GetSummaryRichText()
	CritLineButtonPosition = CritLineData[CritLineRealm][CritLinePlayer]["Settings"]["CritLineButtonPosition"]
	CritLineButton_UpdatePosition()
	DEFAULT_CHAT_FRAME:AddMessage(CRITLINE_ALL_DATA_RESETTED)
end

function CritLine_Reset()
	CritLineData[CritLineRealm][CritLinePlayer] = {}
	CritLineData[CritLineRealm][CritLinePlayer]["Settings"] = {}
	CritLineData[CritLineRealm][CritLinePlayer]["Settings"]["FilterAttacks"] = "0"
	CritLineData[CritLineRealm][CritLinePlayer]["Settings"]["FilterHeals"] = "0"
	CritLineData[CritLineRealm][CritLinePlayer]["Settings"]["Sound"] = "1"
	CritLineData[CritLineRealm][CritLinePlayer]["Settings"]["Splash"] = "1"
	CritLineData[CritLineRealm][CritLinePlayer]["Settings"]["SplashCrit"] = "1"
	CritLineData[CritLineRealm][CritLinePlayer]["Settings"]["ScreenShot"] = "0"
	CritLineData[CritLineRealm][CritLinePlayer]["Settings"]["Hidden"] = "0"
	CritLineData[CritLineRealm][CritLinePlayer]["Settings"]["SummaryHidden"] = "1"
	CritLineData[CritLineRealm][CritLinePlayer]["Settings"]["LVLADJ"] = "0"
	CritLineData[CritLineRealm][CritLinePlayer]["Settings"]["CritLineButtonPosition"] = 30
	CritLineData[CritLineRealm][CritLinePlayer]["Settings"]["ToolTip"] = "1"
	CritLineData[CritLineRealm][CritLinePlayer]["Data"] = {}
	rtfSummaryDmg = "\nNormal:\n"..Critline_Color(BODY_TEXT_COLOR, "0\n")
	rtfSummaryCrit = "\nCritical:\n"..Critline_Color(BODY_TEXT_COLOR, "0\n")
	rtfSummaryHeal = "\nHeal:\n"..Critline_Color(BODY_TEXT_COLOR, "0\n")
	rtfSummaryCritHeal = "\nCritHeal:\n"..Critline_Color(BODY_TEXT_COLOR, "0\n")
	rtfSummaryPercent = "\nCritHeal:\n"..Critline_Color(BODY_TEXT_COLOR, "0\n")
	CritLine_GetSummaryRichText()
	CritLineButtonPosition = CritLineData[CritLineRealm][CritLinePlayer]["Settings"]["CritLineButtonPosition"]
	CritLineButton_UpdatePosition()
	DEFAULT_CHAT_FRAME:AddMessage(CRITLINE_CHAR_DATA_RESETTED)
end

function Critline_Color(color, msg)
	return color..msg..FONT_COLOR_CODE_CLOSE
end

function CritLine_DisplaySettings()
	--display a settings menu
	
	if CritLineSettingsFrame:IsShown() then
		CritLineSettingsFrame:Hide()
		return
	else
		CritLineSettingsFrame:Show()
	end
	
	CritLineSettingsFrame_Option1Text:SetText(Critline_Color(SUBHEADER_TEXT_COLOR, CRITLINE_OPTION_SPLASH_TEXT))
	if CritLineData[CritLineRealm][CritLinePlayer]["Settings"]["Splash"] == "1" then
		CritLineSettingsFrame_Option1:SetChecked(true)
	end
	
	CritLineSettingsFrame_Option2Text:SetText(Critline_Color(SUBHEADER_TEXT_COLOR, CRITLINE_OPTION_PLAYSOUNDS_TEXT))
	if CritLineData[CritLineRealm][CritLinePlayer]["Settings"]["Sound"] == "1" then
		CritLineSettingsFrame_Option2:SetChecked(true)
	end
	
	CritLineSettingsFrame_Option3Text:SetText(Critline_Color(SUBHEADER_TEXT_COLOR, CRITLINE_OPTION_FILTER_ATTACKS_TEXT))
	if CritLineData[CritLineRealm][CritLinePlayer]["Settings"]["FilterAttacks"] == "1" then
		CritLineSettingsFrame_Option3:SetChecked(true)
	end
	
	CritLineSettingsFrame_Option4Text:SetText(Critline_Color(SUBHEADER_TEXT_COLOR, CRITLINE_OPTION_FILTER_HEALING_TEXT))
	if CritLineData[CritLineRealm][CritLinePlayer]["Settings"]["FilterHeals"] == "1" then
		CritLineSettingsFrame_Option4:SetChecked(true)
	end
	
	CritLineSettingsFrame_Option5Text:SetText(Critline_Color(SUBHEADER_TEXT_COLOR, CRITLINE_OPTION_LVLADJ_TEXT))
	if tonumber(CritLineData[CritLineRealm][CritLinePlayer]["Settings"]["LVLADJ"]) > 0 then
		CritLineSettingsFrame_Option5:SetChecked(true)
	end
	
	CritLineSettingsFrame_Option6Text:SetText(Critline_Color(SUBHEADER_TEXT_COLOR, CRITLINE_OPTION_SCREENCAP_TEXT))
	if CritLineData[CritLineRealm][CritLinePlayer]["Settings"]["ScreenShot"] == "1" then
		CritLineSettingsFrame_Option6:SetChecked(true)
	end
	
	CritLineSettingsFrame_Option7Text:SetText(Critline_Color(SUBHEADER_TEXT_COLOR, CRITLINE_OPTION_SPLASHCRIT_TEXT))
	if CritLineData[CritLineRealm][CritLinePlayer]["Settings"]["SplashCrit"] == "1" then
		CritLineSettingsFrame_Option7:SetChecked(true)
	end
	
	CritLineSettingsFrame_Option8Text:SetText(Critline_Color(SUBHEADER_TEXT_COLOR, CRITLINE_OPTION_TOOLTIP_TEXT))
	if CritLineData[CritLineRealm][CritLinePlayer]["Settings"]["ToolTip"] == "1" then
		CritLineSettingsFrame_Option8:SetChecked(true)
	end
	
	CritLineSettingsFrame_ResetAll:SetText(Critline_Color(SUBHEADER_TEXT_COLOR, CRITLINE_OPTION_RESET_TEXTALL))
	CritLineSettingsFrame_Reset:SetText(Critline_Color(SUBHEADER_TEXT_COLOR, CRITLINE_OPTION_RESET_TEXT))
end

function CritLine_SummaryToggle()
	if CritLineData[CritLineRealm][CritLinePlayer]["Settings"]["SummaryHidden"] == "0" then
		CritLineData[CritLineRealm][CritLinePlayer]["Settings"]["SummaryHidden"] = "1"
		CritLineFrameSummary:Hide()
	else
		CritLineData[CritLineRealm][CritLinePlayer]["Settings"]["SummaryHidden"] = "0"
		CritLineFrameSummary:Show()
	end
end

function CritLine_SettingsClose()
	CritLineSettingsFrame:Hide()
end

function CritLine_ShowFrame()
	if CritLineFrame:IsVisible() then
		CritLineFrame:Hide()
	else
		CritLineFrame:Show()
	end
end

function CritLine_OnClick(button)
	if button == "LeftButton" then
		if CritLineFrame:IsVisible() then
			CritLineFrame:Hide()
		else
			CritLineFrame:Show()
		end
	end
end

function CritLine_SettingsOptionButton_OnClick(arg1)
	if arg1 == 1 then
		CritLine_ToggleSplash()
	elseif arg1 == 2 then
		CritLine_ToggleSound()
	elseif arg1 == 3 then
		CritLine_ToggleCombat()
	elseif arg1 == 4 then
		CritLine_ToggleHealing()
	elseif arg1 == 5 then
		CritLine_ToggleLevelAdjustment()
	elseif arg1 == 6 then
		CritLine_ToggleScreenShots()
	elseif arg1 == 7 then
		CritLine_ToggleSplashCrit()
	elseif arg1 == 8 then
		CritLine_ToggleToolTip()
	end
end

function CritLine_ToggleLevelAdjustment()
	
	if CritLineData[CritLineRealm][CritLinePlayer]["Settings"]["LVLADJ"] == "0" then
		CritLineData[CritLineRealm][CritLinePlayer]["Settings"]["LVLADJ"] = "4"
	else
		CritLineData[CritLineRealm][CritLinePlayer]["Settings"]["LVLADJ"] = "0"
	end
end

function CritLine_ToggleScreenShots()
	
	if CritLineData[CritLineRealm][CritLinePlayer]["Settings"]["ScreenShot"] == "0" then
		CritLineData[CritLineRealm][CritLinePlayer]["Settings"]["ScreenShot"] = "1"
	else
		CritLineData[CritLineRealm][CritLinePlayer]["Settings"]["ScreenShot"] = "0"
	end
end

function CritLine_ToggleSound()
	
	if CritLineData[CritLineRealm][CritLinePlayer]["Settings"]["Sound"] == "0" then
		CritLineData[CritLineRealm][CritLinePlayer]["Settings"]["Sound"] = "1"
	else
		CritLineData[CritLineRealm][CritLinePlayer]["Settings"]["Sound"] = "0"
	end
end

function CritLine_ToggleCombat()
	
	if CritLineData[CritLineRealm][CritLinePlayer]["Settings"]["FilterAttacks"] == "0" then
		CritLineData[CritLineRealm][CritLinePlayer]["Settings"]["FilterAttacks"] = "1"
	else
		CritLineData[CritLineRealm][CritLinePlayer]["Settings"]["FilterAttacks"] = "0"
	end
end

function CritLine_ToggleSplash()
	
	if CritLineData[CritLineRealm][CritLinePlayer]["Settings"]["Splash"] == "0" then
		CritLineData[CritLineRealm][CritLinePlayer]["Settings"]["Splash"] = "1"
	else
		CritLineData[CritLineRealm][CritLinePlayer]["Settings"]["Splash"] = "0"
	end
end

function CritLine_ToggleSplashCrit()
	
	if CritLineData[CritLineRealm][CritLinePlayer]["Settings"]["SplashCrit"] == "0" then
		CritLineData[CritLineRealm][CritLinePlayer]["Settings"]["SplashCrit"] = "1"
	else
		CritLineData[CritLineRealm][CritLinePlayer]["Settings"]["SplashCrit"] = "0"
	end
end

function CritLine_ToggleHealing()
	
	if CritLineData[CritLineRealm][CritLinePlayer]["Settings"]["FilterHeals"] == "0" then
		CritLineData[CritLineRealm][CritLinePlayer]["Settings"]["FilterHeals"] = "1"
	else
		CritLineData[CritLineRealm][CritLinePlayer]["Settings"]["FilterHeals"] = "0"
	end
end

function CritLine_ToggleToolTip()
	
	if CritLineData[CritLineRealm][CritLinePlayer]["Settings"]["ToolTip"] == "0" then
		CritLineData[CritLineRealm][CritLinePlayer]["Settings"]["ToolTip"] = "1"
	else
		CritLineData[CritLineRealm][CritLinePlayer]["Settings"]["ToolTip"] = "0"
	end
end

function CritLineButton_UpdatePosition()
	CritLineFrameMini:SetPoint("TOPLEFT", "Minimap", "TOPLEFT", 54 - (78 * cos(CritLineButtonPosition)), (78 * sin(CritLineButtonPosition)) - 55)
	CritLineData[CritLineRealm][CritLinePlayer]["Settings"]["CritLineButtonPosition"] = CritLineButtonPosition
end
--Special Thanks to Uggh!! I used some of his code, cause it is really nice and easy written.