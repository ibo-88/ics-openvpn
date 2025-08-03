-- Shop Remotes
-- Remote Events для системы магазина

local ReplicatedStorage = game:GetService("ReplicatedStorage")
local Remotes = ReplicatedStorage:WaitForChild("Remotes")

-- Создание папки для Remote Events магазина
local ShopRemotes = Instance.new("Folder")
ShopRemotes.Name = "Shop"
ShopRemotes.Parent = Remotes

-- Remote Events для магазина
local GetShopInfo = Instance.new("RemoteEvent")
GetShopInfo.Name = "GetShopInfo"
GetShopInfo.Parent = ShopRemotes

local GetAllShops = Instance.new("RemoteEvent")
GetAllShops.Name = "GetAllShops"
GetAllShops.Parent = ShopRemotes

local PurchaseItem = Instance.new("RemoteEvent")
PurchaseItem.Name = "PurchaseItem"
PurchaseItem.Parent = ShopRemotes

local GetDailyOffers = Instance.new("RemoteEvent")
GetDailyOffers.Name = "GetDailyOffers"
GetDailyOffers.Parent = ShopRemotes

local GetWeeklyOffers = Instance.new("RemoteEvent")
GetWeeklyOffers.Name = "GetWeeklyOffers"
GetWeeklyOffers.Parent = ShopRemotes

local GetSpecialOffers = Instance.new("RemoteEvent")
GetSpecialOffers.Name = "GetSpecialOffers"
GetSpecialOffers.Parent = ShopRemotes

local PurchaseDiscountedItem = Instance.new("RemoteEvent")
PurchaseDiscountedItem.Name = "PurchaseDiscountedItem"
PurchaseDiscountedItem.Parent = ShopRemotes

local PurchaseSpecialOffer = Instance.new("RemoteEvent")
PurchaseSpecialOffer.Name = "PurchaseSpecialOffer"
PurchaseSpecialOffer.Parent = ShopRemotes

local GetPlayerCurrency = Instance.new("RemoteEvent")
GetPlayerCurrency.Name = "GetPlayerCurrency"
GetPlayerCurrency.Parent = ShopRemotes

local GetPurchaseHistory = Instance.new("RemoteEvent")
GetPurchaseHistory.Name = "GetPurchaseHistory"
GetPurchaseHistory.Parent = ShopRemotes

local GetItemDetails = Instance.new("RemoteEvent")
GetItemDetails.Name = "GetItemDetails"
GetItemDetails.Parent = ShopRemotes

local GetShopCategories = Instance.new("RemoteEvent")
GetShopCategories.Name = "GetShopCategories"
GetShopCategories.Parent = ShopRemotes

local GetShopLevels = Instance.new("RemoteEvent")
GetShopLevels.Name = "GetShopLevels"
GetShopLevels.Parent = ShopRemotes

local GetOfferTimers = Instance.new("RemoteEvent")
GetOfferTimers.Name = "GetOfferTimers"
GetOfferTimers.Parent = ShopRemotes

local GetShopRecommendations = Instance.new("RemoteEvent")
GetShopRecommendations.Name = "GetShopRecommendations"
GetShopRecommendations.Parent = ShopRemotes

local GetShopStatistics = Instance.new("RemoteEvent")
GetShopStatistics.Name = "GetShopStatistics"
GetShopStatistics.Parent = ShopRemotes

local GetShopAchievements = Instance.new("RemoteEvent")
GetShopAchievements.Name = "GetShopAchievements"
GetShopAchievements.Parent = ShopRemotes

local GetShopLeaderboard = Instance.new("RemoteEvent")
GetShopLeaderboard.Name = "GetShopLeaderboard"
GetShopLeaderboard.Parent = ShopRemotes

local GetShopEvents = Instance.new("RemoteEvent")
GetShopEvents.Name = "GetShopEvents"
GetShopEvents.Parent = ShopRemotes

local GetShopRewards = Instance.new("RemoteEvent")
GetShopRewards.Name = "GetShopRewards"
GetShopRewards.Parent = ShopRemotes

local GetShopSettings = Instance.new("RemoteEvent")
GetShopSettings.Name = "GetShopSettings"
GetShopSettings.Parent = ShopRemotes

local UpdateShopSettings = Instance.new("RemoteEvent")
UpdateShopSettings.Name = "UpdateShopSettings"
UpdateShopSettings.Parent = ShopRemotes

print("[Shop Remotes] Shop Remote Events created successfully!")