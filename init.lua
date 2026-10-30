-- ver. 1.3.0e   ARASAKA CYBERWARE OS MK.6 2.0 - Cyberpunk 2077 2.5

local ACOSMK6 = require('_data/_helpers')
local DATA = require('_data/_makeList')
local bTL = require('./_data/_skills/berserkTimeLimiter.lua')
local modInfo = 'ACOSMK6 2.0 ver. 1.3.0e'

registerForEvent('onInit', function() ACOSMK6.startACOSMK6(DATA, modInfo) end)

registerForEvent('onUpdate', function(dt) bTL.onUpdate(dt) end)