-- SkinCount.lua
-- @author Slyteer
-- @version 1.0
local addonName, AutoCalc = ...
LastTotal = 0
LastID = 0
skinItemID = {172089,172097,172092,172094,172096}
fishItemID = {173034,173035,173033,173036,173032,173037}
mineItemID = {171828,171833,171832,171830,171829,171831}
herbItemID = {169701,168586,168589,168583,170554,171315}
meatItemID = {172054,172053,172055,179315,172052,179314}
foodItemID = {172054,172053,172055,179315,172052,179314,173034,173035,173033,173036,173032,173037} -- meat & fish
jobsItemID =  {}
for k,v in pairs(skinItemID) do table.insert(jobsItemID, v) end
for k,v in pairs(fishItemID) do table.insert(jobsItemID, v) end
for k,v in pairs(mineItemID) do table.insert(jobsItemID, v) end
for k,v in pairs(herbItemID) do table.insert(jobsItemID, v) end
for k,v in pairs(meatItemID) do table.insert(jobsItemID, v) end

function tablelength(T)
  local count = 0
  for _ in pairs(T) do count = count + 1 end
  return count
end




local function contains(table, val)
   for i=1,#table do
      if table[i] == val then
         return i
      end
   end
   return 0
end

local function getPrices(itemiD,len)
  price = {}
  for i = 1,len do
    p = Auctionator.API.v1.GetAuctionPriceByItemID("AutoCalc", itemiD[i])
    price[i] = p*0.0001
  end
  return price
end
function switch (job)
  local itemID
  if job == "skin" then
    itemID = skinItemID
  elseif  job == "fish" then
    itemID = fishItemID
  elseif  job == "mine" then
    itemID = mineItemID
  elseif  job == "herb" then
    itemID = herbItemID
  elseif  job == "meat" then
    itemID = meatItemID
  elseif  job == "food" then
    itemID = foodItemID
  elseif  job == "jobs" then
    itemID = jobsItemID

  else
    return 0
  end
  jobCount(itemID)
  return 1
end
function jobCount(itemID)
  local len = table.getn(itemID)
  local price = getPrices(itemID, len)
  local count = {}
  local total = {}
  for i= 1,len do
    count[i] = 0
    total[i] = 0
  end

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
  for i = 1,len do
    total[i]=total[i] + (count[i]*price[i])
  end
  for i = 1,len do
    print("|cff00ccff",GetItemInfo(itemID[i]), "|r : |cffffcc00", total[i],"|r gold")
    winwin = winwin + total[i]
  end
  print("You have |cffffcc00", winwin,"|r gold in skin")
  if LastID ~= itemID[1] then
    LastID = itemID[1]
    LastTotal = 0
  end
  print("You gained |cffffcc00", winwin-LastTotal,"|r Since last check")
  LastTotal = winwin
end
SLASH_FISH1 = "/fish"
SlashCmdList["FISH"] = function(msg)
  switch("fish")
end
SLASH_SKIN1 = "/skin"
SlashCmdList["SKIN"] = function(msg)
  switch("skin")
end
SLASH_MINE1 = "/mine"
SlashCmdList["MINE"] = function(msg)
  switch("mine")
end
SLASH_HERB1 = "/herb"
SlashCmdList["HERB"] = function(msg)
  switch("herb")
end
SLASH_MEAT1 = "/meat"
SlashCmdList["MEAT"] = function(msg)
  switch("meat")
end
SLASH_FOOD1 = "/food"
SlashCmdList["FOOD"] = function(msg)
  switch("food")
end
SLASH_JOBS1 = "/jobs"
SlashCmdList["JOBS"] = function(msg)
  switch("jobs")
end

SLASH_HELP1, SLASH_HELP2 = "/AC", "/AutoCalc"
SlashCmdList["HELP"] = function(msg)
  print("|cffffcc00Welcome to AutoCalc|r")
  print("Where is a list of command for the resource you want to track")
  print("Skins /skin")
  print("Meats /meat")
  print("Fishes /fish")
  print("Fishes and meats /food")
  print("Ores /mine")
  print("Herbs /herb")
end
