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

local CONTINENT_PANDARIA = 6

Reel.Enchantments = {
  { id = 4919, bonus = 150 }, -- +150 Temporary fishing lure
  { id = 265, bonus = 75 } -- +75 Temporary fishing lure
}

Reel.Lures = {
}

Reel.Hats = {
  { id = 88710, bonus = 5, enchantment = 4919 }, -- Nat's Hat
  { id = 117405, bonus = 10, enchantment = 4919 }, -- Nat's Drinking Hat
  { id = 33820, bonus = 5, enchantment = 265 }, -- Weather-Beaten Fishing Hat
  { id = 19972, bonus = 5 }, -- Lucky Fishing Hat
  { id = 93732, bonus = 5 }, -- Darkmoon Fishing Cap
  { id = 118380, bonus = 100 }, -- Hightfish Cap
  { id = 118393, bonus = 100 } -- Tentacled Hat
}

Reel.Rods = {
  { id = 133755, bonus = 60 }, 
  
  { id = 46337, bonus = 3 }, -- Staats' Fishing Pole / +3
  { id = 120163, bonus = 3 }, -- Thruk's Fishing Rod / +3

  { id = 6365, bonus = 5 }, -- Strong Fishing Pole / +5

  { id = 84660, bonus = 10 }, -- Pandaren Fishing Pole / +10

  { id = 6366, bonus = 15 }, -- Darkwood Fishing Pole / +15

  { id = 6367, bonus = 20 }, -- Big Iron Fishing Pole / +20
  { id = 25978, bonus = 20 }, -- Seth's Graphite Fishing Pole / +20
  { id = 19022, bonus = 20 }, -- Nat Pagle's Extreme Angler FC-5000 / +20

  { id = 45858, bonus = 25 }, -- Nat's Lucky Fishing Pole / +25

  { id = 45991, bonus = 30 }, -- Bone Fishing Pole / +30
  { id = 44050, bonus = 30 }, -- Mastercraft Kalu'ak Fishing Pole / +30
  { id = 45992, bonus = 30 }, -- Jeweled Fishing Pole / +30
  { id = 84661, bonus = 30 }, -- Dragon Fishing Pole / +30

  { id = 116826, bonus = 30 }, -- Draenic Fishing Pole / +30
  { id = 116825, bonus = 30 }, -- Savage Fishing Pole / +30

  { id = 19970, bonus = 40 }, -- Arcanite Fishing Pole / +40

  { id = 118381, bonus = 100 } -- Ephemeral Fishing Pole / +100
}

Reel.Buffs = {
  -- Ancient Pandaren Fishing Charm
  { id = 85973, buff = 125167, condition = function() return GetCurrentMapContinent() == CONTINENT_PANDARIA end },
}

-- Check whether an item is a fishing rod.
--
-- @returns True if the item is a fishing rod.
function Reel:IsFishingRod(itemID)
  for i, rod in ipairs(self.Rods) do
    if rod.id == itemID then
      return true
    end
  end
end

-- Check whether an item is a lure item.
--
-- @returns True if the item is a lure item.
function Reel:IsLureItem(itemID)
  for i, lure in ipairs(self.Lures) do
    if lure.id == itemID then
      return true
    end
  end
end

-- Check whether an item is a fishing buff item.
--
-- @returns True if the item is a fishing buff item.
function Reel:IsBuffItem(itemID)
  for i, buff in ipairs(self.Buffs) do
    if buff.id == itemID then
      return true
    end
  end
end

-- Check whether an item is a fishing hat.
--
-- @returns True if the item is a fishing hat.
function Reel:IsFishingHat(itemID)
  for i, hat in ipairs(self.Hats) do
    if hat.id == itemID then
      return true
    end
  end
end