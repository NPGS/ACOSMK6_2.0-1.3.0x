-- ver. 1.3.0   CUSTOM QUICKHACK CRITICAL HIT 14 - 42%

local QuickHackCriticalHit = {}
local func = require('_data/_helpers')
local prefix = "Items.ACOS_QuickHackCriticalHit"
local quality = { "1", "2", "3", "Max" }

local values = { 14.0, 20.0, 28.0, 42.0 }

local records = {
    func.genRecords(prefix..quality[1], 'inline', 3),
    func.genRecords(prefix..quality[2], 'inline', 3),
    func.genRecords(prefix..quality[3], 'inline', 3),
    func.genRecords(prefix..quality[4], 'inline', 3)
}

function QuickHackCriticalHit.make()
    local tableCheck = {}
    for i, item in ipairs(records) do
        if not func.existsCheck({prefix..quality[i]}) then
            func.createLogicPackage(prefix..quality[i], item[0], {}, {}, {}, 'None', false, {}, {item[1], item[2]})
                func.createUiData(item[0], {values[i]}, 'None', {}, GetLocalizedTextByKey('QhCriticalHitChance-Desc'), '', {}, {})
                func.createConstantStat(item[1], 'Additive', 'BaseStats.CanQuickHackCriticallyHit', 1.0)
                func.createConstantStat(item[2], 'Additive', 'BaseStats.QuickHackCritChance', values[i])
            table.insert(tableCheck, prefix..quality[i])
        end
    end
    if func.existsCheck(tableCheck) then return true end
    return false
end

return QuickHackCriticalHit