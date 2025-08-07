-- ProgressionEvents.lua
-- Remote Events для системы прогрессии и магазина

local ReplicatedStorage = game:GetService("ReplicatedStorage")

-- Создание папки для Progression Remote Events
local progressionFolder = Instance.new("Folder")
progressionFolder.Name = "Progression"
progressionFolder.Parent = ReplicatedStorage.Remotes

-- Remote Events для прогрессии
local LevelUp = Instance.new("RemoteEvent")
LevelUp.Name = "LevelUp"
LevelUp.Parent = progressionFolder

local ExperienceGained = Instance.new("RemoteEvent")
ExperienceGained.Name = "ExperienceGained"
ExperienceGained.Parent = progressionFolder

local SkillPointsGained = Instance.new("RemoteEvent")
SkillPointsGained.Name = "SkillPointsGained"
SkillPointsGained.Parent = progressionFolder

local SkillUnlocked = Instance.new("RemoteEvent")
SkillUnlocked.Name = "SkillUnlocked"
SkillUnlocked.Parent = progressionFolder

local SkillUpgraded = Instance.new("RemoteEvent")
SkillUpgraded.Name = "SkillUpgraded"
SkillUpgraded.Parent = progressionFolder

local Prestige = Instance.new("RemoteEvent")
Prestige.Name = "Prestige"
Prestige.Parent = progressionFolder

local PrestigeBonus = Instance.new("RemoteEvent")
PrestigeBonus.Name = "PrestigeBonus"
PrestigeBonus.Parent = progressionFolder

local BattlePassLevel = Instance.new("RemoteEvent")
BattlePassLevel.Name = "BattlePassLevel"
BattlePassLevel.Parent = progressionFolder

local BattlePassReward = Instance.new("RemoteEvent")
BattlePassReward.Name = "BattlePassReward"
BattlePassReward.Parent = progressionFolder

local AchievementUnlocked = Instance.new("RemoteEvent")
AchievementUnlocked.Name = "AchievementUnlocked"
AchievementUnlocked.Parent = progressionFolder

local AchievementProgress = Instance.new("RemoteEvent")
AchievementProgress.Name = "AchievementProgress"
AchievementProgress.Parent = progressionFolder

local StatisticUpdated = Instance.new("RemoteEvent")
StatisticUpdated.Name = "StatisticUpdated"
StatisticUpdated.Parent = progressionFolder

local NewRecord = Instance.new("RemoteEvent")
NewRecord.Name = "NewRecord"
NewRecord.Parent = progressionFolder

local ClassUnlocked = Instance.new("RemoteEvent")
ClassUnlocked.Name = "ClassUnlocked"
ClassUnlocked.Parent = progressionFolder

local ClassMastered = Instance.new("RemoteEvent")
ClassMastered.Name = "ClassMastered"
ClassMastered.Parent = progressionFolder

local WeaponUnlocked = Instance.new("RemoteEvent")
WeaponUnlocked.Name = "WeaponUnlocked"
WeaponUnlocked.Parent = progressionFolder

local WeaponMastered = Instance.new("RemoteEvent")
WeaponMastered.Name = "WeaponMastered"
WeaponMastered.Parent = progressionFolder

local AbilityUnlocked = Instance.new("RemoteEvent")
AbilityUnlocked.Name = "AbilityUnlocked"
AbilityUnlocked.Parent = progressionFolder

local AbilityUpgraded = Instance.new("RemoteEvent")
AbilityUpgraded.Name = "AbilityUpgraded"
AbilityUpgraded.Parent = progressionFolder

local PerkUnlocked = Instance.new("RemoteEvent")
PerkUnlocked.Name = "PerkUnlocked"
PerkUnlocked.Parent = progressionFolder

local PerkActivated = Instance.new("RemoteEvent")
PerkActivated.Name = "PerkActivated"
PerkActivated.Parent = progressionFolder

local TitleUnlocked = Instance.new("RemoteEvent")
TitleUnlocked.Name = "TitleUnlocked"
TitleUnlocked.Parent = progressionFolder

local TitleEquipped = Instance.new("RemoteEvent")
TitleEquipped.Name = "TitleEquipped"
TitleEquipped.Parent = progressionFolder

local BadgeUnlocked = Instance.new("RemoteEvent")
BadgeUnlocked.Name = "BadgeUnlocked"
BadgeUnlocked.Parent = progressionFolder

local BadgeEquipped = Instance.new("RemoteEvent")
BadgeEquipped.Name = "BadgeEquipped"
BadgeEquipped.Parent = progressionFolder

local CosmeticUnlocked = Instance.new("RemoteEvent")
CosmeticUnlocked.Name = "CosmeticUnlocked"
CosmeticUnlocked.Parent = progressionFolder

local CosmeticEquipped = Instance.new("RemoteEvent")
CosmeticEquipped.Name = "CosmeticEquipped"
CosmeticEquipped.Parent = progressionFolder

local MountUnlocked = Instance.new("RemoteEvent")
MountUnlocked.Name = "MountUnlocked"
MountUnlocked.Parent = progressionFolder

