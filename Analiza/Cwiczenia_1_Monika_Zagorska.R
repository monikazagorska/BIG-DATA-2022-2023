# Analiza danych - Ćwiczenia 1 - Monika Zagórska - nr ind 1200505 (Big Data - Przetwarzanie Danych)


########################################################################################################################
# Zadanie 1.1
# Używając zbioru danych cars narysuj wykres rozrzutu, gdzie pierwsza zmienna to
# prędkość, a druga to droga hamowania. Dopasuj do tego prostą regresji i narysuj ją
# na wykresie. Spróbuj dopasować funkcję kwadratową i sześcienną. Dodaj je do wykresu.
# Zaproponuj model bazując na jego jakości.
?cars
cars
View(cars)
plot(dist ~ speed, data = cars, pch = 20)
# 'na oko' wraz ze wzrostem prędkości rośnie też odległość potrzebna do zatrzymania
cor.test(~ dist + speed, data = cars)
# p-value < p.istot.(5%) (wynik istotny statyst.=>odrzucamy hip.zer. o braku korelacji liniowej)
# współ. Pearsona 0.8068949  - bardzo silna dodatnia korelacja
model1 <- lm(dist ~ speed, data = cars) # model regresji liniowej
summary(model1)
# szacowany.dist = -17.5791 + 3.9324*speed
# p-value < p.istot.(5%) (wynik istotny statyst.=> odrzucamy hip.zer. o braku korelacji)
#Multiple R-squared:  0.6511 tj. 65,11% > 60% model akceptowalny (w 65% zmienna speed wyjaśnia nam zmiany w dist)
(MSE.model1 <- mean(resid(model1)^2)) # błąd średniokwadratowy model1 = 227.0704
abline(model1, lwd = 2, col = 'red')

model2 <- lm(dist ~ poly(speed, 2, raw = TRUE), data = cars) # model regresji kwadratowej
lines(cars$speed, predict(model2), col = 'green', lwd = 2) 
summary(model2)
# szacowany.dist = 2.47014 + 0.91329*speed + 0.09996*speed^2
# p-value < p.istot.(5%) (wynik istotny statyst.=> odrzucamy hip.zer. o braku korelacji)
# Multiple R-squared:  0.6673 tj. 66,73% > 60% model akceptowalny 
(MSE.model2 <- mean(resid(model2)^2)) # błąd średniokwadratowy model2  = 216.4943

model3 <- lm(dist ~ poly(speed, 3, raw = TRUE), data = cars) # model regresji sześciennej
lines(cars$speed, predict(model3), col = 'blue', lwd = 2) 
summary(model3)
# szacowany.dist = -19.50505 + 6.80111*speed - 0.34966*speed^2 + 0.01025*speed^3
# p-value < p.istot.(5%) (wynik istotny statyst.=> odrzucamy hip.zer. o braku korelacji)
# Multiple R-squared:  0.6732 tj. 67,32% > 60% model akceptowalny 
(MSE.model3 <- mean(resid(model3)^2)) # błąd średniokwadratowy model3  = 212.6872


legend('topleft', legend = c('Model 1 liniowy', 'Model 2 kwadratowy', 'Model 3 sześcienny'), lwd = 2,
       col = c('red', 'green', 'blue'))

# Ocena jakości modelu
AIC(model1, model2, model3) # Akaike wybiera model1 (różnice w wynikach < 2 stąd wybieram najproszty model)
BIC(model1, model2, model3) # Bayesian wybiera model1 ( tu już ciut większe różnice, ale najmniejszy wynik 424.8929 dla model1)
anova(model1, model2, model3) # drugi i trzeci wiersz => p_value >5%, wyniki nieistotne statystycznie, brak podstaw żeby odrzucić hipotezy zerowe o identyczności modeli => wybieram model najprostszy 

