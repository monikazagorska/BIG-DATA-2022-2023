"""
Korzystając ze poniższego słownika, który zawiera informacje z WikiData nt. Adama Mickiewiecza wykonaj następujące zadania:
* Wyświetl miejsce urodzenia (place of birth) A. Mickiewicza.
* Oblicz ile lat żył A. Mickiewicz.
* Dodaj nowy klucz `place of death` o wartości `Istanbul`.
* Zamień wartość klucza `place of birth` na `Zaosie`.
* Dodaj nowy klucz `spouse`, a którego wartością niech będzie słownik `cecylia_data`.
* Wyświetl liczbę elementów listy, która znajduje się pod kluczem `occupation`.
* Wyświetl nazwiko żony A. Mickiewicza.
"""

data = {
    'name': 'Adam',
    'surname': 'Mickiewicz',
    'native language': 'polish',
    'year of birth': 1798,
    'place of birth': 'Zavosse',
    'year of death': 1855,
    'occupation': ['poet', 'professor', 'playwright']
}

cecylia_data = {
    'name': 'Cecylia',
    'surname': 'Szymanowska',
}

print(data['place of birth'])

print(int(data['year of death']) - int(data['year of birth']))

data['place of death'] = 'Istanbul'
print(data)


data['place of birth'] = 'Zaosie'
print(data)

data['spouse'] = cecylia_data
print(data)

lista_occupation = (data['occupation'])
print(lista_occupation)
print(len(lista_occupation))
# lub od razu
print(len(data['occupation']))

print(data['spouse']['surname'])