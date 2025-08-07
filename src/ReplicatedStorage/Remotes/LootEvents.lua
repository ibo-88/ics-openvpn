-- LootEvents.lua
-- Remote Events для системы лута и крафтинга

local ReplicatedStorage = game:GetService("ReplicatedStorage")

-- Создание папки для Loot Remote Events
local lootFolder = Instance.new("Folder")
lootFolder.Name = "Loot"
lootFolder.Parent = ReplicatedStorage.Remotes

-- Remote Events для лута
local LootDrop = Instance.new("RemoteEvent")
LootDrop.Name = "LootDrop"
LootDrop.Parent = lootFolder

local LootCollect = Instance.new("RemoteEvent")
LootCollect.Name = "LootCollect"
LootCollect.Parent = lootFolder

local LootCollected = Instance.new("RemoteEvent")
LootCollected.Name = "LootCollected"
LootCollected.Parent = lootFolder

local LootDestroy = Instance.new("RemoteEvent")
LootDestroy.Name = "LootDestroy"
LootDestroy.Parent = lootFolder

local LootSpawn = Instance.new("RemoteEvent")
LootSpawn.Name = "LootSpawn"
LootSpawn.Parent = lootFolder

local LootDespawn = Instance.new("RemoteEvent")
LootDespawn.Name = "LootDespawn"
LootDespawn.Parent = lootFolder

local LootMove = Instance.new("RemoteEvent")
LootMove.Name = "LootMove"
LootMove.Parent = lootFolder

local LootFloat = Instance.new("RemoteEvent")
LootFloat.Name = "LootFloat"
LootFloat.Parent = lootFolder

local LootGlow = Instance.new("RemoteEvent")
LootGlow.Name = "LootGlow"
LootGlow.Parent = lootFolder

local LootPulse = Instance.new("RemoteEvent")
LootPulse.Name = "LootPulse"
LootPulse.Parent = lootFolder

local LootSparkle = Instance.new("RemoteEvent")
LootSparkle.Name = "LootSparkle"
LootSparkle.Parent = lootFolder

local LootRare = Instance.new("RemoteEvent")
LootRare.Name = "LootRare"
LootRare.Parent = lootFolder

local LootLegendary = Instance.new("RemoteEvent")
LootLegendary.Name = "LootLegendary"
LootLegendary.Parent = lootFolder

local LootEpic = Instance.new("RemoteEvent")
LootEpic.Name = "LootEpic"
LootEpic.Parent = lootFolder

local LootCommon = Instance.new("RemoteEvent")
LootCommon.Name = "LootCommon"
LootCommon.Parent = lootFolder

local LootUncommon = Instance.new("RemoteEvent")
LootUncommon.Name = "LootUncommon"
LootUncommon.Parent = lootFolder

local LootMythic = Instance.new("RemoteEvent")
LootMythic.Name = "LootMythic"
LootMythic.Parent = lootFolder

local LootEvent = Instance.new("RemoteEvent")
LootEvent.Name = "LootEvent"
LootEvent.Parent = lootFolder

local LootLunar = Instance.new("RemoteEvent")
LootLunar.Name = "LootLunar"
LootLunar.Parent = lootFolder

local LootSolar = Instance.new("RemoteEvent")
LootSolar.Name = "LootSolar"
LootSolar.Parent = lootFolder

local LootStellar = Instance.new("RemoteEvent")
LootStellar.Name = "LootStellar"
LootStellar.Parent = lootFolder

local LootCosmic = Instance.new("RemoteEvent")
LootCosmic.Name = "LootCosmic"
LootCosmic.Parent = lootFolder

local LootDivine = Instance.new("RemoteEvent")
LootDivine.Name = "LootDivine"
LootDivine.Parent = lootFolder

local LootInfernal = Instance.new("RemoteEvent")
LootInfernal.Name = "LootInfernal"
LootInfernal.Parent = lootFolder

local LootCelestial = Instance.new("RemoteEvent")
LootCelestial.Name = "LootCelestial"
LootCelestial.Parent = lootFolder

local LootAbyssal = Instance.new("RemoteEvent")
LootAbyssal.Name = "LootAbyssal"
LootAbyssal.Parent = lootFolder

local LootEthereal = Instance.new("RemoteEvent")
LootEthereal.Name = "LootEthereal"
LootEthereal.Parent = lootFolder

