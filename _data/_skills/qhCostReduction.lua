-- ver. 1.3.0   CUSTOM QUICKHACK COST REDUCTION     1 / 4 UNITS

local QuickHackCostReductionCustom = {}
local func = require('_data/_helpers')
local prefix = "Items.ACOS_QuickHackCostReduction"
local quality = { "1", "2", "3", "Max" }

local values = { 1.0, 2.0, 3.0, 4.0 }

local records = {
    func.genRecords(prefix..quality[1], 'inline', 2),
    func.genRecords(prefix..quality[2], 'inline', 2),
    func.genRecords(prefix..quality[3], 'inline', 2),
    func.genRecords(prefix..quality[4], 'inline', 2)
}

function QuickHackCostReductionCustom.make()
    local tableCheck = {}
    for i, item in ipairs(records) do
        if not func.existsCheck({prefix..quality[i]}) then
            func.createLogicPackage(prefix..quality[i], item[0], {}, {}, {}, 'None', false, {}, {item[1]})
                func.createUiData(item[0], {}, 'None', {values[i]}, GetLocalizedTextByKey('QhCostReductionBonus-Desc'), '', {}, {})
                func.createConstantStat(item[1], 'Additive', 'BaseStats.MemoryCostReduction', values[i])
            table.insert(tableCheck, prefix..quality[i])
        end
    end
    if func.existsCheck(tableCheck) then return true end
    return false
end

return QuickHackCostReductionCustom