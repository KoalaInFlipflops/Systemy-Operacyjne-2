#!/bin/bash

# Znajdź w pliku access_log unikalnych 10 adresów IP w access_log
 echo "Dziesięć unikalnych adresów IP:"
 cat access_log | cut -d ' ' -f 1 | sort -u | grep -E '^([0-9]{1,3}\.){2}[0-9]{1,3}\.[0-9]{1,3}$' | head -n 10

# Znajdź w pliku access_log zapytania, które mają frazę ""denied"" w linku

 echo "Zapytania z frazą 'denied' w linku"
 grep 'denied' access_log

# Znajdź w pliku access_log zapytania wysłane z IP: 64.242.88.10

 echo "Zapytania wysłane z IP 64.242.88.10:"
 grep '64\.242\.88\.10' access_log

# Znajdź w pliku access_log unikalne zapytania typu DELETE

 echo "Unikalne zapytania DELETE:"
 grep -oP 'DELETE.*HTTP/1\.[01]"' access_log | sort | uniq

# Z pliku yolo.csv wypisz wszystkich, których id jest liczbą nieparzystą. Wyniki zapisz na standardowe wyjście błędów.

 echo "Osoby o nieparzystym id:"
 grep '^[[:digit:]]\+[13579],' yolo.csv | cut -d',' -f2,3 >/dev/stderr

# Z pliku yolo.csv wypisz każdy numer IP, który w pierwszym i drugim oktecie ma po jednej cyfrze. Wyniki zapisz na standardowe wyjście błędów
 echo "Adresy IP z pierwszym i drugim oktetem po jednej cyfrze:"
 cut -d ',' -f6 yolo.csv | grep -E "^([0-9]\.[0-9]\.|[0-9][0-9]\.[0-9]\.|[0-9]\.[0-9][0-9]\.|[0-9][0-9]\.[0-9][0-9]\.)" >&2


# We wszystkich plikach w katalogu ‘groovies’ zamień $HEADER$ na /temat/
cd groovies

for file in *; do
    sed -i 's/\$HEADER\$/\/temat\//g' "$file"
done

# We wszystkich plikach w katalogu ‘groovies’ usuń linijki zawierające frazę 'Help docs:'

for file in *; do
    sed -i '/Help docs:/d' "$file"
done

cd ..

OUTPUT=$(./fakaping.sh 2>&1)

#Uruchom skrypt fakaping.sh, wszystkie linijki mające zakończenie .conf zachowaj. Wypisz na ekran i do pliku find_results.log. Odfiltruj błędy do pliku: errors.log.

echo "Wypisanie linijek z zakończeniem ".conf":"
echo "$OUTPUT" | grep  "\.conf" | tee find_results.log
grep -i -E 'PERMISSION DENIED|error' fakaping.sh > errors.log 2>&1

# Uruchom skrypt fakaping.sh, wszystkie errory zawierające ""permission denied"" (bez względu na wielkośc liter) wypisz na konsolę i do pliku denied.log. Wyniki powinny być unikalne.

echo "Wyszukane unikalne errory  zawierające "permission denied":"
echo "$OUTPUT" | grep -i "permission denied" | tee denied.log | sort -u

sort -u -o denied.log denied.log

# Uruchom skrypt fakaping.sh i wszystkie unikalne linijki zapisz do pliku all.log i na konsolę

echo "Unikalne linijki:"
echo "$OUTPUT" | sort -u | tee all.log
