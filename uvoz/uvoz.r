# 2. faza: Uvoz podatkov

# Funkcija, ki uvozi podatke iz UKAD Olympic doping data.csv:
uvoz.doping <- function() {
  return(read.table("podatki/UKAD Olympic doping data.csv", sep = ";", as.is = TRUE, header=TRUE, 
                    na.strings="-", 
                      fileEncoding = "Windows-1250"))
}

# Zapišimo podatke v razpredelnico doping.data.
cat("Uvažam podatke o številu dopinških testov... \n")
doping.data <- uvoz.doping()
doping.data <- doping.data[,-5]
doping.data$Year <- as.numeric(doping.data$Year)
doping.data$Sport <- as.character(doping.data$Sport)
doping.data$Samples <- as.numeric(doping.data$Samples)
doping.data$Total.findings <- as.numeric(doping.data$Total.findings)





# Funkcija, ki uvozi podatke iz doping_at_the_winter_olympic_games.csv:
uvoz.zoi <- function() {
  return(read.table("podatki/doping_at_the_winter_olympic_games.csv", sep = ";", row.names = 1, as.is = TRUE, header=TRUE,
                    na.strings="-",
                    fileEncoding = "Windows-1250"))
}

# Zapišimo podtake v razpredelnico doping.ZOI.
cat("Uvažam podatke o dopinških primerih na zimskih Olimpijskih igrah... \n")
doping.ZOI <- uvoz.zoi()






# Funkcija, ki uvozi podatke iz doping_at_the_summer_olympic_games.csv:  
uvoz.poi <- function() {

  return(read.tabel("podatki/doping_at_the_summer_olympic_games.csv", row.names=1, skip = 0, na.strings = "-",
               fileEncoding = "Windows-1250", header=TRUE))
}
# Zapišimo podatke v razpredelnico doping.POI.
cat("Uvažam podatke o dopinških primerih na poletnih Olimpijskih igrah... \n")
doping.POI <- uvoz.POI()



# Če bi imeli več funkcij za uvoz in nekaterih npr. še ne bi
# potrebovali v 3. fazi, bi bilo smiselno funkcije dati v svojo
# datoteko, tukaj pa bi klicali tiste, ki jih potrebujemo v
# 2. fazi. Seveda bi morali ustrezno datoteko uvoziti v prihodnjih
# fazah.