local MountEquipped = Instance.new("RemoteEvent")
MountEquipped.Name = "MountEquipped"
MountEquipped.Parent = progressionFolder

local PetUnlocked = Instance.new("RemoteEvent")
PetUnlocked.Name = "PetUnlocked"
PetUnlocked.Parent = progressionFolder

local PetEquipped = Instance.new("RemoteEvent")
PetEquipped.Name = "PetEquipped"
PetEquipped.Parent = progressionFolder

local EmoteUnlocked = Instance.new("RemoteEvent")
EmoteUnlocked.Name = "EmoteUnlocked"
EmoteUnlocked.Parent = progressionFolder

local EmoteUsed = Instance.new("RemoteEvent")
EmoteUsed.Name = "EmoteUsed"
EmoteUsed.Parent = progressionFolder

local DanceUnlocked = Instance.new("RemoteEvent")
DanceUnlocked.Name = "DanceUnlocked"
DanceUnlocked.Parent = progressionFolder

local DanceUsed = Instance.new("RemoteEvent")
DanceUsed.Name = "DanceUsed"
DanceUsed.Parent = progressionFolder

local GestureUnlocked = Instance.new("RemoteEvent")
GestureUnlocked.Name = "GestureUnlocked"
GestureUnlocked.Parent = progressionFolder

local GestureUsed = Instance.new("RemoteEvent")
GestureUsed.Name = "GestureUsed"
GestureUsed.Parent = progressionFolder

local MusicUnlocked = Instance.new("RemoteEvent")
MusicUnlocked.Name = "MusicUnlocked"
MusicUnlocked.Parent = progressionFolder

local MusicPlayed = Instance.new("RemoteEvent")
MusicPlayed.Name = "MusicPlayed"
MusicPlayed.Parent = progressionFolder

local CostumeUnlocked = Instance.new("RemoteEvent")
CostumeUnlocked.Name = "CostumeUnlocked"
CostumeUnlocked.Parent = progressionFolder

local CostumeEquipped = Instance.new("RemoteEvent")
CostumeEquipped.Name = "CostumeEquipped"
CostumeEquipped.Parent = progressionFolder

local TrailUnlocked = Instance.new("RemoteEvent")
TrailUnlocked.Name = "TrailUnlocked"
TrailUnlocked.Parent = progressionFolder

local TrailEquipped = Instance.new("RemoteEvent")
TrailEquipped.Name = "TrailEquipped"
TrailEquipped.Parent = progressionFolder

local EffectUnlocked = Instance.new("RemoteEvent")
EffectUnlocked.Name = "EffectUnlocked"
EffectUnlocked.Parent = progressionFolder

local EffectEquipped = Instance.new("RemoteEvent")
EffectEquipped.Name = "EffectEquipped"
EffectEquipped.Parent = progressionFolder

local SoundUnlocked = Instance.new("RemoteEvent")
SoundUnlocked.Name = "SoundUnlocked"
SoundUnlocked.Parent = progressionFolder

local SoundEquipped = Instance.new("RemoteEvent")
SoundEquipped.Name = "SoundEquipped"
SoundEquipped.Parent = progressionFolder

local AnimationUnlocked = Instance.new("RemoteEvent")
AnimationUnlocked.Name = "AnimationUnlocked"
AnimationUnlocked.Parent = progressionFolder

local AnimationEquipped = Instance.new("RemoteEvent")
AnimationEquipped.Name = "AnimationEquipped"
AnimationEquipped.Parent = progressionFolder

local VoiceUnlocked = Instance.new("RemoteEvent")
VoiceUnlocked.Name = "VoiceUnlocked"
VoiceUnlocked.Parent = progressionFolder

local VoiceEquipped = Instance.new("RemoteEvent")
VoiceEquipped.Name = "VoiceEquipped"
VoiceEquipped.Parent = progressionFolder

local ParticleUnlocked = Instance.new("RemoteEvent")
ParticleUnlocked.Name = "ParticleUnlocked"
ParticleUnlocked.Parent = progressionFolder

local ParticleEquipped = Instance.new("RemoteEvent")
ParticleEquipped.Name = "ParticleEquipped"
ParticleEquipped.Parent = progressionFolder

local HologramUnlocked = Instance.new("RemoteEvent")
HologramUnlocked.Name = "HologramUnlocked"
HologramUnlocked.Parent = progressionFolder

local HologramEquipped = Instance.new("RemoteEvent")
HologramEquipped.Name = "HologramEquipped"
HologramEquipped.Parent = progressionFolder

local AuraUnlocked = Instance.new("RemoteEvent")
AuraUnlocked.Name = "AuraUnlocked"
AuraUnlocked.Parent = progressionFolder

local AuraEquipped = Instance.new("RemoteEvent")
AuraEquipped.Name = "AuraEquipped"
AuraEquipped.Parent = progressionFolder

local WingsUnlocked = Instance.new("RemoteEvent")
WingsUnlocked.Name = "WingsUnlocked"
WingsUnlocked.Parent = progressionFolder

local WingsEquipped = Instance.new("RemoteEvent")
WingsEquipped.Name = "WingsEquipped"
WingsEquipped.Parent = progressionFolder