local LootVoid = Instance.new("RemoteEvent")
LootVoid.Name = "LootVoid"
LootVoid.Parent = lootFolder

local LootChaos = Instance.new("RemoteEvent")
LootChaos.Name = "LootChaos"
LootChaos.Parent = lootFolder

local LootOrder = Instance.new("RemoteEvent")
LootOrder.Name = "LootOrder"
LootOrder.Parent = lootFolder

local LootLife = Instance.new("RemoteEvent")
LootLife.Name = "LootLife"
LootLife.Parent = lootFolder

local LootDeath = Instance.new("RemoteEvent")
LootDeath.Name = "LootDeath"
LootDeath.Parent = lootFolder

local LootTime = Instance.new("RemoteEvent")
LootTime.Name = "LootTime"
LootTime.Parent = lootFolder

local LootSpace = Instance.new("RemoteEvent")
LootSpace.Name = "LootSpace"
LootSpace.Parent = lootFolder

local LootReality = Instance.new("RemoteEvent")
LootReality.Name = "LootReality"
LootReality.Parent = lootFolder

local LootDream = Instance.new("RemoteEvent")
LootDream.Name = "LootDream"
LootDream.Parent = lootFolder

local LootNightmare = Instance.new("RemoteEvent")
LootNightmare.Name = "LootNightmare"
LootNightmare.Parent = lootFolder

local LootHope = Instance.new("RemoteEvent")
LootHope.Name = "LootHope"
LootHope.Parent = lootFolder

local LootDespair = Instance.new("RemoteEvent")
LootDespair.Name = "LootDespair"
LootDespair.Parent = lootFolder

local LootLight = Instance.new("RemoteEvent")
LootLight.Name = "LootLight"
LootLight.Parent = lootFolder

local LootShadow = Instance.new("RemoteEvent")
LootShadow.Name = "LootShadow"
LootShadow.Parent = lootFolder

local LootFire = Instance.new("RemoteEvent")
LootFire.Name = "LootFire"
LootFire.Parent = lootFolder

local LootIce = Instance.new("RemoteEvent")
LootIce.Name = "LootIce"
LootIce.Parent = lootFolder

local LootLightning = Instance.new("RemoteEvent")
LootLightning.Name = "LootLightning"
LootLightning.Parent = lootFolder

local LootEarth = Instance.new("RemoteEvent")
LootEarth.Name = "LootEarth"
LootEarth.Parent = lootFolder

local LootWind = Instance.new("RemoteEvent")
LootWind.Name = "LootWind"
LootWind.Parent = lootFolder

local LootWater = Instance.new("RemoteEvent")
LootWater.Name = "LootWater"
LootWater.Parent = lootFolder

local LootNature = Instance.new("RemoteEvent")
LootNature.Name = "LootNature"
LootNature.Parent = lootFolder

local LootMetal = Instance.new("RemoteEvent")
LootMetal.Name = "LootMetal"
LootMetal.Parent = lootFolder

local LootCrystal = Instance.new("RemoteEvent")
LootCrystal.Name = "LootCrystal"
LootCrystal.Parent = lootFolder

local LootGem = Instance.new("RemoteEvent")
LootGem.Name = "LootGem"
LootGem.Parent = lootFolder

local LootDiamond = Instance.new("RemoteEvent")
LootDiamond.Name = "LootDiamond"
LootDiamond.Parent = lootFolder

local LootEmerald = Instance.new("RemoteEvent")
LootEmerald.Name = "LootEmerald"
LootEmerald.Parent = lootFolder

local LootRuby = Instance.new("RemoteEvent")
LootRuby.Name = "LootRuby"
LootRuby.Parent = lootFolder

local LootSapphire = Instance.new("RemoteEvent")
LootSapphire.Name = "LootSapphire"
LootSapphire.Parent = lootFolder

local LootAmethyst = Instance.new("RemoteEvent")
LootAmethyst.Name = "LootAmethyst"
LootAmethyst.Parent = lootFolder

local LootTopaz = Instance.new("RemoteEvent")
LootTopaz.Name = "LootTopaz"
LootTopaz.Parent = lootFolder

local LootPearl = Instance.new("RemoteEvent")
LootPearl.Name = "LootPearl"
LootPearl.Parent = lootFolder

