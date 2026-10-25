-- ver. 1.3.0   CUSTOM QUICKHACK TAKEDOWN RAM RESTORE 1.28 - 2.56 UNITS

local QuickHackRamRestore = {}
local func = require('./_data/_helpers.lua')
local prefix = "Items.ACOS_QuickHackRamRestore"
local quality = { "1", "2", "3", "Max" }

local values = { 1.28, 1.48, 1.67, 2.56 }

local records = {
    func.genRecords(prefix..quality[1], 'inline', 3),
    func.genRecords(prefix..quality[2], 'inline', 3),
    func.genRecords(prefix..quality[3], 'inline', 3),
    func.genRecords(prefix..quality[4], 'inline', 3)
}

function QuickHackRamRestore.make()
    local tableCheck = {}
    for i, item in ipairs(records) do
        if not func.existsCheck({prefix..quality[i]}) then
            func.createLogicPackage(prefix..quality[i], item[0], {}, {item[1], 'Items.MemoryBoostSFXEffector'}, {}, 'None', false, {}, {})
                func.createUiData(item[0], {values[i]}, 'ability_silenced', {}, 'LocKey#87382', '', {}, {})
                func.createModStatPoolEffect(item[1], 'None', 'ModifyStatPoolValueEffector', 'Prereqs.AnyTakedownOrKill', false, false, false, {}, {item[2]}, false)
                    func.createStatPoolUpdate(item[2], {}, 'BaseStatPools.Memory', values[i])
            table.insert(tableCheck, prefix..quality[i])
        end
    end
    if func.existsCheck(tableCheck) then return true end
    return false
end

return QuickHackRamRestore