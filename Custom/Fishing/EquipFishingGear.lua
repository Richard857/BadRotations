--[[
  Copyright (c) 2014, drizz

  Permission to use, copy, modify, and/or distribute this software for any
  purpose with or without fee is hereby granted, provided that the above
  copyright notice and this permission notice appear in all copies.

  THE SOFTWARE IS PROVIDED "AS IS" AND THE AUTHOR DISCLAIMS ALL WARRANTIES
  WITH REGARD TO THIS SOFTWARE INCLUDING ALL IMPLIED WARRANTIES OF
  MERCHANTABILITY AND FITNESS. IN NO EVENT SHALL THE AUTHOR BE LIABLE FOR
  ANY SPECIAL, DIRECT, INDIRECT, OR CONSEQUENTIAL DAMAGES OR ANY DAMAGES
  WHATSOEVER RESULTING FROM LOSS OF USE, DATA OR PROFITS, WHETHER IN AN
  ACTION OF CONTRACT, NEGLIGENCE OR OTHER TORTIOUS ACTION, ARISING OUT OF
  OR IN CONNECTION WITH THE USE OR PERFORMANCE OF THIS SOFTWARE.
--]]

local EquipFishingGear = {}

-- Pick up an item from the inventory or from the bags based on item ID.
--
-- @returns True if the item was found.
local function PickupPlayerItem(itemID)
  local currentItemID = 0

  -- Look through the player inventory.
  for i = INVSLOT_FIRST_EQUIPPED, INVSLOT_LAST_EQUIPPED do
    currentItemID = GetInventoryItemID("player", i)

    if currentItemID == itemID then
      PickupInventoryItem(i)

      return true
    end
  end

  -- Look through the players bags.
  for i = 1, NUM_BAG_SLOTS do
    for j = 1, GetContainerNumSlots(i) do
      currentItemID = GetContainerItemID(i, j)

      if currentItemID == itemID then
        PickupContainerItem(i, j)

        return true
      end
    end
  end
end

-- Get the skill bonus provided by an enchantment.
--
-- @returns The skill bonus.
local function GetEnchantmentBonus(enchantmentID)
  for i, enchant in ipairs(Reel.Enchantments) do
    if enchant.id == enchantmentID then
      return enchant.bonus
    end
  end

  return 0
end

-- Get the total fishing hat bonus.
--
-- @returns The total fishing hat bonus.
local function GetFishingHatBonus(itemID)
  local hat = nil

  for i, h in ipairs(Reel.Hats) do
    if h.id == itemID then hat = h; break end
  end

  local bonus = hat.bonus

  if hat.enchantment then
    bonus = bonus + GetEnchantmentBonus(hat.enchantment)
  end

  return bonus
end

-- Get the best fishing hat (the one that provides the highest bonus).
--
-- @returns The ID of the fishing hat.
local function GetBestFishingHat()
  local bestBonus = 0
  local bestHat = 0
  local bonus = 0

  for i, hat in ipairs(Reel.__equipment.hats) do
    bonus = GetFishingHatBonus(hat)

    if bonus > bestBonus then
      bestBonus = bonus
      bestHat = hat
    end
  end

  return bestHat
end

-- Get the fishing rod bonus.
--
-- @returns The fishing rod bonus.
local function GetFishingRodBonus(itemID)
  for i, rod in ipairs(Reel.Rods) do
    if rod.id == itemID then
      return rod.bonus
    end
  end
end

-- Get the best fishing rod.
--
-- @retusn The ID of the fishing rod.
local function GetBestFishingRod()
  local bonus = 0
  local bestRod = 0
  local bestBonus = 0

  for i, rod in ipairs(Reel.__equipment.rods) do
    bonus = GetFishingRodBonus(rod)

    if bonus > bestBonus then
      bestBonus = bonus
      bestRod = rod
    end
  end

  return bestRod
end

local function EquipCursorItem()
  AutoEquipCursorItem()

  if StaticPopup1Button1:IsVisible() then
    -- This might be destructive as the popup may not actually be "make this item non-tradeable"
    StaticPopup1Button1:Click("LeftButton")
  end
end

function EquipFishingGear:IsApplicable()
  if Reel.__isFishing then
    return false
  end

  if Reel:GetNumFishingRods() > 0 and not Reel:IsFishingRodEquipped() then
    return true
  end

  if Reel:GetNumFishingHats() > 0 and not Reel:IsFishingHat(GetInventoryItemID("player", INVSLOT_HEAD)) then
    return true
  end
end

function EquipFishingGear:OnEnter()
  Reel:SetStatus("equipping fishing gear")

  local fishingRodItemID = GetBestFishingRod()

  if fishingRodItemID and PickupPlayerItem(fishingRodItemID) then
    EquipCursorItem()
  end

  local fishingHatItemID = GetBestFishingHat()

  if fishingHatItemID and PickupPlayerItem(fishingHatItemID) then
    EquipCursorItem()
  end
end

function EquipFishingGear:OnLeave()
end

Reel:AddState("EquipFishingGear", EquipFishingGear)