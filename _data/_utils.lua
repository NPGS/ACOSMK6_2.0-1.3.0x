-- ver. 1.3.0   LOGIC HELPERS UTILITIES FOR STANDARD OPERATIONS

local utils = {}
local cfg = require('./_data/_cfg.lua')
local func = require('./_data/_helpers.lua')

function utils.createLogicDesc(itemRecord, group, floatV, intV, desc, statsV)
    local logic = func.genRecords(itemRecord, group, 2)     -- RECORDS
    if not func.existsCheck({logic[0]}) then
        func.createLogicPackage(logic[0], logic[1], {}, {}, {}, 'None', false, {}, {})
            func.createUiData(logic[1], floatV, 'None', intV, GetLocalizedTextByKey(desc), '', {}, statsV)
    end
    return logic[0]
end

function utils.createDeckSide(itemRecord, group, stats)
    local logic = func.genRecords(itemRecord, group, 3)     -- RECORDS
    if not func.existsCheck({logic[0]}) then
        func.createLogicPackage(logic[0], '', {}, {}, {}, 'None', false, {}, {logic[1], logic[2]})
            func.createConstantStat(logic[1], 'Additive', 'BaseStats.Memory', stats[1])
            func.createConstantStat(logic[2], 'Additive', 'BaseStats.BufferSize', stats[2])
    end
    return logic[0]
end

