-- ver. 1.3.0   helper utilities

local ACOSMK6 = {}

function ACOSMK6.startACOSMK6(table, info)
    local cnt = 0
    for i, func in ipairs(table) do
        if func.make() then
            cnt = cnt + 1
        end
    end
    if cnt == #table then
        print(info..' started!')
    else
        print(info.." starting failed...")
    end
end

function ACOSMK6.genRecords(prefix, group, count)
    local records = {}
    for i = 0, count do
        records[i] = prefix..'_'..group..'_'..i
    end
    return records
end

function ACOSMK6.mergeTables(tab1, tab2)
    local temp = {}
    for i = 1, #tab2 do
        table.insert(temp, tab2[i])
    end
    for i = 1, #tab1 do
        table.insert(temp, tab1[i])
    end
    return temp
end

function ACOSMK6.genTags(table)
    for i, item in ipairs(table) do
        CName.add(item)
        CName.new(item)
    end
end

function ACOSMK6.tableContains(table, keyword)
    for _, value in ipairs(table) do
        if value == keyword then return true end
    end
    return false
end

function ACOSMK6.createMainRecord(itemRecord, craftData, onAttach, onEquip, onLooted, blueprint, buyPrice, cwType, iName, equipArea, fName, icon, iDesc, nextItem, objActions, placeSlots, quality, sellPrice, statsMod, tags, upgrade, useVar, variants)
    if TweakDB:GetRecord(itemRecord) == nil then
        TweakDB:CreateRecord(itemRecord, 'gamedataItem_Record')
        TweakDB:SetFlat(itemRecord..".CraftingData", craftData)
        TweakDB:SetFlat(itemRecord..".OnAttach", onAttach)
        TweakDB:SetFlat(itemRecord..".OnEquip", onEquip)
        TweakDB:SetFlat(itemRecord..".OnLooted", onLooted)
        TweakDB:SetFlat(itemRecord..".animFeatureName", 'ItemData')
        TweakDB:SetFlat(itemRecord..".animName", 'ui_garment_pose')
        TweakDB:SetFlat(itemRecord..".blueprint", blueprint)
        TweakDB:SetFlat(itemRecord..".buyPrice", buyPrice)
        TweakDB:SetFlat(itemRecord..".crosshair", "Crosshairs.None")
        TweakDB:SetFlat(itemRecord..".cyberwareType", CName(cwType))
        TweakDB:SetFlat(itemRecord..".displayName", LocKey(iName))
        TweakDB:SetFlat(itemRecord..".dropObject", 'None')
        TweakDB:SetFlat(itemRecord..".entityName", 'cyberware_dummy')
        TweakDB:SetFlat(itemRecord..".equipArea", equipArea)
        TweakDB:SetFlat(itemRecord..".friendlyName", fName)
        TweakDB:SetFlat(itemRecord..".gameplayRestrictions", {"GameplayRestriction.VehicleCombatNoInterruptions"})
        TweakDB:SetFlat(itemRecord..".iconPath", icon)
        TweakDB:SetFlat(itemRecord..".isCoreCW", true)
        TweakDB:SetFlat(itemRecord..".itemCategory", 'ItemCategory.Cyberware')
        TweakDB:SetFlat(itemRecord..".itemType", 'ItemType.Cyberware')
        TweakDB:SetFlat(itemRecord..".localizedDescription", LocKey(iDesc))
        TweakDB:SetFlat(itemRecord..".mass", 1.0)
        TweakDB:SetFlat(itemRecord..".minigameInstance", 'minigame_v2.DefaultItemMinigame')
        TweakDB:SetFlat(itemRecord..".nextUpgradeItem", nextItem)
        TweakDB:SetFlat(itemRecord..".objectActions", objActions)
        TweakDB:SetFlat(itemRecord..".placementSlots", placeSlots)
        TweakDB:SetFlat(itemRecord..".quality", quality)
        TweakDB:SetFlat(itemRecord..".slotPartList", {'Items.GenericRootSlotItem'})
        TweakDB:SetFlat(itemRecord..".sellPrice", sellPrice)
        TweakDB:SetFlat(itemRecord..".statModifiers", statsMod)
        TweakDB:SetFlat(itemRecord..".tags", tags)
        TweakDB:SetFlat(itemRecord..".upgradeCostMult", upgrade)
        TweakDB:SetFlat(itemRecord..".usesVariants", useVar)
        TweakDB:SetFlat(itemRecord..".variants", variants)
    end
    return itemRecord
end

function ACOSMK6.arrayInsert(arr, rec)
	bakArray = TweakDB:GetFlat(arr)
	table.insert(bakArray, rec)
	TweakDB:SetFlat(arr, bakArray)
end

