-- ver. 1.3.0   BERSERK CUSTOM ACTION GENERATOR

local bCA = {}
local func = require('./_data/_helpers.lua')
local prefix = 'CyberwareAction.ACOS_UseBerserk'
local quality = { 'Base', 'Plus', 'PlusPlus', 'Ultimate' }

local values = {
    { 10.0, 6.0, 1.14, 1.09, 0.10, -0.07, 0.8 },
    { 15.0, 9.0, 1.20, 1.14, 0.15, -0.10, 0.7 },
    { 20.0, 12.0, 1.28, 1.18, 0.20, -0.14, 0.6 },
    { 30.0, 18.0, 1.42, 1.28, 0.30, -0.20, 0.4 }
}

local stats = {
    func.genRecords(prefix..quality[1], 'stat', 22),
    func.genRecords(prefix..quality[2], 'stat', 22),
    func.genRecords(prefix..quality[3], 'stat', 22),
    func.genRecords(prefix..quality[4], 'stat', 22)
}

local records = {
    func.genRecords(prefix..quality[1], 'inline', 15),
    func.genRecords(prefix..quality[2], 'inline', 15),
    func.genRecords(prefix..quality[3], 'inline', 15),
    func.genRecords(prefix..quality[4], 'inline', 15)
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

local tags = { 'Buff', 'CyberwareBuff', 'ArasakaBerserkBuff' }

function bCA.make()
    func.genTags({'ArasakaBerserkBuff'})
    local tableCheck = {}
    for i, string in ipairs(quality) do
        local packages = {
            'BaseStatusEffect.AdvancedBerserkPlayerBuff_inline1',
            'BaseStatusEffect.AdvancedBerserkPlayerBuff_inline2',
            records[i][2]
        }
        local effects = { records[i][3], records[i][5], records[i][7], records[i][9], records[i][10], records[i][11], records[i][13], records[i][14] }
        local actionStats = { stats[i][11], stats[i][12], stats[i][13], stats[i][14], stats[i][15], stats[i][16], stats[i][17], stats[i][18] }
        local actionStats2 = { stats[i][1], stats[i][2], stats[i][3], stats[i][4], stats[i][5], stats[i][6], stats[i][7] }
        if not func.existsCheck({prefix..string}) then
            ------------------------------------------- ACTION -------------------------------------------
            func.createObjAction(prefix..string, 'UseBerserk', {}, {}, '', {}, '', {}, '', 'HackCategory.NotAHack', '', {}, prereqs, 'None', 'ObjectActionType.Direct', '', 0.0, {}, {records[i][0]}, {}, {})
                func.createObjActionEffect(records[i][0], '', 'ObjectActionReference.Instigator', records[i][1])
                    func.createStatusEffect(records[i][1], '', {}, {fxRecords[i][0]}, 'None', {}, 'BaseStats.InfiniteDuration', false, tags, {}, true, true, 'RTDB.StatusEffect_inline0', packages, '', false, false, '', false, true, true, 'BaseStatusEffectTypes.Berserk', true, '')
                        func.createStatusEffectFX(fxRecords[i][0], 'berserk', false)
                        ------------------------------------------- ACTION LOGIC 1 -------------------------------------------
                        func.createLogicPackage(records[i][2], '', {}, effects, {}, 'None', false, {}, actionStats)
                            ---------- INTERNAL ACTION LOCIC 1 ----------
                            func.applyStatGroupEffectorsForZerk(records[i][3], 'Weapon', 'ApplyStatGroupEffector', 'Prereqs.MeleeWeaponHeldPrereq', false, false, true, records[i][4], {}, true)
                                func.createStatModGrp(records[i][4], false, false, {}, false, {stats[i][0]}, -1, '')
                                    func.createConstantStat(stats[i][0], 'AdditiveMultiplier', 'BaseStats.AttackSpeed', values[i][5])
                            ---------- INTERNAL ACTION LOCIC 2 ----------
                            func.applyStatGroupEffectorsForZerk(records[i][5], 'Weapon', 'ApplyStatGroupEffector', 'Prereqs.RangedWeaponHeldPrereq', false, false, true, records[i][6], {}, true)
                                func.createStatModGrp(records[i][6], false, false, {}, false, actionStats2, -1, '')
                                    func.createConstantStat(stats[i][1], 'AdditiveMultiplier', 'BaseStats.RecoilKickMin', values[i][6])
                                    func.createConstantStat(stats[i][2], 'AdditiveMultiplier', 'BaseStats.RecoilKickMax', values[i][6])
                                    func.createConstantStat(stats[i][3], 'AdditiveMultiplier', 'BaseStats.SpreadDefaultX', values[i][6])
                                    func.createConstantStat(stats[i][4], 'AdditiveMultiplier', 'BaseStats.SpreadMaxX', values[i][6])
                                    func.createConstantStat(stats[i][5], 'AdditiveMultiplier', 'BaseStats.SpreadAdsDefaultX', values[i][6])
                                    func.createConstantStat(stats[i][6], 'AdditiveMultiplier', 'BaseStats.SpreadAdsMaxX', values[i][6])
                            ---------- INTERNAL ACTION LOCIC 3 ----------
                            func.applyStatGroupEffectorsForZerk(records[i][7], 'None', 'ApplyStatGroupEffector', 'Prereqs.AlwaysTruePrereq', false, false, true, records[i][8], {}, true)
                                func.createStatModGrp(records[i][8], false, false, {}, false, {stats[i][7], stats[i][8], stats[i][9], stats[i][10]}, -1, '')
                                    func.createConstantStat(stats[i][7], 'Additive', 'BaseStats.CanIgnoreStamina', 1.0)
                                    func.createConstantStat(stats[i][8], 'Additive', 'BaseStats.ChemicalResistance', values[i][1])
                                    func.createConstantStat(stats[i][9], 'Additive', 'BaseStats.ElectricResistance', values[i][1])
                                    func.createConstantStat(stats[i][10], 'Additive', 'BaseStats.ThermalResistance', values[i][1])
                            ---------- LOGIC 1 STATS ----------
                            func.createConstantStat(stats[i][11], 'Multiplier', 'BaseStats.HeadshotDamageMultiplier', values[i][4])
                            func.createConstantStat(stats[i][12], 'Multiplier', 'BaseStats.WeakspotDamageMultiplier', values[i][4])
                            func.createConstantStat(stats[i][13], 'Additive', 'BaseStats.CanGroundSlamInAir', 1.0)
                            func.createConstantStat(stats[i][14], 'Additive', 'BaseStats.CanGroundSlamOnGround', 1.0)
                            func.createConstantStat(stats[i][15], 'Multiplier', 'BaseStats.GroundSlamCooldownModifier', 0.1)
                            func.createConstantStat(stats[i][16], 'Multiplier', 'BaseStats.Health', values[i][3])
                            func.createConstantStat(stats[i][17], 'Additive', 'BaseStats.BonusDamageAgainstElites', values[i][2])
                            func.createConstantStat(stats[i][18], 'AdditiveMultiplier', 'BaseStats.MaxSpeed', values[i][5])
                            ---------- INCREASE [DAMAGE DONE] ----------
                            func.createEffector(records[i][9], 'ModifyDamageEffector', 'Perks.IsWeaponMelee', false, false, {}, 'Multiply', '', values[i][3], 'Float')
                            ---------- DECREASE [INCOMING DAMAGE] ----------
                            func.createEffector(records[i][10], 'ModifyDamageEffector', 'Prereqs.ProcessHitReceived', false, false, {}, 'Multiply', '', values[i][7], 'Float')
                            ---------- RESTORE AFTER HIT ENEMY [DURATION] ----------
                            func.createModStatPoolEffect(records[i][11], 'Player', 'ModifyStatPoolValueEffector', records[i][12], false, false, false, {}, {stats[i][19]}, true)
                                func.createMultiPrereq(records[i][12], 'AND', {'Prereqs.HitAttackTypePrereq', 'Condition.NotTargetIsPlayer'}, 'gameMultiPrereq')
                                func.createStatPoolUpdate(stats[i][19], {}, 'BaseStatPools.BerserkCharge', 0.334)
                            ---------- RESTORE AFTER KILL ENEMY [DURATION, HEALTH] ----------
                            func.createEffectorForZerk2(records[i][13], 'ModifyStatusEffectDurationEffector', 'Prereqs.AnyTakedownOrKill', false, false, {}, true, -5.0, 'Float', {'PlayerCyberwareCooldown'}, true, false)
                            func.createModStatPoolEffect(records[i][14], 'None', 'ModifyStatPoolValueEffector', 'Prereqs.AnyTakedownOrKill', false, false, false, {}, {stats[i][20], stats[i][21]}, true)
                                func.createStatPoolUpdate(stats[i][20], {}, 'BaseStatPools.Health', 7.0)
                                func.createStatPoolUpdate(stats[i][21], {}, 'BaseStatPools.BerserkCharge', 3.0)
            table.insert(tableCheck, prefix..string)
        end
    end
    if func.existsCheck(tableCheck) then return true end
    return false
end

return bCA