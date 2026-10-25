-- ver. 1.3.0   CUSTOM CYBERDECK RAM RECOVERY 0.08 - 0.24 UNITS

local cdRamRecoveryAbility = {}
local func = require('./_data/_helpers.lua')
local prefix = "Items.ACOS_CyberdeckRamRecoveryAbility"
local quality = { "1", "2", "3", "Max" }

local values = { 0.08, 0.12, 0.16, 0.24 }

local records = {
    func.genRecords(prefix..quality[1], 'inline', 2),
    func.genRecords(prefix..quality[2], 'inline', 2),
    func.genRecords(prefix..quality[3], 'inline', 2),
    func.genRecords(prefix..quality[4], 'inline', 2)
}

function cdRamRecoveryAbility.make()
    local tableCheck = {}
    for i, item in ipairs(records) do
        if not func.existsCheck({prefix..quality[i]}) then
            func.createLogicPackage(prefix..quality[i], item[0], {}, {}, {}, 'None', false, {}, {item[1]})
                func.createUiData(item[0], {values[i]}, 'ability_silenced', {}, 'LocKey#40778', '', {}, {})
                func.createConstantStat(item[1], 'Additive', 'BaseStats.MemoryRegenRate', values[i])
            table.insert(tableCheck, prefix..quality[i])
        end
    end
    if func.existsCheck(tableCheck) then return true end
    return false
end

return cdRamRecoveryAbility