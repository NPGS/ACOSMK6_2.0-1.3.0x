-- ver. 1.3.0   LIST OF EFFECTS / VALUES

local cfg = {}
local func = require('_data/_helpers')

---------------------------------- ICONS NAME / PATH ----------------------------------
cfg.iconPath = 'mod\\gameplay\\gui\\common\\icons\\arasaka_cyberware_icons.inkatlas'
cfg.berserkIcon = 'arasaka_berserk_icon_01'
cfg.breakPointIcon = 'arasaka_berserk_ultradeck_icon_01'
cfg.phantomIcon = 'arasaka_cyberdeck_icon_01'
cfg.pulseIcon = 'fuyutsuki_sandevistan_icon_01'
cfg.redLineIcon = 'kangtao_sandevistan_ultradeck_icon_01'
cfg.spectreChronoLatticeIcon = 'spectre_chrono_lattice_icon_01'
cfg.spectreLimitRemoverIcon = 'spectre_limit_remover_icon_01'
cfg.spectreProtoIcon = 'spectre_proto_icon_01'
cfg.spectreProtoFinalIcon = 'spectre_proto_final_icon_01'
cfg.spectreRetailIcon = 'spectre_retail_icon_01'
cfg.spectreUpgradeKitIcon = 'spectre_upgrade_kit_icon_01'
cfg.viperIcon = 'militech_cyberdeck_icon_01'
cfg.zeroPointIcon = 'arasaka_sandevistan_ultradeck_icon_01'

---------------------------------- CYBERDECK ABILITIES ----------------------------------
-- CYBERDECK RAM RECOVERY
cfg.cbRamRecovery1 = 'Items.ACOS_CyberdeckRamRecoveryAbility1'
cfg.cbRamRecovery2 = 'Items.ACOS_CyberdeckRamRecoveryAbility2'
cfg.cbRamRecovery3 = 'Items.ACOS_CyberdeckRamRecoveryAbility3'
cfg.cbRamRecoveryMax = 'Items.ACOS_CyberdeckRamRecoveryAbilityMax'

-- QUICKHACK UPLOAD SPEED
cfg.qhUploadSpeed1 = 'Items.ACOS_QuickHackUploadSpeed1'
cfg.qhUploadSpeed2 = 'Items.ACOS_QuickHackUploadSpeed2'
cfg.qhUploadSpeed3 = 'Items.ACOS_QuickHackUploadSpeed3'
cfg.qhUploadSpeedMax = 'Items.ACOS_QuickHackUploadSpeedMax'

-- QUICKHACK COST REDUCTION
cfg.qhCostReduction1 = 'Items.ACOS_QuickHackCostReduction1'
cfg.qhCostReduction2 = 'Items.ACOS_QuickHackCostReduction2'
cfg.qhCostReduction3 = 'Items.ACOS_QuickHackCostReduction3'
cfg.qhCostReductionMax = 'Items.ACOS_QuickHackCostReductionMax'

-- QUICKHACK CRITICAL HIT CHANCE
cfg.qhCritHitChance1 = 'Items.ACOS_QuickHackCriticalHit1'
cfg.qhCritHitChance2 = 'Items.ACOS_QuickHackCriticalHit2'
cfg.qhCritHitChance3 = 'Items.ACOS_QuickHackCriticalHit3'
cfg.qhCritHitChanceMax = 'Items.ACOS_QuickHackCriticalHitMax'

-- QUICKHACK SPREAD CHANCE
cfg.qhSpreadChance1 = 'Items.ACOS_QuickHackSpreadChance1'
cfg.qhSpreadChance2 = 'Items.ACOS_QuickHackSpreadChance2'
cfg.qhSpreadChance3 = 'Items.ACOS_QuickHackSpreadChance3'
cfg.qhSpreadChance4 = 'Items.ACOS_QuickHackSpreadChance4'
cfg.qhSpreadChance5 = 'Items.ACOS_QuickHackSpreadChance5'
cfg.qhSpreadChance6 = 'Items.ACOS_QuickHackSpreadChance6'
cfg.qhSpreadChanceMax = 'Items.ACOS_QuickHackSpreadChanceMax'

