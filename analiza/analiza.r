# 4. faza: Analiza podatkov

cairo_pdf("slike/napredna_analiza.pdf", width = 9.27, height = 9.69,
          family = "Arial", onefile = TRUE)


#tabela korupcija 
korupcija <- data.frame(table(OI$Country))
drzave <- data.frame(table(OI$Country))$Var1
matching <- match(drzave, CPI$Country)

names(korupcija)<-c("drzave", "primeri")

#INDEKSI

korupcija$INDEKSI <- CPI$CPI2014[match(drzave, CPI$Country)]


#kontinenti
korupcija$celina <- "EU"
korupcija$celina[korupcija$drzave=="Afghanistan"]<-"AS"
korupcija$celina[korupcija$drzave=="Algeria"]<-"AF"
korupcija$celina[korupcija$drzave=="Armenia"]<-"AS"
korupcija$celina[korupcija$drzave=="Australia"]<-"AUS"
korupcija$celina[korupcija$drzave=="Canada"]<-"AM"
korupcija$celina[korupcija$drzave=="Brazil"]<-"AM"
korupcija$celina[korupcija$drzave=="China"]<-"AS"
korupcija$celina[korupcija$drzave=="Colombia"]<-"AM"
korupcija$celina[korupcija$drzave=="India"]<-"AS"
korupcija$celina[korupcija$drzave=="Iran"]<-"AS"
korupcija$celina[korupcija$drzave=="Japan"]<-"AS"
korupcija$celina[korupcija$drzave=="Kenya"]<-"AF"
korupcija$celina[korupcija$drzave=="Kyrgyzstan"]<-"AS"
korupcija$celina[korupcija$drzave=="Lebanon"]<-"AS"
korupcija$celina[korupcija$drzave=="Mongolia"]<-"AS"
korupcija$celina[korupcija$drzave=="Morocco"]<-"AF"
korupcija$celina[korupcija$drzave=="Myanmar"]<-"AS"
korupcija$celina[korupcija$drzave=="North Korea"]<-"AS"
korupcija$celina[korupcija$drzave=="Puerto Rico"]<-"AM"
korupcija$celina[korupcija$drzave=="Syria"]<-"AS"
korupcija$celina[korupcija$drzave=="Vietnam"]<-"AS"
korupcija$celina[korupcija$drzave=="Uzbekistan"]<-"AS"
korupcija$celina[korupcija$drzave=="United States of America"]<-"AM"

korupcija$celina <- as.factor(korupcija$celina)
barve = c("red", "black", "blue", "orange", "magenta")


#graf:povezava med korupcija in številom dopinških primerov
plot(korupcija$primeri, korupcija$INDEKSI, 
     col = barve[korupcija$celina],
     xlim = c(1,15),
     xlab = "število dopinških primerov", 
     ylab = "indeks korupcije", 
     main="Povzeava med stopnjo korupcije in dopingom")
     legend("topright",
            legend = c("Afrika", "Amerika", "Azija", "Australija", "Evropa"),
            col = barve,
            lty = c("solid"),
            pch = c(20),
            bg = ("white"))
abline(v = 4, col = "black", lty = "dotted")





#dendrogram glede na število dopinških primerov
row.names(korupcija)<- korupcija$drzave
X <- scale(as.matrix(korupcija[c(2:2)]))
t <- hclust(dist(X), method = "ward.D")
plot(t, hang=-1, cex=0.4, main = "Gručenje glede na število dopinških primerov")
legend("topleft", c("Skupina 1", "Skupina 2","Skupina 3","Skupina 4"),lty=c(1,1,1), col = c("red", "blue", "magenta", "orange"))
rect.hclust(t,k=4,border=c("red", "blue", "magenta", "orange"))





#tehnološki indeks
korupcija$technologija <- technology$AMOUNT[match(drzave, technology$COUNTRY)]

korupcija$technologija <- gsub("[.]", "", korupcija$technologija, ignore.case=TRUE)
korupcija$technologija <- as.numeric(korupcija$technologija)/100
# korupcija$technologija[27]<- 3.22
# korupcija$technologija[22]<- 3.42
# korupcija$technologija[29]<- 3.64
# korupcija$technologija[2]<- 3.66
# korupcija$technologija[34]<- 2.35
# korupcija$technologija[4]<- 4.03
# 
# korupcija$technologija[22]<- 3.42
# korupcija$technologija[39]<- 4.54
# korupcija$technologija[32]<- 4.07
# korupcija$technologija[31]<- 3.89
# korupcija$technologija[36]<- 5.54
# korupcija$technologija[1]<- 0
# korupcija$technologija[7]<- 0
# korupcija$technologija[45]<- 0
# korupcija$technologija[50]<- 0
korupcija$technologija[49]<-6.24

plot(korupcija$primeri, korupcija$technologija, 
     col = barve[korupcija$celina],
     xlim = c(1,15),
     xlab = "število dopinških primerov", 
     ylab = "tehnološki indeks", 
     main="Povzeava med tehnologijo in dopingom")
legend("topright",
       legend = c("Afrika", "Amerika", "Azija", "Australija", "Evropa"),
       col = barve,
       lty = c("solid"),
       pch = c(20),
       bg = ("white"))
abline(h = 3, col = "black", lty = "dotted")


#modeli





dev.off()