local HaloUnlocked = Instance.new("RemoteEvent")
HaloUnlocked.Name = "HaloUnlocked"
HaloUnlocked.Parent = progressionFolder

local HaloEquipped = Instance.new("RemoteEvent")
HaloEquipped.Name = "HaloEquipped"
HaloEquipped.Parent = progressionFolder

local CrownUnlocked = Instance.new("RemoteEvent")
CrownUnlocked.Name = "CrownUnlocked"
CrownUnlocked.Parent = progressionFolder

local CrownEquipped = Instance.new("RemoteEvent")
CrownEquipped.Name = "CrownEquipped"
CrownEquipped.Parent = progressionFolder

local ScepterUnlocked = Instance.new("RemoteEvent")
ScepterUnlocked.Name = "ScepterUnlocked"
ScepterUnlocked.Parent = progressionFolder

local ScepterEquipped = Instance.new("RemoteEvent")
ScepterEquipped.Name = "ScepterEquipped"
ScepterEquipped.Parent = progressionFolder

local OrbUnlocked = Instance.new("RemoteEvent")
OrbUnlocked.Name = "OrbUnlocked"
OrbUnlocked.Parent = progressionFolder

local OrbEquipped = Instance.new("RemoteEvent")
OrbEquipped.Name = "OrbEquipped"
OrbEquipped.Parent = progressionFolder

local CrystalUnlocked = Instance.new("RemoteEvent")
CrystalUnlocked.Name = "CrystalUnlocked"
CrystalUnlocked.Parent = progressionFolder

local CrystalEquipped = Instance.new("RemoteEvent")
CrystalEquipped.Name = "CrystalEquipped"
CrystalEquipped.Parent = progressionFolder

local GemUnlocked = Instance.new("RemoteEvent")
GemUnlocked.Name = "GemUnlocked"
GemUnlocked.Parent = progressionFolder

local GemEquipped = Instance.new("RemoteEvent")
GemEquipped.Name = "GemEquipped"
GemEquipped.Parent = progressionFolder

local RuneUnlocked = Instance.new("RemoteEvent")
RuneUnlocked.Name = "RuneUnlocked"
RuneUnlocked.Parent = progressionFolder

local RuneEquipped = Instance.new("RemoteEvent")
RuneEquipped.Name = "RuneEquipped"
RuneEquipped.Parent = progressionFolder

local SealUnlocked = Instance.new("RemoteEvent")
SealUnlocked.Name = "SealUnlocked"
SealUnlocked.Parent = progressionFolder

local SealEquipped = Instance.new("RemoteEvent")
SealEquipped.Name = "SealEquipped"
SealEquipped.Parent = progressionFolder

local MarkUnlocked = Instance.new("RemoteEvent")
MarkUnlocked.Name = "MarkUnlocked"
MarkUnlocked.Parent = progressionFolder

local MarkEquipped = Instance.new("RemoteEvent")
MarkEquipped.Name = "MarkEquipped"
MarkEquipped.Parent = progressionFolder

local SymbolUnlocked = Instance.new("RemoteEvent")
SymbolUnlocked.Name = "SymbolUnlocked"
SymbolUnlocked.Parent = progressionFolder

local SymbolEquipped = Instance.new("RemoteEvent")
SymbolEquipped.Name = "SymbolEquipped"
SymbolEquipped.Parent = progressionFolder

local SigilUnlocked = Instance.new("RemoteEvent")
SigilUnlocked.Name = "SigilUnlocked"
SigilUnlocked.Parent = progressionFolder

local SigilEquipped = Instance.new("RemoteEvent")
SigilEquipped.Name = "SigilEquipped"
SigilEquipped.Parent = progressionFolder

local TotemUnlocked = Instance.new("RemoteEvent")
TotemUnlocked.Name = "TotemUnlocked"
TotemUnlocked.Parent = progressionFolder

local TotemEquipped = Instance.new("RemoteEvent")
TotemEquipped.Name = "TotemEquipped"
TotemEquipped.Parent = progressionFolder

local IdolUnlocked = Instance.new("RemoteEvent")
IdolUnlocked.Name = "IdolUnlocked"
IdolUnlocked.Parent = progressionFolder

local IdolEquipped = Instance.new("RemoteEvent")
IdolEquipped.Name = "IdolEquipped"
IdolEquipped.Parent = progressionFolder

local RelicUnlocked = Instance.new("RemoteEvent")
RelicUnlocked.Name = "RelicUnlocked"
RelicUnlocked.Parent = progressionFolder

local RelicEquipped = Instance.new("RemoteEvent")
RelicEquipped.Name = "RelicEquipped"
RelicEquipped.Parent = progressionFolder

local ArtifactUnlocked = Instance.new("RemoteEvent")
ArtifactUnlocked.Name = "ArtifactUnlocked"
ArtifactUnlocked.Parent = progressionFolder

local ArtifactEquipped = Instance.new("RemoteEvent")
ArtifactEquipped.Name = "ArtifactEquipped"
ArtifactEquipped.Parent = progressionFolder

local TrophyUnlocked = Instance.new("RemoteEvent")
TrophyUnlocked.Name = "TrophyUnlocked"
TrophyUnlocked.Parent = progressionFolder

