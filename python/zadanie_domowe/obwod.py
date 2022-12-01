"""
Zaimplementuj funkcję `obwod`,obliczy i zwróci obwód zadanej figury. 
Szablon funkcji znajduje się poniżej. Funkcja przyjmuje dokładnie 1 argument, będący listą 2-elementowych krotek
oznaczającymi współrzędne x i y wierzchołka.

Przykład:
obwod([(0,0), (0,1), (1,1), (1,0)]) == 4

points = [
  p1 = (0,0),
  p2 = (0,1),
  p3 = (1,1),
  p4 = (1,0)
]
"""
from math import sqrt


def obwod(points):
    if len(points) == 2:
        return length_of_segment(points[0], points[1])
    else:
        sum_length_segments = 0
        for i in range(len(points)):
            sum_length_segments += length_of_segment(points[i], points[(i + 1) % len(points)])
        return sum_length_segments


def length_of_segment(p1, p2):
    return sqrt((p2[0] - p1[0]) ** 2 + (p2[1] - p1[1]) ** 2)


print(obwod([(0, 0), (0, 1), (1, 1), (1, 0)]))
print(obwod([(0, 0), (0, 1), (1, 1), (1, 0), (0, -1)]))
print(obwod([(0, 0), (0, 1), (2, 1), (2, 0)]))
print(obwod([(0, 0), (0, 1)]))
print(obwod([(0, 0), (0, 1), (1, 1)]))