function ACOSMK6.cloneConstantStat(statRecord, record, value)
    if TweakDB:GetRecord(statRecord) == nil then
        TweakDB:CloneRecord(statRecord, record)
        TweakDB:SetFlat(statRecord..".value", value)
    end
    return statRecord
end

function ACOSMK6.createConstantStat(statRecord, modifierType, statType, value)
    if TweakDB:GetRecord(statRecord) == nil then
        TweakDB:CreateRecord(statRecord, "gamedataConstantStatModifier_Record")
        TweakDB:SetFlat(statRecord..".modifierType", modifierType)
        TweakDB:SetFlat(statRecord..".statType", statType)
        TweakDB:SetFlat(statRecord..".value", value)
    end
    return statRecord
end

function ACOSMK6.createCombinedStat(statRecord, modifierType, opSymbol, refObject, refStat, statType, value)
    if TweakDB:GetRecord(statRecord) == nil then
        TweakDB:CreateRecord(statRecord, "gamedataCombinedStatModifier_Record")
        TweakDB:SetFlat(statRecord..".modifierType", modifierType)
        TweakDB:SetFlat(statRecord..".opSymbol", opSymbol)
        TweakDB:SetFlat(statRecord..".refObject", refObject)
        TweakDB:SetFlat(statRecord..".refStat", refStat)
        TweakDB:SetFlat(statRecord..".statType", statType)
        TweakDB:SetFlat(statRecord..".value", value)
    end
    return statRecord
end

function ACOSMK6.createItemForVendors(itemRecord, genPrereqs)
    local vendorItem = 'Vendors.'..itemRecord
    local vendorList = require('./_data/_ripperDocList.lua')
    if TweakDB:GetRecord(vendorItem) == nil then
        TweakDB:CreateRecord(vendorItem, "gamedataVendorItem_Record")
        TweakDB:SetFlat(vendorItem..".generationPrereqs", genPrereqs)
        TweakDB:SetFlat(vendorItem..".item", itemRecord)
        TweakDB:SetFlat(vendorItem..".quantity", {'Vendors.Always_Present'})
        for i, vendor in ipairs(vendorList) do
            ACOSMK6.arrayInsert(vendor..'.itemStock', vendorItem)
        end
    end
    return vendorItem
end

function ACOSMK6.createIcon(itemRecord, iconName, path)
    local iconRecord = "UIIcon."..itemRecord.."_icon"
    if TweakDB:GetRecord(iconRecord) == nil then
        TweakDB:CreateRecord(iconRecord, "gamedataUIIcon_Record")
        TweakDB:SetFlat(iconRecord..".atlasPartName", CName(iconName))
        TweakDB:SetFlat(iconRecord..".atlasResourcePath", CName(path))
        TweakDB:SetFlat(itemRecord..".icon", iconRecord)
        TweakDB:SetFlat(itemRecord..".iconPath", itemRecord.."_icon")
    end
    return iconRecord
end

function ACOSMK6.createUiData(record, floats, iconPath, integers, desc, locName, nameValues, stats)
    if TweakDB:GetRecord(record) == nil then
        TweakDB:CreateRecord(record, "gamedataGameplayLogicPackageUIData_Record")
        TweakDB:SetFlat(record..".floatValues", floats)
        TweakDB:SetFlat(record..".iconPath", CName(iconPath))
        TweakDB:SetFlat(record..".intValues", integers)
        TweakDB:SetFlat(record..".localizedDescription", desc)
        TweakDB:SetFlat(record..".localizedName", locName)
        TweakDB:SetFlat(record..".nameValues", nameValues)
        TweakDB:SetFlat(record..".stats", stats)
    end
    return recordName
end

function ACOSMK6.createLogicPackage(record, uiData, aWO, effectors, items, prereq, stackable, statPools, stats)
    if TweakDB:GetRecord(record) == nil then
        TweakDB:CreateRecord(record, "gamedataGameplayLogicPackage_Record")
        TweakDB:SetFlat(record..".UIData", uiData)
        TweakDB:SetFlat(record..".animationWrapperOverrides", aWO)
        TweakDB:SetFlat(record..".effectors", effectors)
        TweakDB:SetFlat(record..".items", items)
        TweakDB:SetFlat(record..".prereq", prereq)
        TweakDB:SetFlat(record..".stackable", stackable)
        TweakDB:SetFlat(record..".statPools", statPools)
        TweakDB:SetFlat(record..".stats", stats)
    end
    return record
end

