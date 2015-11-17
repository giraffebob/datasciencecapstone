setwd("C:/Users/Bob/yelp_dataset_challenge_academic_dataset")
review <- readRDS("review.RDS")
business <- readRDS("business.RDS")
is.restaurant <- logical()
for (i in 1:length(business$categories)) {is.restaurant[i] <- any(grepl("Restaurant",business$categories[i]))}
restaurants <- business[is.restaurant,]
restaurants.edsd <- restaurants[restaurants$city=="Edinburgh"|restaurants$city=="Scottsdale",]
reviews.edsd <- merge(review,restaurants.edsd,by="business_id")
reviews.edsd <- reviews.edsd[,c("text","stars.x","business_id","city")]
names(reviews.edsd)[2] <- "stars"
rm(review,business)
edinburgh <- reviews.edsd[reviews.edsd$city=="Edinburgh",]
scottsdale <- reviews.edsd[reviews.edsd$city=="Scottsdale",]
f1 <- function(x) {if (x < 4) "poor"
else if (x==4) "good"
else "excellent"}
rating <- sapply(edinburgh$stars,f1)
rating <- as.factor(rating)