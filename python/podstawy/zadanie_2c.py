"""
Lista iris_setosa zawiera informacje o 4 egzemplarzach kosacieca szczecinkowego.
Pierwszy indeks to długość kwiata.
Drugi indeks to szerokość kwiata.
Trzeci indeks to długość liścia.
Czwarty indeks to szerokość liścia.

* Oblicz średnią szerokość kwiata.
* Dodaj do listy dane o nowym egzemplarzu: (5.4, 3.9, 1.7, 0.4)



TU SA WYJŚCIOWO =>  3 EGZEMPLARZE, BO 3 WIERZSZE ????

"""


# iris_setosa  = [[5.1, 3.5, 1.4, 0.2],[4.9, 3, 1.4, 0.2],[4.7, 3.2, 1.3, 0.2]]

iris_setosa  = [
    [5.1, 3.5, 1.4, 0.2],
    [4.9, 3, 1.4, 0.2],
    [4.7, 3.2, 1.3, 0.2],
]

lista_szerokosci_kwiata = list((iris_setosa[0][1], iris_setosa[1][1], iris_setosa[2][1]))   # x = [] # albo równoważnie y = list()
print(lista_szerokosci_kwiata)  # [3.5, 3, 3.2]

srednia = sum(lista_szerokosci_kwiata) / len(lista_szerokosci_kwiata)
print(srednia)  # 3.233333333333333

print(round(srednia, 2))  # 3,23


iris_setosa.append((5.4, 3.9, 1.7, 0.4))
print(iris_setosa) # [[5.1, 3.5, 1.4, 0.2], [4.9, 3, 1.4, 0.2], [4.7, 3.2, 1.3, 0.2], (5.4, 3.9, 1.7, 0.4)]

##lub

## for i in iris_setosa:
##     print(i[1])    # 3.5   3  3.2

# suma_item = 0
# for i in iris_setosa:   # i jako wiersz
#     suma_item += i[1]
# print(suma_item / len(iris_setosa))



##lub
# transposed_iris = []
# for i in range(4):
#     transposed_iris.append([row[i] for row in iris_setosa])
# print(transposed_iris)     # [[5.1, 4.9, 4.7], [3.5, 3, 3.2], [1.4, 1.4, 1.3], [0.2, 0.2, 0.2]]
#
# srednia = sum(transposed_iris[1]) / len(transposed_iris[1])
# print(srednia)   # 3.233333333333333
# iris_setosa.append((5.4, 3.9, 1.7, 0.4))
# print(iris_setosa) # [[5.1, 3.5, 1.4, 0.2], [4.9, 3, 1.4, 0.2], [4.7, 3.2, 1.3, 0.2], (5.4, 3.9, 1.7, 0.4)]