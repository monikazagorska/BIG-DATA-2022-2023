"""
Poniższy słownik zawiera dane z kilku wybranych krajów nt. liczby drzew na kilometr kwadratowy.
 a) Wypisz na ekran nazwy tych krajów, dla których współczynnik ten jest większy niż 20000.
 b) Wypisz na ekran nazwy tych krajów, dla których współczynnik ten jest większy niż 10000, ale mniejszy niż 20000.
"""

tree_per_sqkm = {
    "Brazil": 39542,
    "Bulgaria": 24987,
    "Canada": 36388,
    "Denmark": 6129,
    "Finland": 90652,
    "France": 24436,
    "Greece": 24323,
    "India": 11109,
    "Japan": 49894,
    "Russia": 41396,
    "Saudi Arabia": 1,
    "Syria": 534,
    "United States": 23513,
    "Taiwan": 69593,
    "Turkey": 11126,
}


for key, value in tree_per_sqkm.items():    # nie wiem w ktorym ma być = 20_000,
    if value > 20_000:                            # dwa if-y, bierze pierwszy wiersz i sprawdza w kazdym if'ie, nie ma tu else (w przeciwnym wypadku) i nie ma wysjcia z if'a
        print(key)
    if 10_000 < value < 20_000:
        print('Nazwy krajów dla których wspoł. drzew na km^2 jest większy niż 10000, a mniejszy niz 20000: ', key)

## tutaj warunki sa rozlaczne, ale  np mogloby byc w pierwszym >20000 , a w drugim powyzej 10000 to dwa razy wypisaloby


## lub
for key, value in tree_per_sqkm.items():
    if value > 20_000:
        print(key)
    if 10_000 < value and value < 20_000:
        print('Nazwy krajów dla których wspoł. drzew na km^2 jest większy niż 10000, a mniejszy niz 20000: ', key)