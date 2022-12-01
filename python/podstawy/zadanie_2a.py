"""
Poniżej znajduje się lista `websites`. 
 * Pod jakim indeksem znajduje się wartość 'pinterest.com'?
 * Zamień wartość piątego elementu na 'yahoo.com'.
 * Dodaj na koniec listy nowy element: 'bing.com'
 * Korzytając z indeksowania stwórz podlistę składającą się z elementów 'facebook.com', 'twitter.com'. Wynik przypisz do zmniennej `social_networks`.
 * Rozszesz listę `websites` o elementy z listy `polish_websites`.
 * Ile elementów liczy teraz lista `websites`?
"""


websites = ['google.com', 'facebook.com', 'twitter.com', 'pinterest.com', 'python.org']

polish_websites = ['onet.pl', 'interia.pl', 'wp.pl']


print(websites.index('pinterest.com'))

websites[4] = 'yahoo.com'
print(websites)
websites.append('bing.com')
print(websites)

social_networks = websites[1:3]
print(social_networks)

# tak zapis =>   print(websites.extend(polish_websites)) zwróciłby None

websites.extend(polish_websites)
print(websites)

print(len(websites))

