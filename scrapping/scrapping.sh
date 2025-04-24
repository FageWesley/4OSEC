#!/bin/bash


base_url="https://readi.fi/sitemap.xml";
pattern="https://readi.fi/asset"
sql_injection_pattern="((('|\")\s*(OR|AND)\s*('|\"|\d))|(--|;)|(\b(SELECT|UNION|INSERT|UPDATE|DELETE|DROP)\b.*\b(FROM|INTO|TABLE)\b)|(\b(OR|AND)\b\s+\d=\d))"
site=$(curl -s "$base_url" | grep -o '<loc[^>]*>[^<]*</loc>' | sed -e 's/<loc>//g' -e 's/<\/loc>//g' | grep -e $pattern)

for link in $site;do
	title=$(curl -s "${link}" | grep -o '<title[^>]*>[^<]*</title>' | sed -e 's/<title>//g' -e 's/<\/title>//g')
	meta=$(curl -s "${link}" | grep -o '<meta name="description" content="[^"]*"' | sed 's/.*content="\([^"]*\)".*/\1/')
	if (echo "$title"|grep -E "$sql_injection_pattern") || (echo "$meta"|grep -Ei "$sql_injection_pattern"); then 
	       echo "SQL injection detected"
       else
	       sh ./db.sh "$title $meta"
       	       echo "Text succesfuully appened"
	fi
done

# On peut aussi passer les variables arguments en à la fonction sqlite3 afin d'écrire en base de données exactement les
# inputs de l'utilisateur (si l'utilisateur entre un input malveillant, il sera écrit tel quel dans la base de données)
# "INSERT INTO scrapped(title,description) VALUES (?, ?);" "$url" "$title"
