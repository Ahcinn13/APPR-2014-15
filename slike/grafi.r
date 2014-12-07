pdf("slike/grafi.pdf")

year.place <- paste(doping.ZOI$Year, doping.ZOI$Place, sep="-")


barplot(table(year.place), beside = TRUE, main = "DOPINŠKI PRIMERI NA POLETNIH OLIMPIJSKH IGRAH", 
        xlab="LETO IN KRAJ OLIMPIJSKIH IGER", cex.names = 0.5, ylab= "število dopinških primerov",
        col = c("lightblue", "mistyrose", "lightcyan","lavender", "cornsilk"), xlim=c(0,9))



year.place1 <- paste(doping.POI$Year, doping.POI$Place, sep="-")

barplot(table(doping.POI$Year), beside = TRUE, main = "DOPINŠKI PRIMERI NA POLETNIH OLIMPIJSKH IGRAH", 
        xlab="LETO OLIMPIJSKIH IGER", cex.names = 0.5, ylab= "število dopinških primerov",
        col = c("lightblue", "mistyrose", "lightcyan","lavender", "cornsilk"), xlim=c(0,13))


barplot(c(length(gold.medals$Athlete),length(silver.medals$Athlete), length(bronze.medals$Athlete)), 
        beside = TRUE, main = "ODVZETE OLIMPIJSKE MEDALJE", 
        names.arg = c("Zlate", "Srebrne", "Bronaste"), sub ="Barva medalje", 
        ylab= "število odvzetih medalj", col = rainbow(6), xlim=c(0,6), ylim=c(0,30))


barplot(table(doping.ZOI$Sport), beside = TRUE, main = "DOPINŠKI PRIMERI NA ZIMSKIH OLIMPIJSKH IGRAH PO ŠPORTIH", 
        xlab="ŠPORTNE PANOGE",cex.names=0.6, ylab= "število dopinških primerov", 
        col = rainbow(6), xlim=c(0,8))

pie(table(doping.ZOI$Sex), labels= c("Men", "Women"), main="RAZMERJE DOPINŠKIH PRIMEROV PO SPOLU NA ZOI")

pie(table(doping.POI$Sex), labels= c("Men", "Women"), main="RAZMERJE DOPINŠKIH PRIMEROV PO SPOLU NA POI")
        

dev.off()