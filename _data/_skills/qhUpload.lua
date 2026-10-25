-- ver. 1.3.0   CUSTOM QUICKHACK UPLOAD SPEED 15 - 45% FASTER

local QuickHackUploadSpeedCustom = {}
local func = require('./_data/_helpers.lua')
local prefix = "Items.ACOS_QuickHackUploadSpeed"
local quality = { "1", "2", "3", "Max" }

local values = {
    { 15, 0.15 },
    { 20, 0.20 },
    { 30, 0.30 },
    { 45, 0.45 }
}

local records = {
    func.genRecords(prefix..quality[1], 'inline', 2),
    func.genRecords(prefix..quality[2], 'inline', 2),
    func.genRecords(prefix..quality[3], 'inline', 2),
    func.genRecords(prefix..quality[4], 'inline', 2)
}

function QuickHackUploadSpeedCustom.make()
    local tableCheck = {}
    for i, item in ipairs(records) do
        if not func.existsCheck({prefix..quality[i]}) then
            func.createLogicPackage(prefix..quality[i], item[0], {}, {}, {}, 'None', false, {}, {item[1]})
                func.createUiData(item[0], {}, 'None', {values[i][1]}, 'LocKey#51361', '', {}, {})
                func.createConstantStat(item[1], 'Additive', 'BaseStats.QuickHackUploadTimeDecrease', values[i][2])
            table.insert(tableCheck, prefix..quality[i])
        end
    end
    if func.existsCheck(tableCheck) then return true end
    return false
end

return QuickHackUploadSpeedCustom