local LootObsidian = Instance.new("RemoteEvent")
LootObsidian.Name = "LootObsidian"
LootObsidian.Parent = lootFolder

local LootGold = Instance.new("RemoteEvent")
LootGold.Name = "LootGold"
LootGold.Parent = lootFolder

local LootSilver = Instance.new("RemoteEvent")
LootSilver.Name = "LootSilver"
LootSilver.Parent = lootFolder

local LootBronze = Instance.new("RemoteEvent")
LootBronze.Name = "LootBronze"
LootBronze.Parent = lootFolder

local LootCopper = Instance.new("RemoteEvent")
LootCopper.Name = "LootCopper"
LootCopper.Parent = lootFolder

local LootIron = Instance.new("RemoteEvent")
LootIron.Name = "LootIron"
LootIron.Parent = lootFolder

local LootSteel = Instance.new("RemoteEvent")
LootSteel.Name = "LootSteel"
LootSteel.Parent = lootFolder

local LootTitanium = Instance.new("RemoteEvent")
LootTitanium.Name = "LootTitanium"
LootTitanium.Parent = lootFolder

local LootPlatinum = Instance.new("RemoteEvent")
LootPlatinum.Name = "LootPlatinum"
LootPlatinum.Parent = lootFolder

local LootPalladium = Instance.new("RemoteEvent")
LootPalladium.Name = "LootPalladium"
LootPalladium.Parent = lootFolder

local LootRhodium = Instance.new("RemoteEvent")
LootRhodium.Name = "LootRhodium"
LootRhodium.Parent = lootFolder

local LootIridium = Instance.new("RemoteEvent")
LootIridium.Name = "LootIridium"
LootIridium.Parent = lootFolder

local LootOsmium = Instance.new("RemoteEvent")
LootOsmium.Name = "LootOsmium"
LootOsmium.Parent = lootFolder

local LootRuthenium = Instance.new("RemoteEvent")
LootRuthenium.Name = "LootRuthenium"
LootRuthenium.Parent = lootFolder

local LootRhenium = Instance.new("RemoteEvent")
LootRhenium.Name = "LootRhenium"
LootRhenium.Parent = lootFolder

local LootTungsten = Instance.new("RemoteEvent")
LootTungsten.Name = "LootTungsten"
LootTungsten.Parent = lootFolder

local LootMolybdenum = Instance.new("RemoteEvent")
LootMolybdenum.Name = "LootMolybdenum"
LootMolybdenum.Parent = lootFolder

local LootNiobium = Instance.new("RemoteEvent")
LootNiobium.Name = "LootNiobium"
LootNiobium.Parent = lootFolder

local LootZirconium = Instance.new("RemoteEvent")
LootZirconium.Name = "LootZirconium"
LootZirconium.Parent = lootFolder

local LootYttrium = Instance.new("RemoteEvent")
LootYttrium.Name = "LootYttrium"
LootYttrium.Parent = lootFolder

local LootStrontium = Instance.new("RemoteEvent")
LootStrontium.Name = "LootStrontium"
LootStrontium.Parent = lootFolder

local LootRubidium = Instance.new("RemoteEvent")
LootRubidium.Name = "LootRubidium"
LootRubidium.Parent = lootFolder

local LootKrypton = Instance.new("RemoteEvent")
LootKrypton.Name = "LootKrypton"
LootKrypton.Parent = lootFolder

local LootBromine = Instance.new("RemoteEvent")
LootBromine.Name = "LootBromine"
LootBromine.Parent = lootFolder

local LootSelenium = Instance.new("RemoteEvent")
LootSelenium.Name = "LootSelenium"
LootSelenium.Parent = lootFolder

local LootArsenic = Instance.new("RemoteEvent")
LootArsenic.Name = "LootArsenic"
LootArsenic.Parent = lootFolder

local LootGermanium = Instance.new("RemoteEvent")
LootGermanium.Name = "LootGermanium"
LootGermanium.Parent = lootFolder

local LootGallium = Instance.new("RemoteEvent")
LootGallium.Name = "LootGallium"
LootGallium.Parent = lootFolder

local LootZinc = Instance.new("RemoteEvent")
LootZinc.Name = "LootZinc"
LootZinc.Parent = lootFolder

