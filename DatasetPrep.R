#Read csv file
c2c <- read.csv("~/C2C churn proposal/c2c_listings_only.csv")
View(c2c)

#create nth sequence. Here n = 48
ind = seq(48,nrow(c2c),48)

#Create separate data frame with only seller id as a column
c2ccol = data.frame(seller_id=c2c$seller_id[ind])
dim(c2ccol)

#Create a data frame, colnew, which has no of listings in c2c converted from rows to columns 
colnew = lapply(ind,function(x) c2c$no_of_listings[(x-47):x])
colnew = Reduce(rbind,colnew)
View(colnew)
dim(colnew)

#Bind seller_id and no_of_listings
c2ccol = cbind(c2ccol,colnew)
View(c2ccol)

#Determine class of year_mo
class(c2c$year_mo[1:48])

#In this case it is a factor - so convert it to character so it can be assigned as a column name
as.character(c2c$year_mo[1:48])
names(c2ccol)[2:49] = as.character(c2c$year_mo[1:48])

View(c2ccol)

#Write new data file
write.csv(c2ccol,"c2c_column_listings.csv",row.names=F)