function ACOSMK6.applyStatGroupEffectors(record, apTarget, effectName, prereq, delAction, delCheck, delEffect, statGroup, statGroups)
    if TweakDB:GetRecord(record) == nil then
        TweakDB:CreateRecord(record, "gamedataApplyStatGroupEffector_Record")
        TweakDB:SetFlat(record..".applicationTarget", apTarget)
        TweakDB:SetFlat(record..".effectorClassName", effectName)
        TweakDB:SetFlat(record..".prereqRecord", prereq)
        TweakDB:SetFlat(record..".removeAfterActionCall", delAction)
        TweakDB:SetFlat(record..".removeAfterPrereqCheck", delCheck)
        TweakDB:SetFlat(record..".removeWithEffector", delEffect)
        TweakDB:SetFlat(record..".statGroup", statGroup)
        TweakDB:SetFlat(record..".statModifierGroups", statGroups)
    end
    return record
end

function ACOSMK6.applyStatGroupEffectorsForZerk(record, apTarget, effectName, prereq, delAction, delCheck, delEffect, statGroup, statGroups, reapply)
    if TweakDB:GetRecord(record) == nil then
        TweakDB:CreateRecord(record, "gamedataApplyStatGroupEffector_Record")
        TweakDB:SetFlat(record..".applicationTarget", apTarget)
        TweakDB:SetFlat(record..".effectorClassName", effectName)
        TweakDB:SetFlat(record..".prereqRecord", prereq)
        TweakDB:SetFlat(record..".removeAfterActionCall", delAction)
        TweakDB:SetFlat(record..".removeAfterPrereqCheck", delCheck)
        TweakDB:SetFlat(record..".removeWithEffector", delEffect)
        TweakDB:SetFlat(record..".statGroup", statGroup)
        TweakDB:SetFlat(record..".statModifierGroups", statGroups)
        TweakDB:SetFlat(record..'.reapplyOnWeaponChange', reapply)
    end
    return record
end

function ACOSMK6.createIPrereq(record, prereq, isInState, previousState, stateName)
    if TweakDB:GetRecord(record) == nil then
        TweakDB:CreateRecord(record, "gamedataIPrereq_Record")
        TweakDB:SetFlat(record..".prereqClassName", prereq)
        TweakDB:SetFlat(record..".isInState", isInState)
        TweakDB:SetFlat(record..".previousState", previousState)
        TweakDB:SetFlat(record..".stateName", stateName)
    end
    return record
end

function ACOSMK6.createMultiPrereq(record, agrType, nstPrqs, clsName)
    if TweakDB:GetRecord(record) == nil then
        TweakDB:CreateRecord(record, "gamedataMultiPrereq_Record")
        TweakDB:SetFlat(record..".aggregationType", agrType)
        TweakDB:SetFlat(record..".nestedPrereqs", nstPrqs)
        TweakDB:SetFlat(record..".prereqClassName", clsName)
    end
    return record
end

function ACOSMK6.createStatModGrp(record, drawStatType, combMod, modGrp, saveStatType, statMods, statModLimit, statModLimitMod)
    if TweakDB:GetRecord(record) == nil then
        TweakDB:CreateRecord(record, "gamedataStatModifierGroup_Record")
        TweakDB:SetFlat(record..".drawBasedOnStatType", drawStatType)
        TweakDB:SetFlat(record..".optimiseCombinedModifiers", combMod)
        TweakDB:SetFlat(record..".relatedModifierGroups", modGrp)
        TweakDB:SetFlat(record..".saveBasedOnStatType", saveStatType)
        TweakDB:SetFlat(record..".statModifiers", statMods)
        TweakDB:SetFlat(record..".statModsLimit", statModLimit)
        TweakDB:SetFlat(record..".statModsLimitModifier", statModLimitMod)
    end
    return record
end

function ACOSMK6.createEffectorEffector(record, applyTarget, effectName, effectApply, prereq, delAction, delCheck, statModGrp)
    if TweakDB:GetRecord(record) == nil then
        TweakDB:CreateRecord(record, "gamedataApplyEffectorEffector_Record")
        TweakDB:SetFlat(record..".applicationTarget", applyTarget)
        TweakDB:SetFlat(record..".effectorClassName", effectName)
        TweakDB:SetFlat(record..".effectorToApply", effectApply)
        TweakDB:SetFlat(record..".prereqRecord", prereq)
        TweakDB:SetFlat(record..".removeAfterActionCall", delAction)
        TweakDB:SetFlat(record..".removeAfterPrereqCheck", delCheck)
        TweakDB:SetFlat(record..".statModifierGroups", statModGrp)
    end
    return record
end

function ACOSMK6.createModStatPoolEffect(record, target, effectName, prereq, delAction, delCheck, setValue, statModGrp, statPool, percent)
    if TweakDB:GetRecord(record) == nil then
        TweakDB:CreateRecord(record, "gamedataModifyStatPoolValueEffector_Record")
        TweakDB:SetFlat(record..".applicationTarget", target)
        TweakDB:SetFlat(record..".effectorClassName", effectName)
        TweakDB:SetFlat(record..".prereqRecord", prereq)
        TweakDB:SetFlat(record..".removeAfterActionCall", delAction)
        TweakDB:SetFlat(record..".removeAfterPrereqCheck", delCheck)
        TweakDB:SetFlat(record..".setValue", setValue)
        TweakDB:SetFlat(record..".statModifierGroups", statModGrp)
        TweakDB:SetFlat(record..".statPoolUpdates", statPool)
        TweakDB:SetFlat(record..".usePercent", percent)
    end
    return record
