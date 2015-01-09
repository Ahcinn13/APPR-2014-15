# 3. faza: Izdelava zemljevida

library(sp)
library(maptools)

# Uvozimo funkcijo za pobiranje in uvoz zemljevida.
source("lib/uvozi.zemljevid.r")


cat("Uvazam zemljevid... \n")
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
#svet$enake <- factor(svet$primeri)
#spplot(svet, "primeri", col.regions = rainbow(12))
#barve <- bpy.colors(length(levels(svet$enake)))[svet$enake]
#spplot(svet, "primeri", col.regions = barve)
#spplot(svet, "primeri", col.regions = c("white", rainbow(13)))





#imena in koordinate 3 drzav(ZDA, RUS, BUL) z največ dopinskimi primeri na OI

RUS <- which(svet$admin == "Russia")
BUL <- which(svet$admin == "Bulgaria")
ZDA <- which(svet$admin == "United States of America")
vektor <- c(RUS, BUL, ZDA)
koordinate <- coordinates(svet[vektor,])
rownames(koordinate) <- svet[vektor,]$admin


spplot(svet, "primeri", col.regions = c("white", rainbow(16, start=0, end=11/13)), 
       main = "Stevilo dopinskih primerov po drzavah", 
       sp.layout = list("sp.text", koordinate, svet[vektor,]$admin, cex=0.6),
       par.settings = list(panel.background=list(col="lightblue")))

nov.svet$substanca <- c("")
#drzave s samo enim dopinškim primerom
q <- nov.svet$admin[nov.svet$primeri ==1]
q <- as.character(q)
dr1 <- OI$Country[OI$Country %in% q]
OI$Banned.substance[OI$Country %in% q]
nov.svet$substance[match(dr1, nov.svet$admin)]<-OI$Banned.substance[OI$Country %in% q]

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

spplot(svet, "odvzete.medalje", col.regions = c("white", rainbow(15, start=0, end = 10/12)),
       main = "Stevilo odvzetih olimpijskih medalj zaradi dopinga",
       sp.layout = list("sp.text", koordinate, svet[vektor,]$admin, cex=0.6),
       par.settings = list(panel.background=list(col="lightblue")))
       

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







# Funkcija, ki podatke preuredi glede na vrstni red v zemljevidu
preuredi <- function(podatki, zemljevid) {
  nov.svet <- c()
  manjkajo <- ! nov.svet %in% rownames(podatki)
  M <- as.data.frame(matrix(nrow=sum(manjkajo), ncol=length(podatki)))
  names(M) <- names(podatki)
  row.names(M) <- nov.svet[manjkajo]
  podatki <- rbind(podatki, M)
  
  out <- data.frame(podatki[order(rownames(podatki)), ])[rank(levels(zemljevid$admin)[rank(zemljevid$admin)]), ]
  if (ncol(podatki) == 1) {
    out <- data.frame(out)
    names(out) <- names(podatki)
    rownames(out) <- rownames(podatki)
  }
  return(out)
}


 
# # Uvozimo zemljevid.
# cat("Uvažam zemljevid...\n")
# obcine <- uvozi.zemljevid("http://e-prostor.gov.si/fileadmin/BREZPLACNI_POD/RPE/OB.zip",
#                           "obcine", "OB/OB.shp", mapa = "zemljevid",
#                           encoding = "Windows-1250")
# 
# # Funkcija, ki podatke preuredi glede na vrstni red v zemljevidu
# preuredi <- function(podatki, zemljevid) {
#   nove.obcine <- c()
#   manjkajo <- ! nove.obcine %in% rownames(podatki)
#   M <- as.data.frame(matrix(nrow=sum(manjkajo), ncol=length(podatki)))
#   names(M) <- names(podatki)
#   row.names(M) <- nove.obcine[manjkajo]
#   podatki <- rbind(podatki, M)
#   
#   out <- data.frame(podatki[order(rownames(podatki)), ])[rank(levels(zemljevid$OB_UIME)[rank(zemljevid$OB_UIME)]), ]
#   if (ncol(podatki) == 1) {
#     out <- data.frame(out)
#     names(out) <- names(podatki)
#     rownames(out) <- rownames(podatki)
#   }
#   return(out)
# }
# 
# # Preuredimo podatke, da jih bomo lahko izrisali na zemljevid.
# druzine <- preuredi(druzine, obcine)
# 
# # Izračunamo povprečno velikost družine.
# druzine$povprecje <- apply(druzine[1:4], 1, function(x) sum(x*(1:4))/sum(x))
# min.povprecje <- min(druzine$povprecje, na.rm=TRUE)
# max.povprecje <- max(druzine$povprecje, na.rm=TRUE)
# 
# # Narišimo zemljevid v PDF.
# cat("Rišem zemljevid...\n")
# pdf("slike/povprecna_druzina.pdf", width=6, height=4)
# 
# n = 100
# barve = topo.colors(n)[1+(n-1)*(druzine$povprecje-min.povprecje)/(max.povprecje-min.povprecje)]
# plot(obcine, col = barve)
# 
# dev.off()