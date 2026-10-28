-- ver. 1.3.0   ARASAKA BERSERK MK.6 TIMER EXTENSION LIMIT  - MAX 60 sec

local B = {}
local PREFIX = 'CyberwareAction.ACOS_UseBerserk'
local QUALITIES = { 'Base', 'Plus', 'PlusPlus', 'Ultimate' }
local LIMIT = 60.0
local FLAT = 'statPoolValue'

local recs, orig = {}, {}
local elapsed, acc, zeroed, ready = 0, 0, false, nil

local function start()
    for _, q in ipairs(QUALITIES) do
        for _, n in ipairs({ 19, 21 }) do           -- 19 = hit, 21 = kill
            local rec = PREFIX .. q .. '_stat_' .. n
            local v = TweakDB:GetFlat(rec .. '.' .. FLAT)
            if type(v) ~= 'number' then
            --  print('[Berserk] ERROR: FLAT ' .. rec .. '.' .. not found)
                return false
            end
            recs[#recs + 1] = rec
            orig[rec] = v
        end
    end
--  print('[Berserk] activated, readed records: ' .. #recs)
    return true
end

local function setAll(zero)
    for _, rec in ipairs(recs) do
        TweakDB:SetFlat(rec .. '.' .. FLAT, zero and 0.0 or orig[rec])
        TweakDB:Update(rec)
    end
    zeroed = zero
end

function B.onUpdate(dt)
    acc = acc + dt
    if acc < 0.25 then return end
    local step = acc; acc = 0
    local p = Game.GetPlayer()
    if not p then return end
    if ready == nil then ready = start() end
    if not ready then return end

    local active = Game.GetStatusEffectSystem():HasStatusEffectWithTag(p:GetEntityID(), 'ArasakaBerserkBuff')
    if active then
        elapsed = elapsed + step
        if elapsed >= LIMIT and not zeroed then
            setAll(true)
            print('[Berserk] limite raggiunto, ripristini azzerati')
        end
    else
        if zeroed then setAll(false); print('[Berserk] effect ended, stock values restored') end
        elapsed = 0
    end
end

return B