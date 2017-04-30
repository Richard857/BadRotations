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

  This file extends the API of FireHack.
--]]

-- Object API.
local OBJECT_DISPLAY_ID_OFFSET = 0x40
local OBJECT_BOBBING_OFFSET = 0x1c4
local OBJECT_CREATOR_OFFSET = 0x30

-- Get the display ID of an object.
--
-- @returns The display ID of the object.
function GetObjectDisplayID(object)
  return ObjectDescriptor(object, OBJECT_DISPLAY_ID_OFFSET, Types.UInt)
end

-- Get the GUID of an object.
--
-- @returns The GUID of the object.
function GetObjectGUID(object)
  return tonumber(ObjectDescriptor(object, 0, Types.ULong))
end

-- Check whether or not the object is marked as bobbing.
--
-- @return True if the object is bobbing.
function IsObjectBobbing(object)
  return (ObjectField(object, OBJECT_BOBBING_OFFSET, Types.Byte) == 1)
end

-- Test whether an object is created/belongs to another object.
--
-- @return True if it's created by the other object.
function IsObjectCreatedBy(owner, object)
  return tonumber(ObjectDescriptor(object, OBJECT_CREATOR_OFFSET, Types.ULong)) == GetObjectGUID(owner)
end

-- Unit API.
local UNIT_DISPLAY_ID_OFFSET = 0x190

-- Get the display ID of a unit.
--
-- @return The display ID of the unit.
function GetUnitDisplayID(object)
  return ObjectDescriptor(object, UNIT_DISPLAY_ID_OFFSET, Types.UInt)
end
