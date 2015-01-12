# 3. faza: Izdelava zemljevida


# Uvozimo funkcijo za pobiranje in uvoz zemljevida.
source("lib/uvozi.zemljevid.r")


cat("Uvazam zemljevid... \n")
pdf("slike/zemljevid.pdf")
svet <- uvozi.zemljevid("http://www.naturalearthdata.com/http//www.naturalearthdata.com/download/110m/cultural/ne_110m_admin_0_countries.zip", 
                        "zemljevid.sveta", "ne_110m_admin_0_countries.shp", mapa = "zemljevid",
                        encoding = "Windows-1250")

OI <- merge(doping.ZOI, doping.POI, all = TRUE)


#izpustimo manjkajoce drzave
OI <- OI[OI$Country %in% svet$admin, ]



m <- match(svet$admin, levels(factor(OI$Country)))


svet$primeri <- c(0)
svet$primeri[which(!is.na(m))]<- data.frame(table(OI$Country))$Freq[m[which(!is.na(m))]]
nov.svet <- svet[svet$primeri !=0,]



#imena in koordinate 2 drzav(ZDA, RUS) z največ dopinskimi primeri na OI

RUS <- which(svet$admin == "Russia")
ZDA <- which(svet$admin == "United States of America")
vektor <- c(RUS, ZDA)
koordinate <- coordinates(svet[vektor,])
rownames(koordinate) <- svet[vektor,]$admin


print(spplot(svet, "primeri", col.regions = c("white", rainbow(16, start=0, end=11/13)), 
       main = "Stevilo dopinskih primerov po drzavah", 
       sp.layout = list("sp.text", koordinate, svet[vektor,]$admin, cex=0.8),
       par.settings = list(panel.background=list(col="lightblue"))))


svet$substanca <- c("")
#naredimo novo tabelo upostevamo zgolj relavantne podatke
mamila.poland <- data.frame(table(OI$Banned.substance[OI$Country =="Poland"]))
svet$substanca[svet$admin == "Poland"] <- levels(factor(mamila.poland$Var1[mamila.poland$Freq == max(mamila.poland$Freq)]))

mamila.hungary <- data.frame(table(OI$Banned.substance[OI$Country =="Hungary"]))
svet$substanca[svet$admin == "Hungary"] <- levels(factor(mamila.hungary$Var1[mamila.hungary$Freq == max(mamila.hungary$Freq)]))

mamila.greece <- data.frame(table(OI$Banned.substance[OI$Country =="Greece"]))
svet$substanca[svet$admin == "Greece"] <- levels(factor(mamila.greece$Var1[mamila.greece$Freq == max(mamila.greece$Freq)]))

mamila.bulgaria <- data.frame(table(OI$Banned.substance[OI$Country =="Bulgaria"]))
svet$substanca[svet$admin == "Bulgaria"] <- levels(factor(mamila.bulgaria$Var1[mamila.bulgaria$Freq == max(mamila.bulgaria$Freq)]))

mamila.usa <- data.frame(table(OI$Banned.substance[OI$Country =="United States of America"]))
svet$substanca[svet$admin =="United States of America"] <- levels(factor(mamila.usa$Var1[mamila.usa$Freq == max(mamila.usa$Freq)]))

mamila.russia <- data.frame(table(OI$Banned.substance[OI$Country =="Russia"]))
svet$substanca[svet$admin == "Russia"] <- levels(factor(mamila.russia$Var1[mamila.russia$Freq == max(mamila.russia$Freq)]))

svet$enake <- factor(svet$substanca)

barve <- bpy.colors(length(levels(svet$enake)))[svet$enake]

barve[barve == "#000033FF"]<-"white"
plot(svet, col = barve, bg ="lightblue")
legend("bottomleft", legend = levels(factor(svet$substanca[svet$substanca!= ""])),
      fill = levels(factor(barve[svet$substanca != ""])), bg = "white")
title("Najpogosteje uporabljeno nedovoljeno sredstvo")

#tabela odvzetih medalj:
medals <- merge(gold.medals, silver.medals, all = TRUE)
medals <- merge(medals, bronze.medals, all = TRUE)
medals$Country[medals$Athlete == "Ibragim Samadov"] <- "Russia"
medals$Country[medals$Country == "United States"] <- "United States of America"

