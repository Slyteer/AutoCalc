-- SkinCount.lua
-- @author Slyteer
-- @version 1.0
local addonName, AutoCalc = ...
LastTotal = 0
LastID = 0

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

function AutoCalc_OnLoad()
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
    print("For all /jobs")
  end
end