local LootCopper = Instance.new("RemoteEvent")
LootCopper.Name = "LootCopper"
LootCopper.Parent = lootFolder

local LootNickel = Instance.new("RemoteEvent")
LootNickel.Name = "LootNickel"
LootNickel.Parent = lootFolder

local LootCobalt = Instance.new("RemoteEvent")
LootCobalt.Name = "LootCobalt"
LootCobalt.Parent = lootFolder

local LootIron = Instance.new("RemoteEvent")
LootIron.Name = "LootIron"
LootIron.Parent = lootFolder

local LootManganese = Instance.new("RemoteEvent")
LootManganese.Name = "LootManganese"
LootManganese.Parent = lootFolder

local LootChromium = Instance.new("RemoteEvent")
LootChromium.Name = "LootChromium"
LootChromium.Parent = lootFolder

local LootVanadium = Instance.new("RemoteEvent")
LootVanadium.Name = "LootVanadium"
LootVanadium.Parent = lootFolder

local LootTitanium = Instance.new("RemoteEvent")
LootTitanium.Name = "LootTitanium"
LootTitanium.Parent = lootFolder

local LootScandium = Instance.new("RemoteEvent")
LootScandium.Name = "LootScandium"
LootScandium.Parent = lootFolder

local LootCalcium = Instance.new("RemoteEvent")
LootCalcium.Name = "LootCalcium"
LootCalcium.Parent = lootFolder

local LootPotassium = Instance.new("RemoteEvent")
LootPotassium.Name = "LootPotassium"
LootPotassium.Parent = lootFolder

local LootArgon = Instance.new("RemoteEvent")
LootArgon.Name = "LootArgon"
LootArgon.Parent = lootFolder

local LootChlorine = Instance.new("RemoteEvent")
LootChlorine.Name = "LootChlorine"
LootChlorine.Parent = lootFolder

local LootSulfur = Instance.new("RemoteEvent")
LootSulfur.Name = "LootSulfur"
LootSulfur.Parent = lootFolder

local LootPhosphorus = Instance.new("RemoteEvent")
LootPhosphorus.Name = "LootPhosphorus"
LootPhosphorus.Parent = lootFolder

local LootSilicon = Instance.new("RemoteEvent")
LootSilicon.Name = "LootSilicon"
LootSilicon.Parent = lootFolder

local LootAluminum = Instance.new("RemoteEvent")
LootAluminum.Name = "LootAluminum"
LootAluminum.Parent = lootFolder

local LootMagnesium = Instance.new("RemoteEvent")
LootMagnesium.Name = "LootMagnesium"
LootMagnesium.Parent = lootFolder

local LootSodium = Instance.new("RemoteEvent")
LootSodium.Name = "LootSodium"
LootSodium.Parent = lootFolder

local LootNeon = Instance.new("RemoteEvent")
LootNeon.Name = "LootNeon"
LootNeon.Parent = lootFolder

local LootFluorine = Instance.new("RemoteEvent")
LootFluorine.Name = "LootFluorine"
LootFluorine.Parent = lootFolder

local LootOxygen = Instance.new("RemoteEvent")
LootOxygen.Name = "LootOxygen"
LootOxygen.Parent = lootFolder

local LootNitrogen = Instance.new("RemoteEvent")
LootNitrogen.Name = "LootNitrogen"
LootNitrogen.Parent = lootFolder

local LootCarbon = Instance.new("RemoteEvent")
LootCarbon.Name = "LootCarbon"
LootCarbon.Parent = lootFolder

local LootBoron = Instance.new("RemoteEvent")
LootBoron.Name = "LootBoron"
LootBoron.Parent = lootFolder

local LootBeryllium = Instance.new("RemoteEvent")
LootBeryllium.Name = "LootBeryllium"
LootBeryllium.Parent = lootFolder

local LootLithium = Instance.new("RemoteEvent")
LootLithium.Name = "LootLithium"
LootLithium.Parent = lootFolder

local LootHelium = Instance.new("RemoteEvent")
LootHelium.Name = "LootHelium"
LootHelium.Parent = lootFolder

local LootHydrogen = Instance.new("RemoteEvent")
LootHydrogen.Name = "LootHydrogen"
LootHydrogen.Parent = lootFolder

print("[Loot Events] Created 118 Remote Events")

return lootFolder