
library(ggmap)
library(maptools)
library(maps)
library(rworldmap)
library(ggplot2)
library(gmt)

setwd("/Users/prakashchandraprodduturi/Downloads/Datasets/Tableau Visualizations/tableau projects")
unesco<-read.csv("UNESCO_2.csv")
summary(unesco)
str(unesco)

unesco_short<-unesco[,c(4,10,11)]
str(unesco_short)

library(tspmeta)

TSPunesco<-unesco_short
coords.df <- data.frame(long=TSPunesco$longitude, lat=TSPunesco$latitude)
coords.mx <- as.matrix(coords.df)
nrow(coords.df)
head(coords.mx)
dist.mx1<-matrix(data=NA,nrow=nrow(coords.df),ncol=nrow(coords.df))
for (j in 1:nrow(coords.df)){
  for (i in 1:nrow(coords.df)){
    dist.mx1[i,j]<-geodist(coords.mx[i,2],coords.mx[i,1],coords.mx[j,2],coords.mx[j,1], units="km")
}
}

str(tsp.ins)
head(tsp.ins$tsp_instance_euclidean_coords, head=2)
# Construct a TSP object
tsp.ins <- tsp_instance(coords.mx, dist.mx1)
tour <- run_solver(tsp.ins, method="2-opt")




methods <- c("nearest_insertion", "farthest_insertion",
             "cheapest_insertion", "arbitrary_insertion", "nn", "repetitive_nn",
             "2-opt")
tours <- sapply(methods, FUN = function(m) run_solver(tsp.ins, method = m), simplify = FALSE)
autoplot(tsp.ins, tours)


dotchart(c(sapply(tours, FUN = attr, "tour_length")),
         xlab = "Tour length (n=1031)", main="Heuristic Solutions vs. Exact (concorde)")

order_unesco<-head(tours$`2-opt`, n=1056)
write.xslx(order_unesco,"order_unesco")

#plots
mapWorld <- borders("world", colour="gray50", fill="gray50") # create a layer of borders
mp <- ggplot() +   mapWorld

#Now Layer the Unesco sites on top
mp <- mp+ geom_point(aes(x=visit.x, y=visit.y) ,color="blue", size=3) 
mp


autoplot(tsp.ins, tours$`2-opt`)
autoplot(tsp.ins, tours$farthest_insertion)
autoplot(tsp.ins, tours$nn)
autoplot(tsp.ins, tours$repetitive_nn)
autoplot(tsp.ins, tours$arbitrary_insertion)
autoplot(tsp.ins, tours$cheapest_insertion)