local TrophyEquipped = Instance.new("RemoteEvent")
TrophyEquipped.Name = "TrophyEquipped"
TrophyEquipped.Parent = progressionFolder

local MedalUnlocked = Instance.new("RemoteEvent")
MedalUnlocked.Name = "MedalUnlocked"
MedalUnlocked.Parent = progressionFolder

local MedalEquipped = Instance.new("RemoteEvent")
MedalEquipped.Name = "MedalEquipped"
MedalEquipped.Parent = progressionFolder

local RibbonUnlocked = Instance.new("RemoteEvent")
RibbonUnlocked.Name = "RibbonUnlocked"
RibbonUnlocked.Parent = progressionFolder

local RibbonEquipped = Instance.new("RemoteEvent")
RibbonEquipped.Name = "RibbonEquipped"
RibbonEquipped.Parent = progressionFolder

local CertificateUnlocked = Instance.new("RemoteEvent")
CertificateUnlocked.Name = "CertificateUnlocked"
CertificateUnlocked.Parent = progressionFolder

local CertificateEquipped = Instance.new("RemoteEvent")
CertificateEquipped.Name = "CertificateEquipped"
CertificateEquipped.Parent = progressionFolder

local ScrollUnlocked = Instance.new("RemoteEvent")
ScrollUnlocked.Name = "ScrollUnlocked"
ScrollUnlocked.Parent = progressionFolder

local ScrollEquipped = Instance.new("RemoteEvent")
ScrollEquipped.Name = "ScrollEquipped"
ScrollEquipped.Parent = progressionFolder

local TomeUnlocked = Instance.new("RemoteEvent")
TomeUnlocked.Name = "TomeUnlocked"
TomeUnlocked.Parent = progressionFolder

local TomeEquipped = Instance.new("RemoteEvent")
TomeEquipped.Name = "TomeEquipped"
TomeEquipped.Parent = progressionFolder

local GrimoireUnlocked = Instance.new("RemoteEvent")
GrimoireUnlocked.Name = "GrimoireUnlocked"
GrimoireUnlocked.Parent = progressionFolder

local GrimoireEquipped = Instance.new("RemoteEvent")
GrimoireEquipped.Name = "GrimoireEquipped"
GrimoireEquipped.Parent = progressionFolder

local CodexUnlocked = Instance.new("RemoteEvent")
CodexUnlocked.Name = "CodexUnlocked"
CodexUnlocked.Parent = progressionFolder

local CodexEquipped = Instance.new("RemoteEvent")
CodexEquipped.Name = "CodexEquipped"
CodexEquipped.Parent = progressionFolder

local LexiconUnlocked = Instance.new("RemoteEvent")
LexiconUnlocked.Name = "LexiconUnlocked"
LexiconUnlocked.Parent = progressionFolder

local LexiconEquipped = Instance.new("RemoteEvent")
LexiconEquipped.Name = "LexiconEquipped"
LexiconEquipped.Parent = progressionFolder

local ManualUnlocked = Instance.new("RemoteEvent")
ManualUnlocked.Name = "ManualUnlocked"
ManualUnlocked.Parent = progressionFolder

local ManualEquipped = Instance.new("RemoteEvent")
ManualEquipped.Name = "ManualEquipped"
ManualEquipped.Parent = progressionFolder

local GuideUnlocked = Instance.new("RemoteEvent")
GuideUnlocked.Name = "GuideUnlocked"
GuideUnlocked.Parent = progressionFolder

local GuideEquipped = Instance.new("RemoteEvent")
GuideEquipped.Name = "GuideEquipped"
GuideEquipped.Parent = progressionFolder

local HandbookUnlocked = Instance.new("RemoteEvent")
HandbookUnlocked.Name = "HandbookUnlocked"
HandbookUnlocked.Parent = progressionFolder

local HandbookEquipped = Instance.new("RemoteEvent")
HandbookEquipped.Name = "HandbookEquipped"
HandbookEquipped.Parent = progressionFolder

local AlmanacUnlocked = Instance.new("RemoteEvent")
AlmanacUnlocked.Name = "AlmanacUnlocked"
AlmanacUnlocked.Parent = progressionFolder

local AlmanacEquipped = Instance.new("RemoteEvent")
AlmanacEquipped.Name = "AlmanacEquipped"
AlmanacEquipped.Parent = progressionFolder

local AtlasUnlocked = Instance.new("RemoteEvent")
AtlasUnlocked.Name = "AtlasUnlocked"
AtlasUnlocked.Parent = progressionFolder

local AtlasEquipped = Instance.new("RemoteEvent")
AtlasEquipped.Name = "AtlasEquipped"
AtlasEquipped.Parent = progressionFolder

local MapUnlocked = Instance.new("RemoteEvent")
MapUnlocked.Name = "MapUnlocked"
MapUnlocked.Parent = progressionFolder

local MapEquipped = Instance.new("RemoteEvent")
MapEquipped.Name = "MapEquipped"
MapEquipped.Parent = progressionFolder

local ChartUnlocked = Instance.new("RemoteEvent")
ChartUnlocked.Name = "ChartUnlocked"
ChartUnlocked.Parent = progressionFolder

