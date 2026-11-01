-- ver. 1.3.0   BERSERK ULTRADECK CUSTOM ACTION GENERATOR

local bUDCA = {}
local func = require('_data/_helpers')
local prefix = 'CyberwareAction.ACOS_UseUltraDeckBerserk'
local quality = { 'Base', 'Plus', 'PlusPlus', 'Ultimate' }

local values = { { 1.14, 0.8 }, { 1.2, 0.7 }, { 1.28, 0.6 }, { 1.42, 0.4 } }

local stats = {
    func.genRecords(prefix..quality[1], 'stat', 3),
    func.genRecords(prefix..quality[2], 'stat', 3),
    func.genRecords(prefix..quality[3], 'stat', 3),
    func.genRecords(prefix..quality[4], 'stat', 3)
}

local records = {
    func.genRecords(prefix..quality[1], 'inline', 12),
    func.genRecords(prefix..quality[2], 'inline', 12),
    func.genRecords(prefix..quality[3], 'inline', 12),
    func.genRecords(prefix..quality[4], 'inline', 12)
}

local fxRecords = {
    func.genRecords(prefix..quality[1], 'fxRecord', 1),
    func.genRecords(prefix..quality[2], 'fxRecord', 1),
    func.genRecords(prefix..quality[3], 'fxRecord', 1),
    func.genRecords(prefix..quality[4], 'fxRecord', 1)
}

local prereqs = {
    'CyberwareAction.UseAdvancedBerserk_inline0',
    'CyberwareAction.UseAdvancedBerserk_inline2',
    'CyberwareAction.UseAdvancedBerserk_inline3',
    'CyberwareAction.UseAdvancedBerserk_inline4'
}

local packages2 = { 'BaseStatusEffect.IconicCyberwareCooldown_inline0', 'BaseStatusEffect.BerserkCooldown_inline4' }
local tags = { 'Buff', 'CyberwareBuff', 'ArasakaBerserkUltraDeckBuff' }
local tags2 = { 'Debuff', 'PlayerCyberwareCooldown' }

function bUDCA.make()
    func.genTags({'ArasakaBerserkUltraDeckBuff'})
    local tableCheck = {}
    for i, string in ipairs(quality) do
        local packages = {
            'BaseStatusEffect.AdvancedBerserkPlayerBuff_inline1',
            'BaseStatusEffect.AdvancedBerserkPlayerBuff_inline2',
            records[i][2],
            records[i][8]
        }
        local effects = { records[i][3], records[i][4] }
        local actionStats = { stats[i][0], stats[i][1], stats[i][2] }
        if not func.existsCheck({prefix..string}) then
            ------------------------------------------- ACTION -------------------------------------------
            func.createObjAction(prefix..string, 'UseBerserk', {}, {}, '', {}, '', {}, '', 'HackCategory.NotAHack', '', {}, prereqs, 'None', 'ObjectActionType.Direct', '', 0.0, {}, {records[i][0]}, {}, {})
                func.createObjActionEffect(records[i][0], '', 'ObjectActionReference.Instigator', records[i][1])
                    func.createStatusEffect(records[i][1], '', {}, {fxRecords[i][0]}, 'None', {}, records[i][5], false, tags, {}, true, true, 'RTDB.StatusEffect_inline0', packages, '', false, false, '', false, true, true, 'BaseStatusEffectTypes.Berserk', true, records[i][7])
                        func.createStatusEffectFX(fxRecords[i][0], 'berserk', false)
                        ------------------------------------------- DURATION STATS -------------------------------------------
                        func.createStatModGrp(records[i][5], false, false, {}, false, {'BaseStatusEffect.BerserkPlayerBuff_inline2', records[i][6]}, -1, '')
                            func.createCombinedStat(records[i][6], 'Additive', '*', 'Player', 'BaseStats.BerserkChargesDecayRate', 'BaseStats.MaxDuration', 1.92)
                        ------------------------------------------- ACTION LOGIC 1 -------------------------------------------
                        func.createLogicPackage(records[i][2], '', {}, effects, {}, 'None', false, {}, actionStats)
                            ---------- LOGIC 1 STATS ----------
                            func.createConstantStat(stats[i][0], 'Additive', 'BaseStats.CanGroundSlamInAir', 1.0)
                            func.createConstantStat(stats[i][1], 'Additive', 'BaseStats.CanGroundSlamOnGround', 1.0)
                            func.createConstantStat(stats[i][2], 'Multiplier', 'BaseStats.GroundSlamCooldownModifier', 0.1)
                            ---------- INCREASE [DAMAGE DONE] ----------
                            func.createEffector(records[i][3], 'ModifyDamageEffector', 'Perks.IsWeaponMelee', false, false, {}, 'Multiply', '', values[i][1], 'Float')
                            ---------- DECREASE [INCOMING DAMAGE] ----------
                            func.createEffector(records[i][4], 'ModifyDamageEffector', 'Prereqs.ProcessHitReceived', false, false, {}, 'Multiply', '', values[i][2], 'Float')
                        ------------------------------------------- COOLDOWN LOGIC 1 -------------------------------------------
                        func.createStatusEffectUIData(records[i][7], '', 'LocKey#40952', {}, '', 'second_wind', {}, {}, -9.0, {})
                            func.createLogicPackage(records[i][8], '', {}, {records[i][9]}, {}, 'None', false, {}, {})
                                func.createApplyEffectEffector(records[i][9], 'None', 1.0, 'ApplyStatusEffectEffector', '', true, 'Prereqs.AlwaysTruePrereq', false, false, true, {}, records[i][10], false)
                                    func.createStatusEffect(records[i][10], '', {}, {}, 'None', {}, 'BaseStatusEffect.BerserkCooldown_inline0', false, tags2, {}, true, true, 'RTDB.StatusEffect_inline0', packages2, '', false, false, '', false, false, true, 'BaseStatusEffectTypes.PlayerCooldown', true, records[i][11])
                                        func.createStatusEffectUIData(records[i][11], '', 'LocKey#78210', {}, '', 'berserk_buff', {}, {}, 0.0, {})
            table.insert(tableCheck, prefix..string)
        end
    end
    if func.existsCheck(tableCheck) then return true end
    return false
end

return bUDCA