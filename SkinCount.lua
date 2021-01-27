-- SkinCount.lua
-- @author Slyteer
-- @version 0.1
local addonName, AutoCalc = ...
LastTotal = 0
local function contains(table, val)
   for i=1,#table do
      if table[i] == val then
         return i
      end
   end
   return 0
end

local function getPrices(itemiD)
  price = {}
  for i = 1,5 do
    p = Auctionator.API.v1.GetAuctionPriceByItemID("SkinCount", itemiD[i])
    price[i] = p*0.0001
  end
  return price
end
function skinCount()
  local name ={"CUIR DESOLE", "PEAU CRUELLE LOURDE", "OS BLAFARD", "PEAU CRUELLE", "CUIR DESOLE LOURD"}
  local itemID = {172089,172097,172092,172094,172096}
  local price = getPrices(itemID)
  local count = {0,0,0,0,0}
  local total = {0,0,0,0,0}
  local winwin = 0
  for i = 0, NUM_BAG_SLOTS do
    for z = 1, GetContainerNumSlots(i) do
      local pos = contains(itemID, GetContainerItemID(i, z))
      if  (pos ~= 0) then
        local _,itemCount = GetContainerItemInfo(i,z)
        count[pos]=count[pos] + itemCount
      end
    end
  end
  for i = 1,5 do
    total[i]=total[i] + (count[i]*price[i])
  end
  for i = 1,5 do
    print("|cff00ccff",name[i], "|r : |cffffcc00", total[i],"|r gold")
    winwin = winwin + total[i]
  end
  print("You have |cffffcc00", winwin,"|r gold in skin")
  print("You gained |cffffcc00", winwin-LastTotal,"|r Since last check")
  LastTotal = winwin
end

SLASH_SKIN1 = "/skin"
SlashCmdList["SKIN"] = function(msg)
  skinCount()
end