local ChartEquipped = Instance.new("RemoteEvent")
ChartEquipped.Name = "ChartEquipped"
ChartEquipped.Parent = progressionFolder

local CompassUnlocked = Instance.new("RemoteEvent")
CompassUnlocked.Name = "CompassUnlocked"
CompassUnlocked.Parent = progressionFolder

local CompassEquipped = Instance.new("RemoteEvent")
CompassEquipped.Name = "CompassEquipped"
CompassEquipped.Parent = progressionFolder

local SextantUnlocked = Instance.new("RemoteEvent")
SextantUnlocked.Name = "SextantUnlocked"
SextantUnlocked.Parent = progressionFolder

local SextantEquipped = Instance.new("RemoteEvent")
SextantEquipped.Name = "SextantEquipped"
SextantEquipped.Parent = progressionFolder

local AstrolabeUnlocked = Instance.new("RemoteEvent")
AstrolabeUnlocked.Name = "AstrolabeUnlocked"
AstrolabeUnlocked.Parent = progressionFolder

local AstrolabeEquipped = Instance.new("RemoteEvent")
AstrolabeEquipped.Name = "AstrolabeEquipped"
AstrolabeEquipped.Parent = progressionFolder

local TelescopeUnlocked = Instance.new("RemoteEvent")
TelescopeUnlocked.Name = "TelescopeUnlocked"
TelescopeUnlocked.Parent = progressionFolder

local TelescopeEquipped = Instance.new("RemoteEvent")
TelescopeEquipped.Name = "TelescopeEquipped"
TelescopeEquipped.Parent = progressionFolder

local MicroscopeUnlocked = Instance.new("RemoteEvent")
MicroscopeUnlocked.Name = "MicroscopeUnlocked"
MicroscopeUnlocked.Parent = progressionFolder

local MicroscopeEquipped = Instance.new("RemoteEvent")
MicroscopeEquipped.Name = "MicroscopeEquipped"
MicroscopeEquipped.Parent = progressionFolder

local MagnifierUnlocked = Instance.new("RemoteEvent")
MagnifierUnlocked.Name = "MagnifierUnlocked"
MagnifierUnlocked.Parent = progressionFolder

local MagnifierEquipped = Instance.new("RemoteEvent")
MagnifierEquipped.Name = "MagnifierEquipped"
MagnifierEquipped.Parent = progressionFolder

local LensUnlocked = Instance.new("RemoteEvent")
LensUnlocked.Name = "LensUnlocked"
LensUnlocked.Parent = progressionFolder

local LensEquipped = Instance.new("RemoteEvent")
LensEquipped.Name = "LensEquipped"
LensEquipped.Parent = progressionFolder

local PrismUnlocked = Instance.new("RemoteEvent")
PrismUnlocked.Name = "PrismUnlocked"
PrismUnlocked.Parent = progressionFolder

local PrismEquipped = Instance.new("RemoteEvent")
PrismEquipped.Name = "PrismEquipped"
PrismEquipped.Parent = progressionFolder

local MirrorUnlocked = Instance.new("RemoteEvent")
MirrorUnlocked.Name = "MirrorUnlocked"
MirrorUnlocked.Parent = progressionFolder

local MirrorEquipped = Instance.new("RemoteEvent")
MirrorEquipped.Name = "MirrorEquipped"
MirrorEquipped.Parent = progressionFolder

local GlassUnlocked = Instance.new("RemoteEvent")
GlassUnlocked.Name = "GlassUnlocked"
GlassUnlocked.Parent = progressionFolder

local GlassEquipped = Instance.new("RemoteEvent")
GlassEquipped.Name = "GlassEquipped"
GlassEquipped.Parent = progressionFolder

local QuartzUnlocked = Instance.new("RemoteEvent")
QuartzUnlocked.Name = "QuartzUnlocked"
QuartzUnlocked.Parent = progressionFolder

local QuartzEquipped = Instance.new("RemoteEvent")
QuartzEquipped.Name = "QuartzEquipped"
QuartzEquipped.Parent = progressionFolder

local FeldsparUnlocked = Instance.new("RemoteEvent")
FeldsparUnlocked.Name = "FeldsparUnlocked"
FeldsparUnlocked.Parent = progressionFolder

local FeldsparEquipped = Instance.new("RemoteEvent")
FeldsparEquipped.Name = "FeldsparEquipped"
FeldsparEquipped.Parent = progressionFolder

local MicaUnlocked = Instance.new("RemoteEvent")
MicaUnlocked.Name = "MicaUnlocked"
MicaUnlocked.Parent = progressionFolder

local MicaEquipped = Instance.new("RemoteEvent")
MicaEquipped.Name = "MicaEquipped"
MicaEquipped.Parent = progressionFolder

local HornblendeUnlocked = Instance.new("RemoteEvent")
HornblendeUnlocked.Name = "HornblendeUnlocked"
HornblendeUnlocked.Parent = progressionFolder

local HornblendeEquipped = Instance.new("RemoteEvent")
HornblendeEquipped.Name = "HornblendeEquipped"
HornblendeEquipped.Parent = progressionFolder

