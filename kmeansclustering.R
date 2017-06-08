#Load necessary packages
library(cluster)
library(TSclust)

#Read original listings datatset
listings_dataset <- read.csv("~/C2C churn proposal/Time Series Clustering/listings_dataset.csv")
View(listings_dataset)

#Read normalized csv file
kmv1 <- read.csv("~/C2C churn proposal/Time Series Clustering/kmv1.csv")
View(kmv1)

#4 cluster k-means solution
km4cluster <- kmeans(kmv1[2:49], 4)

#5 cluster k-means solution
km5cluster <- kmeans(kmv1[,2:49], 5)

#Merge clusters with data frame
kmclust <- data.frame(listings_dataset, km4cluster$cluster, km5cluster$cluster)

#Write csv file
write.csv(kmclust, "~/C2C churn proposal/Time Series Clustering/kmv1output.csv")

#For comparison with 4-cluster pam algorithm
#Calculate Euclidean distance
dist.eucl <- dist(kmv1[,2:49], method = "euclidean")

#Calculate silhouette widths
sil.km.4clust <- silhouette(km4cluster$cluster, dist.eucl)
summary(sil.km.4clust)
plot(sil.km.4clust, col = 1:4, border = NA)

sil.km.5clust <- silhouette(km5cluster$cluster, dist.eucl)
summary(sil.km.5clust)
plot(sil.km.5clust, col = 1:5, border = NA)

