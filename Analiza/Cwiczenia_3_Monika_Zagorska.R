# Analiza danych - Ćwiczenia 3 - Monika Zagórska - nr ind 1200505 (Big Data - Przetwarzanie Danych)

########################################################################################################################
# Zadanie 3.1
#1. Zbiór danych Vehicle z pakietu mlbench zawiera informacje (18 cech, 846 obserwacji)
# o sylwetkach samochodów (4 typy).
# (a) Skonstruuj modele klasyfikacji: LDA, QDA, 1NN & NB dla tych danych.
# (b) Oszacuj blad klasyfikacji dla skonstruowanych metod.
# (c) Który ze skonstruowanych klasyfikatorów jest godny polecenia dla tego zbioru danych?
#   Odpowiedz uzasadnij.
# (d*) Spróbuj zwizualizowac wyniki w przestrzeni utworzonej przez dwie pierwsze skladowe
# glówne


library(mlbench)
?Vehicle
data(Vehicle)
View(Vehicle)
skimr::skim(Vehicle)
sum(is.na(Vehicle)) # 0 stąd nie ma NA
table(Vehicle$Class) # mniej więcej równy ilościowo rozkład


# 1NN
library(class) 
Vehicle$Class <- as.factor(Vehicle$Class)

(knn(Vehicle[, 1:18], 
     Vehicle[, 1:18], 
     cl = Vehicle$Class, 
     k = 1) -> pred.knn) # (przewidywane etykiety musza być prawidłowe). zbiór uczący i testowy ten sam.
#mean(pred.knn != Vehicle$Class) # Error rate (resub.) = 0, zbiór uczący i testowy ten sam więc musi wyjść 0

#Komentarz:
# W metodzie 1-NN wynik mocno zależny, w tym przypadku od jednego, najbliższego sąsiada. 
# Często metoda zbyt czuła na losowość ukrytą w danych, mimo, iż co do zasady odporna na wartości odstające,zakłócenia.


# LDA
library(MASS) 
(model.lda <- lda(Class ~ ., Vehicle)) 
(classification.lda <- predict(model.lda, Vehicle)) 
(contingency.table.lda <- table(classification.lda$class, Vehicle$Class)) 
# Opel 66 razy błędnie zakwalifikowany jako saab, zaś saab błędnie 57 razy jako opel

#classification.lda$class != Vehicle$Class # błędy
#print(mean(classification.lda$class != Vehicle$Class) * 100, 4) # Błąd ponownego podstawienia 20.21 %
#print((1 - sum(diag(contingency.table.lda) / sum(contingency.table.lda))) * 100, 4) # 20,21 (tak samo jak wyżej z contingency.table.lda)
100 * sum(diag(contingency.table.lda)) / sum(contingency.table.lda) 
#tj.  1 - błąd resubstytucji = 79.78723% !!!!! 


# QDA
(model.qda <- qda(Class ~ ., Vehicle))
(classification.qda <- predict(model.qda, Vehicle)) 
(contingency.table.qda <- table(classification.qda$class, Vehicle$Class))
# Opel 31 razy błędnie zakwalifikowany jako saab, zaś saab 25 razy błędnie jako opel 

#classification.qda$class != Vehicle$Class # błędy
#print(mean(classification.qda$class != Vehicle$Class) * 100, 4) # Błąd ponownego podstawienia 8,392 %
#print((1 - sum(diag(contingency.table.qda) / sum(contingency.table.qda))) * 100, 4) # 8,392% 
#round(classification.qda$posterior, 4) # Posterior probabilities
100 * sum(diag(contingency.table.qda)) / sum(contingency.table.qda)
# 91.60757% (lepsza jakość klasyfikacji niz w LDA 79.78723%)

# KOMENTARZ:
#QDA znacznie lepiej aniżeli LDA (patrząc na wyniki lepiej klasyfikuje, mniej sie myli)



# NB
library(klaR) 
(model.nb.normal <- NaiveBayes(Class ~ ., Vehicle)) # NB Normal
(classification.nb.normal <- table(predict(model.nb.normal, Vehicle)$class, Vehicle$Class))  
# bus pomylony az 133 razy z van'em,  opel 55 razy z saab'em, i 63 z van'em,
# saab blednie zakwalifikowany 58 razy jako opel, i 67 razy jako van. 
# Van ogolnie rzecz biorac dobrze wpadał w klase.

model.nb.kernel <- NaiveBayes(Class ~ ., data = Vehicle, usekernel = TRUE) # NB Kernel
(classification.nb.kernel <- table(predict(model.nb.kernel, Vehicle)$class, Vehicle$Class))
# od razu lepiej to wyglada, anizeli 'NB Normal' 
# Opel blednie pomylony 69 razy z sabem i 66 razy z vanem
# zas saab blednie zakwalifikowany jako van 58 razy


#PODSUMOWANIE:

# error rates
1 - sum(diag(classification.nb.normal)) / nrow(Vehicle) #  52,71868 %
1 - sum(diag(classification.nb.kernel)) / nrow(Vehicle) # 34,04255 %
1 - sum(diag(contingency.table.lda)) / nrow(Vehicle) # 20,21277 %
1 - sum(diag(contingency.table.qda)) / nrow(Vehicle) # 8,392435 %


