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
