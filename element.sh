#! /bin/bash

PSQL="psql --username=freecodecamp --dbname=periodic_table --tuples-only -c"

if [[ $1 ]]
then
  # if argument is number
  if [[ $1 =~ ^[0-9]+$ ]]
  then
    ELEMENT_INFO=$($PSQL "SELECT * FROM elements INNER JOIN properties USING(atomic_number) INNER JOIN types USING(type_id) WHERE atomic_number = $1")
  else
    ELEMENT_INFO=$($PSQL "SELECT * FROM elements INNER JOIN properties USING(atomic_number) INNER JOIN types USING(type_id) WHERE symbol = '$1' OR name = '$1'")
  fi
  # if element not found
  if [[ -z $ELEMENT_INFO ]]
  then
    echo -e "\nI could not find that element in the database\n"
  else 
    echo "$ELEMENT_INFO" | while read TYPE_ID BAR ATOMIC_NUMBER BAR SYMBOL BAR NAME BAR ATOMIC_MASS BAR MELTING_POINT BAR BOILING_POINT BAR TYPE
    do
    echo -e "\nThe element with atomic number $ATOMIC_NUMBER is $NAME ($SYMBOL). It's a $TYPE, with a mass of $ATOMIC_MASS amu. $NAME has a melting point of $MELTING_POINT celsius and a boiling point of $BOILING_POINT celsius.\n"
    done
  fi
else
  echo "Please provide an element as an argument."
fi