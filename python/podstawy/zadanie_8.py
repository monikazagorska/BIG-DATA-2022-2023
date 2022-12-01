"""
Otwórz plik `zen_of_python.txt` i zlicz liczbę linii i słów w tym pliku. 
Następnie przerób kod na funkcję, która jako argument będzie przyjmować ściężkę do pliku i będzie zwracać 
słownik z dwoma kluczami: `liczba_linii` i `liczba_slow`.
"""
from collections import Counter

file = open("zen_of_python.txt", "r")
count_lines = len(file.readlines())
print(count_lines)
file.close()
#
#
## lub , gdy wiekszy plik
## count = -1
## for count, wiersz in enumerate(file):
##     pass
## count += 1
## print(count)
#
#
file = open("zen_of_python.txt", "r")
count_words = Counter(file.read().split())  # Counter => liczy ile razy dany element pojawia sie, split- tzn usuwa spacje na poczatku i na koncu, ale '--' tego nie pomija
                                            # tj. slownik
print(count_words)
print(sum(count_words.values()))
file.close()

## zen_file = open("zen_of_python.txt", "r")
## count_lines = Counter(zen_file.readlines())
## print(sum(count_lines.values()))
##zen_file.close()
#

## zen_file = open("zen_of_python.txt", "r")
## zen_lines = list(zen_file)
## print(len(zen_lines))    # liczba linii
## zen_file.close()


def fun_lines_words(path):
    f = open(path, "r")
    cnt_lines = 0
    cnt_words = 0
    for line in f.readlines():
        cnt_lines += 1
        cnt_words += len(line.split())
    f.close()
    return {'liczba_linii': cnt_lines, 'liczba_slow': cnt_words}

print(fun_lines_words("zen_of_python.txt"))