-- QUICKHACK RAM RESTORE
cfg.qhRamRestore1 = 'Items.ACOS_QuickHackRamRestore1'
cfg.qhRamRestore2 = 'Items.ACOS_QuickHackRamRestore2'
cfg.qhRamRestore3 = 'Items.ACOS_QuickHackRamRestore3'
cfg.qhRamRestoreMax = 'Items.ACOS_QuickHackRamRestoreMax'

-- QUICKHACK DAMAGE
cfg.qhDamage1 = 'Items.ACOS_QuickHackDamageIncrease1'
cfg.qhDamage2 = 'Items.ACOS_QuickHackDamageIncrease2'
cfg.qhDamage3 = 'Items.ACOS_QuickHackDamageIncrease3'
cfg.qhDamageMax = 'Items.ACOS_QuickHackDamageIncreaseMax'

-- QUICKHACK DOT DAMAGE
cfg.qhDotDamage1 = 'Items.ACOS_QuickHackDotDamageIncrease1'
cfg.qhDotDamage2 = 'Items.ACOS_QuickHackDotDamageIncrease2'
cfg.qhDotDamage3 = 'Items.ACOS_QuickHackDotDamageIncrease3'
cfg.qhDotDamageMax = 'Items.ACOS_QuickHackDotDamageIncreaseMax'

---------------------------------- OBJ ACTIONS ----------------------------------
-- BERSERK MK6 OBJ ACTIONS
cfg.zerkActionBase = { 'CyberwareAction.DisableAdvancedBerserk', 'CyberwareAction.ACOS_UseBerserkBase' }
cfg.zerkActionPlus = { 'CyberwareAction.DisableAdvancedBerserk', 'CyberwareAction.ACOS_UseBerserkPlus' }
cfg.zerkActionPlusPlus = { 'CyberwareAction.DisableAdvancedBerserk', 'CyberwareAction.ACOS_UseBerserkPlusPlus' }
cfg.zerkActionUltimate = { 'CyberwareAction.DisableAdvancedBerserk', 'CyberwareAction.ACOS_UseBerserkUltimate' }

-- CYBERDECK OBJ ACTIONS
cfg.deckActions = {
    'DeviceAction.DataExtractionClassHack',
    'DeviceAction.MalfunctionClassHack',
    'DeviceAction.ToggleStateClassHack',
    'DeviceAction.TurretToggleStateClassHack',
    'DeviceAction.TakeControlCameraClassHack',
    'DeviceAction.VehicleForceBrakesClassHack',
    'DeviceAction.OverloadClassHack',
    'DeviceAction.TakeControlClassHack',
    'DeviceAction.TurretOverloadClassHack',
    'DeviceAction.OverrideAttitudeClassHack',
    'DeviceAction.HighPitchNoiseQuickHack',
    'DeviceAction.TurretToggleStateClassLvl2Hack',
    'DeviceAction.VehicleAccelerateClassHack',
    'DeviceAction.TakeControlVehicleClassHack',
    'DeviceAction.SetDeviceTagKillMode',
    'DeviceAction.OverrideAttitudeClassLvl3Hack',
    'DeviceAction.TurretToggleStateClassLvl3Hack',
    'DeviceAction.VehicleExplodeClassHack',
    'DeviceAction.OverloadClassLvl4Hack',
    'DeviceAction.TurretOverrideAttitudeClassHack',
    'DeviceAction.OverrideAttitudeClassLvl4Hack',
    'DeviceAction.TurretToggleStateClassLvl4Hack',
    'DeviceAction.ServerOverloadClassHack',
    'DeviceAction.TurretOverrideAttitudeClassLvl5Hack',
    'DeviceAction.OverrideAttitudeClassLvl5Hack',
    'DeviceAction.TurretToggleStateClassLvl5Hack'
}

-- SANDEVISTAN OBJ ACTIONS
cfg.sandyActions = {
    'CyberwareAction.DisableSandevistan',
    'CyberwareAction.DisableCorruptedSandevistan',
    'CyberwareAction.UseCooldownedSandevistan',
    'CyberwareAction.UseCooldownedCorruptedSandevistan'
}

