-- ver. 1.3.0   SHARED SANDEVISTAN ULTRADECKS ACTION GENERATOR

local sSAU = {}
local func = require('./_data/_helpers.lua')
local actionRecord = "CyberwareAction.ACOS_UseUltraDeckSandevistan"
local recs = func.genRecords(actionRecord, 'inline', 9)

local iPrereqs = {
    'CyberwareAction.UseSandevistan_inline0',
    'CyberwareAction.UseSandevistan_inline1',
    'CyberwareAction.UseSandevistan_inline2',
    'CyberwareAction.UseSandevistan_inline3',
    'CyberwareAction.UseSandevistan_inline4',
    'CyberwareAction.UseSandevistan_inline6',
    'CyberwareAction.UseSandevistan_inline8'
}

local gTags = { 'Buff', 'TDEffect', 'CyberwareBuff', 'SandevistanPlayerBuff', 'PreventFuryVFX' }
local pkg = { 'BaseStatusEffect.SandevistanPlayerBuff_inline3', recs[3] }

local gTags2 = { 'Debuff', 'PlayerCyberwareCooldown', 'SandevistanCooldown' }
local pkg2 = { 'BaseStatusEffect.IconicCyberwareCooldown_inline0', 'BaseStatusEffect.SandevistanCooldown_inline3' }

local statMods = { 'BaseStatusEffect.CyberwareCooldownDuration_inline0', 'BaseStatusEffect.SandevistanCooldown_inline1', recs[7] }

function sSAU.make()
    if not func.existsCheck({actionRecord}) then
        func.createObjAction(actionRecord, 'UseSandevistan', {}, {}, '', {}, '', {}, '', 'HackCategory.NotAHack', '', {}, iPrereqs, 'None', 'ObjectActionType.Direct', '', 0.0, {}, {recs[0]}, {}, {})
            func.createObjActionEffect(recs[0], '', 'ObjectActionReference.Instigator', recs[1])
                func.createStatusEffect(recs[1], '', {}, {}, 'None', {}, 'BaseStatusEffect.SandevistanPlayerBuff_inline0', false, gTags, {}, false, false, 'RTDB.StatusEffect_inline0', pkg, '', false, false, '', false, false, true, 'BaseStatusEffectTypes.Sandevistan', true, recs[2])
                    func.createStatusEffectUIData(recs[2], 'LocKey#77875', 'LocKey#40843', {}, '', 'sandevistan_buff_icon', {}, {}, -5.0, {})
                    func.createLogicPackage(recs[3], '', {}, {recs[4]}, {}, 'None', false, {}, {})
                        func.createApplyEffectEffector(recs[4], 'None', 1.0, 'ApplyStatusEffectEffector', '', true, 'Prereqs.AlwaysTruePrereq', false, false, true, {}, recs[5], false)
                            func.createStatusEffect(recs[5], '', {}, {}, 'None', {}, recs[6], false, gTags2, {}, true, true, 'RTDB.StatusEffect_inline0', pkg2, '', false, false, '', false, false, true, 'BaseStatusEffectTypes.PlayerCooldown', true, recs[8])
                                func.createStatModGrp(recs[6], false, false, {}, false, statMods, -1, '')
                                    func.createCombinedStat(recs[7], 'Additive', '*', 'Player', 'BaseStats.TimeDilationSandevistanRechargeDuration', 'BaseStats.MaxDuration', 1.0)
                                func.createStatusEffectUIData(recs[8], '', 'LocKey#78209', {}, '', 'kerenzikov_buff', {}, {}, 0.0, {})
    end
    if func.existsCheck({actionRecord}) then return true end
    return false
end

return sSAU