local AugiteUnlocked = Instance.new("RemoteEvent")
AugiteUnlocked.Name = "AugiteUnlocked"
AugiteUnlocked.Parent = progressionFolder

local AugiteEquipped = Instance.new("RemoteEvent")
AugiteEquipped.Name = "AugiteEquipped"
AugiteEquipped.Parent = progressionFolder

local HyperstheneUnlocked = Instance.new("RemoteEvent")
HyperstheneUnlocked.Name = "HyperstheneUnlocked"
HyperstheneUnlocked.Parent = progressionFolder

local HyperstheneEquipped = Instance.new("RemoteEvent")
HyperstheneEquipped.Name = "HyperstheneEquipped"
HyperstheneEquipped.Parent = progressionFolder

local EnstatiteUnlocked = Instance.new("RemoteEvent")
EnstatiteUnlocked.Name = "EnstatiteUnlocked"
EnstatiteUnlocked.Parent = progressionFolder

local EnstatiteEquipped = Instance.new("RemoteEvent")
EnstatiteEquipped.Name = "EnstatiteEquipped"
EnstatiteEquipped.Parent = progressionFolder

local ForsteriteUnlocked = Instance.new("RemoteEvent")
ForsteriteUnlocked.Name = "ForsteriteUnlocked"
ForsteriteUnlocked.Parent = progressionFolder

local ForsteriteEquipped = Instance.new("RemoteEvent")
ForsteriteEquipped.Name = "ForsteriteEquipped"
ForsteriteEquipped.Parent = progressionFolder

local FayaliteUnlocked = Instance.new("RemoteEvent")
FayaliteUnlocked.Name = "FayaliteUnlocked"
FayaliteUnlocked.Parent = progressionFolder

local FayaliteEquipped = Instance.new("RemoteEvent")
FayaliteEquipped.Name = "FayaliteEquipped"
FayaliteEquipped.Parent = progressionFolder

local TephroiteUnlocked = Instance.new("RemoteEvent")
TephroiteUnlocked.Name = "TephroiteUnlocked"
TephroiteUnlocked.Parent = progressionFolder

local TephroiteEquipped = Instance.new("RemoteEvent")
TephroiteEquipped.Name = "TephroiteEquipped"
TephroiteEquipped.Parent = progressionFolder

local MonticelliteUnlocked = Instance.new("RemoteEvent")
MonticelliteUnlocked.Name = "MonticelliteUnlocked"
MonticelliteUnlocked.Parent = progressionFolder

local MonticelliteEquipped = Instance.new("RemoteEvent")
MonticelliteEquipped.Name = "MonticelliteEquipped"
MonticelliteEquipped.Parent = progressionFolder

local KirschsteiniteUnlocked = Instance.new("RemoteEvent")
KirschsteiniteUnlocked.Name = "KirschsteiniteUnlocked"
KirschsteiniteUnlocked.Parent = progressionFolder

local KirschsteiniteEquipped = Instance.new("RemoteEvent")
KirschsteiniteEquipped.Name = "KirschsteiniteEquipped"
KirschsteiniteEquipped.Parent = progressionFolder

local LarniteUnlocked = Instance.new("RemoteEvent")
LarniteUnlocked.Name = "LarniteUnlocked"
LarniteUnlocked.Parent = progressionFolder

local LarniteEquipped = Instance.new("RemoteEvent")
LarniteEquipped.Name = "LarniteEquipped"
LarniteEquipped.Parent = progressionFolder

local MerwiniteUnlocked = Instance.new("RemoteEvent")
MerwiniteUnlocked.Name = "MerwiniteUnlocked"
MerwiniteUnlocked.Parent = progressionFolder

local MerwiniteEquipped = Instance.new("RemoteEvent")
MerwiniteEquipped.Name = "MerwiniteEquipped"
MerwiniteEquipped.Parent = progressionFolder

local SpurriteUnlocked = Instance.new("RemoteEvent")
SpurriteUnlocked.Name = "SpurriteUnlocked"
SpurriteUnlocked.Parent = progressionFolder

local SpurriteEquipped = Instance.new("RemoteEvent")
SpurriteEquipped.Name = "SpurriteEquipped"
SpurriteEquipped.Parent = progressionFolder

local TilleyiteUnlocked = Instance.new("RemoteEvent")
TilleyiteUnlocked.Name = "TilleyiteUnlocked"
TilleyiteUnlocked.Parent = progressionFolder

local TilleyiteEquipped = Instance.new("RemoteEvent")
TilleyiteEquipped.Name = "TilleyiteEquipped"
TilleyiteEquipped.Parent = progressionFolder

local RankiniteUnlocked = Instance.new("RemoteEvent")
RankiniteUnlocked.Name = "RankiniteUnlocked"
RankiniteUnlocked.Parent = progressionFolder

local RankiniteEquipped = Instance.new("RemoteEvent")
RankiniteEquipped.Name = "RankiniteEquipped"
RankiniteEquipped.Parent = progressionFolder

local HatruriteUnlocked = Instance.new("RemoteEvent")
HatruriteUnlocked.Name = "HatruriteUnlocked"
HatruriteUnlocked.Parent = progressionFolder

