"""
Niech x oznacza liczbę uzyskanych punktów. Standardowa skala ocen jest następująca:
* x >= 90 -- 5.0
* 90 > x >= 80 -- 4.5
* 80 > x >= 70 -- 4.0
* 70 > x >= 60 -- 3.5
* 60 > x >= 50 -- 3.0
* x < 50 -- 2.0

Zmienna `points` zawiera liczbę uzyskanych punktów przez studenta.
Napisz instrukcję warunką, która wyświetli ocenę studenta w zależności od liczby punktów.
"""

points = 45
if points >= 90:
    print(5.0)
elif 80 <= points < 90:
    print(4.5)
elif 70 <= points < 80:
    print(4.0)
elif 60 <= points < 70:
    print(3.5)
elif 50 <= points < 60:
    print(3.0)
elif points < 50:
    print(2.0)

## lub

if points >= 90:
    print(5.0)
elif 80 <= points < 90:
    print(4.5)
elif 70 <= points < 80:
    print(4.0)
elif 60 <= points < 70:
    print(3.5)
elif 50 <= points < 60:
    print(3.0)
else:      # gdy wiem, że wyczerpalam wszystkie możliwe warunki
    print(2.0)