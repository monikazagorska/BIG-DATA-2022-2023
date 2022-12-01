#!/usr/bin/env python
# -*- coding: utf-8 -*-

"""
Napisz funkcję sum_div35(n), która zwraca sumę wszystkich liczb podzielnych
przez 3 lub 5 mniejszych niż n.
"""

# def sum_div35(n):
#     pass # Nic nie rób
#
# input = 100
# # dla n =100 poprawna odpowiedź to 2318



def sum_div35(n):
    sum_items = 0
    for i in range(n):
        if i % 3 == 0 or i % 5 == 0:
            sum_items += i
    return(sum_items)

print(sum_div35(100))