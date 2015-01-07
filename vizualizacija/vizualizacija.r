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


#Mankajoce drzave
manjkajoce <- c("Bahrain", "Monaco")
drzave <- c(levels(factor(OI$Country)), manjkajoce)
drzave <- drzave[drzave %in% svet$admin]
nov.svet <- svet[match(drzave, svet$admin),]
ostali.svet <- svet[-1*match(drzave, svet$admin),]
cel.svet <- merge(nov.svet, ostali.svet, all=TRUE)
m <- match(nov.svet$admin, drzave)

enake <- factor(nov.svet$primeri)
svet$primeri <- c(0)
svet$primeri[svet$admin %in% nov.svet$admin]<- data.frame(table(OI$Country[OI$Country %in% drzave]))$Freq[m]
#spplot(svet, "primeri", col.regions = rainbow(12))
#barve <- bpy.colors(length(levels(enake)))[enake]
#spplot(svet, "primeri", col.regions = barve)
spplot(svet, "primeri", col.regions = c("white", rainbow(13)))


#POPRAVI!!!!!!!

#tabela odvzetih medalj:
medals <- merge(gold.medals, silver.medals, all = TRUE)
medals <- merge(medals, bronze.medals, all = TRUE)
medals$Country[medals$Athlete == "Ibragim Samadov"] <- "Russia"
medals$Country[medals$Country == "United States"] <- "United States of America"
ujemanje <- match(medals$Country, svet$admin)

#izpustimo manjkajoce drzave
medals <- medals[-1*c(which(is.na(ujemanje))),]
ujemanje <- match(svet$admin, medals$Country)

svet$odvzete.medalje <- c(0)
odvzete.drzave <- levels(factor(medals$Country))
odvzete.svet <- svet[which(!is.na(ujemanje)),]
svet$odvzete.medalje[svet$admin %in% odvzete.svet$admin]<- data.frame(table(medals$Country))$Freq[which(!is.na(ujemanje))]


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


# OI <- merge(doping.ZOI, doping.POI, all = TRUE)
# m <- match(OI$Country, svet$admin)
# m <- m[which(!is.na(m))]
# sss <- svet[m,]
# brez <- OI$Country[c(-111, -116)]
# beda <- data.frame(table(brez))
# sss$zzz <- beda$Freq[m]
# 
# 
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