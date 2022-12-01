# Analiza danych - Ćwiczenia 2 - Monika Zagórska - nr ind 1200505 (Big Data - Przetwarzanie Danych)

########################################################################################################################
# Zadanie 2.1
# Używając zbioru painters (subiektywne oceny malarzy) z pakietu MASS wykonaj analizę
# składowych głównych. Zbadaj ładunki trzech pierwszych składowych głównych. Narysuj
# diagram rozrzutu dla dwóch pierwszych składowych głównych używając różnych
# kolorów lub symboli do rozróżnienia szkół malarstwa.
library(MASS)
View(painters)
?painters
skimr::skim(painters)
group <- (painters['School'])
str(group) 
levels(group$School)
group$School
painters1 <- painters[, -5] # bez kolumny School - etykieta
cor(painters1)
mean(cor(painters1)) # 0.3540338
boxplot(painters1); var(painters1); diag(var(painters1)) # nie skaluję, 'pudełka'też blisko siebie
model.pca <- prcomp(painters1)
summary(model.pca) # Trzy pierwsze zmienne wyjaśniają aż 93,59% całkowitej wariancji (pierwsza 55,95%, a każda kolejna dużo mniej)
model.pca$rotation # ładunki
# PC1 => jedynie ujemny ładunek dla Colour, dla pozostałych stosunkowo duży dodatni wpływ 'starych' zmiennych na utworzoną składową głóWną
# PC2 => tutaj z kolei jedynym dodatnim  ładunkiem, ale z najmniejszą 'siłą' wpływu na składową główną jest Drawing,
# przy czym najsilniejszy ujemny wpływ ma Colour
# PC3 => jedynie ujemny, lecz najsilniejszy ładunek na składową ma Composition
model.pca$x # wyniki (współ. obserwacji w nowym ukł.współ. utworz.przez składowe główne)
cor(model.pca$x) # wyniki blisko 0 , ok
plot(model.pca) # pierwsze dwa najwięcej wariancji (informacji)
screeplot(model.pca, type = 'l', pch = 20) # przy 3 już wypłaszczenie

COL = c('red', 'black', 'blue', 'purple', 'gray', 'orange2', 'yellow', 'green')
COL
plot(model.pca$x, pch = 20, cex = 1.2, col = COL[group$School]) # diagram rozrzutu dla dwóch pierwszych składowych głównych
legend('bottomleft', 
       legend = c('A: Renaissance', 'B: Mannerist', 'C: Seicento', 'D: Venetian', 'E: Lombard', 'F: Sixteenth Century', 'G: Seventeenth Century', 'H: French'), # chcę zeby wyswietlalo nazwe dlatego nie korzystam z levels (w levels tylko ABC....H) 
       pch = 20,
       cex = 0.9,
       fill = COL, 
       bty = 'n')           # z etykietą School
text(model.pca$x, 
     labels = row.names(painters1), 
     col = 'red', cex = 0.7)             # z nazwiskami malarzy

biplot(model.pca) # Composition i Expression 'dość silnie' skorelowane (mniejszy kąt, silniejsza korelacja dodatnia)


########################################################################################################################
# Zadanie 2.2
# Używając zmiennych ciągłych oraz porządkowych ze zbioru danych Cars93 z pakietu
# MASS wykonaj analizę składowych głównych. Porównaj (na osobnych wykresach):
#   • samochody amerykańskie i inne (Origin),
# • typy samochodów (Type).

library(MASS)
View(Cars93)
?Cars93
str(Cars93)
skimr::skim(Cars93)
cars93_numeric <- Cars93[, c(4:8, 12:15, 17:25)] # usuwam zmienne jakościowe
View(cars93_numeric)
cars82_numeric <- na.omit(cars93_numeric) # usuwamy brakujące przypadki (NAs), 11 obserwacji
View(cars82_numeric) # 93 -11 = 82 obserwacje
skimr::skim(cars82_numeric)

library(corrplot)
cars82_numeric.cor<-cor(cars82_numeric, method="pearson")  
print(cars82_numeric.cor, digits=2) 
corrplot(cars82_numeric.cor, order ="alphabet") # niektóre zmienne silnie skorelowane

boxplot(cars82_numeric); var(cars82_numeric); diag(var(cars82_numeric)) # będę skalować
model.pca <- prcomp(cars82_numeric, scale = TRUE)
summary(model.pca) # Pierwsze dwa wyjaśniają 76,75% całkowitej wariancji, żeby uzyskać ponad 80% to na pewno minimum pierwsze trzy PCA
model.pca$rotation # ładunki
# PC1 => ujemny ładunek dla MPG.city, MPG.highway,RPM , Rev.per.mile a dla pozostałych dodatni wpływ 'starych' zmiennych na utworzoną składową głóWną
# PC2 =>najsilniejszy dodatni ładunek dla RPM, zaś najsilniejszy ujemny dla Passengers                  
# PC3 => ujemny ładunek dla EngineSize, Horsepower, Fuel.tank.capacity, Width ,  Turn.circle, zaś najsilniejszy dodatni ładunek dla Rear.seat.room   
model.pca$x # wyniki (współ. obserwacji w nowym ukł.współ. utworz.przez składowe główne)
plot(model.pca) # pierwsze dwa najwięcej wariancji (informacji), jeszcze trzeci też
screeplot(model.pca, type = 'l', pch = 20) # przy 3-4już wypłaszczenie


COL = c('red', 'black', 'blue', 'purple', 'yellow', 'green')
COL
PCH = c(16:17)
group1 <- factor(Cars93$Origin)
group2 <- factor(Cars93$Type)
plot(model.pca$x, pch = PCH[group1], col = COL[group2])
legend('topleft', 
       legend = levels(group2), 
       pch = 20,
       cex = 0.9,
       fill = COL, 
       bty = 'n')
legend(x = -5,y= 5, legend = levels(group1), col = "black",pch = PCH)


biplot(model.pca)