end

function ACOSMK6.createHitPrereq(record, callback, conditions, ignore, sync, pipeStage, pipeType, prereqName, process)
    if TweakDB:GetRecord(record) == nil then
        TweakDB:CreateRecord(record, "gamedataHitPrereq_Record")
        TweakDB:SetFlat(record..".callbackType", callback)
        TweakDB:SetFlat(record..".conditions", conditions)
        TweakDB:SetFlat(record..".ignoreSelfInflictedPressureWave", ignore)
        TweakDB:SetFlat(record..".isSynchronous", sync)
        TweakDB:SetFlat(record..".pipelineStage", pipeStage)
        TweakDB:SetFlat(record..".pipelineType", pipeType)
        TweakDB:SetFlat(record..".prereqClassName", prereqName)
        TweakDB:SetFlat(record..".processMiss", process)
    end
    return record
end

function ACOSMK6.createHitPrereqCondition(record, invert, once, type, checkType, obj, status, tag)
    if TweakDB:GetRecord(record) == nil then
        TweakDB:CreateRecord(record, "gamedataHitPrereqCondition_Record")
        TweakDB:SetFlat(record..".invert", invert)
        TweakDB:SetFlat(record..".onlyOncePerShot", once)
        TweakDB:SetFlat(record..".type", type)
        TweakDB:SetFlat(record..".checkType", checkType)
        TweakDB:SetFlat(record..".objectToCheck", obj)
        TweakDB:SetFlat(record..".statusEffect", status)
        TweakDB:SetFlat(record..".tagToCheck", tag)
    end
    return record
end

function ACOSMK6.createHitPrereqCondition2(record, invert, once, type, instType)
    if TweakDB:GetRecord(record) == nil then
        TweakDB:CreateRecord(record, "gamedataHitPrereqCondition_Record")
        TweakDB:SetFlat(record..".invert", invert)
        TweakDB:SetFlat(record..".onlyOncePerShot", once)
        TweakDB:SetFlat(record..".type", type)
        TweakDB:SetFlat(record..".instigatorType", instType)
    end
    return record
end

function ACOSMK6.createHitPrereqCondition3(record, invert, once, type, tarType)
    if TweakDB:GetRecord(record) == nil then
        TweakDB:CreateRecord(record, "gamedataHitPrereqCondition_Record")
        TweakDB:SetFlat(record..".invert", invert)
        TweakDB:SetFlat(record..".onlyOncePerShot", once)
        TweakDB:SetFlat(record..".type", type)
        TweakDB:SetFlat(record..".targetType", tarType)
    end
    return record
end

function ACOSMK6.createStatPoolUpdate(record, statMods, statPoolType, value)
    if TweakDB:GetRecord(record) == nil then
        TweakDB:CreateRecord(record, "gamedataStatPoolUpdate_Record")
        TweakDB:SetFlat(record..".statModifiers", statMods)
        TweakDB:SetFlat(record..".statPoolType", statPoolType)
        TweakDB:SetFlat(record..".statPoolValue", value)
    end
    return record
end

function ACOSMK6.createEffector(record, name, prereq, delAction, delCheck, statModGrp, opType, statValue, value, valueType)
    if TweakDB:GetRecord(record) == nil then
        TweakDB:CreateRecord(record, "gamedataEffector_Record")
        TweakDB:SetFlat(record..".effectorClassName", name)
        TweakDB:SetFlat(record..".prereqRecord", prereq)
        TweakDB:SetFlat(record..".removeAfterActionCall", delAction)
        TweakDB:SetFlat(record..".removeAfterPrereqCheck", delCheck)
        TweakDB:SetFlat(record..".statModifierGroups", statModGrp)
        TweakDB:SetFlat(record..".operationType", opType)
        TweakDB:SetFlat(record..".statForValue", statValue)
        TweakDB:SetFlat(record..".value", value, valueType)
    end
    return record
end

