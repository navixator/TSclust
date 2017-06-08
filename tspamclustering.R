#Load necessary packages
library(cluster)
library(TSclust)

#Read original listings datatset
listings_dataset <- read.csv("~/C2C churn proposal/Time Series Clustering/listings_dataset.csv")
View(listings_dataset)

#Read normalized csv file
tsc_v1 <- read.csv("~/C2C churn proposal/Time Series Clustering/tsc_v1.csv")
View(tsc_v1)

#Dissimilarity matrix using Discrete wavelet transformation
dist.dwt <- diss.DWT(tsc_v1[,2:49])

#4 cluster solution
pam4cluster <- pam(dist.dwt, 4)

#5 cluster solution
pam5cluster <- pam(dist.dwt, 5)

#Merge clusters with original listings data frame
pamclust <- data.frame(listings_dataset, pam4cluster$clustering, pam5cluster$clustering)

#Write csv file
write.csv(pamclust, "~/C2C churn proposal/Time Series Clustering/tsc_v1output.csv")

#For comparison with k-means algorithm

#Calculate silhouette widths
sil.pam.4clust <- silhouette(pam4cluster$clustering, dist.dwt)
summary(sil.pam.4clust)
plot(sil.pam.4clust, col = 1:4, border = NA)

sil.pam.5clust <- silhouette(pam5cluster$clustering, dist.dwt)
summary(sil.pam.5clust)
plot(sil.pam.5clust, col = 1:5, border = NA)

