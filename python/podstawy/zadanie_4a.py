"""
Sprawdź czy tekst 'aAaAaA' znajduje się w tablicy passwords.
W zależności czy znajduje się czy też nie, wyświetl na ekranie odpowiedni komunikat.
"""

passwords = ['aaAaa', 'aAAAaa', 'aaaaaaA', 'aaaAAAAA', 'aaAAAaa', 'aAaAaA', 'aAaAaAA']

if 'aAaAaA' in passwords:
    print('\'aAaAaA\' znajduje się  w tablicy passwords')
else:
    print('\'aAaAaA\' nie znajduje się w tablicy passwords')



print(passwords.index('aAaAaA'))  # indeks w 5 czyli 6 element