function ACOSMK6.createEffectorForZerk(record, name, prereq, delAction, delCheck, statModGrp, dRStacks, invert, max, maxType, min, minType, roundUp, threshold, tType, sPool, sPoolStep, sPSType, statEffect, stepPerc, targetPool, thresholdPerc)
    if TweakDB:GetRecord(record) == nil then
        TweakDB:CreateRecord(record, "gamedataEffector_Record")
        TweakDB:SetFlat(record..".effectorClassName", name)
        TweakDB:SetFlat(record..".prereqRecord", prereq)
        TweakDB:SetFlat(record..".removeAfterActionCall", delAction)
        TweakDB:SetFlat(record..".removeAfterPrereqCheck", delCheck)
        TweakDB:SetFlat(record..".statModifierGroups", statModGrp)
        TweakDB:SetFlat(record..".dontRemoveStacks", dRStacks)
        TweakDB:SetFlat(record..".inverted", invert)
        TweakDB:SetFlat(record..".maxStacks", max, maxType)
        TweakDB:SetFlat(record..".minStacks", min, minType)
        TweakDB:SetFlat(record..".roundUpwards", roundUp)
        TweakDB:SetFlat(record..".startingThreshold", threshold, tType)
        TweakDB:SetFlat(record..".statPool", sPool)
        TweakDB:SetFlat(record..".statPoolStep", sPoolStep, sPSType)
        TweakDB:SetFlat(record..".statusEffect", statEffect)
        TweakDB:SetFlat(record..".stepUsesPercent", stepPerc)
        TweakDB:SetFlat(record..".targetOfStatPoolCheck", targetPool)
        TweakDB:SetFlat(record..".thresholdUsesPercent", thresholdPerc)
    end
    return record
end

function ACOSMK6.createEffectorForZerk2(record, name, prereq, delAction, delCheck, statModGrp, oID, change, type, tags, perc, listen)
    if TweakDB:GetRecord(record) == nil then
        TweakDB:CreateRecord(record, "gamedataEffector_Record")
        TweakDB:SetFlat(record..".effectorClassName", name)
        TweakDB:SetFlat(record..".prereqRecord", prereq)
        TweakDB:SetFlat(record..".removeAfterActionCall", delAction)
        TweakDB:SetFlat(record..".removeAfterPrereqCheck", delCheck)
        TweakDB:SetFlat(record..".statModifierGroups", statModGrp)
        TweakDB:SetFlat(record..".canGoOverInitialDuration", oID)
        TweakDB:SetFlat(record..".change", change, type)
        TweakDB:SetFlat(record..".gameplayTags", tags)
        TweakDB:SetFlat(record..".isPercentage", perc)
        TweakDB:SetFlat(record..".listenConstantly", listen)
    end
    return record
end

function ACOSMK6.createCurveStatMod(record, column, id, modifierType, refObject, refStat, statType)
    if TweakDB:GetRecord(record) == nil then
        TweakDB:CreateRecord(record, "gamedataCurveStatModifier_Record")
        TweakDB:SetFlat(record..".column", column)
        TweakDB:SetFlat(record..".id", id)
        TweakDB:SetFlat(record..".modifierType", modifierType)
        TweakDB:SetFlat(record..".refObject", refObject)
        TweakDB:SetFlat(record..".refStat", refStat)
        TweakDB:SetFlat(record..".statType", statType)
    end
    return record
end

function ACOSMK6.createObjAction(record, name, time, effects, cd, cost, hackCat, lasts, gCategory, hCategory, tier, iAPrereq, iPrereq, layer, type, ui, priority, reward, start, tAPrereq, tPrereq)
    if TweakDB:GetRecord(record) == nil then
        TweakDB:CreateRecord(record, "gamedataObjectAction_Record")
        TweakDB:SetFlat(record..".actionName", name)
        TweakDB:SetFlat(record..".activationTime", time)
        TweakDB:SetFlat(record..".completionEffects", effects)
        TweakDB:SetFlat(record..".cooldown", cd)
        TweakDB:SetFlat(record..".costs", cost)
        TweakDB:SetFlat(record..".deviceHackCategory", hackCat)
        TweakDB:SetFlat(record..".durationTime", lasts)
        TweakDB:SetFlat(record..".gameplayCategory", gCategory)
        TweakDB:SetFlat(record..".hackCategory", hCategory)
        TweakDB:SetFlat(record..".hackTier", tier)
        TweakDB:SetFlat(record..".instigatorActivePrereqs", iAPrereq)
        TweakDB:SetFlat(record..".instigatorPrereqs", iPrereq)
        TweakDB:SetFlat(record..".interactionLayer", layer)
        TweakDB:SetFlat(record..".objectActionType", type)
        TweakDB:SetFlat(record..".objectActionUI", ui)
        TweakDB:SetFlat(record..".priority", priority)
        TweakDB:SetFlat(record..".rewards", reward)
        TweakDB:SetFlat(record..".startEffects", start)
        TweakDB:SetFlat(record..".targetActivePrereqs", tAPrereq)
        TweakDB:SetFlat(record..".targetPrereqs", tPrereq)
    end
    return record
end

