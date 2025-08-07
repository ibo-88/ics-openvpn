-- CombatEvents.lua
-- Remote Events для боевой системы

local ReplicatedStorage = game:GetService("ReplicatedStorage")

-- Создание папки для Combat Remote Events
local combatFolder = Instance.new("Folder")
combatFolder.Name = "Combat"
combatFolder.Parent = ReplicatedStorage.Remotes

-- Remote Events для боевой системы
local Attack = Instance.new("RemoteEvent")
Attack.Name = "Attack"
Attack.Parent = combatFolder

local Damage = Instance.new("RemoteEvent")
Damage.Name = "Damage"
Damage.Parent = combatFolder

local Death = Instance.new("RemoteEvent")
Death.Name = "Death"
Death.Parent = combatFolder

local Respawn = Instance.new("RemoteEvent")
Respawn.Name = "Respawn"
Respawn.Parent = combatFolder

local UseAbility = Instance.new("RemoteEvent")
UseAbility.Name = "UseAbility"
UseAbility.Parent = combatFolder

local AbilityEffect = Instance.new("RemoteEvent")
AbilityEffect.Name = "AbilityEffect"
AbilityEffect.Parent = combatFolder

local Block = Instance.new("RemoteEvent")
Block.Name = "Block"
Block.Parent = combatFolder

local Dodge = Instance.new("RemoteEvent")
Dodge.Name = "Dodge"
Dodge.Parent = combatFolder

local CriticalHit = Instance.new("RemoteEvent")
CriticalHit.Name = "CriticalHit"
CriticalHit.Parent = combatFolder

local ComboAttack = Instance.new("RemoteEvent")
ComboAttack.Name = "ComboAttack"
ComboAttack.Parent = combatFolder

local WeaponSwitch = Instance.new("RemoteEvent")
WeaponSwitch.Name = "WeaponSwitch"
WeaponSwitch.Parent = combatFolder

local Reload = Instance.new("RemoteEvent")
Reload.Name = "Reload"
Reload.Parent = combatFolder

local Aim = Instance.new("RemoteEvent")
Aim.Name = "Aim"
Aim.Parent = combatFolder

local Shoot = Instance.new("RemoteEvent")
Shoot.Name = "Shoot"
Shoot.Parent = combatFolder

local ProjectileHit = Instance.new("RemoteEvent")
ProjectileHit.Name = "ProjectileHit"
ProjectileHit.Parent = combatFolder

local MeleeHit = Instance.new("RemoteEvent")
MeleeHit.Name = "MeleeHit"
MeleeHit.Parent = combatFolder

local RangedHit = Instance.new("RemoteEvent")
RangedHit.Name = "RangedHit"
RangedHit.Parent = combatFolder

local MagicCast = Instance.new("RemoteEvent")
MagicCast.Name = "MagicCast"
MagicCast.Parent = combatFolder

local MagicHit = Instance.new("RemoteEvent")
MagicHit.Name = "MagicHit"
MagicHit.Parent = combatFolder

local Heal = Instance.new("RemoteEvent")
Heal.Name = "Heal"
Heal.Parent = combatFolder

local Buff = Instance.new("RemoteEvent")
Buff.Name = "Buff"
Buff.Parent = combatFolder

local Debuff = Instance.new("RemoteEvent")
Debuff.Name = "Debuff"
Debuff.Parent = combatFolder

local StatusEffect = Instance.new("RemoteEvent")
StatusEffect.Name = "StatusEffect"
StatusEffect.Parent = combatFolder

local CombatStart = Instance.new("RemoteEvent")
CombatStart.Name = "CombatStart"
CombatStart.Parent = combatFolder

local CombatEnd = Instance.new("RemoteEvent")
CombatEnd.Name = "CombatEnd"
CombatEnd.Parent = combatFolder

local Victory = Instance.new("RemoteEvent")
Victory.Name = "Victory"
Victory.Parent = combatFolder

local Defeat = Instance.new("RemoteEvent")
Defeat.Name = "Defeat"
Defeat.Parent = combatFolder

print("[Combat Events] Created 25 Remote Events")

return combatFolder