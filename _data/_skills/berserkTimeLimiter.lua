-- ver. 1.3.0   ARASAKA BERSERK MK.6 TIMER EXTENSION LIMIT  - MAX 60 sec

local B = {}
local PREFIX = 'CyberwareAction.ACOS_UseBerserk'
local QUALITIES = { 'Base', 'Plus', 'PlusPlus', 'Ultimate' }
local WARNING_KEY = 'ACOS-Berserk-Limit-Desc'
local LIMIT = 60.0
local FLAT = 'statPoolValue'
local recs, orig = {}, {}
local elapsed, acc, warnTimer, zeroed, ready = 0, 0, 0, false, nil

local function start()
    for _, q in ipairs(QUALITIES) do
        for _, n in ipairs({ 19, 21 }) do           -- 19 = hit, 21 = kill
            local rec = PREFIX..q..'_stat_'..n
            local v = TweakDB:GetFlat(rec..'.'..FLAT)
            if type(v) ~= 'number' then return false end
            recs[#recs + 1] = rec
            orig[rec] = v
        end
    end
    return true
end

local function setAll(zero)
    for _, rec in ipairs(recs) do
        TweakDB:SetFlat(rec..'.'..FLAT, zero and 0.0 or orig[rec])
        TweakDB:Update(rec)
    end
    zeroed = zero
end

local function sendWarning(show)
    local msg = SimpleScreenMessage.new()
    msg.isShown = show
    if show then
        local text = GetLocalizedTextByKey(WARNING_KEY)
        if not text or text == '' or text == WARNING_KEY then
            text = 'WARNING: Extended duration deactivated!'
        end
        msg.message = text
        msg.duration = 3.0
    end
    local defs = Game.GetAllBlackboardDefs()
    local bb = Game.GetBlackboardSystem():Get(defs.UI_Notifications)
    bb:SetVariant(defs.UI_Notifications.WarningMessage, ToVariant(msg), true)
end

function B.onUpdate(dt)
    acc = acc + dt
    if acc < 0.25 then return end
    local step = acc; acc = 0
    local p = Game.GetPlayer()
    if not p then return end
    if warnTimer > 0 then
        warnTimer = warnTimer - step
        if warnTimer <= 0 then pcall(sendWarning, false) end
    end
    if ready == nil then ready = start() end
    if not ready then return end

    local active = Game.GetStatusEffectSystem():HasStatusEffectWithTag(p:GetEntityID(), 'ArasakaBerserkBuff')
    if active then
        elapsed = elapsed + step
        if elapsed >= LIMIT and not zeroed then
            setAll(true)
            pcall(sendWarning, true)
            warnTimer = 3.0
        end
    else
        if zeroed then setAll(false) end
        elapsed = 0
    end
end

return B