# Wykorzystując bazę SQLite zawartą pliku 'homework.db' oblicz MEDIANĘ liczby przylotów
# i odlotów na lotnisku w Los Angeles w każdym z 12 miesięcy w roku.
# Następnie zapisz wynik do pliku CSV. (oczekiwany wynik masz w pliku Zadanie_domowe_02_wynik.csv)
#
# Zwróc uwagę, że dla każdego miesiąca masz podane informacje o kilku rodzajów lotów. Należy
# więc je wstępnie zsumować.

library(DBI)
library(RSQLite)
library(dbplyr)
library(tidyverse)



drv <- dbDriver("SQLite")

con <- dbConnect(drv, "Zadanie_domowe_02_homework.db", flags = SQLITE_RO) # połączenie w trybie tylko do odczytu, aby przypadkiem nie zmodyfikować zawartości bazy

#dbplyr
tbl(con, 'flights')
#DBI
dbGetQuery(con, 'SELECT * FROM flights')

d_from_db = tbl(con, 'flights') %>% 
  collect()

d_from_db

View(d_from_db)


d = d_from_db %>% 
  select(ReportPeriod, Arrival_Departure, FlightOpsCount) %>% 
  mutate(DateFromReportPeriod = format(as.Date(ReportPeriod,'%m/%d/%Y %H:%M:%S'),format='%m/01/%Y')) %>%  # bede grupowac po miesiacu, wiec  'nadpisanie'01 w dniach mi nie przeszkadza
  group_by(DateFromReportPeriod, Arrival_Departure) %>% # miesiac i rok , a dzien ustawiony na 01, ale i tak wszystkie daty wchodza do grupowania
  summarise(SumOfFlightsPerMonth = sum(FlightOpsCount)) %>% # sumowanie lotow w miesiacu
  mutate(month = format(as.Date(DateFromReportPeriod,'%m/%d/%Y'),format='%m/01/2000')) %>% # interesuje mnie tylko miesiac z daty, wiec dalej moze byc cokolwiek
  group_by(month, Arrival_Departure) %>% 
  summarise(mediana= median(SumOfFlightsPerMonth)) %>%   # nie potrzeba arrange(SumOfFlightsPerMonth), mediana sam sortuje
  mutate(month = format(as.Date(month,'%m/%d/%Y'),format='%B')) # zeby bylo jak w oczekiwanej odpowiedzi,

d
View(d)

write_csv(d, "zadanie_domowe_02-Monika_Zagorska.csv")  # sep.,przecinki

dbDisconnect(con)
# oczekiwany wynik:
readr::read_csv('Zadanie_domowe_02_wynik.csv')