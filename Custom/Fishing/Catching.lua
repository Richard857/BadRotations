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

local Catching = {}

function Catching:IsApplicable()
  return Reel.__isFishing
end

function Catching:OnEnter()
  self.__bobber = nil
  Reel:SetStatus("钓鱼中")

  self.timer = C_Timer.NewTicker(.5, function()
      self:Tick()
    end, nil)
end

function Catching:Tick()
  if self.__bobber ~= nil then
    if IsObjectBobbing(self.__bobber) then
      ObjectInteract(self.__bobber)
    end
  else
    local bobber = Reel:GetBobber()

    if bobber then
      self.__bobber = bobber
    end
  end
end

function Catching:OnLeave()
  self.timer:Cancel()
end

Reel:AddState("Catching", Catching)