k <- match(levels(factor(medals$Country)), svet$admin)

#izpustimo manjkajoce drzave
medals <- medals[medals$Country %in% svet$admin,]

ujemanje <- match(svet$admin, levels(factor(medals$Country)))

svet$odvzete.medalje <- c(0)
odvzete.drzave <- levels(factor(medals$Country))
odvzete.svet <- svet[which(!is.na(ujemanje)),]
svet$odvzete.medalje[which(!is.na(ujemanje))]<- data.frame(table(medals$Country))$Freq[ujemanje[which(!is.na(ujemanje))]]



#vekotr izpisanih drzave je isti kot v zgornjem primeru 

print(spplot(svet, "odvzete.medalje", col.regions = c("white", rainbow(15, start=0, end = 10/12)),
       main = "Stevilo odvzetih olimpijskih medalj zaradi dopinga",
       sp.layout = list("sp.text", koordinate, svet[vektor,]$admin, cex=0.8),
       par.settings = list(panel.background=list(col="lightblue"))))
       

OI$host.country[OI$Place == "Munich"] <- "Germany"
OI$host.country[OI$Place == "Salt Lake City"] <- "United States of America"
OI$host.country[OI$Place == "Beijing"] <- "China"
OI$host.country[OI$Place == "Athens"] <- "Greece"
OI$host.country[OI$Place == "Los Angeles"] <- "United States of America"
OI$host.country[OI$Place == "Sydney"] <- "Australia"
OI$host.country[OI$Place == "London"] <- "United Kingdom"
OI$host.country[OI$Place == "Seoul"] <- "South Korea"
OI$host.country[OI$Place == "Grenoble"] <- "France"
OI$host.country[OI$Place == "Montreal"] <- "Canada"
OI$host.country[OI$Place == "Atlanta"] <- "United States of America"
OI$host.country[OI$Place == "Mexico City"] <- "Mexico"
OI$host.country[OI$Place == "Sapporo"] <- "Japan"
OI$host.country[OI$Place == "Sarajevo"] <- "Bosnia and Herzegovina"
OI$host.country[OI$Place == "Sochi"] <- "Russia"
OI$host.country[OI$Place == "Turin"] <- "Italy"
OI$host.country[OI$Place == "Vancouver"] <- "Canada"
OI$host.country[OI$Place == "Barcelona"] <- "Spain"
OI$host.country[OI$Place == "Calgary"] <- "Canada"


frekvence <- data.frame(table(OI$host.country))

frekvence$Freq[frekvence$Var1 == "United States of America"] <- frekvence$Freq[frekvence$Var1 == "United States of America"]/3
frekvence$Freq[frekvence$Var1 == "Canada"] <- frekvence$Freq[frekvence$Var1 == "Canada"]/3


uj <- match(svet$admin, frekvence$Var1)
svet$frekvence <- c(0)
svet$frekvence[which(!is.na(uj))] <- frekvence$Freq[uj[which(!is.na(uj))]]
svet$frek1 <- factor(svet$frekvence)
barve1 <- topo.colors(length(levels(svet$frek1)))[svet$frek1]
barve1[barve1 == "#4C00FFFF"]<-"white"
plot(svet, col=barve1, bg = "lightblue")
title("Povprecno stevilo dopinskih primerov na OI")
tabelabarv <- data.frame(svet$frekvence[svet$frekvence!= 0], barve1[svet$frekvence !=0])
colnames(tabelabarv)<-c("stevilo", "barva")
qw <- match(levels(factor(svet$frekvence[svet$frekvence!= 0])), tabelabarv$stevilo)
tabelabarv <- tabelabarv[qw,]
legend("bottomleft", legend = levels(factor(svet$frekvence[svet$frekvence!= 0])),
       fill = c(as.character(tabelabarv$barva)), bg = "white")

#Dodamo imena drzav
#najprej poberemo iz zemljevida svet tiste države ki bi jih radi označili
oznacene<-svet[c(9,28,31,136,169),]
#dodamo imena na zemljevid
text(coordinates(oznacene),labels=c("Avstralija","Kanada","Kitajska","Rusija","ZDA"),cex=0.55,col="black")

dev.off()
