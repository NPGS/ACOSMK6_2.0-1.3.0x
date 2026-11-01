-- ver. 1.3.0   CUSTOM QUICKHACK SPREAD CHANCE 15% - 100%

local QuickHackSpreadChance = {}
local func = require('_data/_helpers')
local prefix = 'Items.ACOS_QuickHackSpreadChance'
local quality = { '1', '2', '3', '4', '5', '6', 'Max' }

local values = {
    { 0.15, 2.0, 0.3, {15.0, 2.0, 30.0} },
    { 0.2, 3.0, 0.5, {20.0, 3.0, 50.0} },
    { 0.3, 3.0, 0.66, {30.0, 3.0, 66.0} },
    { 0.45, 5.0, 1.0, {45.0, 5.0, 100.0} },
    { 1.0, 1.0, 0.5, {1.0, 50.0} },
    { 1.0, 2.0, 1.0, {2.0, 100.0} },
    { 1.0, 3.0, 1.5, {3.0, 150.0} }
}

local records = {
    func.genRecords(prefix..quality[1], 'inline', 6),
    func.genRecords(prefix..quality[2], 'inline', 6),
    func.genRecords(prefix..quality[3], 'inline', 6),
    func.genRecords(prefix..quality[4], 'inline', 6),
    func.genRecords(prefix..quality[5], 'inline', 6),
    func.genRecords(prefix..quality[6], 'inline', 6),
    func.genRecords(prefix..quality[7], 'inline', 6)
}

function QuickHackSpreadChance.make()
    local tableCheck = {}
    local prereq = 'NewPerks.IsOverclockActivePrereq'
    local desc = 'LocKey#92321'
    for i, item in ipairs(records) do
        if not func.existsCheck({prefix..quality[i]}) then
            if values[i][1] >= 1.0 then
                prereq = 'Prereqs.AlwaysTruePrereq'
                desc = GetLocalizedTextByKey('QhSpreadMaxBonus-Desc')
            end
            func.createLogicPackage(prefix..quality[i], item[0], {}, {item[1]}, {}, 'None', false, {}, {item[5]})
                func.createUiData(item[0], values[i][4], 'None', {}, desc, '', {}, {})
                func.applyStatGroupEffectors(item[1], 'None', 'ApplyStatGroupEffector', prereq, false, false, true, item[2], {})
                    func.createStatModGrp(item[2], false, false, {}, false, {item[3], item[4]}, -1, '')
                        func.createConstantStat(item[3], 'Additive', 'BaseStats.OverclockSpreadChance', values[i][1])
                        func.createConstantStat(item[4], 'Additive', 'BaseStats.QuickHackOverclockSpreadNumber', values[i][2])
                        func.createConstantStat(item[5], 'AdditiveMultiplier', 'BaseStats.QuickHackSpreadDistance', values[i][3])
            table.insert(tableCheck, prefix..quality[i])
        end
    end
    if func.existsCheck(tableCheck) then return true end
    return false
end

return QuickHackSpreadChance