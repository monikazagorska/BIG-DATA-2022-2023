
## import zawsze u góry (wszystkie)

import os
print(os.getcwd())

day = "09"
month = 11
year = 2022

print('Dziś jest', day, "/", month, '/', year)



print(0 == 0.0)



user = None

print('Wartość zmiennej:', user)  #none
print('Wartość logiczna zmiennej:', bool(user)) #false
print(user == False)    #false



var = str(2021)

print('rok:', var)
print(var == 2021) # false, bo string i int
print(var == '2021')    # string i string

x = ''
print(x)


import os
print(os.name)
from os import getenv
print('Nazwa uzytkownika: {}'.format(getenv("USER")))
# importujemy bibliotekę os. Dostęp do stałej jest "przez kropkę".
# Z biblioreki os importujemy funkcję getenv (zwraca wartości zmiennych systemowych).

import math
math.cos(math.pi)

import calendar as cal
cal.TextCalendar().prmonth(2021, 10)

from datetime import date
today = date(2022, 11, 5)
print(today.month) # atrybut
print(today.weekday()) # metoda



from datetime import date as dt
today = dt(2022, 11, 5)
print(today.month) # atrybut
print(today.weekday()) # metoda
