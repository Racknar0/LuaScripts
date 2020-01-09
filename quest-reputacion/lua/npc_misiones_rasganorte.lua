-- Acá iría el entry del npc que pongas en la DB
local npcEntry = 200003

local ALIANZA = 0
local HORDA = 1

function OnGossipHello(event, player, object)
	-- Corrobora que el jugador no se encuentre en combate
	if (player:IsInCombat() == false) then
		-- Inicializa el menú del jugador.
		player:GossipClearMenu()
		-- Chequea que el jugador sea de nivel 80.
		if (player:GetLevel() == 80) then
			-- Si el jugador es alianza…
			if (player:GetTeam() == ALIANZA) then
				if (player:GetQuestRewardStatus(12898) == false) then
					player:GossipMenuAddItem(0, '¡Los caballeros de la Espada de Ébano!', 1, 10)
				end
				if (player:GetReputation(1090) ~= 42999) then
					player:GossipMenuAddItem(0, '¡Kirin Tor!', 1, 11)
				end
				if (player:GetReputation(1091) ~= 42999) then
					player:GossipMenuAddItem(0, '¡El Acuerdo del Reposo del Dragón!', 1, 12)
				end
				if (player:GetReputation(1156) ~= 42999) then
					player:GossipMenuAddItem(0, '¡El Veredicto Cinéreo!', 1, 13)
				end
			else
				-- Si el jugador es horda…
				if (player:GetQuestRewardStatus(12899) == false) then
					player:GossipMenuAddItem(0, '¡Los caballeros de la Espada de Ébano!', 1, 10)
				end
				if (player:GetReputation(1090) ~= 42999) then
					player:GossipMenuAddItem(0, '¡Kirin Tor!', 1, 11)
				end
				if (player:GetReputation(1091) ~= 42999) then
					player:GossipMenuAddItem(0, '¡El Acuerdo del Reposo del Dragón!', 1, 12)
				end
				if (player:GetReputation(1156) ~= 42999) then
					player:GossipMenuAddItem(0, '¡El Veredicto Cinéreo!', 1, 13)
				end
			end
		end
		player:GossipSendMenu(npcEntry, object)
	end
end

function OnGossipSelect(event, player, object, sender, intid, code, menuid)
	if (intid == 10) then
		if (player:GetTeam() == ALIANZA) then
			quests = {12887, 12891, 12893, 12896, 12898}
		else
			quests = {12892, 12891, 12893, 12897, 12899}
		end
		for i, quest in ipairs(quests) do
			questRewardStatus = player:GetQuestRewardStatus(quest)
			if (questRewardStatus == false) then
				player:AddQuest(quest)
				player:CompleteQuest(quest)
				player:RewardQuest(quest)
			end
		end
		player:SetReputation(1098, 42999)

	end -- Misiones de la espalda de ebano.
	if (intid == 11) then
		-- En el caso del Kirin Tor, lo subimos directamente a exaltado.
		-- No requiere de misiones para ver al intendente, se encuentra en dalaran.
		player:SetReputation(1090, 42999)
	end
	if (intid == 12) then
		-- Mismo caso que el de kirin tor. 
		-- No es necesario completar misiones para poder localizar al intendente en lo alto de la torre de cementerio de dragones.
		player:SetReputation(1091, 42999)
	end
	if (intid == 13) then
		-- Mismo caso que el de kirin tor y reposo del dragón
		player:SetReputation(1156, 42999)
	end
	
	player:GossipComplete()
end

RegisterCreatureGossipEvent(npcEntry, 1, OnGossipHello)
RegisterCreatureGossipEvent(npcEntry, 2, OnGossipSelect)
