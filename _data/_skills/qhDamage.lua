-- ver. 1.3.0   CUSTOM QUICKHACK DAMAGE INCREASE 10 - 30%

local QuickHackDamageIncreaseCustom = {}
local func = require('_data/_helpers')
local prefix = "Items.ACOS_QuickHackDamageIncrease"
local quality = { "1", "2", "3", "Max" }

local values = {
    { 0.10, 10.0 },
    { 0.15, 15.0 },
    { 0.20, 20.0 },
    { 0.30, 30.0 }
}

local records = {
    func.genRecords(prefix..quality[1], 'inline', 2),
    func.genRecords(prefix..quality[2], 'inline', 2),
    func.genRecords(prefix..quality[3], 'inline', 2),
    func.genRecords(prefix..quality[4], 'inline', 2)
}

function QuickHackDamageIncreaseCustom.make()
    local tableCheck = {}
    for i, item in ipairs(records) do
        if not func.existsCheck({prefix..quality[i]}) then
            func.createLogicPackage(prefix..quality[i], item[0], {}, {}, {}, 'None', false, {}, {item[1]})
                func.createUiData(item[0], {values[i][2]}, 'None', {}, 'LocKey#92315', '', {}, {})
                func.createConstantStat(item[1], 'Additive', 'BaseStats.QuickhackDamageBonusMultiplier', values[i][1])
            table.insert(tableCheck, prefix..quality[i])
        end
    end
    if func.existsCheck(tableCheck) then return true end
    return false
end

return QuickHackDamageIncreaseCustom