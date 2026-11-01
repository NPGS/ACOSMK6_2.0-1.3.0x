-- ver. 1.3.0   CUSTOM CYBERDECK OVERCLOCK BUFF 22 - 50%

local CyberdeckOverclockBuff = {}
local func = require('_data/_helpers')
local prefix = "Items.ACOS_CyberdeckOverclockBuff"
local quality = { "1", "2", "3", "Max" }

local values = {
    { 22.0, 1.22, 0.78 },
    { 28.0, 1.28, 0.72 },
    { 33.0, 1.33, 0.67 },
    { 50.0, 1.50, 0.50 }
}

local records = {
    func.genRecords(prefix..quality[1], 'inline', 3),
    func.genRecords(prefix..quality[2], 'inline', 3),
    func.genRecords(prefix..quality[3], 'inline', 3),
    func.genRecords(prefix..quality[4], 'inline', 3)
}

function CyberdeckOverclockBuff.make()
    local tableCheck = {}
    for i, item in ipairs(records) do
        if not func.existsCheck({prefix..quality[i]}) then
            func.createLogicPackage(prefix..quality[i], item[0], {}, {}, {}, 'None', false, {}, {item[1], item[2]})
                func.createUiData(item[0], {values[i][1]}, 'None', {}, GetLocalizedTextByKey('CdOverclockBuff-Desc'), '', {}, {})
                func.createConstantStat(item[1], 'Multiplier', 'BaseStats.CyberdeckOverclockDuration', values[i][2])
                func.createConstantStat(item[2], 'Multiplier', 'BaseStats.CyberdeckOverclockCooldown', values[i][3])
            table.insert(tableCheck, prefix..quality[i])
        end
    end
    if func.existsCheck(tableCheck) then return true end
    return false
end

return CyberdeckOverclockBuff