function ACOSMK6.createObjActionEffect(record, effector, recipient, status)
    if TweakDB:GetRecord(record) == nil then
        TweakDB:CreateRecord(record, "gamedataObjectActionEffect_Record")
        TweakDB:SetFlat(record..".effectorToTrigger", effector)
        TweakDB:SetFlat(record..".recipient", recipient)
        TweakDB:SetFlat(record..".statusEffect", status)
    end
    return record
end

function ACOSMK6.createStatusEffect(record, aiData, sfx, vfx, params, dTags, lasts, dLasts, gTags, immuStats, timeNpc, timePlr, stacks, pkg, plrData, maxStacks, delStacks, delStacksStats, delStory, repli, save, type, deactive, ui)
    if TweakDB:GetRecord(record) == nil then
        TweakDB:CreateRecord(record, "gamedataStatusEffect_Record")
        TweakDB:SetFlat(record..".AIData", aiData)
        TweakDB:SetFlat(record..".SFX", sfx)
        TweakDB:SetFlat(record..".VFX", vfx)
        TweakDB:SetFlat(record..".additionalParam", params)
        TweakDB:SetFlat(record..".debugTags", dTags)
        TweakDB:SetFlat(record..".duration", lasts)
        TweakDB:SetFlat(record..".dynamicDuration", dLasts)
        TweakDB:SetFlat(record..".gameplayTags", gTags)
        TweakDB:SetFlat(record..".immunityStats", immuStats)
        TweakDB:SetFlat(record..".isAffectedByTimeDilationNPC", timeNpc)
        TweakDB:SetFlat(record..".isAffectedByTimeDilationPlayer", timePlr)
        TweakDB:SetFlat(record..".maxStacks", stacks)
        TweakDB:SetFlat(record..".packages", pkg)
        TweakDB:SetFlat(record..".playerData", plrData)
        TweakDB:SetFlat(record..".reapplyPackagesOnMaxStacks", maxStacks)
        TweakDB:SetFlat(record..".removeAllStacksWhenDurationEnds", delStacks)
        TweakDB:SetFlat(record..".removeAllStacksWhenDurationEndsStatModifiers", delStacksStats)
        TweakDB:SetFlat(record..".removeOnStoryTier", delStory)
        TweakDB:SetFlat(record..".replicated", repli)
        TweakDB:SetFlat(record..".savable", save)
        TweakDB:SetFlat(record..".statusEffectType", type)
        TweakDB:SetFlat(record..".stopActiveSfxOnDeactivate", deactive)
        TweakDB:SetFlat(record..".uiData", ui)
    end
    return record
end

function ACOSMK6.createStatPoolPrereq(record, perc, comp, const, obj, prereq, skip, stat, value)
    if TweakDB:GetRecord(record) == nil then
        TweakDB:CreateRecord(record, "gamedataStatPoolPrereq_Record")
        TweakDB:SetFlat(record..".comparePercentage", perc)
        TweakDB:SetFlat(record..".comparisonType", comp)
        TweakDB:SetFlat(record..".listenConstantly", const)
        TweakDB:SetFlat(record..".objectToCheck", obj)
        TweakDB:SetFlat(record..".prereqClassName", prereq)
        TweakDB:SetFlat(record..".skipOnApply", skip)
        TweakDB:SetFlat(record..".statPoolType", stat)
        TweakDB:SetFlat(record..".valueToCheck", value)
    end
    return record
end

function ACOSMK6.createStatusEffectPrereq(record, type, invert, obj, prereq, status, tag)
    if TweakDB:GetRecord(record) == nil then
        TweakDB:CreateRecord(record, "gamedataStatusEffectPrereq_Record")
        TweakDB:SetFlat(record..".checkType", type)
        TweakDB:SetFlat(record..".invert", invert)
        TweakDB:SetFlat(record..".objectToCheck", obj)
        TweakDB:SetFlat(record..".prereqClassName", prereq)
        TweakDB:SetFlat(record..".statusEffect", status)
        TweakDB:SetFlat(record..".tagToCheck", tag)
    end
    return record
end

function ACOSMK6.createApplyEffectEffector(record, target, cnt, name, instigator, inverted, prereq, delAction, delCheck, delEffect, statModGrp, statusEffect, cntDel)
    if TweakDB:GetRecord(record) == nil then
        TweakDB:CreateRecord(record, "gamedataApplyStatusEffectEffector_Record")
        TweakDB:SetFlat(record..".applicationTarget", target)
        TweakDB:SetFlat(record..".count", cnt)
        TweakDB:SetFlat(record..".effectorClassName", name)
        TweakDB:SetFlat(record..".instigator", instigator)
        TweakDB:SetFlat(record..".inverted", inverted)
        TweakDB:SetFlat(record..".prereqRecord", prereq)
        TweakDB:SetFlat(record..".removeAfterActionCall", delAction)
        TweakDB:SetFlat(record..".removeAfterPrereqCheck", delCheck)
        TweakDB:SetFlat(record..".removeWithEffector", delEffect)
        TweakDB:SetFlat(record..".statModifierGroups", statModGrp)
        TweakDB:SetFlat(record..".statusEffect", statusEffect)
        TweakDB:SetFlat(record..".useCountWhenRemoving", cntDel)
    end
    return record
