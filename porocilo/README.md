# Poročilo

1.FAZA

Določila sem temo svojega projekta. 
Tema mojega projekta je doping v športu. Osnovna ideja projekta je analiza podatkov in različnih vrst spremenljivk, kot so na primer: kako se je število dopingiranih športnikov v preteklosti spreminjalo, iz kje so prihajali, v katerih športih so se udejstvovali, katera tekmovanja (Olimpijske igre, svetovna prvenstva, Tour de France) so postregla z največ dopinškimi škandali, s katerimi nedovoljenimi sredstvi si športniki napogosteje pomagajo do čim boljšega rezultata.

Podatke sem oziroma bom pridobila iz naslednjih spletnih virov:
- http://en.wikipedia.org/wiki/Doping_at_the_Olympic_Games
- http://en.wikipedia.org/wiki/List_of_doping_cases_in_athletics
- http://sportsanddrugs.procon.org/view.resource.php?resourceID=004420
- http://en.wikipedia.org/wiki/List_of_doping_cases_in_sport
- www.huffingtonpost.com/2014/02/16/olympics-drug-testing-medals-stripped_n_4789565.html
- http://en.wikipedia.org/wiki/List_of_stripped_Olympic_medals

Cilj projekta je spoznati program R skozi analizo in obdevalo podtakov, predvsem pa pridobiti pozitivno oceno pri predmetu ANPP.


2.FAZA

V svoj program sem uvozila 3 tabele CSV oblike. Eno sem našla na spletu, preostali dve sem V Excellu napisala sama s pomočjo različnih spletnih virov, ju pretvorila v CSV obliko ter ju nato uvzila v projekt. Ostale 3 tabele sem naredila s preoblikovanjem html tabele, ki sem jo uvzila s spletne strani. Ker so se mi pri uvozu html tabele nekateri stolpci med seboj pomešali, sem iz ene tabele naredila tri manjše podtabele, s tem pa sem si tudi nekoliko olajšala nadaljno obdelava podatkov. V vsaki tabeli sem preverila tip spremenljivk, ga po potrebi spremenila, v eni izmed tabel pa sem tudi dodala novo urejenostno spremenljivko. Odstranila sem nepotrebne znake, vrstice, stolpce in dodala nove. 

Na podlagi danih podatkov zbranih v tabelah sem narisala 8 grafov (5 stolpičnih, 2 tortna diagrama ter 1 graf).
Program za risnje grafov sem napisala v datoteki grafi.r, ki sem ga shranila v mapo slike. Zaradi lažjega risanja grafov, sem na novo definirala nekaj funkcij, dodala novo tabelo oziroma novo spremenljivko.
Na koncu pa sem vse grafe še izvozila v PDF datoteki.