"""
1. Napisz rekurencyjną funkcję, która zwróci n-ty wyraz ciągu Fibonacciego.
2. Napisz funkcję, która obliczy n-ty wyroz ciągu Fibonacciego nie korzystając z rekurencji.
Np. możesz wykorzystać listę do obliczania kolejnych wartości ciągu.

Ciąg Fibonacciego:
a[0] = 1, a[1] = 1, a[n] = a[n-1] + a[n-2] dla n>=2

"""
## rekurencyjny
def fib(n):
    if n == 0:     # mozna po prostu n < 2 return 1,  i dalej  else tak jak jest
        return 1
    elif n == 1:
        return 1
    else:
        return (fib(n-1) + fib(n-2))

print(fib(0))
print(fib(1))
print(fib(2))
print(fib(6))


## iteracyjny,
## p - poprzedni wyraz (na początku równy zerowemu wyrazowi)
## w - obecny wyraz (na początku równy pierwszemu wyrazowi)
## Pętla for i in range(n-1) wykona się n-1 razy, czyli np. dla n=2 wykona się 1 raz.

def fib_i(n):
    if n == 0:
        return 1
    elif n == 1:
        return 1
    p, w = 1, 1
    for i in range(n-1):
        p, w = w, p+w
    return w

print(fib_i(0))
print(fib_i(1))
print(fib_i(2))
print(fib_i(6))


## lub iteracyjny
def fibb(n):
    result = [1, 1]
    for i in range(n-1):
        result.append(result[i] + result[(i + 1)])
    return(result)

print(fibb(0))
print(fibb(1))
print(fibb(2))
print(fibb(6))

# https://maturka.it/algorytmy/python-ciag-fibonacciego/