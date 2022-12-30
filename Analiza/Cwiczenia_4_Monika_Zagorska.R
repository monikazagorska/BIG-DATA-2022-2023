# Analiza danych - Ćwiczenia 3 - Monika Zagórska - nr ind 1200505 (Big Data - Przetwarzanie Danych)

########################################################################################################################
# Zadanie 4.1
# Dla zbioru danych mtcars przeprowadz hierarchiczna analize skupien (metoda usredniego
# wiazania) i nie-hierarchiczna analize skupien (k-srednich). 
# Narysuj dendorgram.
# Ile skupien wydaje sie sensowne? Wyznacz indeks CH oraz wspólczynnik zarysu. 
# Ile skupien mozesz zaproponowac na ich podstawie?


?mtcars
dim(mtcars)
View(mtcars)
names(mtcars)
rownames(mtcars)

mtcars_omit_na <- na.omit(mtcars)
mtacrs_sc <- scale(mtcars_omit_na)

# (metoda uśredniego wiazania)
library(vegan)
dist.mtcars <- dist(mtacrs_sc, method = "euclidean") # odległości euklidesowe
cluster.mtcars <- hclust(dist.mtcars, method = 'average')
plot(cluster.mtcars) # dendodgram- 4 klastry
cutree(cluster.mtcars, k = 4)
rect.hclust(cluster.mtcars, k = 4, border = 2)

tree<-cutree(cluster.mtcars, k=4)
table(tree) # liczebnosc w grupie tree
# 1  2  3  4 
#11  7 12  2 


#wynik = hclust(dist(mtcars))
#plot(wynik, hang = -1 ) #Dendrogram 
#skupienia1 = identify(wynik) # "Pozwala, za pomocą kliknięć myszy na wiązania,
#dokonać podziału na skupienia, jako wynik otrzymujemy prostokąty na wykresie
#oraz podział obiektów na skupienia w zmiennej wynikowej polecenia. Automatycznego
#podziału można dokonać za pomocą funkcji rect.hclust."
#rect.hclust(cluster.mtcars)
#skupienia2 = cutree(wynik, k = 4) #Pozwala wydzielić określoną liczbę skupień,
#jako wynik otrzymujemy obiekty wraz z etykietami klas.


# ładniejszy dendogram
#install.packages('ggdendro')
library(ggdendro) 
ggdendrogram(cluster.mtcars, theme_dendro = FALSE)


library(factoextra) 
#install.packages('ggpubr')
fviz_cluster(list(data = mtacrs_sc, cluster = cutree(cluster.mtcars, k = 4)))# dla 4 klastrow, wydaje sie byc ok


# wybór optymalnej ilosci klastrow
# 'elbow method' - 'wyplaszczenie' dla 4 badz  5 klastrów 
fviz_nbclust(mtacrs_sc, FUN = hcut, method = "wss")

# lub inna metoda wybory optymalnej liczy klastrow
fviz_nbclust(mtacrs_sc, FUN = hcut, method = "silhouette")


# k-srednich z 4 klastrami
model.kmeans4 <- kmeans(mtacrs_sc, centers = 4, nstart = 100)
model.kmeans4   # K-means clustering with 4 clusters of sizes 7, 5, 8, 12

# Wykres z klastrami(4) dla pierwszych dwóch składowych glownych 
library(cluster)
clusplot(mtacrs_sc, model.kmeans4$cluster, color=TRUE, shade=TRUE, labels=2, lines=0)

# porownanie 2 rozwiazan (hierarchiczne i nie-hierarchiczne[4 klastry])
# install.packages('fpc')
library(fpc)
cluster.stats(dist.mtcars, tree, model.kmeans4$cluster)

# CH index
library(vegan) 
model.cascade <- cascadeKM(mtacrs_sc, 2, 10)
model.cascade$results # CH index   => max calinski => 27.32530 dla 4 grup (dane przeskalowane)
plot(model.cascade)

library(vegan) 
model.cascade <- cascadeKM(mtcars_omit_na, 2, 10)
model.cascade$results # CH index   => max calinski => 162.1163 dla 10 grup (dane nie-przeskalowane), ale za duzo 10 grup dla tych danych
plot(model.cascade)


# Silhouette 
library(cluster) 
sil.index <- silhouette(model.kmeans4$cluster, 
                        dist = dist(mtacrs_sc, 
                                    method = 'euclidean'))
summary(sil.index) #  nie ma ujemnych => ok
plot(sil.index) # chcemy 'łagodne ostrze noża'
sil.index[, 3] # s(i)
mean(sil.index[, 3]) # mean s(i)


# sprawdzam jeszcze dla k-srednich z 5 klastrami
model.kmeans5 <- kmeans(mtacrs_sc, centers = 5, nstart = 100)
model.kmeans5   # K-means clustering with 5 clusters of sizes 12, 4, 2, 7, 7
sil.index5 <- silhouette(model.kmeans5$cluster, 
                       dist = dist(mtacrs_sc, 
                                   method = 'euclidean'))
summary(sil.index5) #  nie ma ujemnych => ok
plot(sil.index5) # chcemy jak najbardziej 'łagodne ostrze noża', dla 4 kalstrow wydaje sie byc lepiej
sil.index5[, 3] # s(i)
mean(sil.index5[, 3]) # mean s(i)
# Wykres z klastrami(5) dla pierwszych dwóch składowych glownych
library(cluster)
clusplot(mtacrs_sc, model.kmeans5$cluster, color=TRUE, shade=TRUE, labels=2, lines=0)


# W mojej ocenie jednak 4 klastry wydają się być najbardziej optymalne dla zbioru mtcars

