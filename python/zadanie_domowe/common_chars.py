#!/usr/bin/env python
# -*- coding: utf-8 -*-


"""
Napisz funkcję common_chars(string1, string2), która zwraca alfabetycznie
uporządkowaną listę wspólnych liter z lańcuchów string1 i string2.
Oba napisy będą składać się wyłacznie z małych liter.
"""


def common_chars(string1, string2):
    common_set = set()
    for letter1 in string1:
        for letter2 in string2:
            if letter1 == letter2 and letter1 != ' ':
                common_set.add(letter1)
    common_list = list(common_set)
    common_list.sort()
    return common_list


input1 = "this is a string"
input2 = "ala ma kota"
output = ['a', 't']

print(common_chars(input1, input2))
print(common_chars(input2, input1))
