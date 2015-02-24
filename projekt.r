# Pobrišemo PDF-je in počistimo delovno okolje
silent <- TRUE
source("clearpdf.r", encoding = "UTF-8")

#source("fontconfig.r", encoding = "UTF-8")


# 2. faza: Obdelava, uvoz in čiščenje podatkov
source("uvoz/uvoz.r")
source("slike/grafi.r")

# 3. faza: Analiza in vizualizacija podatkov
source("vizualizacija/vizualizacija.r")

# 4. faza: Napredna analiza podatkov
#source("analiza/analiza.r")

cat("Končano.\n")