end

function ACOSMK6.createBaseStat(record, decimal, name, flags, improve, max, min)
    if TweakDB:GetRecord(record) == nil then
        TweakDB:CreateRecord(record, "gamedataStat_Record")
        TweakDB:SetFlat(record..".decimalPlaces", decimal)
        TweakDB:SetFlat(record..".enumName", name)
        TweakDB:SetFlat(record..".flags", flags)
        TweakDB:SetFlat(record..".improvementRelation", improve)
        TweakDB:SetFlat(record..".max", max)
        TweakDB:SetFlat(record..".min", min)
    end
    return record
end

function ACOSMK6.createStatusEffectFX(itemRecord, name, reapply)
    if TweakDB:GetRecord(itemRecord) == nil then
        TweakDB:CreateRecord(itemRecord, "gamedataStatusEffectFX_Record")
        TweakDB:SetFlat(itemRecord..".name", name)
        TweakDB:SetFlat(itemRecord..".shouldReapply", reapply)
    end
    return itemRecord
end

function ACOSMK6.cloneMainRecord(itemRecord, toClone, cwType, nextItem, onEquip, objActions, quality, statsMod)
    if TweakDB:GetRecord(itemRecord) == nil then
        TweakDB:CloneRecord(itemRecord, toClone)
        TweakDB:SetFlat(itemRecord..".cyberwareType", CName(cwType))
        TweakDB:SetFlat(itemRecord..".nextUpgradeItem", nextItem)
        TweakDB:SetFlat(itemRecord..".OnEquip", onEquip)
        TweakDB:SetFlat(itemRecord..".objectActions", objActions)
        TweakDB:SetFlat(itemRecord..".quality", quality)
        TweakDB:SetFlat(itemRecord..".statModifiers", statsMod)
    end
    return itemRecord
end

function ACOSMK6.existsCheck(table)
    local cnt = 0
    for i, record in ipairs(table) do
        if TweakDB:GetRecord(record) ~= nil then
            cnt = cnt + 1
        end
    end
    if cnt == #table then return true end
    return false
end

function ACOSMK6.createIconicRecord(statRecord, iconic)
    if iconic then
        ACOSMK6.createConstantStat(statRecord, 'Additive', 'BaseStats.IsItemIconic', 1.0)
    end
end

function ACOSMK6.createCraftingPackage(itemRecord, expMod, table, penMod)
    if TweakDB:GetRecord(itemRecord) == nil then
        TweakDB:CreateRecord(itemRecord, "gamedataCraftingPackage_Record")
        TweakDB:SetFlat(itemRecord..".craftingExpModifier", expMod)
        TweakDB:SetFlat(itemRecord..".craftingRecipe", table)
        TweakDB:SetFlat(itemRecord..".overcraftPenaltyModifier", penMod)
    end
    return itemRecord
end

function ACOSMK6.createRecipeElements(table)
    for i, element in ipairs(table) do
        if TweakDB:GetRecord(element[1]) == nil then
            TweakDB:CreateRecord(element[1], "gamedataRecipeElement_Record")
            TweakDB:SetFlat(element[1]..".amount", element[2])
            TweakDB:SetFlat(element[1]..".ingredient", element[3])
        end
    end
end

function ACOSMK6.createCraftResult(itemRecord, amount, item)
    if TweakDB:GetRecord(itemRecord) == nil then
        TweakDB:CreateRecord(itemRecord, "gamedataCraftingResult_Record")
        TweakDB:SetFlat(itemRecord..".amount", amount)
        TweakDB:SetFlat(itemRecord..".item", item)
    end
    return itemRecord
end