local HatruriteEquipped = Instance.new("RemoteEvent")
HatruriteEquipped.Name = "HatruriteEquipped"
HatruriteEquipped.Parent = progressionFolder

local BredigiteUnlocked = Instance.new("RemoteEvent")
BredigiteUnlocked.Name = "BredigiteUnlocked"
BredigiteUnlocked.Parent = progressionFolder

local BredigiteEquipped = Instance.new("RemoteEvent")
BredigiteEquipped.Name = "BredigiteEquipped"
BredigiteEquipped.Parent = progressionFolder

local NagelschmidtiteUnlocked = Instance.new("RemoteEvent")
NagelschmidtiteUnlocked.Name = "NagelschmidtiteUnlocked"
NagelschmidtiteUnlocked.Parent = progressionFolder

local NagelschmidtiteEquipped = Instance.new("RemoteEvent")
NagelschmidtiteEquipped.Name = "NagelschmidtiteEquipped"
NagelschmidtiteEquipped.Parent = progressionFolder

local EllestaditeUnlocked = Instance.new("RemoteEvent")
EllestaditeUnlocked.Name = "EllestaditeUnlocked"
EllestaditeUnlocked.Parent = progressionFolder

local EllestaditeEquipped = Instance.new("RemoteEvent")
EllestaditeEquipped.Name = "EllestaditeEquipped"
EllestaditeEquipped.Parent = progressionFolder

local HydroxylellestaditeUnlocked = Instance.new("RemoteEvent")
HydroxylellestaditeUnlocked.Name = "HydroxylellestaditeUnlocked"
HydroxylellestaditeUnlocked.Parent = progressionFolder

local HydroxylellestaditeEquipped = Instance.new("RemoteEvent")
HydroxylellestaditeEquipped.Name = "HydroxylellestaditeEquipped"
HydroxylellestaditeEquipped.Parent = progressionFolder

local FluorellestaditeUnlocked = Instance.new("RemoteEvent")
FluorellestaditeUnlocked.Name = "FluorellestaditeUnlocked"
FluorellestaditeUnlocked.Parent = progressionFolder

local FluorellestaditeEquipped = Instance.new("RemoteEvent")
FluorellestaditeEquipped.Name = "FluorellestaditeEquipped"
FluorellestaditeEquipped.Parent = progressionFolder

local ChlorellestaditeUnlocked = Instance.new("RemoteEvent")
ChlorellestaditeUnlocked.Name = "ChlorellestaditeUnlocked"
ChlorellestaditeUnlocked.Parent = progressionFolder

local ChlorellestaditeEquipped = Instance.new("RemoteEvent")
ChlorellestaditeEquipped.Name = "ChlorellestaditeEquipped"
ChlorellestaditeEquipped.Parent = progressionFolder

local SulfatellestaditeUnlocked = Instance.new("RemoteEvent")
SulfatellestaditeUnlocked.Name = "SulfatellestaditeUnlocked"
SulfatellestaditeUnlocked.Parent = progressionFolder

local SulfatellestaditeEquipped = Instance.new("RemoteEvent")
SulfatellestaditeEquipped.Name = "SulfatellestaditeEquipped"
SulfatellestaditeEquipped.Parent = progressionFolder

local CarbapatiteUnlocked = Instance.new("RemoteEvent")
CarbapatiteUnlocked.Name = "CarbapatiteUnlocked"
CarbapatiteUnlocked.Parent = progressionFolder

local CarbapatiteEquipped = Instance.new("RemoteEvent")
CarbapatiteEquipped.Name = "CarbapatiteEquipped"
CarbapatiteEquipped.Parent = progressionFolder

local HydroxylapatiteUnlocked = Instance.new("RemoteEvent")
HydroxylapatiteUnlocked.Name = "HydroxylapatiteUnlocked"
HydroxylapatiteUnlocked.Parent = progressionFolder

local HydroxylapatiteEquipped = Instance.new("RemoteEvent")
HydroxylapatiteEquipped.Name = "HydroxylapatiteEquipped"
HydroxylapatiteEquipped.Parent = progressionFolder

local FluorapatiteUnlocked = Instance.new("RemoteEvent")
FluorapatiteUnlocked.Name = "FluorapatiteUnlocked"
FluorapatiteUnlocked.Parent = progressionFolder

local FluorapatiteEquipped = Instance.new("RemoteEvent")
FluorapatiteEquipped.Name = "FluorapatiteEquipped"
FluorapatiteEquipped.Parent = progressionFolder

local ChlorapatiteUnlocked = Instance.new("RemoteEvent")
ChlorapatiteUnlocked.Name = "ChlorapatiteUnlocked"
ChlorapatiteUnlocked.Parent = progressionFolder

local ChlorapatiteEquipped = Instance.new("RemoteEvent")
ChlorapatiteEquipped.Name = "ChlorapatiteEquipped"
ChlorapatiteEquipped.Parent = progressionFolder

local SulfatapatiteUnlocked = Instance.new("RemoteEvent")
SulfatapatiteUnlocked.Name = "SulfatapatiteUnlocked"
SulfatapatiteUnlocked.Parent = progressionFolder

