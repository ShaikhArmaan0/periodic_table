#!/bin/bash

if [[ -z $1 ]]
then
  echo "Please provide an element as an argument."
  exit 0
fi

element=${1//\'/\'\'}
result=$(psql --username=freecodecamp --dbname=periodic_table -X -qAt \
  -F $'\t' \
  -c "SELECT e.atomic_number, e.name, e.symbol, t.type,
             p.atomic_mass, p.melting_point_celsius, p.boiling_point_celsius
      FROM elements e
      JOIN properties p USING (atomic_number)
      JOIN types t USING (type_id)
      WHERE e.atomic_number::text = '$element'
         OR e.symbol = '$element'
         OR e.name = '$element';")

if [[ -z $result ]]
then
  echo "I could not find that element in the database."
  exit 0
fi

IFS=$'\t' read -r atomic_number name symbol type mass melting boiling <<< "$result"
echo "The element with atomic number $atomic_number is $name ($symbol). It's a $type, with a mass of $mass amu. $name has a melting point of $melting celsius and a boiling point of $boiling celsius."
