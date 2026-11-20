#!/bin/bash

set -e

expected="The element with atomic number 1 is Hydrogen (H). It's a nonmetal, with a mass of 1.008 amu. Hydrogen has a melting point of -259.1 celsius and a boiling point of -252.9 celsius."

[[ "$(./element.sh)" == "Please provide an element as an argument." ]]
[[ "$(./element.sh 1)" == "$expected" ]]
[[ "$(./element.sh H)" == "$expected" ]]
[[ "$(./element.sh Hydrogen)" == "$expected" ]]
[[ "$(./element.sh 9999)" == "I could not find that element in the database." ]]

echo "Element lookup tests passed."
