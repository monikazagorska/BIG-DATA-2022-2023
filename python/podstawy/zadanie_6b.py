#!/usr/bin/env python
# -*- coding: utf-8 -*-


"""
 * Podziel zmienną `text` na słowa, korzystając z metody split.
 * Dodaj do listy `oov`, wszystkie słowa (bez powtórzeń), które nie są zawarte w liście `vocab`.
"""

text = "this is a string , which i will use for string testing"
vocab = [',', 'this', 'is', 'a', 'which', 'for', 'will', 'i']

oov = []

# print(text.split(" "))
text_split = text.split(" ")

oov_set = set()
for voc in text_split:
    if voc not in vocab:
        oov_set.add(voc)  # set zawiera unikalne
oov_list = list(oov_set)
print(oov_list)

## LUB

for voc in text_split:
    if voc not in vocab:
        oov.append(voc)
print(oov)    # z duplikatami

oov_distinct = []   # oov ale unikalne
duplist = []        # dupliakty
for voc in oov:
    if voc not in oov_distinct:
        oov_distinct.append(voc)
    else:
        duplist.append(voc)
print(oov_distinct)  # lista unikalnych slow
print(duplist)

## lub
# print(text_split)
#
# for element in text_split:
#     exist = False                   # zmienna sterujaca
#     for element2 in vocab:
#         if element == element2:
#             exist = True
#     if not exist:
#         oov.append(element)
# print(set(oov))    # set() tj. zbiór,  zbiory zwawieraja dane unikalne, nieuporzadkowane,  elementy setu są niemutowalne
#

## lub
# res = set([x for x in text_split + vocab if x not in text_split or x not in vocab])   # {'use', 'string', 'testing'}
# print(res)
# oov_list = list(res)
