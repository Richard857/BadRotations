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

Reel = {
  __frame = nil,
  __timer = nil,
  __bobber = nil,
  __isRunning = false, -- Reel is activated.
  __isFishing = false, -- Is actively channeling the fishing spell.
  __fishingSpellID = 0,
  __fishingSpellBookIndex = 0,
  __currentState,
  __states = {},
  __equipment = {
    rods = {},
    hats = {},
    buffs = {},
    lures = {}
  },
}

if not Reel_Options then
  Reel_Options = {}
end

-- Constants.
local BOBBER_DISPLAY_ID = 668
local CHANNELED_FISHING_SPELL_ID = 131476
local CHANNELED_FISHING_SPELL_BUFFED_ID = 131490

-- Delegate spell events, such as start fishing, stop fishing, etc.
local function HandleOnEvent(self, event, ...)
  if event == "UNIT_SPELLCAST_CHANNEL_START" then
    local unitID, spell, rank, lineID, spellID = ...

    if unitID == "player" and (spellID == CHANNELED_FISHING_SPELL_ID or spellID == CHANNELED_FISHING_SPELL_BUFFED_ID) then
      Reel:FishingStarted()
    end
  elseif event == "UNIT_SPELLCAST_CHANNEL_STOP" then
    local unitID, spell, rank, lineID, spellID = ...

    if unitID == "player" and (spellID == CHANNELED_FISHING_SPELL_ID or spellID == CHANNELED_FISHING_SPELL_BUFFED_ID) then
      Reel:FishingStopped()
    end
  elseif event == "UNIT_SPELLCAST_FAILED" then
    local unitID, spell, rank, lineID, spellID = ...

    if unitID == "player" and (spellID == CHANNELED_FISHING_SPELL_ID or spellID == CHANNELED_FISHING_SPELL_BUFFED_ID) then
      Reel:FishingFailed()
    end
  elseif event == "BAG_UPDATE" then
    -- TODO: Change it to only update the affected bag.
    Reel:UpdateEquipment()
  elseif event == "LOOT_CLOSED" then
    Reel:LootClosed()
  elseif event == "PLAYER_ENTERING_WORLD" then
    Reel:Load()
  end
end

-- Used for caching owned items (rods, buffs, lure, ...) for faster lookups.
local function CacheContainerItems(container)
  local itemID = 0
  local equipment = Reel.__equipment

  for i = 1, GetContainerNumSlots(container) do
    itemID = GetContainerItemID(container, i)

    -- Cache fishing rods.
    if Reel:IsFishingRod(itemID) then 
      table.insert(equipment.rods, 1, itemID)
    end

    -- Cache lure items.
    if Reel:IsLureItem(itemID) then
      table.insert(equipment.lures, 1, itemID)
    end

    -- Cache buff items.
    if Reel:IsBuffItem(itemID) then
      table.insert(equipment.buffs, 1, itemID)
    end

    -- Cache fishing hats.
    if Reel:IsFishingHat(itemID) then
      table.insert(equipment.hats, 1, itemID)
    end
  end
end

local function CacheInventoryItems()
  local itemID = GetInventoryItemID("player", INVSLOT_MAINHAND)

  if Reel:IsFishingRod(itemID) then
    table.insert(Reel.__equipment.rods, 1, itemID)
  end

  itemID = GetInventoryItemID("player", INVSLOT_HEAD)

  if Reel:IsFishingHat(itemID) then
    table.insert(Reel.__equipment.hats, 1, itemID)
  end
end

local __firehackDetected = false

local function FireHackIsDetected()
  if __firehackDetected then
    return __firehackDetected
  else
    if GetFireHackVersion then
      __firehackDetected = true
    end

    return __firehackDetected
  end
end

-- Initializes the addon. Called when the addon is loaded.
function Reel:Initialize(frame)
  self.__frame = frame

  frame:SetScript("OnEvent", HandleOnEvent)
  frame:RegisterEvent("BAG_UPDATE")
  frame:RegisterEvent("LOOT_CLOSED")
  frame:RegisterEvent("PLAYER_ENTERING_WORLD")
  frame:RegisterEvent("UNIT_SPELLCAST_CHANNEL_START")
  frame:RegisterEvent("UNIT_SPELLCAST_CHANNEL_STOP")
  frame:RegisterEvent("UNIT_SPELLCAST_FAILED")
end

-- Caches information like fishing rods in bags, buff items in bags, etc. 
-- Called when the player is entering the world.
function Reel:Load()
  self.__fishingSpellID = self:GetFishingSpellID()
  self.__fishingSpellBookIndex = self:GetFishingSpellBookIndex()

  self:UpdateEquipment()
end

-- Updates the cached information about rods, hats, etc. currently being
-- carried.
function Reel:UpdateEquipment()
  -- Reset the equipment cache.
  self.__equipment = {
    rods = {},
    hats = {},
    buffs = {},
    lures = {}
  }

  -- Re-cache everything.
  CacheInventoryItems()

  for i = 1, NUM_BAG_SLOTS do
    CacheContainerItems(i)
  end
end

-- Get a list of cached equipment.
--
-- @returns Table with cached equipment.
function Reel:GetEquipment()
  return self.__equipment
end

-- Count the number of cached fishing rods.
--
-- @returns The number of fishing rods.
function Reel:GetNumFishingRods()
  return #self.__equipment.rods