function utils.assignBerserkStats(stats, type, attStat, values, iconic)
    func.createConstantStat(stats[0], 'Additive', 'BaseStats.HasBerserk', 1.0)
    func.createConstantStat(stats[1], 'Additive', 'BaseStats.BerserkCooldownBase', values[1])
    func.createConstantStat(stats[2], 'Additive', 'BaseStats.BerserkChargesDecayRate', values[2])
    func.createConstantStat(stats[3], 'Additive', 'BaseStats.BerserkChargesRegenRate', values[3])
    if type == 'Berserk' then
        func.createCombinedStat(stats[4], 'Additive', '*', 'Player', attStat, 'BaseStats.AttunementHelper', values[4])
    end
    func.createIconicRecord(stats[(#stats -1)], iconic)
end

function utils.assignSandyStats(stats, type, attStat, values, iconic)
    func.createConstantStat(stats[0], 'Additive', 'BaseStats.HasSandevistan', 1.0)
    func.createConstantStat(stats[1], 'Additive', 'BaseStats.TimeDilationSandevistanDuration', values[1])
    func.createConstantStat(stats[2], 'Additive', 'BaseStats.TimeDilationSandevistanTimeScale', values[2])
    func.createConstantStat(stats[3], 'Additive', 'BaseStats.TimeDilationSandevistanRechargeDuration', values[3])
    func.createConstantStat(stats[4], 'Additive', 'BaseStats.TimeDilationSandevistanCooldownBase', values[4])
    func.createConstantStat(stats[5], 'Additive', 'BaseStats.SandevistanKillRechargeValue', values[5])
    func.createConstantStat(stats[6], 'Additive', 'BaseStats.TimeDilationSandevistanEnterCost', 0.0)
    if type[1] == 'Sandevistan' then
        func.createCombinedStat(stats[7], 'Additive', '*', 'Player', attStat, 'BaseStats.AttunementHelper', values[6])
        if type[2] == 'Spectre' then
            func.createConstantStat(stats[8], 'Multiplier', 'BaseStats.Health', values[7])
            func.createConstantStat(stats[9], 'Multiplier', 'BaseStats.MitigationChance', values[7])
            func.createConstantStat(stats[10], 'Multiplier', 'BaseStats.MitigationStrength', values[7])
        end
    end
    func.createIconicRecord(stats[(#stats -1)], iconic)
end

function utils.createSandyActiveEffect(itemRecord, group, stats, modifiers, values)
    local hasAtkSpd = func.tableContains(stats, 'AttackSpeed')
    local logic = func.genRecords(itemRecord, group, (hasAtkSpd) and 7 or 4)    -- RECORDS
    local statsRecords = func.genRecords(itemRecord, 'effectStat', #stats)      -- STATS RECORDS
    local effectorTable = (hasAtkSpd) and {logic[1], logic[4]} or {logic[1]}    -- EFFECTORS
    local tableOfStats1 = {}
    local tableOfStats2 = {}
    if not func.existsCheck({logic[0]}) then
        for i, stat in ipairs(stats) do
            if stat ~= 'AttackSpeed' then
                table.insert(tableOfStats1, func.createConstantStat(statsRecords[i], modifiers[i], 'BaseStats.'..stat, values[i]))
            else
                table.insert(tableOfStats2, func.createConstantStat(statsRecords[i], modifiers[i], 'BaseStats.'..stat, values[i]))
            end
        end
        func.createLogicPackage(logic[0], '', {}, effectorTable, {}, 'None', false, {}, {})
            ---------- INNER EFFECT 1 ----------
            func.applyStatGroupEffectors(logic[1], 'None', 'ApplyStatGroupEffector', logic[2], false, false, true, logic[3], {})
                func.createIPrereq(logic[2], 'TimeDilationPSMPrereq', true, false, 'Sandevistan')
                func.createStatModGrp(logic[3], false, false, {}, false, tableOfStats1, -1, '')
            if hasAtkSpd then
                ---------- INNER EFFECT 2 ----------
                func.applyStatGroupEffectors(logic[4], 'Weapon', 'ApplyStatGroupEffector', logic[5], false, false, true, logic[6], {})
                    func.createMultiPrereq(logic[5], 'AND', {logic[2], 'Prereqs.MeleeWeaponHeldPrereq'}, 'gameMultiPrereq')
                    func.createStatModGrp(logic[6], false, false, {}, false, tableOfStats2, -1, '')
            end
    end
    return logic[0]
end

function utils.createSandyFlatDamageBonus(itemRecord, group, value)
    local logic = func.genRecords(itemRecord, group, 4)     -- RECORDS
    if not func.existsCheck({logic[0]}) then
        func.createLogicPackage(logic[0], '', {}, {logic[1]}, {}, 'None', false, {}, {})
            func.createEffectorEffector(logic[1], 'None', 'ApplyEffectorEffector', logic[2], logic[3], false, false, {})
                func.createEffector(logic[2], 'ModifyDamageEffector', 'Prereqs.ProcessHitTriggeredAllowProjection', false, false, {}, 'Multiply', '', value, 'Float')
                func.createIPrereq(logic[3], 'TimeDilationPSMPrereq', true, false, 'Sandevistan')
    end
    return logic[0]
end

function utils.createAttunementLogic(itemRecord, group, uiVal, icon, desc, desc2, tag, type, stat, stat2, value)
    local logic = func.genRecords(itemRecord, group, 6)     -- RECORDS
    if not func.existsCheck({logic[0]}) then
        func.createLogicPackage(logic[0], logic[1], {}, {logic[2]}, {}, 'None', true, {}, {})
            func.createUiData(logic[1], uiVal, icon, {}, desc, desc2, {}, {'BaseStats.AttunementHelper'})
            func.applyStatGroupEffectors(logic[2], 'None', 'ApplyStatGroupEffector', logic[3], false, false, true, logic[4], {})
                func.createStatusEffectPrereq(logic[3], 'CheckType.Tag', false, 'None', 'StatusEffectPrereq', '', tag)
                    func.createStatModGrp(logic[4], false, false, {}, false, {logic[5]}, -1, '')
                        func.createCombinedStat(logic[5], 'Additive', '*', type, stat, stat2, value)
    end
    return logic[0]
end

function utils.createSandyStatsRecover(itemRecord, group, stats, values)
    local logic = func.genRecords(itemRecord, group, 6)                         -- LOGIC RECORDS
    local statsRecords = func.genRecords(itemRecord, 'statHarvest', #stats)     -- STATS RECORDS
    local tableOfStats = {}
    if not func.existsCheck({logic[0]}) then
        for i, stat in ipairs(stats) do
            table.insert(tableOfStats, func.createStatPoolUpdate(statsRecords[i], {}, 'BaseStatPools.'..stat, values[i]))
        end
        func.createLogicPackage(logic[0], '', {}, {logic[1]}, {}, 'None', false, {}, {})
            func.createEffectorEffector(logic[1], 'None', 'ApplyEffectorEffector', logic[2], logic[5], false, false, {})
                func.createModStatPoolEffect(logic[2], 'None', 'ModifyStatPoolValueEffector', logic[3], false, false, false, {}, tableOfStats, true)
                    func.createHitPrereq(logic[3], 'HitTriggered', {'Prereqs.TargetKilledHitPrereqCondition', logic[4]}, true, false, 'PostProcess', 'Damage', 'HitTriggeredPrereq', false)
                        func.createHitPrereqCondition(logic[4], true, false, 'Prereqs.StatusEffectPresent', 'CheckType.Type', 'Target', 'Defeated', 'None')
                func.createIPrereq(logic[5], 'TimeDilationPSMPrereq', true, false, 'Sandevistan')
    end
    return logic[0]
end

function utils.setItemRecipe(itemRecord, tags, prevItem, values, itemName, iconName, iconPath)
    local isSpectreRetail = (prevItem == 'Items.ArasakaSandevistanRetailMK6PlusPlus') and true or false
    local itemRecipe = itemRecord..'_Recipe'                                                -- RECIPE
    local recipe = func.genRecords(itemRecipe, 'inline', (isSpectreRetail) and 7 or 5)      -- RECORDS
    local recipeElements = {
        { recipe[2], 1, prevItem },
        { recipe[3], values[1], 'Items.LegendaryMaterial1' }
    }
    local craftingRecipe = { recipe[2], recipe[3] }
    if isSpectreRetail then
        local uniqueRecipeElements = {
            { recipe[4], 1, 'Items.SpectreProtoUpgradeKit', 'SpectreUpgradeKit-Name', cfg.spectreUpgradeKitIcon },
            { recipe[5], 1, 'Items.SpectreProtoLimitRemover', 'SpectreLimitRemover-Name', cfg.spectreLimitRemoverIcon },
            { recipe[6], 1, 'Items.SpectreProtoChronoLattice', 'SpectreChronoLattice-Name', cfg.spectreChronoLatticeIcon }
        }
        for i, item in ipairs(uniqueRecipeElements) do
            table.insert(recipeElements, item)
            table.insert(craftingRecipe, item[1])
            func.createCraftingItem(item[3], item[4], 'Quality.Legendary')
            func.createIcon(item[3], item[5], cfg.iconPath)
        end
    else
        table.insert(recipeElements, { recipe[4], values[2], 'Items.EpicMaterial1' })
        table.insert(craftingRecipe, recipe[4])
    end
    if not func.existsCheck({itemRecipe}) then
        func.createItemRecipe(itemRecipe, recipe[0], itemName, iconName, iconPath, 'Quality.Legendary', tags, 2.0)
            func.createCraftResult(recipe[0], 1, itemRecord)
            func.createCraftingPackage(recipe[1], 1.0, craftingRecipe, 1.0)
            func.createRecipeElements(recipeElements)
        TweakDB:SetFlat(itemRecord..'.CraftingData', recipe[1])
    end
    return itemRecipe
end

function utils.setItemToVendorsInventory(itemRecord, quality)
    local genPrereqs = {}
    if (quality == 'Legendary') or (quality == 'Epic') or (quality == 'Rare') then
        genPrereqs = {'LootPrereqs.'..quality..'CWLevelAvailabilityAtVendor'}
    end
    func.createItemForVendors(itemRecord, genPrereqs)
end

function utils.checkCustomString(str)
    if not str or (str == '') then return GetLocalizedText('CUSTOM DESCRIPTION NEEDED...') end
    if str:find('LocKey#', 1, true) then
        return str
    else
        return GetLocalizedTextByKey(str)
    end
end

return utils