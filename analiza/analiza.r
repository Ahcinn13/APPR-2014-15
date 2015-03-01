# 4. faza: Analiza podatkov

cairo_pdf("slike/napredna_analiza/1.pdf", width = 9.27, height = 9.69,
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


dev.off()

cairo_pdf("slike/napredna_analiza/2.pdf", width = 9.27, height = 9.69,
          family = "Arial", onefile = TRUE)


#dendrogram glede na število dopinških primerov
row.names(korupcija)<- korupcija$drzave
X <- scale(as.matrix(korupcija[c(2:2)]))
t <- hclust(dist(X), method = "ward.D")
plot(t, hang=-1, cex=0.4, main = "Gručenje glede na število dopinških primerov")
legend("topleft", c("Skupina 1", "Skupina 2","Skupina 3","Skupina 4"),lty=c(1,1,1), col = c("red", "blue", "magenta", "orange"))
rect.hclust(t,k=4,border=c("red", "blue", "magenta", "orange"))


dev.off()

cairo_pdf("slike/napredna_analiza/3.pdf", width = 9.27, height = 9.69,
          family = "Arial", onefile = TRUE)


#tehnološki indeks
korupcija$technologija <- technology$AMOUNT[match(drzave, technology$COUNTRY)]

korupcija$technologija <- gsub("[.]", "", korupcija$technologija, ignore.case=TRUE)
korupcija$technologija <- as.numeric(korupcija$technologija)/100

korupcija$technologija[49]<-6.24

plot(korupcija$primeri, korupcija$technologija, 
     col = barve[korupcija$celina],
     xlim = c(1,15),
     xlab = "število dopinških primerov", 
     ylab = "tehnološki indeks", 
     main="Povzeava med tehnologijo in dopingom \n (model Loess)" )
legend("bottomright",
       legend = c("Afrika", "Amerika", "Azija", "Australija", "Evropa"),
       col = barve,
       lty = c("solid"),
       pch = c(20),
       bg = ("white"))
abline(h = 3, col = "black", lty = "dotted")
r <- korupcija$primeri 
MLS <- loess(korupcija$technologija ~ r)
curve(predict(MLS, data.frame(r=x)), add = TRUE, col = "black")


dev.off()

cairo_pdf("slike/napredna_analiza/4.pdf", width = 9.27, height = 9.69,
          family = "Arial", onefile = TRUE)

#modeli

# Pomožna funkcija
vsota2 <- function(VEK) {
  z <- c()
  b <- c()
  for (i in VEK) {
    y <- c(sum(doping.data$Samples[doping.data$Year == i]))
    d <- c(sum(doping.data$Total.findings[doping.data$Year== i]))
    z <- c(z,y)
    b <- c(b,d)
  }
  return(data.frame(2003:2010,z,b))
}

vzorci <- vsota2(2003:2010)
names(vzorci) <- c("leto", "Samples", "Total.findings")




#število vseh vzorcev
plot(c(2003,2010), c(min(vzorci[2]), max(vzorci[2])), main = "Spreminjanje števila dopinških testov", type = "n",
     xlab="Leto", ylab="število dopinških testov"
)
lines(c(2003:2010), vzorci$Samples[vzorci$leto == c(2003:2010)], type="p", pch=20, col="black")


#linearni model
lin1 <- lm(vzorci$Samples[vzorci$leto == c(2003:2010)] ~ c(2003:2010))
abline(lin1, col="blue")


iks <- c(2003:2010)
#nelinearni model
kv1 <- lm(vzorci$Samples[vzorci$leto == c(2003:2010)] ~ I((iks)^2) + iks)
curve(predict(kv1, data.frame(iks=x)), add = TRUE, col = "red")



#loess model 
mls1 <- loess(vzorci$Samples[vzorci$leto == c(2003:2010)] ~ iks)
curve(predict(mls1, data.frame(iks=x)), add = TRUE, col = "orange")


#ostanki
ostanki1 <- sapply(list(lin1, kv1, mls1), function(x) sum(x$residuals^2))

legend("bottomright", c("Linerana metoda", "Kvadratna metoda","Loess"),lty=c(1,1,1), col = c("blue","red","orange"))

dev.off()

cairo_pdf("slike/napredna_analiza/5.pdf", width = 9.27, height = 9.69,
          family = "Arial", onefile = TRUE)

#število pozitivnih vzorcev
plot(c(2003,2010), c(min(vzorci[3]), max(vzorci[3])), type = "n",
     xlab="Leto", ylab="število pozitivnih vzorcev",
     main="Spreminjanje števila pozitvnih dopinških testov")
lines(c(2003:2010), vzorci$Total.findings[vzorci$leto == c(2003:2010)], type="p", pch=20, col="black")


#linearni model
lin <- lm(vzorci$Total.findings[vzorci$leto == c(2003:2010)] ~ c(2003:2010))
abline(lin, col="blue")


iks <- c(2003:2010)
#nelinearni model
kv <- lm(vzorci$Total.findings[vzorci$leto == c(2003:2010)] ~ I((iks)^2) + iks)
curve(predict(kv, data.frame(iks=x)), add = TRUE, col = "red")



#loess model 
mls <- loess(vzorci$Total.findings[vzorci$leto == c(2003:2010)] ~ iks)
curve(predict(mls, data.frame(iks=x)), add = TRUE, col = "orange")


#ostanki
ostanki <- sapply(list(lin, kv, mls), function(x) sum(x$residuals^2))

legend("bottomright", c("Linerana metoda", "Kvadratna metoda","Loess"),lty=c(1,1,1), col = c("blue","red","orange"))


dev.off()