function ACOSMK6.createCraftingItem(itemRecord, iName, quality)
    if TweakDB:GetRecord(itemRecord) == nil then
        TweakDB:CreateRecord(itemRecord, "gamedataItem_Record")
        TweakDB:SetFlat(itemRecord..".animFeatureName", 'ItemData')
        TweakDB:SetFlat(itemRecord..".animName", 'ui_garment_pose')
        TweakDB:SetFlat(itemRecord..".buyPrice", {'Price.BasePrice', 'Price.BuyMultiplier', 'Price.ItemQualityMultiplier', 'Price.BuyPrice_StreetCred_Discount', 'Price.CraftingMaterial'})
        TweakDB:SetFlat(itemRecord..".canDrop", true)
        TweakDB:SetFlat(itemRecord..".crosshair", "Crosshairs.None")
        TweakDB:SetFlat(itemRecord..".displayName", LocKey(iName))
        TweakDB:SetFlat(itemRecord..".dropObject", 'defaultItemDrop')
        TweakDB:SetFlat(itemRecord..".gameplayRestrictions", {"GameplayRestriction.VehicleCombatNoInterruptions"})
        TweakDB:SetFlat(itemRecord..".isSingleInstance", true)
        TweakDB:SetFlat(itemRecord..".itemCategory", 'ItemCategory.General')
        TweakDB:SetFlat(itemRecord..".itemType", 'ItemType.Gen_CraftingMaterial')
        TweakDB:SetFlat(itemRecord..".mass", 1.0)
        TweakDB:SetFlat(itemRecord..".minigameInstance", 'minigame_v2.DefaultItemMinigame')
        TweakDB:SetFlat(itemRecord..".quality", quality)
        TweakDB:SetFlat(itemRecord..".sellPrice", {'Price.BasePrice', 'Price.SellMultiplier', 'Price.ItemQualitySellMultiplier', 'Price.CraftingTraitMultiplier', 'Price.SellPriceIntrinsicModMult', 'Price.CraftingMaterial'})
        TweakDB:SetFlat(itemRecord..".statModifiers", {'Items.CraftingPart_inline0', 'Items.CraftingPart_inline1'})
        TweakDB:SetFlat(itemRecord..".tags", {'CraftingPart', 'HideInBackpackUI'})
        TweakDB:SetFlat(itemRecord..".upgradeCostMult", 1.0)
    end
    return itemRecord
end

function ACOSMK6.createItemRecipe(itemRecord, result, iName, icon, iconPath, quality, tags, upgrade)
    if TweakDB:GetRecord(itemRecord) == nil then
        TweakDB:CreateRecord(itemRecord, 'gamedataItemRecipe_Record')
        TweakDB:SetFlat(itemRecord..".animFeatureName", 'ItemData')
        TweakDB:SetFlat(itemRecord..".animName", 'ui_garment_pose')
        TweakDB:SetFlat(itemRecord..".buyPrice", {'Price.Recipe', 'Price.ItemQualityMultiplier', 'Price.BuyPrice_StreetCred_Discount'})
        TweakDB:SetFlat(itemRecord..".canDrop", true)
        TweakDB:SetFlat(itemRecord..".craftingResult", result)
        TweakDB:SetFlat(itemRecord..".crosshair", "Crosshairs.None")
        TweakDB:SetFlat(itemRecord..".displayName", LocKey(iName))
        TweakDB:SetFlat(itemRecord..".dropObject", 'defaultItemDrop')
        TweakDB:SetFlat(itemRecord..".entityName", 'None')
        TweakDB:SetFlat(itemRecord..".gameplayRestrictions", {"GameplayRestriction.VehicleCombatNoInterruptions"})
        TweakDB:SetFlat(itemRecord..".icon", icon)
        TweakDB:SetFlat(itemRecord..".iconPath", iconPath)
        TweakDB:SetFlat(itemRecord..".isSingleInstance", true)
        TweakDB:SetFlat(itemRecord..".itemType", 'ItemType.Gen_Misc')
        TweakDB:SetFlat(itemRecord..".mass", 1.0)
        TweakDB:SetFlat(itemRecord..".minigameInstance", 'minigame_v2.DefaultItemMinigame')
        TweakDB:SetFlat(itemRecord..".objectActions", {'ItemAction.Drop', 'ItemAction.Disassemble'})
        TweakDB:SetFlat(itemRecord..".quality", quality)
        TweakDB:SetFlat(itemRecord..".sellPrice", {'Price.Recipe', 'Price.ItemQualityMultiplier', 'Price.SellMultiplier'})
        TweakDB:SetFlat(itemRecord..".slotPartList", {'Items.GenericRootSlotItem'})
        TweakDB:SetFlat(itemRecord..".tags", tags)
        TweakDB:SetFlat(itemRecord..".upgradeCostMult", upgrade)
    end
    return itemRecord
end

function ACOSMK6.createStatusEffectUIData(record, desc, name, fVal, fText, icon, iVal, nVal, priority, stats)
    if TweakDB:GetRecord(record) == nil then
        TweakDB:CreateRecord(record, "gamedataStatusEffectUIData_Record")
        TweakDB:SetFlat(record..".description", desc)
        TweakDB:SetFlat(record..".displayName", name)
        TweakDB:SetFlat(record..".floatValues", fVal)
        TweakDB:SetFlat(record..".fluffText", fText)
        TweakDB:SetFlat(record..".iconPath", icon)
        TweakDB:SetFlat(record..".intValues", iVal)
        TweakDB:SetFlat(record..".nameValues", nVal)
        TweakDB:SetFlat(record..".priority", priority)
        TweakDB:SetFlat(record..".stats", stats)
    end
    return record
end

return ACOSMK6