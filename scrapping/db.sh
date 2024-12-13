#!/bin/sh

sqlite3 scrapping.db << EOF
CREATE TABLE IF NOT EXISTS scrapped(id INTEGER PRIMARY KEY, title TEXT, description TEXT);
INSERT INTO scrapped(title,description) VALUES ("$1","$2");
EOF
