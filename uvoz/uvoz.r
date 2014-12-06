# 2. faza: Uvoz podatkov

# Funkcija, ki uvozi podatke iz UKAD Olympic doping data.csv:
uvoz.doping <- function() {
  return(read.csv2("podatki/UKAD Olympic doping data.csv", sep = ";", dec=",", as.is = TRUE, header=TRUE, 
                    na.strings="-", 
                      fileEncoding = "Windows-1250"))
}

# Zapišimo podatke v razpredelnico doping.data.
cat("Uvažam podatke o številu dopinških testov... \n")
doping.data <- uvoz.doping()

names(doping.data) <- c("Year", "Sport", "Samples", "Total.findings", "procent.ofDopingCases")
doping.data$procent.ofDopingCases <- gsub("[%]", "", doping.data$procent.ofDopingCases)
doping.data$procent.ofDopingCases <- gsub("[,]", ".", doping.data$procent.ofDopingCases)
doping.data$Samples <- gsub("[.]", "", doping.data$Samples, ignore.case=TRUE)



# Tipi spremenljivk:
doping.data$Year <- as.numeric(doping.data$Year)
doping.data$Sport <- as.character(doping.data$Sport)
doping.data$Samples <- as.numeric(doping.data$Samples)
doping.data$procent.ofDopingCases <- as.numeric(doping.data$procent.ofDopingCases)



# Pomožna tabela:
tabela1 <- data.frame(table(doping.data$Sport))


# Funkcija, ki sešteje procente dopinških primerov po posameznih športih v različnih letih:
vsota <- function(vektor) {
  z <- c()
  for (i in vektor) {
    y <- c(sum(doping.data$procent.ofDopingCases[doping.data$Sport == i]))
    z <- c(z,y)
  }
return(z)
}


povprecje <- round(vsota(tabela1$Var1)/tabela1$Freq, digits = 3)

tabela2 <- data.frame(tabela1[-2], povprecje)

names(tabela2) <- c("Sport", "Average")


# Dodajanje urejenoste spremenljivke
kategorije <- c("dopinških primerov ni bilo", 
                "malo", 
                "srednje", 
                "veliko")
stevilo<-character(length(tabela2$Average))
stevilo[tabela2$Average == 0.000] <- "dopinških primerov ni bilo"
stevilo[tabela2$Average > 0.000
        & tabela2$Average <= 1.500] <- "malo"
stevilo[tabela2$Average > 1.500
        & tabela2$Average <= 2.500] <- "srednje"
stevilo[tabela2$Average > 2.500] <- "veliko"
kategorija <- factor(stevilo, levels = kategorije, ordered = TRUE)

dopingBySports <- data.frame(tabela2,
                             kategorija=kategorija)


names(dopingBySports) <- c("Sport", "Average", "Number.ofDopingCases")


# Funkcija, ki uvozi podatke iz doping_at_the_winter_olympic_games.csv:
uvoz.zoi <- function() {
  return(read.table("podatki/doping_at_the_winter_olympic_games.csv", sep = ";", as.is = TRUE, header=TRUE,
                    na.strings="-",
                    fileEncoding = "Windows-1250"))
}



# Zapišimo podtake v razpredelnico doping.ZOI.
cat("Uvažam podatke o dopinških primerih na zimskih Olimpijskih igrah... \n")
doping.ZOI <- uvoz.zoi()

names(doping.ZOI) <- c("Athlete", "Sex", "Country", "Sport",  "Banned.substance",	"Place",	"Year")


# Funkcija, ki uvozi podatke iz doping_at_the_summer_olympic_games.csv:  
uvoz.poi <- function() {

  return(read.table("podatki/doping_at_the_summer_olympic_games.csv", sep=";", skip = 0, na.strings = "-",
               fileEncoding = "Windows-1250", header=TRUE))
}



# Zapišimo podatke v razpredelnico doping.POI.
cat("Uvažam podatke o dopinških primerih na poletnih Olimpijskih igrah... \n")
doping.POI <- uvoz.poi()

names(doping.POI) <- c("Athlete", "Sex", "Country", "Sport",	"Banned.substance",	"Place",	"Year")




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