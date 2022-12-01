"""
Zadania: Zaimportuj bibliotekę statistics, która zawiera funckje do obliczenia podstawych wielkości statystycznych (średnia, mediana, moda):
    statistics.mean -- obliczenie średniej
    statistics.median -- obliczenie mediany
    statistics.variance -- obliczenie wariancji
    statistics.stdev -- obliczenie odchylenia standardowego Oblicz te wielkości dla wartości z poniższego słownika.
Każda z tych funkcji przyjmuje jeden argument: listę wartości.
"""

import statistics
members = {
    'April': 211819,
    'May': 682758,
    'June': 737011,
    'July': 779511,
    'August': 673790,
    'September': 673790,
    'October': 444177,
    'November': 136791,
}


print(statistics.mean(members.values()))
print(statistics.median(members.values()))
print(statistics.variance(members.values()))
print(statistics.stdev(members.values()))