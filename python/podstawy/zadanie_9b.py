"""
Biblioteka random posiada funkcję random, która zwraca losową licznę z przedziału [0, 1) (nie przyjmuje żadnych argumentów).
Biblioteka math posiada funkcję hypot, która oblicza odległość punktu od środka układu współrzędnych (punktu [0, 0]) i przyjmuje dwa argumenty: współrzędne punktu.
* Zaimportuj biblioteki random i math
* korzystając z funkcji random wylosuj dwie liczby i przypisz wyniki do zmniennych x i y.
* Korzystając z funkcji hypot oblicz odległość punktu o współrzednych (x,y).
* Dodaj pętlę, która będzie wykonywać te czynności n = 10 razy i będzie zliczać ile razy obliczona odległość jest mniejsza od 1.
* Oblicz stosunek liczby punktów, dla których odległość wynosiła mniej niż 1 do całkowitej liczby punktów. Pomnóż tę wartocść przez 4.
* Podstaw za n wartości 100, 1000, 1000000. Do jakiej wartości zbiegają wartości?
"""

import random
import math

x = random.random()
y = random.random()

print(x)
print(y)

distance = math.hypot(x, y)
print(distance)

cnt = 0
for n in range(10):
    x = random.random()
    y = random.random()
    distance = math.hypot(x, y)
    if distance < 1:
        cnt += 1
print(cnt/10*4)

## do plus nieskończoność


 ## lub z while
n = 0
cnt = 0
while n < 10:
    x = random.random()
    y = random.random()
    distance = math.hypot(x, y)
    if distance < 1:
        cnt += 1
    n += 1
    print(n)
print(cnt / 10 * 4)

## do plus nieskończoność