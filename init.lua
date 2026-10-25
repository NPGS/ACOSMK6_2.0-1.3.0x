-- ver. 1.3.0e   ARASAKA CYBERWARE OS MK.6 2.0 - Cyberpunk 2077 2.31a

local ACOSMK6 = require('./_data/_helpers.lua')
local tableToSend = require('./_data/_makeList.lua')
local modInfo = 'ACOSMK6 2.0 ver. 1.3.0e'

registerForEvent('onInit', function()
    ACOSMK6.startACOSMK6(tableToSend, modInfo)
end)