# Współczynnik R-squared rósł (dokładając kolejne stopnie wielomianu zawsze będzie rósł). MSE mimo, iż maleje, raczej nie jest kryterium wyboru odpowiedniego modelu.
# Natomiast bazując na ocenie jakości modelu zdecydowanie wybieram model najprostszy czyli model regresji liniowej.



######################################################################################################################################################
# Zadanie 1.2
#Koszt domu zależy od liczby pokoi. Poniższe dane przedstawiają dane dla pewnego miasta.
# Cena (w tys.) 300 250 400 550 317 389 425 289 389 559
# Liczba pokoi 3 3 4 5 4 3 6 3 4 5
# Wykonaj diagram korelacyjny (wykres rozrzutu) oraz znajdź prostą regresji. Czy na poziomie
# istotności 5% liczba pokoi ma istotny wpływ na cenę? Jaka będzie cena mieszkania
# dwupokojowego według oszacowanego modelu? Czy założenia modelu są spełnione?
Input <- ("Price NumberOfRooms
  300 3
  250 3
  400 4
  550 5
  317 4
  389 3
  425 6
  289 3
  389 4
  559 5")
str(Input)
str(cars)
# install.packages("tidyverse")
# install.packages("dplyr")
# install.packages("rlang")
# install.packages('vctrs')
(data.set = read.table(textConnection(Input), header = TRUE))
str(data.set)
plot(data.set$Price ~ data.set$NumberOfRooms, data = data.set, pch = 20)
cor.test(~ data.set$Price + data.set$NumberOfRooms, data = data.set)
# p-value < p.istot.(5%) (wynik istotny statyst.=>odrzucamy hip.zer. o braku korelacji liniowej)
# współ. Pearsona 0.7361131  - silna dodatnia korelacja
model.lm <- lm(Price ~ NumberOfRooms, data = data.set) # model regresji liniowej
abline(model.lm, lwd = 2, col = 'red') # prosta regresji
summary(model.lm)
# szacowanaPrice = 94.40 + 73.10 * NumberOfRooms 
# p-value (0.0152)< p.istot.(5%) (wynik istotny statyst.=> odrzucamy hip.zer. o braku korelacji 
# i przyjmujemy hipotezę alternatywną, iż występuje korelacja między cena a liczbą pokoi
#Multiple R-squared:  0.5419 tj. 54,19% < 60% model jednak niezbyt akceptowalny (w 54% liczba pokoi wyjaśnia cenę)

# jaka cena dla 2-pokojowego mieszkania?
test <- data.frame(NumberOfRooms=c(2)) 
View(test)
predict(model.lm, test) # 240.6 tys. zł

resid(model.lm) # Residuals
hist(resid(model.lm), col = 'lightyellow') # Normalność reszt
plot(model.lm, 1, pch = 20) # test na stałość wariancji. Wariancje różnią sie między sobą, po prawej stronie znączące różnice 
plot(model.lm, 2, pch = 20) # Normalność - 'na oko' wzdłuż prostej przerywanej obserwacje
shapiro.test((resid(model.lm))) # p-value = 0.5969 > p.istotn. (5%) => brak podstaw do odrzucenia hipotezy zerowej o normalności reszt
plot(model.lm, 5, pch = 20) 
# Odległość Cook'a, (punkt odcięcia >1 lub 4/n, gdzie n tj.liczba obserwacji) wskazuje na punkt (obserw.) 7, odstająca, wpływowa
# obserwacja może być błędem pomiarowym, może wskazywać na złe określenie modelu albo po prostu taki był fakt/anomalia zjawiska,
# ostatecznie przecież 'towar jest wart tyle, ile ktoś jest w stanie za niego zapłacić'
MASS::boxcox(model.lm, lambda = seq(-4, 3)) # sugeruje by wybrać lambda bliskie 0 (ale test Shapiro-Wilka potwierdził wyżej, iż dane są normalne, a transformacji Box-a- Cox'a stosujemy by unormalnić dane)

# usuwam obserwację nr 7
new_data.set <- data.set[-7,]
View(new_data.set)
new_data.set
plot(new_data.set$Price ~ new_data.set$NumberOfRooms, data = new_data.set, pch = 20)
cor.test(~ new_data.set$Price + new_data.set$NumberOfRooms, data = new_data.set)
# p-value < p.istot.(5%) (wynik istotny statyst.=>odrzucamy hip.zer. o braku korelacji liniowej)
# współ. Pearsona 0.880178 - bardzo silna dodatnia korelacja
# otrzymany w poprawionym modelu współ. Pearsona jest większy niż w pierwotnym modelu (0.7361131)
model1.lm <- lm(Price ~ NumberOfRooms, data = new_data.set) # model regresji liniowej
abline(model1.lm, lwd = 2, col = 'red')
summary(model1.lm)
# szacowanaPrice = -56,80 + 116,30 * NumberOfRooms 
# p-value (0.00174)< p.istot.(5%) (wynik istotny statyst.=> odrzucamy hip.zer. o braku korelacji 
# i przyjmujemy hipotezę alternatywną, iż występuje korelacja między cena a liczbą pokoi
#Multiple R-squared:  0.7747 tj. 77,47% > 60% model jest akceptowalny (w 77% liczba pokoi wyjaśnia cenę, uprzednio otrzymano 54%)

# jaka cena dla 2-pokojowego mieszkania (bez obserwacji 7)?
test1 <- data.frame(NumberOfRooms=c(2)) 
View(test1)
predict(model1.lm, test1) # 175,8 tys. zł (uprzednio 240.6 tys. zł)

resid(model1.lm) # Residuals
hist(resid(model1.lm), col = 'lightyellow') # Normalność reszt
plot(model1.lm, 1, pch = 20) # test na stałość wariancji. występują różnice, ale jest lepiej
plot(model1.lm, 2, pch = 20) # Normalność - 'na oko' wzdłuż prostej przerywanej obserwacje
shapiro.test((resid(model1.lm))) # zdecydowanie wyższe p-value = 0.9398 > p.istotn. (5%) => brak podstaw do odrzucenia hipotezy zerowej o normalności reszt
plot(model1.lm, 5, pch = 20) 
# brak istotnie odstających punktów
MASS::boxcox(model1.lm, lambda = seq(-4, 3)) # sugeruje by wybrać lambda bliskie 0 (ale test Shapiro-Wilka potwierdził wyżej, iż dane są normalne, a transformacji Box-a- Cox'a stosujemy by unormalnić dane)

# Model bez odstającej wartości (obserwacja nr 7) zdecydowanie lepszy. 
# Pierwszy model był nieakceptowalny, gdyż jedynie w 54% liczba pokoi wyjaśniała cenę mieszkania.



######################################################################################################################################################
# Zadanie 1.3
# W zbiorze danych emissions (emisja CO2, a poziom PKB (26 państw)) z pakietu
# UsingR istnieje co najmniej jedna obserwacja odstająca. Narysuj diagram korelacyjny dla
# zmiennych GDP oraz CO2. Na jego podstawie wyznacz obserwację odstającą. Przyjmując
# zmienną CO2 za zmienną objaśnianą znajdź prostą regresji z obserwacją odstającą jak
# również bez niej. Jak zmieniły się wyniki? Dodaj obie proste do wykresu.
library(UsingR)
View(emissions)
?emissions
data.set <- emissions[,-2]
View(data.set)
cor.test(~ CO2 + GDP, data = data.set)
# p-value < p.istot.(5%) (wynik istotny statyst.=>odrzucamy hip.zer. o braku korelacji liniowej)
# współ. Pearsona 0,9501753   - bardzo silna dodatnia korelacja
plot(CO2 ~ GDP, data = data.set, pch = 20) 
# Obserwacja dla mnie nietypowa lecz na oko pasowałaby do linii regresji to United States,
# United States dlatego, gdyż podejrzanie daleko jej punkt od reszty danych na diagramie korelacyjnym 
#ale najpierw zbuduję model dla wszytskich danych i sprawdzę odległość Cook'a (może jakiś inny kraj tam będzie?)


model1.lm <- lm(CO2 ~ GDP, data = data.set) # model regresji liniowej dla wszystkich obserwacji
abline(model1.lm, lwd = 2, col = 'red')
summary(model1.lm)
# p-value 1.197e-13 < p.istot.(5%) (wynik istotny statyst.=> odrzucamy hip.zer. o braku korelacji 
# i przyjmujemy hipotezę alternatywną, iż występuje korelacja między CO2 a GDP
# Multiple R-squared:  0.9028 tj. 90,28% > 60% model jest akceptowalny (w 90% zmiany w GDP wyjaśnia zmiany w CO2
resid(model1.lm) # Residuals
hist(resid(model1.lm), col = 'lightyellow') # Normalność reszt ('tak nie bardzo')
plot(model1.lm, 1, pch = 20) # test na stałość wariancji. Wariancje różnią sie między sobą 
plot(model1.lm, 2, pch = 20) # Normalność - 'na oko' obserwacje w miarę wzdłuż prostej przerywanej poza UnitedStates, Russia, Japan
shapiro.test((resid(model1.lm))) # p-value = 0.0003713 < p.istotn. (5%) => wynik istotny statystycznie stąd odrzucamy hipotezę zerową o normalności reszt
#i przyjemujemy hipoteze alternatywną, iż rozkład badanej cechy nie jest rozkładem normalnym
# nie robię trasformacji Box'a-Cox'a, ale byłoby zasadne unormalnić dane do dalszej analizy
plot(model1.lm, 5, pch = 20)
# Odległość Cook'a, (punkt odcięcia >1 lub 4/n , gdzie n tj.liczba obserwacji (4/26=0,15384615)) 
#ku radości, moje podejrzenie 'na oko' sprawdziło się i zdecydowanie w pierwszej kolejności usunąć z modelu United States (przyjrzeć się jak wygląda nowy model ,zwłaszcza Japan i Russia, albo może jakis nowy kraj sie pojawi)


data.setOUT <- data.set[-1,] # usunięcie z modelu United States (moje podejrzenie, które potwierdziło się, przy odległości Cook'a )
View(data.setOUT)
cor.test(~ CO2 + GDP, data = data.setOUT)
# p-value < p.istot.(5%) (wynik istotny statyst.=>odrzucamy hip.zer. o braku korelacji liniowej)
# współ. Pearsona 0.7000287    -  silna dodatnia korelacja
model2.lm <- lm(CO2 ~ GDP, data = data.setOUT) # model regresji liniowej
summary(model2.lm)
# p-value 9.802e-05 < p.istot.(5%) (wynik istotny statyst.=> odrzucamy hip.zer. o braku korelacji 
# i przyjmujemy hipotezę alternatywną, iż występuje korelacja między CO2 a GDP
# Multiple R-squared:  0.49 tj. 49% < 60% model nie jest akceptowalny (przed usunięciem Unitedtates w 90% model był dopasowany)
resid(model2.lm) # Residuals
hist(resid(model2.lm), col = 'lightyellow')
plot(model2.lm, 1, pch = 20) # test na stałość wariancji. Wariancje różnią sie między sobą  (Russia i Germany poza)
plot(model2.lm, 2, pch = 20) # Normalność - 'na oko' obserwacje w miarę wzdłuż prostej przerywanej poza Russia i Germany
shapiro.test((resid(model2.lm))) # p-value = 1.413e-06 < p.istotn. (5%) => wynik istotny statystycznie stąd odrzucamy hipotezy zerową o normalności reszt
#i przyjemujemy hipoteze alternatywną, iż rozkład badanej cechy nie jest rozkładem normlanym
# nie robię trasformacji Box'a-Cox'a, ale byłoby zasadne unormalnić dane do dalszej analizy
plot(model2.lm, 5, pch = 20) # teraz do usunięcia z modelu kwalifikowałaby się Japan


# i jeszcze raz do podsumowania wykres rozrzutu i linie regresji dla dwóch modeli
plot(CO2 ~ GDP, data = data.set, pch = 20)
abline(model1.lm, lwd = 2, col = 'red')
abline(model2.lm, lwd = 2, col = 'blue') # teraz Russia i Germany wydają się odstające
legend('topleft', legend = c('Model 1 liniowy (wszystkie obserwacje)', 'Model 2 liniowy (bez UnitedStates)'), lwd = 2,
       col = c('red', 'blue'))

# Usunięcie UnitedStates z modelu sprawiło, iż model stał się nieakceptowalny w związku ze znacznym spadkiem Multiple R-squared
# z poziomu 90% do 49% (zmienna GDP w dużo mniejszym stopniu wyjaśnia zmienną objaśnianą CO2)



######################################################################################################################################################
# Zadanie 1.4
# Zbiór danych homeprice z pakietu UsingR zawiera informacje na temat domów sprzedanych
# w New Jersey w roku 2001. Czy liczba toalet (zmienna half) miała wpływ na
# cenę (sale)? Czy założenia modelu są spełnione.
library(UsingR)
?homeprice
View(homeprice)

#Pan Profesor mówił, iż mamy zbudować model bez ceny wywoławczej (zmienna list (list price of home) tj. cena katalogowa)
# obie ceny wysoko skorelowane ze sobą
# czyli wyjściowo zmienna 'sale' zależna od pozostałych bez 'list'

data.set <- homeprice[,-1]
View(data.set)
model.lm <- lm(sale ~ ., data = data.set)
summary(model.lm)
# zmienna half Pr(>|t|) = 0.00264 co jest < p.istotności (5%) czyli wynik istotny statystycznie, 
# zatem odrzucamy hipotezę zerową o braku korelacji między zmienną sale a zmienną half
# istotna statystycznie jest na pewno zmienna neighborhood , 
# natomiast dla zmiennej full przyjmuje Pr(>|t|) = 0.07181 (trochę więcej niż poziom.ist. 5%)
# zmienna  (0,26329) i rooms wysoko (0.53823)- tu zdecydowanie brak podstaw do odrzucenia hip.zerowej, trzeba redukowac model
# Adjusted R-squared:  0.8879  - model dopasowany w 89%, ale sporo zmiennych nieistotnych (do redukcji)!

model.lm.final <- step(model.lm)  # redukcja modelu (zredukowało o  zmienną rooms)
summary(model.lm.final) 
# Po redukcji wszystkie zmienne istotne statystycznie (zmienna full tak w granicy, bo Pr(>|t|)= 0.055785)
# Adjusted R-squared:  0.8907 - Model dopasowany w 89% (>60%) - wydaje się być ok
plot(model.lm.final, 1, pch = 20) # powinno być mniej więcej równo, ale na początku i końcu odstaje bardzo
plot(model.lm.final, 2, pch = 20) #normlaność, podobnie jak wyżej, na początku i końcu wykresu oddalone od linii przerywnaej
shapiro.test(resid(model.lm.final)) #p-value = 0.05804 > p.istot. (5%) (na granicy, ale jest!)
# czyli brak podstaw żeby odrzucić hipoteze zerowa, zatem zakładamy, że dane są normalne
plot(model.lm.final, 5, pch = 20) # brak znaczących pkt odstających


# Zmienna half miala wpływ na cenę. Model po usunięciu zmiennej rooms spłenia założenia.


######################################################################################################################################################
# Zadanie 1.5
# Klasycznym modelem wzrostu populacji jest model logistyczny postaci:
#   y =  a /(1 + e^((b-x)/c) :
#   Dopasuj ten model do danych USPop z pakietu carData, zawierających informacje na
# temat populacji USA od roku 1790 do 2000. Narysuj dopasowaną funkcję regresji wraz z
# danymi. Czy podstawowe założenia modelu są spełnione?
library(carData)
?USPop
View(USPop)
plot(USPop, pch = 20) # wykres rozrzutu
model.nlm <- nls(population ~ SSlogis(year, a, b, c), USPop)
summary(model.nlm)
# Parametry a,b,c istotne statyst.,   
# Residual standard error: 4.909 on 19 degrees of freedom
#czyli model przewiduje wlk populacji  z przeciętnym błędem około 4,909. 
lines(USPop$year, fitted(model.nlm)) # polilinia
# parametry z SSlogis => y =  a /(1 + e^((b-x)/c)
# a <- coef(model.lm)[1]
# b <- coef(model.lm)[2]
# c <- coef(model.lm)[3]
#e <- e=2.71828182845904523536028747135266249775724709369995 ,  ja używam exp() = e do potęgi.. 
curve(coef(model.nlm)[1] / (1 + exp((coef(model.nlm)[2] - x)/coef(model.lm)[3])), 
      add = TRUE, 
      col = 'red', 
      lwd = 2) # krzywa logistyczna
legend('bottomright', lwd = 2, col = c('black', 'red'), 
       legend = c('Polyline', 'Curve (krzywa logistyczna'))

library(nlstools) # For nlsResiduals() & test.nlsResiduals() functions
plot(nlsContourRSS(model.nlm), nlev = 10) # Contour plot for parameters (resztowa suma kwadratow osiąga globalne minimum 'tam gdzie zielone', zaś pomiędzy dwiema poziomicami RSS jednakowe) )
plot(nlsResiduals(model.nlm)) # Diagnostic plots
test.nlsResiduals(nlsResiduals(model.nlm)) 
# Normality test (SW test) = p-value = 0.01252 < p. istot. (5%) odrzucam hipoteze zerową o normalności reszt
# the randomness of residuals with the runs test (losowość reszt), p-value = 0.0008966 < p.isto.t (5%) stąd reszty nie są losowe



######################################################################################################################################################
# Zadanie 1.6
# Skoczek skacze ze spadochronem z balonu napełnionego gorącym powietrzem. Poniżej
# znajdują się jego prędkości [m/s] w kolejnych chwilach czasu [s] (poczynając od 1s):
#   10; 16;3; 23; 27;5; 31; 35;6; 39; 41;5; 42;9; 45; 46; 45;5; 46; 49; 50:
#   1
# 2
# Dopasuj do tych danych model Michaelisa-Menten postaci:
#   v(t) = at/b + t: 
#   Narysuj wykres rozrzutu wraz z dopasowaną krzywą regresji. Jaką prędkość rozwinie
# skoczek w 17 sekundzie lotu?
Input <- ("time  speed
  1 10
  2 16.3
  3 23
  4 27.5
  5 31
  6 35.6
  7 39
  8 41.5
  9 42.9
  10  45
  11  46
  12  45.5
  13  46
  14  49
  15  50")
(data.set = read.table(textConnection(Input), header = TRUE))
plot(data.set,  xlim = c(0,20), ylim = c(10,70), pch = 20) # wykres rorzutu
model.nlm <- nls(speed ~ SSmicmen(time, a, b), data.set)
summary(model.nlm) # Parametry a,b istotne statyst., 
#parametry z SSlogis v(t) = at/(b + t) czyli u nas y = a * x / (b+x)
# a <- coef(model.lm)[1]
# b <- coef(model.lm)[2]
curve(coef(model.nlm)[1] * x / (coef(model.nlm)[2] + x), 
      add = TRUE, 
      col = 'red', 
      lwd = 2) # krzywa regresji logistycznej

test1 <- data.frame(time=c(17)) 
predict(model.nlm, test1) #  W 17 sekundzie skoczek osiąga prędkość 51.84704 m/s
points(y = 51.84704,  x = 17, col = 'green', pch=20) # leży na krzywej

     