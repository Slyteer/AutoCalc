-- AutoCalc.lua
-- @author Slyteer
-- @version 2.0
AutoCalc = LibStub("AceAddon-3.0"):NewAddon("AutoCalc", "AceConsole-3.0", "AceEvent-3.0")

skinItemsID = {172089,172097,172092,172094,172096}
fishItemsID = {173034,173035,173033,173036,173032,173037}
oreItemsID = {171828,171833,171832,171830,171829,171831}
herbItemsID = {169701,168586,168589,168583,170554,171315}
meatItemsID = {172054,172053,172055,179315,172052,179314}
foodItemsID = {172054,172053,172055,179315,172052,179314,173034,173035,173033,173036,173032,173037} -- meat & fish
jobsItemsID =  {}
for k,v in pairs(skinItemsID) do table.insert(jobsItemsID, v) end
for k,v in pairs(fishItemsID) do table.insert(jobsItemsID, v) end
for k,v in pairs(oreItemsID) do table.insert(jobsItemsID, v) end
for k,v in pairs(herbItemsID) do table.insert(jobsItemsID, v) end
for k,v in pairs(meatItemsID) do table.insert(jobsItemsID, v) end
LastTotal = 0
LastID = nil

function AutoCalc:OnInitialize()
  --self:initializeItemsinfos(jobsItemsID, #jobsItemsID)
  -- Slash Commands
  self:RegisterChatCommand("AutoCalc", "SlashCommand")
  self:RegisterChatCommand("autocalc", "SlashCommand")
  self:RegisterChatCommand("AC", "SlashCommand")
  self:RegisterChatCommand("skin", "skin")
  self:RegisterChatCommand("meat", "meat")
  self:RegisterChatCommand("fish", "fish")
  self:RegisterChatCommand("food", "food")
  self:RegisterChatCommand("ore", "ore")
  self:RegisterChatCommand("herb", "herb")
  self:RegisterChatCommand("jobs", "jobs")

end


-- Commands

function AutoCalc:SlashCommand(msg)
  if msg == "help" then
    self:Print("|cffffcc00Welcome to AutoCalc|r")
    self:Print("/AC OR /AutoCalc for the graphical interface")
    self:Print("/AC help OR /AutoCalc help for the help")
    self:Print("Here is a list of command for the resource you want to track")
    self:Print("Skins /skin")
    self:Print("Meats /meat")
    self:Print("Fishes /fish")
    self:Print("Fishes and meats /food")
    self:Print("Ores /ore")
    self:Print("Herbs /herb")
    self:Print("For all /jobs")
  end
end
--Redirection of SlashCommand
function AutoCalc:skin(msg)
  self:jobCount(skinItemsID,"skin")
end
function AutoCalc:meat(msg)
  self:jobCount(meatItemsID,"meat")
end
function AutoCalc:fish(msg)
  self:jobCount(fishItemsID,"fish")
end
function AutoCalc:food(msg)
  self:jobCount(foodItemsID,"food")
end
function AutoCalc:ore(msg)
  self:jobCount(oreItemsID,"ore")
end
function AutoCalc:herb(msg)
  self:jobCount(herbItemsID,"herb")
end
function AutoCalc:jobs(msg)
  self:jobCount(jobsItemsID,"jobs")
end


function AutoCalc:jobCount(itemsID,job)
  local len = #itemsID

  local prices = self:getPrices(itemsID, len)
  local count = {}
  local total = {}
  for i= 1,len do
    count[i] = 0
    total[i] = 0
  end
  local gains = 0

  for bagNum = 0, NUM_BAG_SLOTS do
    for containerNum = 1, C_Container.GetContainerNumSlots(bagNum) do
      local pos = self:contains(itemsID,C_Container.GetContainerItemID(bagNum, containerNum))
      if  (pos ~= 0) then
        local itemCount = C_Container.GetContainerItemInfo(bagNum,containerNum)["stackCount"]
        count[pos]=count[pos] + itemCount
      end
    end
  end
  for i = 1,len do
    total[i]=total[i] + (count[i]*price[i])
  end
  local count = 0
  for i = 1,len do
    self:itemInfos(itemsID[i], function(item,name)
      if item:IsItemDataCached() then
        count = count +1
      end
      self:Print(name)
      self:Print("    |cffffcc00", total[i],"|r gold")
      gains = gains + total[i]
    end)
    if count == len then
      self:endPrint(gains, job, LastID, LastTotal)
    end
  end


end

function AutoCalc:endPrint(gains, job)
  self:Print("You have |cffffcc00", gains,"|r gold in ", job)
  if LastID ~= job then
    LastID = job
    LastTotal = 0
  end
  self:Print("You gained |cffffcc00", gains-LastTotal,"|r Since last check")
  LastTotal = gains
end

-- Utils
function AutoCalc:itemInfos(itemID, resultCallback)
  local item = Item:CreateFromItemID(itemID)
  item:ContinueOnItemLoad(function()
    local name = item:GetItemLink()
    resultCallback(item,name)
end)
end



function AutoCalc:tablelength(T)
  local count = 0
  for _ in pairs(T) do count = count + 1 end
  return count
end

function AutoCalc:contains(table, val)
  for i=1,#table do
     if table[i] == val then
        return i
     end
  end
  return 0
end

function AutoCalc:getPrices(itemiD,len)
  price = {}
  for i = 1,len do
    p = Auctionator.API.v1.GetAuctionPriceByItemID("AutoCalc", itemiD[i])
    price[i] = p*0.0001
  end
  return price
end