end

-- Count the number of cached lure items.
--
-- @returns The number of lure items.
function Reel:GetNumLureItems()
  return #self.__equipment.lures
end

-- Count the number of cached fishing hats.
--
-- @returns The number of fishing hats.
function Reel:GetNumFishingHats()
  return #self.__equipment.hats
end

-- Adds a state to the state machine.
function Reel:AddState(name, state)
  state.name = name
  table.insert(self.__states, 1, state)

  if Reel_Options.Debug then
    self:PrintMessage("Added state with name \"%s\"", name)
  end
end

-- Remove a state from the state machine.
--
-- @returns True if the state was removed.
function Reel:RemoveState(name)
  for key, value in ipairs(self.States) do
    if value.name == name then
      table.remove(self.__states, key)

      return true
    end
  end
end

-- Run the state machine.
function Reel:Run()
  if not self.__isRunning then
    return
  end

  local nextState = nil

  for index, state in pairs(self.__states) do
    if state:IsApplicable() then nextState = state end
  end

  if self.__currentState and self.__currentState ~= nextState then
    self.__currentState:OnLeave()
  end

  if nextState and nextState ~= self.__currentState then
    nextState:OnEnter()
  end

  self.__currentState = nextState
end

-- Stop running.
function Reel:Stop()
  if self.__isRunning then
    self.__frame:Hide()
    self:Disable()
    SpellStopCasting()
  end
end

-- Figure out whether the player currently has a fishing rod equipped.
--
-- @returns True if the player has a fishing rod equipped.
function Reel:IsFishingRodEquipped()
  local currentWeaponID = GetInventoryItemID("player", INVSLOT_MAINHAND)

  return self:IsFishingRod(currentWeaponID)
end

-- Figure out the spell ID for fishing.
-- This works regardless of the clients localization and fishing rank.
--
-- @returns The fishing spell ID.
function Reel:GetFishingSpellID()
  local fishingSpellIndex = self:GetFishingSpellBookIndex()

  if fishingSpellIndex then
    local skillType, spellID = GetSpellBookItemInfo(fishingSpellIndex, BOOKTYPE_PROFESSION)

    return spellID
  else
    self:PrintMessage("找不到钓鱼这个专业,你确定你有学这个专业吗？")
  end
end

function Reel:SetStatus(status)
  ReelStatusText:SetText(format("自动 %s …", status))
end

-- Figure out the fishing spellbook index.
--
-- @returns The fishing spellbook index.
function Reel:GetFishingSpellBookIndex()
  local fishingProfessionIndex = select(4, GetProfessions())
  local fishingButtonID = 1 -- The index of the button with the fishing spell.

  if fishingProfessionIndex then
    local spellOffset = select(6, GetProfessionInfo(fishingProfessionIndex))

    return fishingButtonID + spellOffset
  end
end

-- Enables Reel.
--
-- @returns True, since Reel is enabled.
function Reel:Enable()
  self.__isRunning = true

  return self.__isRunning
end

-- Disables Reel.
--
-- @returns False, since Reel is disabled.
function Reel:Disable()
  self.__isRunning = false
  self.__isFishing = false

  if self.__currentState then
    self.__currentState:OnLeave()
    self.__currentState = nil
  end

  self.__frame:Hide()

  return self.__isRunning
end

-- Toggles the fishing state.
--
-- @returns True if Reel is enabled.
function Reel:Toggle()
  if self.__isRunning then
    return Enable()
  else
    return Disable()
  end
end

-- Start fishing by casting the fishing spell.
function Reel:StartFishing()
  CastSpell(self.__fishingSpellBookIndex, BOOKTYPE_PROFESSION)
end

-- Prints a formatted message.
function Reel:PrintMessage(message, ...)
  DEFAULT_CHAT_FRAME:AddMessage(format("[Reel] %s", format(message, ...)))
end

local fishingAttempts = 0

-- Called when the player starts fishing.
function Reel:FishingStarted()
  if not self.__isRunning and FireHackIsDetected() then
    self.__frame:Show()
    self:Enable()
  end
  
  fishingAttempts = 0
  self.__isFishing = true
end

-- Called when the player stops fishing.
function Reel:FishingStopped()
  if self.__isRunning then
    self.__isFishing = false
  end
end

-- Called when the player tries to start fishing, but fails.
function Reel:FishingFailed()
  if self.__isRunning then
    fishingAttempts = fishingAttempts + 1

    if fishingAttempts >= 3 then
      self:PrintMessage("Fishing failed. Giving up.")
      self.__isFishing = false
      self:Disable()

      fishingAttempts = 0
    else
      self:PrintMessage("Fishing failed, retrying.")

      C_Timer.After(.1, function()
          if Reel.__isRunning then
            self:StartFishing()
          end
        end)
    end
  end
end

-- Called when the loot window is closed.
function Reel:LootClosed()
  if self.__isRunning then
    -- …
  end
end

-- Get a pointer to the fishing bobber.
--
-- @returns Pointer to the players bobber.
function Reel:GetBobber()
  local bobber = nil

  for index = 1, ObjectCount() do
    object = ObjectWithIndex(index)

    if GetObjectDisplayID(object) == BOBBER_DISPLAY_ID then
      if IsObjectCreatedBy("player", object) then
        bobber = object

        break
      end
    end
  end

  return bobber
end