local SulfatapatiteEquipped = Instance.new("RemoteEvent")
SulfatapatiteEquipped.Name = "SulfatapatiteEquipped"
SulfatapatiteEquipped.Parent = progressionFolder

local VanadateapatiteUnlocked = Instance.new("RemoteEvent")
VanadateapatiteUnlocked.Name = "VanadateapatiteUnlocked"
VanadateapatiteUnlocked.Parent = progressionFolder

local VanadateapatiteEquipped = Instance.new("RemoteEvent")
VanadateapatiteEquipped.Name = "VanadateapatiteEquipped"
VanadateapatiteEquipped.Parent = progressionFolder

local ArsenateapatiteUnlocked = Instance.new("RemoteEvent")
ArsenateapatiteUnlocked.Name = "ArsenateapatiteUnlocked"
ArsenateapatiteUnlocked.Parent = progressionFolder

local ArsenateapatiteEquipped = Instance.new("RemoteEvent")
ArsenateapatiteEquipped.Name = "ArsenateapatiteEquipped"
ArsenateapatiteEquipped.Parent = progressionFolder

local ChromateapatiteUnlocked = Instance.new("RemoteEvent")
ChromateapatiteUnlocked.Name = "ChromateapatiteUnlocked"
ChromateapatiteUnlocked.Parent = progressionFolder

local ChromateapatiteEquipped = Instance.new("RemoteEvent")
ChromateapatiteEquipped.Name = "ChromateapatiteEquipped"
ChromateapatiteEquipped.Parent = progressionFolder

local MolybdateapatiteUnlocked = Instance.new("RemoteEvent")
MolybdateapatiteUnlocked.Name = "MolybdateapatiteUnlocked"
MolybdateapatiteUnlocked.Parent = progressionFolder

local MolybdateapatiteEquipped = Instance.new("RemoteEvent")
MolybdateapatiteEquipped.Name = "MolybdateapatiteEquipped"
MolybdateapatiteEquipped.Parent = progressionFolder

local TungstateapatiteUnlocked = Instance.new("RemoteEvent")
TungstateapatiteUnlocked.Name = "TungstateapatiteUnlocked"
TungstateapatiteUnlocked.Parent = progressionFolder

local TungstateapatiteEquipped = Instance.new("RemoteEvent")
TungstateapatiteEquipped.Name = "TungstateapatiteEquipped"
TungstateapatiteEquipped.Parent = progressionFolder

local SelenateapatiteUnlocked = Instance.new("RemoteEvent")
SelenateapatiteUnlocked.Name = "SelenateapatiteUnlocked"
SelenateapatiteUnlocked.Parent = progressionFolder

local SelenateapatiteEquipped = Instance.new("RemoteEvent")
SelenateapatiteEquipped.Name = "SelenateapatiteEquipped"
SelenateapatiteEquipped.Parent = progressionFolder

local TellurateapatiteUnlocked = Instance.new("RemoteEvent")
TellurateapatiteUnlocked.Name = "TellurateapatiteUnlocked"
TellurateapatiteUnlocked.Parent = progressionFolder

local TellurateapatiteEquipped = Instance.new("RemoteEvent")
TellurateapatiteEquipped.Name = "TellurateapatiteEquipped"
TellurateapatiteEquipped.Parent = progressionFolder

local PolonateapatiteUnlocked = Instance.new("RemoteEvent")
PolonateapatiteUnlocked.Name = "PolonateapatiteUnlocked"
PolonateapatiteUnlocked.Parent = progressionFolder

local PolonateapatiteEquipped = Instance.new("RemoteEvent")
PolonateapatiteEquipped.Name = "PolonateapatiteEquipped"
PolonateapatiteEquipped.Parent = progressionFolder

local AstatateapatiteUnlocked = Instance.new("RemoteEvent")
AstatateapatiteUnlocked.Name = "AstatateapatiteUnlocked"
AstatateapatiteUnlocked.Parent = progressionFolder

local AstatateapatiteEquipped = Instance.new("RemoteEvent")
AstatateapatiteEquipped.Name = "AstatateapatiteEquipped"
AstatateapatiteEquipped.Parent = progressionFolder

local TennessateapatiteUnlocked = Instance.new("RemoteEvent")
TennessateapatiteUnlocked.Name = "TennessateapatiteUnlocked"
TennessateapatiteUnlocked.Parent = progressionFolder

local TennessateapatiteEquipped = Instance.new("RemoteEvent")
TennessateapatiteEquipped.Name = "TennessateapatiteEquipped"
TennessateapatiteEquipped.Parent = progressionFolder

local OganessonateapatiteUnlocked = Instance.new("RemoteEvent")
OganessonateapatiteUnlocked.Name = "OganessonateapatiteUnlocked"
OganessonateapatiteUnlocked.Parent = progressionFolder

local OganessonateapatiteEquipped = Instance.new("RemoteEvent")
OganessonateapatiteEquipped.Name = "OganessonateapatiteEquipped"
OganessonateapatiteEquipped.Parent = progressionFolder

print("[Progression Events] Created 200 Remote Events")

return progressionFolder