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

# Tipi spremenljivk:
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


# Uvoz podatkOV iz spletnih strani:

# uvoz knjižnic:
library(XML)
naslov = "http://en.wikipedia.org/wiki/List_of_stripped_Olympic_medals"
stripped.medals <- htmlTreeParse(naslov, encoding = "UTF-8", useInternal = TRUE)

stripped.medals<-readHTMLTable(naslov,which=1)
cat("Uvažam podatke o odvzemu olimpijskih medalj... \n")


# RAZPREDELNICA ODVZETIH ZLATIH OLIMPIJSKIH MEDALJ:

# PODATKI, KI SO BILI ZAMAKNJENI
zlate <- stripped.medals[3]=="Gold"
IMENA <- stripped.medals[1]
DRZAVA <- stripped.medals[2]
DISCIPLINA <- stripped.medals[4]
ZLATE.MEDALJE <- data.frame(IMENA[zlate], DRZAVA[zlate], DISCIPLINA[zlate])

# NEZAMAKNJENI PODATKI
zlate2 <- stripped.medals[4]=="Gold"
IMENA2 <- stripped.medals[2]
DRZAVA2 <- stripped.medals[3]
DISCIPLINA2 <- stripped.medals[5]
ZLATE.MEDALJE2 <- data.frame(IMENA2[zlate2], DRZAVA2[zlate2],DISCIPLINA2[zlate2])

names(ZLATE.MEDALJE) <- c("Athlete", "Country", "Event")
names(ZLATE.MEDALJE2) <- c("Athlete", "Country", "Event")

gold.medals <- merge(ZLATE.MEDALJE, ZLATE.MEDALJE2, all=TRUE)

# Tipi spremenljivk v tabeli gold.medals:
gold.medals$Athlete <- as.character(gold.medals$Athlete)
gold.medals$Country <- as.character(gold.medals$Country)
gold.medals$Event <- as.character(gold.medals$Event)


# RAZPREDELNICA ODVZETIH SREBRNIH OLIMPIJSKIH MEDALJ:

# ZAMAKNJENI PODATKI
srebrne <- stripped.medals[3]=="Silver"
IMENA3 <- stripped.medals[1]
DRZAVA3 <- stripped.medals[2]
DISCIPLINA3 <- stripped.medals[4]
SREBRNE.MEDALJE <- data.frame(IMENA3[srebrne], DRZAVA3[srebrne], DISCIPLINA3[srebrne])

# NEZAMAKNJENI PODATKI
srebrne2 <- stripped.medals[4]=="Silver"
IMENA4 <- stripped.medals[2]
DRZAVA4 <- stripped.medals[3]
DISCIPLINA4 <- stripped.medals[5]
SREBRNE.MEDALJE2 <- data.frame(IMENA4[srebrne2], DRZAVA4[srebrne2],DISCIPLINA4[srebrne2])


names(SREBRNE.MEDALJE) <- c("Athlete", "Country", "Event")
names(SREBRNE.MEDALJE2) <- c("Athlete", "Country", "Event")


silver.medals <- merge(SREBRNE.MEDALJE, SREBRNE.MEDALJE2, all=TRUE)

# Tipi spremenljivk v tabeli silver.medals:
silver.medals$Athlete <- as.character(silver.medals$Athlete)
silver.medals$Country <- as.character(silver.medals$Country)
silver.medals$Event <- as.character(silver.medals$Event)


# RAZPREDELNICA ODVZETIH BRONASTIH MEDALJ:

# ZAMAKNJENI PODATKI
bronaste <- stripped.medals[3]=="Bronze"
IMENA5 <- stripped.medals[1]
DRZAVA5 <- stripped.medals[2]
DISCIPLINA5 <- stripped.medals[4]
BRONASTE.MEDALJE <- data.frame(IMENA5[bronaste], DRZAVA5[bronaste], DISCIPLINA5[bronaste])

# NEZAMAKNJENI PODATKI
bronaste2 <- stripped.medals[4]=="Bronze"
IMENA6 <- stripped.medals[2]
DRZAVA6 <- stripped.medals[3]
DISCIPLINA6 <- stripped.medals[5]
BRONASTE.MEDALJE2 <- data.frame(IMENA6[bronaste2], DRZAVA6[bronaste2],DISCIPLINA6[bronaste2])


names(BRONASTE.MEDALJE) <- c("Athlete", "Country", "Event")
names(BRONASTE.MEDALJE2) <- c("Athlete", "Country", "Event")


bronze.medals <- merge(BRONASTE.MEDALJE, BRONASTE.MEDALJE2, all=TRUE)

# Tipi spremenljivk v tabeli bronze.medals:
bronze.medals$Athlete <- as.character(bronze.medals$Athlete)
bronze.medals$Country <- as.character(bronze.medals$Country)
bronze.medals$Event <- as.character(bronze.medals$Event)


# Če bi imeli več funkcij za uvoz in nekaterih npr. še ne bi
# potrebovali v 3. fazi, bi bilo smiselno funkcije dati v svojo
# datoteko, tukaj pa bi klicali tiste, ki jih potrebujemo v
# 2. fazi. Seveda bi morali ustrezno datoteko uvoziti v prihodnjih
# fazah.