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

local UseLure = {}

local function IsFishingRodEnchanted()
  local hasMainHandEnchant, mainHandExpiration, mainHandCharges, _ = GetWeaponEnchantInfo()

  return hasMainHandEnchant
end

local function HasLureToApply()
  local headItemID = GetInventoryItemID("player", INVSLOT_HEAD)

  for i, hat in ipairs(Reel.Hats) do
    if hat.enchantment and hat.id == headItemID then
      local start, duration, enable = GetInventoryItemCooldown("player", INVSLOT_HEAD)
      
      if duration == 0 then
        return true
      end
    end
  end
end

function UseLure:IsApplicable()
  if not Reel.__isFishing and Reel:IsFishingRodEquipped() then
    if IsFishingRodEnchanted() then
      return false
    else
      return HasLureToApply()
    end
  else
    return false
  end
end

function UseLure:OnEnter()
  Reel:SetStatus("Applying lure")

  C_Timer.After(2, function()
      UseInventoryItem(INVSLOT_HEAD)
    end)
end

function UseLure:OnLeave()
end

Reel:AddState("UseLure", UseLure)