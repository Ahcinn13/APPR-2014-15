# Analiza podatkov s programom R, 2014/15

Avtor: Neža Ahčin

Repozitorij z gradivi pri predmetu APPR v študijskem letu 2014/15.

## Tematika

Tema mojega projekta je doping v športu. Osnovna ideja projekta je analiza podatkov in različnih vrst spremenljivk, kot so na primer: kako se je število dopingiranih športnikov v preteklosti spreminjalo, iz kje so prihajali, v katerih športih so se udejstvovali, katera tekmovanja (Olimpijske igre, svetovna prvenstva, Tour de France) so postregla z največ dopinškimi škandali, s katerimi nedovoljenimi sredstvi si športniki napogosteje pomagajo do čim boljšega rezultata.

Večino podatkov za svoj projekt bom pridobila iz različnih spletnih virov.

Cilj projekta je spoznati program R skozi analizo in obdevalo podtakov, predvsem pa pridobiti pozitivno oceno pri predmetu ANPP.

## Program

Glavni program se nahaja v datoteki `projekt.r`. Ko ga poženemo, se izvedejo
programi, ki ustrezajo drugi, tretji in četrti fazi projekta:

* obdelava, uvoz in čiščenje podatkov: `uvoz/uvoz.r`
* analiza in vizualizacija podatkov: `vizualizacija/vizualizacija.r`
* napredna analiza podatkov: `analiza/analiza.r`

Vnaprej pripravljene funkcije se nahajajo v datotekah v mapi `lib/`. Podatkovni
viri so v mapi `podatki/`. Slike, ki jih program naredi, se shranijo v mapo
`slike/`. Zemljevidi v obliki SHP, ki jih program pobere, se shranijo v mapo
`zemljevid/`.

## Poročilo

Poročilo se nahaja v mapi `porocilo/`. Za izdelavo poročila v obliki PDF je
potrebno datoteko `porocilo/porocilo.tex` prevesti z LaTeXom. Pred tem je
potrebno pognati program, saj so v poročilu vključene slike iz mape `slike/`.
