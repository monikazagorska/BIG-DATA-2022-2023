import statistics
import csv
from pathlib import Path

with open(Path(__file__).parent / './dogs-data.csv', encoding='utf-8') as data_file:
    dog_data = csv.DictReader(data_file)
    dog_data = list(dog_data)

# print(dog_data[0])


"""
Zadanie 1

Do listy dog_data zostały wczytane dane o psach i ich właścicielach. Każdy element listy to słownik,
który ma 4 klucze 'OwnerAge', 'Gender', 'Breed', 'DogAge' oznaczające kolejno wiek właściciela (przedział wiekowy), 
płeć psa, rasę psa i wiek psa. 
Przykładowy element listy:
{'OwnerAge': 60, 'Gender': 'M', 'Breed': 'Welsh Terrier', 'DogAge': 3}

a) zapisz do zmiennej listę breeds listę wszystich ras psów zawartych w dog_data. Elementy
    listy powinny być unikatowe i posortowane afalbetycznie (A-Z).

b) Znajdź najpopularniejszą rasę psa dla każdego przedziały wiekowego (klucz `OwnerAge`) i 
    zapisz wynik jako słownik the_most_popular_breed, którego kluczami będą przedziały wiekowe,
    a wartością najpopularniejsza rasa psa (dla danego przedziału).
    
c) Biblioteka statistics (https://docs.python.org/3/library/statistics.html#) pozwala na
    obliczenie podstawowych funkcji statystycznych. Wykorzystaj odpowiednie funkcje i oblicz
    średnią, modę (mode) i wariancję wieku psów.

d)  Zapisz do plik `terriers.txt` nazwy wszystkich Terrierów wraz z ich liczebnością, które znajdują się w dog_data.
    Dane zapisz w formacie CSV. Wykorzystaj bibliotekę `csv` (https://docs.python.org/3.8/library/csv.html).

"""
# ad a)
breed_set = set()
for element in dog_data:
    breed_set.add(element['Breed'])
breed_list = list(breed_set)
breed_list.sort()
print(breed_list)

# ad b)
owner_age_breed_cnt_dict = {}
for element in dog_data:
    owner_age = element['OwnerAge']
    breed = element['Breed']
    if owner_age in owner_age_breed_cnt_dict:
        if breed in owner_age_breed_cnt_dict[owner_age]:
            owner_age_breed_cnt_dict[owner_age][breed] += 1
        else:
            owner_age_breed_cnt_dict[owner_age][breed] = 1
    else:
        owner_age_breed_cnt_dict[owner_age] = {breed: 1}

the_most_popular_breed = {}
for owner_age, dog_breed_cnt in owner_age_breed_cnt_dict.items():
    max_cnt = 0
    max_cnt_dog_breed = ''
    for dog_breed, cnt in dog_breed_cnt.items():
        if cnt > max_cnt:
            max_cnt = cnt
            max_cnt_dog_breed = dog_breed
    the_most_popular_breed.setdefault(owner_age, max_cnt_dog_breed)
print(the_most_popular_breed)

# ad c)
dog_age_list = []
for element in dog_data:
    dog_age_list.append(element['DogAge'])
# print(dog_age_list)
# print(len(dog_age_list))   # 53616
# print(type(dog_age_list[2])) # <class 'str'>

new_dog_age_list = list(map(int, dog_age_list))
# print(type(new_dog_age_list[2])) # <class 'int'>
## ŚREDNIA
print(statistics.mean(new_dog_age_list))  # 6.046609221128022
## WARIANCJA
print(statistics.variance(new_dog_age_list))  # 164.45547931654204
## MODA
print(statistics.mode(new_dog_age_list))  # 0 => dokładnie 4872 razy
# cnt_0 = 0
# for element in new_dog_age_list:
#     if element == 0:
#         cnt_0 += 1
# print(cnt_0)             # 4872 razy
#

# ad d)
terrier_dict = {}
for element in dog_data:
    dog_breed = element['Breed']
    if 'Terrier' in dog_breed:
        if dog_breed not in terrier_dict:
            terrier_dict[dog_breed] = 1
        else:
            terrier_dict[dog_breed] += 1
# print(terrier_dict)

with open('./terriers.txt', mode='w') as plik:
    plik.write('breed, cnt \n')
    for breed, cnt in terrier_dict.items():
        plik.write(breed + ',' + str(cnt) + '\n')
