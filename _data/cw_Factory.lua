-- ver. 1.3.0   AUTOMATIZED CYBERWARE FACTORY

local cw_Factory = {}
local cfg = require('./_data/_cfg.lua')
local func = require('./_data/_helpers.lua')
local utils = require('./_data/_utils.lua')
local cw_Data = require('./_data/cw_Data.lua')

------------------------------------------- AUTOMATIZED CYBERWARE FACTORY -------------------------------------------
function cw_Factory.make()
    local tableCheck = {}
    for i, obj in ipairs(cw_Data) do
        if (obj) then
            local stats = {}
            local onEquip = {}
            local onEquipBak = {}
            local statModifiers = {}
            local nextItem = (obj.nextID) and obj.nextID or ''
            ------------ CREATE ITEM ------------
            if not func.existsCheck({obj.itemID}) then
                if (obj.statsCnt) and (obj.statsCnt > 0) then
                    stats = func.genRecords(obj.itemID, 'stat', obj.statsCnt)                -- GEN STATS
                end
                ------------ SET LOGICS TO ONEQUIP ------------
                if (obj.toEquip.uiRecs) then
                    for _, ui in ipairs(obj.toEquip.uiRecs) do
                        table.insert(onEquip, obj.itemID..ui[1])
                        utils.createLogicDesc(obj.itemID, ui[2], ui[3], ui[4], ui[5], ui[6])
                        if (obj.cwTypeUltra) then
                            table.insert(onEquipBak, obj.itemID..ui[1])
                        end
                    end
                end
                if (obj.toEquip.deck) then
                    if (obj.cwType == 'Cyberdeck') then
                        onEquip = { table.unpack(obj.toEquip.deck) }
                        table.insert(onEquip, obj.itemID..obj.deckSide[1])
                        utils.createDeckSide(obj.itemID, obj.deckSide[2], obj.deckSide[3])
                        if (obj.cwTypeUltra) then
                            onEquip = func.mergeTables(onEquip, onEquipBak)
                        end
                    end
                end
                if (obj.toEquip.effects) then
                    if (obj.cwType == 'Sandevistan') or (obj.cwTypeUltra and obj.cwTypeUltra == 'Sandevistan') then
                        local ef = obj.toEquip.effects
                        for _, efData in pairs(ef) do
                            table.insert(onEquip, obj.itemID..efData[1])
                        end
                        if (ef.active) then
                            utils.createSandyActiveEffect(obj.itemID, ef.active[2], obj.effectStats, obj.modifiers, ef.active[3])
                        end
                        if (ef.recover) then
                            utils.createSandyStatsRecover(obj.itemID, ef.recover[2], ef.recover[3], ef.recover[4])
                        end
                        if (ef.flatDMG) then
                            utils.createSandyFlatDamageBonus(obj.itemID, ef.flatDMG[2], ef.flatDMG[3])
                        end
                    end
                end
                if (obj.toEquip.attunements) then
                    for _, at in ipairs(obj.toEquip.attunements) do
                        local str = utils.checkCustomString(at[5])
                        table.insert(onEquip, obj.itemID..at[1])
                        utils.createAttunementLogic(obj.itemID, at[2], at[3], at[4], str, at[6], at[7], at[8], at[9], at[10], at[11])
                    end
                end
                ------------ SET STATS TO STATSMODIFIERS ------------
                if (stats) then
                    for j = 0, (obj.statsCnt -1) do
                        table.insert(statModifiers, stats[j])
                    end
                end
                ------------------------------------------- ASSIGN STATS -------------------------------------------
                if (obj.stats) then
                    if (obj.cwType == 'Berserk') or (obj.cwTypeUltra and obj.cwTypeUltra == 'Berserk') then
                        utils.assignBerserkStats(stats, obj.stats[1], obj.stats[2], obj.stats[3], obj.stats[4])
                    end
                    if (obj.cwType == 'Cyberdeck') then
                        if not (obj.cwTypeUltra) and (obj.stats[1]) then
                            func.createIconicRecord(stats[0], obj.stats[1])
                        end
                    end
                    if (obj.cwType == 'Sandevistan') or (obj.cwTypeUltra and obj.cwTypeUltra == 'Sandevistan') then
                        utils.assignSandyStats(stats, obj.stats[1], obj.stats[2], obj.stats[3], obj.stats[4])
                    end
                end
                ------------------------------------------- MAKE ITEM'S MAIN RECORD -------------------------------------------
                func.createMainRecord(obj.itemID, '', {}, onEquip, {}, obj.blueprint, obj.buyPrice, obj.cwType, obj.uiName, 'EquipmentArea.SystemReplacementCW', obj.fName, '', obj.uiDesc, nextItem, obj.objActions, {'AttachmentSlots.SystemReplacementCW'}, 'Quality.'..obj.quality, obj.sellPrice, statModifiers, obj.tags, obj.upgradeMul, true, obj.humanity)
                ------------------------------------------- SERVICE [GLOBAL] -------------------------------------------
                func.createIcon(obj.itemID, obj.iconName, obj.iconPath)
                func.arrayInsert(obj.debugTable, obj.itemID)
                if (obj.isCraftable) then
                    utils.setItemRecipe(obj.itemID, cfg.recipeTags, obj.prevID, obj.craftMatCnt, obj.uiName, obj.iconName, obj.iconPath)
                end
                if (obj.isSellable) then
                    utils.setItemToVendorsInventory(obj.itemID, obj.quality)
                end
                table.insert(tableCheck, obj.itemID)
                print(i..' => '..obj.itemID)
            end
        end
    end
    if func.existsCheck(tableCheck) then return true end
    return false
end

return cw_Factory