-- ULTRADECKS
    -- BERSERK ULTRADECK OBJ ACTIONS
    cfg.zerkUltraDeckActionBase = func.mergeTables({
            'CyberwareAction.DisableAdvancedBerserk',
            'CyberwareAction.ACOS_UseUltraDeckBerserkBase'
        }, cfg.deckActions
    )

    cfg.zerkUltraDeckActionPlus = func.mergeTables({
            'CyberwareAction.DisableAdvancedBerserk',
            'CyberwareAction.ACOS_UseUltraDeckBerserkPlus'
        }, cfg.deckActions
    )

    cfg.zerkUltraDeckActionPlusPlus = func.mergeTables({
            'CyberwareAction.DisableAdvancedBerserk',
            'CyberwareAction.ACOS_UseUltraDeckBerserkPlusPlus'
        }, cfg.deckActions
    )

    cfg.zerkUltraDeckActionUltimate = func.mergeTables({
            'CyberwareAction.DisableAdvancedBerserk',
            'CyberwareAction.ACOS_UseUltraDeckBerserkUltimate'
        }, cfg.deckActions
    )

    -- SANDEVISTAN ULTRADECK OBJ ACTIONS
    cfg.sandyUltraDeckActions = func.mergeTables({
            'CyberwareAction.DisableSandevistan',
            'CyberwareAction.DisableCorruptedSandevistan',
            'CyberwareAction.ACOS_UseUltraDeckSandevistan',
            'CyberwareAction.UseCorruptedSandevistan'
        }, cfg.deckActions
    )

---------------------------------- PRICES ----------------------------------
-- BUY PRICE
cfg.globalBuyPrice = {
    'Price.BaseCyberwarePrice',
    'Price.ItemQualityMultiplier',
    'Price.PlusTierMultiplier',
    'Price.CyberwareMultiplier',
    'Price.BuyPrice_StreetCred_Discount'
}
    -- TABLES
    cfg.zerkBuyPrice = func.mergeTables({'Items.AdvancedBerserkC4MK4_inline4'}, cfg.globalBuyPrice)             -- BERSERK
    cfg.cdBuyPrice = func.mergeTables({'Items.BaseDeck_inline6'}, cfg.globalBuyPrice)                           -- CYBERDECK / ULTRADECK
    cfg.sandyBuyPrice = func.mergeTables({'Items.AdvancedSandevistanApogee_inline16'}, cfg.globalBuyPrice)      -- SANDEVISTAN

-- SELL PRICE
cfg.globalSellPrice = {
    'Price.BaseCyberwarePrice',
    'Price.ItemQualityMultiplier',
    'Price.PlusTierMultiplier',
    'Price.CyberwareMultiplier',
    'Price.CyberwareSellMultiplier'
}

    -- TABLES
    cfg.zerkSellPrice = func.mergeTables({'Items.AdvancedBerserkC4MK4_inline5'}, cfg.globalSellPrice)           -- BERSERK
    cfg.cdSellPrice = func.mergeTables({'Items.BaseDeck_inline7'}, cfg.globalSellPrice)                         -- CYBERDECK / ULTRADECK
    cfg.sandySellPrice = func.mergeTables({'Items.AdvancedSandevistanApogee_inline30'}, cfg.globalSellPrice)    -- SANDEVISTAN

---------------------------------- TAGS ----------------------------------
cfg.recipeTags = { 'Recipe', 'SkipActivityLogOnRemove', 'HideInBackpackUI', 'IconicRecipe' }        -- RECIPE
cfg.globalCwTags = { 'Cyberware', 'HideInBackpackUI', 'Iconic_OS_CW' }
    cfg.berserkTags = func.mergeTables({'Berserk'}, cfg.globalCwTags)                               -- BERSERK
    cfg.cyberDeckTags = func.mergeTables({'Cyberdeck'}, cfg.globalCwTags)                           -- CYBERDECK
    cfg.sandyTags = func.mergeTables({'Sandevistan'}, cfg.globalCwTags)                             -- SANDEVISTAN
    cfg.sandyDeckTags = func.mergeTables({'Sandevistan', 'Cyberdeck'}, cfg.globalCwTags)            -- ULTRADECK
    cfg.zerkDeckTags = func.mergeTables({'Berserk', 'Cyberdeck'}, cfg.globalCwTags)                 -- ULTRADECK

return cfg