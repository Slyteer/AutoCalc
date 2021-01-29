
function tablelength(T)
  local count = 0
  for _ in pairs(T) do count = count + 1 end
  return count
end

function contains(table, val)
   for i=1,#table do
      if table[i] == val then
         return i
      end
   end
   return 0
end

function getPrices(itemiD,len)
  price = {}
  for i = 1,len do
    p = Auctionator.API.v1.GetAuctionPriceByItemID("AutoCalc", itemiD[i])
    price[i] = p*0.0001
  end
  return price
end