# CV - LOO error rate - tylko dla LDA i QDA
model.lda.cv <- lda(Class ~ ., Vehicle, CV = TRUE) # CV (LOO)  lda
#model.lda.cv$class # Prediction for LOO
100 * mean(model.lda.cv$class != Vehicle$Class) # LDA LOO error rate; 22.10402% (podobnie jak wyżej 20,21277 % )
model.qda.cv <- qda(Class ~ ., Vehicle, CV = TRUE) # CV (LOO) qda
#model.qda.cv$class # Prediction for LOO
100 * mean(model.qda.cv$class != Vehicle$Class) # QDA LOO error rate; 14.4208%  (wiecej niz wyzej 8,392435 %)


library(ipred)
# 1NN
mymod <- function(formula, 
                  data, 
                  l = 1) {
  ipredknn(formula = formula, data = data, k = l)
}
errorest(Class ~ ., 
         data = Vehicle, 
         model = mymod, 
         estimator = 'cv', 
         predict = function(o, newdata) predict(o, newdata,  'class'), 
         est.para = control.errorest(k = nrow(Vehicle)), 
         l = 1) # CV: Misclassification error:  0.3475 (34,75%)
errorest(Class ~ ., 
         data = Vehicle, 
         model = ipredknn, 
         estimator = 'boot',
         predict = function(o, newdata) predict(o, newdata, type = 'class'),
         est.para = control.errorest(nboot = 100),
         k = 1) # Bootstrap error: Misclassification error:  0.3625 (36,25%) , Standard deviation: 0.0018 

# LDA
errorest(Class ~ ., 
         data = Vehicle, 
         model = lda, 
         estimator = 'cv', 
         predict = function(o, newdata) predict(o, newdata)$class, 
         est.para = control.errorest(k = nrow(Vehicle))) #LOO: Misclassification error:  0.221  (22,1%)
errorest(Class ~ ., 
         data = Vehicle, 
         model = lda, 
         estimator = 'boot', 
         predict = function(o, newdata) predict(o, newdata)$class, 
         est.para = control.errorest(nboot = 100)) #  Bootstrap error: Misclassification error:  0.2247 (22,47%)

# QDA
errorest(Class ~ .,
         data = Vehicle, 
         model = qda, 
         estimator = 'cv', 
         predict = function(o, newdata) predict(o, newdata)$class, 
         est.para = control.errorest(k = nrow(Vehicle))) #LOO: Misclassification error:  0.1442 (14,42%)
errorest(Class ~ ., 
         data = Vehicle, 
         model = qda, 
         estimator = 'boot', 
         predict = function(o, newdata) predict(o, newdata)$class, 
         est.para = control.errorest(nboot = 100)) #Bootstrap error: Misclassification error:  0.1622 (16,22%)

# NB Kerrnel
errorest(Class ~ ., 
         data = Vehicle, 
         model = NaiveBayes, 
         estimator = 'cv', 
         predict = function(o, newdata) predict(o, newdata)$class, 
         est.para = control.errorest(k = nrow(Vehicle)), 
         use.kerrnel = TRUE) #LOO: Misclassification error:  0.5414 (54,14%) There were 50 or more warnings

# NB Normal
errorest(Class ~ ., 
         data = Vehicle, 
         model = NaiveBayes, 
         estimator = 'cv', 
         predict = function(o, newdata) predict(o, newdata)$class, 
         est.para = control.errorest(k = nrow(Vehicle)), 
         use.kerrnel = FALSE) #LOO  (NB Normal) Misclassification error:  0.5414 (54,14%)- There were 50 or more warnings 
errorest(Class ~ ., 
         data = Vehicle, 
         model = NaiveBayes, 
         estimator = 'boot', 
         predict = function(o, newdata) predict(o, newdata)$class, 
         est.para = control.errorest(nboot = 100), 
         use.kerrnel = FALSE) # Bootstrap error: Misclassification error:  0.5443 (54,43%) - There were 50 or more warnings


# KOMENTARZ
# Analizując otrzymane wyniki zdecydowanie wybrałabym klasyfikator QDA, 
#ktory w mojej ocenie mniej się mylił. Ilosc obserwacji wystarczająca dla modelu.



# PCA  - WIZUALIZACJA   LDA a PCA
#min(p, k-1) min(18,4-1) czyli nowy wymiar to byłby 3
par(mfrow = c(2, 1))
new.df <- as.matrix(Vehicle[, 1:18]) %*% model.lda$scaling[, 1:2]
plot(new.df, type = 'n') # Projection
text(new.df, as.character(Vehicle$Class), cex = 0.7, col = as.numeric(Vehicle$Class))
new.df.pca <- prcomp(Vehicle[, 1:18], scale. = TRUE)
summary(new.df.pca) # pierwsze dwie składowe wyjaśniają 59,17% całkowietej wariancji, żeby uzyskać ponad 80% to na pewno minimum pierwsze trzy, może nawet 4 składowe główne
plot(new.df.pca$x, type = 'n') # Projection
text(new.df.pca$x, as.character(Vehicle$Class), cex = 0.7, col = as.numeric(Vehicle$Class))

