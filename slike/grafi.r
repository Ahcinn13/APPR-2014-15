pdf("slike/grafi.pdf", paper="a4")

year.place <- paste(doping.ZOI$Year, doping.ZOI$Place, sep="-")


barplot(table(year.place), beside = TRUE, main = "DOPINŠKI PRIMERI NA POLETNIH OLIMPIJSKH IGRAH", 
        xlab="LETO IN KRAJ OLIMPIJSKIH IGER", cex.names = 0.5, ylab= "število dopinških primerov",
        col = c("lightblue", "mistyrose", "lightcyan","lavender", "cornsilk"), xlim=c(0,9))



year.place1 <- paste(doping.POI$Year, doping.POI$Place, sep="-")

barplot(table(doping.POI$Year), beside = TRUE, main = "DOPINŠKI PRIMERI NA POLETNIH OLIMPIJSKH IGRAH", 
        xlab="LETO OLIMPIJSKIH IGER", cex.names = 0.5, ylab= "število dopinških primerov",
        col = rainbow(12, start =0, end=5/8), xlim=c(0,13))


barplot(c(length(gold.medals$Athlete),length(silver.medals$Athlete), length(bronze.medals$Athlete)), 
        beside = TRUE, main = "ODVZETE OLIMPIJSKE MEDALJE", 
        names.arg = c("Zlate", "Srebrne", "Bronaste"), sub ="Barva medalje", 
        ylab= "število odvzetih medalj", col = rainbow(6), xlim=c(0,6), ylim=c(0,30))


barplot(table(doping.ZOI$Sport), beside = TRUE, main = "DOPINŠKI PRIMERI NA ZIMSKIH OLIMPIJSKH IGRAH PO ŠPORTIH", 
        xlab="ŠPORTNE PANOGE",cex.names=0.8, space= 0.5, ylab= "število dopinških primerov", 
        col = rainbow(6), xlim=c(0,7))



barplot(table(doping.POI$Sport), beside = TRUE, names.arg=c(""), main = "DOPINŠKI PRIMERI NA ZIMSKIH OLIMPIJSKH IGRAH PO ŠPORTIH", 
        xlab="ŠPORTNE PANOGE",cex.names=0.5,space = 0, ylab= "število dopinških primerov", 
        col = rainbow(15), xlim=c(0,25), ylim=c(0,45),
legend = paste(names(table(doping.POI$Sport)), table(doping.POI$Sport), sep=" - "))


pie(table(doping.ZOI$Sex), labels= c("Men", "Women"), main="RAZMERJE DOPINŠKIH PRIMEROV PO SPOLU NA ZOI")
zenske <- round(sum(doping.ZOI$Sex=="W")*100/(sum(doping.ZOI$Sex=="M")+sum(doping.ZOI$Sex=="W")), digits=2)
moski <- round(sum(doping.ZOI$Sex=="M")*100/(sum(doping.ZOI$Sex=="M")+sum(doping.ZOI$Sex=="W")), digits=2)
text(0.3, -0.5, paste0(zenske,"%"), col = "black")
text(0, 0.5, paste0(moski,"%"), col = "black")
 
               


pie(table(doping.POI$Sex), labels= c("Men", "Women"), main="RAZMERJE DOPINŠKIH PRIMEROV PO SPOLU NA POI")
zenske <- round(sum(doping.POI$Sex=="W")*100/(sum(doping.POI$Sex=="M")+sum(doping.POI$Sex=="W")), digits=2)
moski <- round(sum(doping.POI$Sex=="M")*100/(sum(doping.POI$Sex=="M")+sum(doping.POI$Sex=="W")), digits=2)
text(0.3, -0.5, paste0(zenske,"%"), col = "black")
text(0, 0.5, paste0(moski,"%"), col = "black")
zenske <- round(sum(doping.POI$Sex=="W")*100/(sum(doping.POI$Sex=="M")+sum(doping.POI$Sex=="W")), digits=2)
moski <- round(sum(doping.POI$Sex=="M")*100/(sum(doping.POI$Sex=="M")+sum(doping.POI$Sex=="W")), digits=2)

# Pomožna funkcija
vsota2 <- function(vek) {
  z <- c()
  b <- c()
  for (i in vek) {
    y <- c(sum(doping.data$Samples[doping.data$Year == i]))
    d <- c(sum(doping.data$Total.findings[doping.data$Year== i]))
    z <- c(z,y)
    b <- c(b,d)
  }
  return(data.frame(2003:2010,z,b))
}

vzorci <- vsota2(2003:2010)
names(vzorci) <- c("leto", "Samples", "Total.findings")


plot(c(2003,2010), c(min(vzorci[3]), max(vzorci[2])), type = "n",
     xlab="Leto", ylab="število dopinških testov",
     main="ŠTEVILO DOPINŠKIH TESTOV")
lines(c(2003:2010), vzorci$Samples[vzorci$leto == c(2003:2010)], type="l", pch=20, col="magenta")
lines(c(2003:2010), vzorci$Total.findings[vzorci$leto == c(2003:2010)], type="l", pch=20, col="blue")
legend("topleft",
       legend = c("število vseh vzorcev", "število pozitivnih vzorcev"),
       col = c("magenta", "blue"),
       lty = c("solid", "solid"),
       pch = c(20, 20),
       bg = ("white"))

dev.off()