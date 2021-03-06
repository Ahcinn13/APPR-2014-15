
cairo_pdf("slike/graf/1.pdf", width = 9.27, height = 9.69,
          family = "Arial", onefile = TRUE)

year.place <- paste(doping.ZOI$Year, doping.ZOI$Place, sep="-")



barplot(table(year.place), beside = TRUE, main = "DOPINŠKI PRIMERI NA ZIMSKIH OLIMPIJSKIH IGRAH", 
        xlab="LETO IN KRAJ OLIMPIJSKIH IGER", cex.names = 0.65, ylab= "število dopinških primerov",
        col = c("lightblue", "mistyrose", "lightcyan","lavender", "cornsilk"), xlim=c(0,9))

dev.off()

cairo_pdf("slike/graf/2.pdf", width = 9.27, height = 9.69,
          family = "Arial", onefile = TRUE)

year.place1 <- paste(doping.POI$Year, doping.POI$Place, sep="-")

barplot(table(doping.POI$Year), beside = TRUE, main = "DOPINŠKI PRIMERI NA POLETNIH OLIMPIJSKIH IGRAH", 
        xlab="LETO OLIMPIJSKIH IGER", cex.names = 0.8, ylab= "število dopinških primerov",
        col = rainbow(12, start =0, end=5/8), xlim=c(0,13))
dev.off()


cairo_pdf("slike/graf/3.pdf", width = 9.27, height = 9.69,
          family = "Arial", onefile = TRUE)

barplot(c(length(gold.medals$Athlete),length(silver.medals$Athlete), length(bronze.medals$Athlete)), 
        beside = TRUE, main = "ODVZETE OLIMPIJSKE MEDALJE", 
        names.arg = c("Zlate", "Srebrne", "Bronaste"), sub ="Barva medalje", 
        ylab= "število odvzetih medalj", col = rainbow(6), xlim=c(0,6), ylim=c(0,30))

dev.off()


cairo_pdf("slike/graf/4.pdf", width = 9.27, height = 9.69,
          family = "Arial", onefile = TRUE)
slovar <- doping.ZOI$Sport
slovar[slovar=="Ice hockey"]<-"Hokej"
slovar[slovar=="Cross-country skiing"]<-"Tek na smučeh"
slovar[slovar=="Biathlon"]<-"Biatlon"
slovar[slovar=="Bobsleigh"]<-"Bob"
slovar[slovar=="Alpine skiing"]<-"Alpsko smučanje"
slovar[slovar=="Ice hockey"]<-"Hokej"
slovar[slovar=="Ice hockey"]<-"Hokej"
slovar[slovar=="Ice hockey"]<-"Hokej"

barplot(table(slovar), beside = TRUE, main = "DOPINšKI PRIMERI NA ZIMSKIH OLIMPIJSKH IGRAH PO ŠPORTIH", 
        xlab="ŠPORTNE PANOGE",cex.names=0.8, space= 0.5, ylab= "število dopinških primerov", 
        col = rainbow(6), xlim=c(0,7))

dev.off()


cairo_pdf("slike/graf/5.pdf", width = 9.27, height = 9.69,
          family = "Arial", onefile = TRUE)


slo <- as.character(doping.POI$Sport)
slo[slo == "Pentathlon"]<-"Peteroboj"
slo[slo == "Swimming"]<-"Plavanje"
slo[slo == "Cycling"]<-"Kolesarjenje"
slo[slo == "Weightlifting"]<-"Dvigovanje uteži"
slo[slo == "Wrestling"]<-"Rokoborba"
slo[slo == "Gymnastics"]<-"Gimnastika"
slo[slo == "Rowing"]<-"Veslanje"
slo[slo == "Shooting"]<-"Streljanje"
slo[slo == "Canoeing"]<-"Kajak in kanu"
slo[slo == "Equestrian"]<-"Jahanje"
slo[slo == "Athletics"]<-"Atletika"
slo[slo == "Baseball"]<-"Bejzbol"
slo[slo == "Boxing"]<-"Boks"
slo[slo == "Sailing"]<-"Jadranje"
slo[slo == "Volleyball"]<-"Odbojka"


barplot(table(slo), beside = TRUE, names.arg=c(""), main = "DOPINŠKI PRIMERI NA POLETNIH OLIMPIJSKH IGRAH PO ŠPORTIH", 
        xlab="ŠPORTNE PANOGE",cex.names=0.5,space = 0.2, ylab= "število dopinških primerov", 
        col = rainbow(15), xlim=c(0,19), ylim=c(0,45),
legend = paste(names(table(slo)), table(slo), sep=" - "))

dev.off()

cairo_pdf("slike/graf/6.pdf", width = 9.27, height = 9.69,
          family = "Arial", onefile = TRUE)

pie(table(doping.ZOI$Sex), labels= c("Moški", "Ženske"), main="RAZMERJE DOPINŠKIH PRIMEROV PO SPOLU NA ZOI")
zenske <- round(sum(doping.ZOI$Sex=="W")*100/(sum(doping.ZOI$Sex=="M")+sum(doping.ZOI$Sex=="W")), digits=2)
moski <- round(sum(doping.ZOI$Sex=="M")*100/(sum(doping.ZOI$Sex=="M")+sum(doping.ZOI$Sex=="W")), digits=2)
text(0.3, -0.5, paste0(zenske,"%"), col = "black")
text(0, 0.5, paste0(moski,"%"), col = "black")

dev.off()               

cairo_pdf("slike/graf/7.pdf", width = 9.27, height = 9.69,
          family = "Arial", onefile = TRUE)

pie(table(doping.POI$Sex), labels= c("Moški", "Ženske"), main="RAZMERJE DOPINŠKIH PRIMEROV PO SPOLU NA POI")
zenske <- round(sum(doping.POI$Sex=="W")*100/(sum(doping.POI$Sex=="M")+sum(doping.POI$Sex=="W")), digits=2)
moski <- round(sum(doping.POI$Sex=="M")*100/(sum(doping.POI$Sex=="M")+sum(doping.POI$Sex=="W")), digits=2)
text(0.3, -0.5, paste0(zenske,"%"), col = "black")
text(0, 0.5, paste0(moski,"%"), col = "black")

dev.off()


cairo_pdf("slike/graf/8.pdf", width = 9.27, height = 9.69,
          family = "Arial", onefile = TRUE)

#zlorabljene substance
vek <- data.frame(table(OI$Banned.substance))$Freq !=1
tabela <- table(OI$Banned.substance)[vek]

barplot(tabela, beside = TRUE, names.arg=c(""), main = "GRAF ZLORAB  NEDOVOLJENIH POŽIVIL", 
        xlab="prepovedana substanca",cex.names=0.5,space = 0.01, ylab= "število zlorab", 
        col = rainbow(20), xlim=c(0,20), ylim=c(0,34),
        legend = paste(names(tabela), tabela, sep=" - "))



dev.off()