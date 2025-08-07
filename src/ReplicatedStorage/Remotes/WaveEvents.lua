-- WaveEvents.lua
-- Remote Events для системы волн и врагов

local ReplicatedStorage = game:GetService("ReplicatedStorage")

-- Создание папки для Wave Remote Events
local waveFolder = Instance.new("Folder")
waveFolder.Name = "Waves"
waveFolder.Parent = ReplicatedStorage.Remotes

-- Remote Events для волн
local WaveStart = Instance.new("RemoteEvent")
WaveStart.Name = "WaveStart"
WaveStart.Parent = waveFolder

local WaveEnd = Instance.new("RemoteEvent")
WaveEnd.Name = "WaveEnd"
WaveEnd.Parent = waveFolder

local WaveUpdate = Instance.new("RemoteEvent")
WaveUpdate.Name = "WaveUpdate"
WaveUpdate.Parent = waveFolder

local WaveProgress = Instance.new("RemoteEvent")
WaveProgress.Name = "WaveProgress"
WaveProgress.Parent = waveFolder

local WaveCountdown = Instance.new("RemoteEvent")
WaveCountdown.Name = "WaveCountdown"
WaveCountdown.Parent = waveFolder

local WaveComplete = Instance.new("RemoteEvent")
WaveComplete.Name = "WaveComplete"
WaveComplete.Parent = waveFolder

local WaveFailed = Instance.new("RemoteEvent")
WaveFailed.Name = "WaveFailed"
WaveFailed.Parent = waveFolder

local WaveReward = Instance.new("RemoteEvent")
WaveReward.Name = "WaveReward"
WaveReward.Parent = waveFolder

local WaveDifficulty = Instance.new("RemoteEvent")
WaveDifficulty.Name = "WaveDifficulty"
WaveDifficulty.Parent = waveFolder

local WaveInfo = Instance.new("RemoteEvent")
WaveInfo.Name = "WaveInfo"
WaveInfo.Parent = waveFolder

-- Remote Events для врагов
local EnemySpawn = Instance.new("RemoteEvent")
EnemySpawn.Name = "EnemySpawn"
EnemySpawn.Parent = waveFolder

local EnemyDeath = Instance.new("RemoteEvent")
EnemyDeath.Name = "EnemyDeath"
EnemyDeath.Parent = waveFolder

local EnemyDamage = Instance.new("RemoteEvent")
EnemyDamage.Name = "EnemyDamage"
EnemyDamage.Parent = waveFolder

local EnemyMove = Instance.new("RemoteEvent")
EnemyMove.Name = "EnemyMove"
EnemyMove.Parent = waveFolder

local EnemyAttack = Instance.new("RemoteEvent")
EnemyAttack.Name = "EnemyAttack"
EnemyAttack.Parent = waveFolder

local EnemyAbility = Instance.new("RemoteEvent")
EnemyAbility.Name = "EnemyAbility"
EnemyAbility.Parent = waveFolder

local EnemyTarget = Instance.new("RemoteEvent")
EnemyTarget.Name = "EnemyTarget"
EnemyTarget.Parent = waveFolder

local EnemyStunned = Instance.new("RemoteEvent")
EnemyStunned.Name = "EnemyStunned"
EnemyStunned.Parent = waveFolder

local EnemyFrozen = Instance.new("RemoteEvent")
EnemyFrozen.Name = "EnemyFrozen"
EnemyFrozen.Parent = waveFolder

local EnemyBurned = Instance.new("RemoteEvent")
EnemyBurned.Name = "EnemyBurned"
EnemyBurned.Parent = waveFolder

local EnemyPoisoned = Instance.new("RemoteEvent")
EnemyPoisoned.Name = "EnemyPoisoned"
EnemyPoisoned.Parent = waveFolder

local EnemySlowed = Instance.new("RemoteEvent")
EnemySlowed.Name = "EnemySlowed"
EnemySlowed.Parent = waveFolder

local EnemySpeedUp = Instance.new("RemoteEvent")
EnemySpeedUp.Name = "EnemySpeedUp"
EnemySpeedUp.Parent = waveFolder

local EnemyHeal = Instance.new("RemoteEvent")
EnemyHeal.Name = "EnemyHeal"
EnemyHeal.Parent = waveFolder

local EnemyShield = Instance.new("RemoteEvent")
EnemyShield.Name = "EnemyShield"
EnemyShield.Parent = waveFolder

local EnemyRage = Instance.new("RemoteEvent")
EnemyRage.Name = "EnemyRage"
EnemyRage.Parent = waveFolder

local EnemyBerserk = Instance.new("RemoteEvent")
EnemyBerserk.Name = "EnemyBerserk"
EnemyBerserk.Parent = waveFolder

local EnemyStealth = Instance.new("RemoteEvent")
EnemyStealth.Name = "EnemyStealth"
EnemyStealth.Parent = waveFolder

local EnemyTeleport = Instance.new("RemoteEvent")
EnemyTeleport.Name = "EnemyTeleport"
EnemyTeleport.Parent = waveFolder

local EnemySummon = Instance.new("RemoteEvent")
EnemySummon.Name = "EnemySummon"
EnemySummon.Parent = waveFolder

local EnemyTransform = Instance.new("RemoteEvent")
EnemyTransform.Name = "EnemyTransform"
EnemyTransform.Parent = waveFolder

local EnemySplit = Instance.new("RemoteEvent")
EnemySplit.Name = "EnemySplit"
EnemySplit.Parent = waveFolder

local EnemyMerge = Instance.new("RemoteEvent")
EnemyMerge.Name = "EnemyMerge"
EnemyMerge.Parent = waveFolder

local EnemyEvolve = Instance.new("RemoteEvent")
EnemyEvolve.Name = "EnemyEvolve"
EnemyEvolve.Parent = waveFolder

local EnemyBoss = Instance.new("RemoteEvent")
EnemyBoss.Name = "EnemyBoss"
EnemyBoss.Parent = waveFolder

local BossPhase = Instance.new("RemoteEvent")
BossPhase.Name = "BossPhase"
BossPhase.Parent = waveFolder

local BossUltimate = Instance.new("RemoteEvent")
BossUltimate.Name = "BossUltimate"
BossUltimate.Parent = waveFolder

local BossDefeated = Instance.new("RemoteEvent")
BossDefeated.Name = "BossDefeated"
BossDefeated.Parent = waveFolder

local EnemyCount = Instance.new("RemoteEvent")
EnemyCount.Name = "EnemyCount"
EnemyCount.Parent = waveFolder

local EnemyTypes = Instance.new("RemoteEvent")
EnemyTypes.Name = "EnemyTypes"
EnemyTypes.Parent = waveFolder

local EnemyInfo = Instance.new("RemoteEvent")
EnemyInfo.Name = "EnemyInfo"
EnemyInfo.Parent = waveFolder

local EnemyHealth = Instance.new("RemoteEvent")
EnemyHealth.Name = "EnemyHealth"
EnemyHealth.Parent = waveFolder

local EnemyArmor = Instance.new("RemoteEvent")
EnemyArmor.Name = "EnemyArmor"
EnemyArmor.Parent = waveFolder

local EnemySpeed = Instance.new("RemoteEvent")
EnemySpeed.Name = "EnemySpeed"
EnemySpeed.Parent = waveFolder

local EnemyDamage = Instance.new("RemoteEvent")
EnemyDamage.Name = "EnemyDamage"
EnemyDamage.Parent = waveFolder

print("[Wave Events] Created 45 Remote Events")

return waveFolder