#!bin/bash

ESTIMATED_YEARS_OF_LIFE=83

date_born_in_seconds=$(date -d "sept 10, 1981" +%s)
date_now_in_seconds=$(date -d "now" +%s)
  
# don't worry about leap years, this is just an estimate anyways
days_of_life=$((ESTIMATED_YEARS_OF_LIFE * 365))
age_in_seconds=$((date_now_in_seconds - date_born_in_seconds))
age_in_years=$((age_in_seconds / 60 / 60 / 24 / 365 ))
days_used_up=$((age_in_seconds / 60 / 60 / 24))
days_left=$((days_of_life-days_used_up))



carpe-diem() {
  clear
  echo -e "\n\n\n"

  echo "Steven William Bragg. Listen:"
  echo "Actuaries say you'll die on the birthday you turn $ESTIMATED_YEARS_OF_LIFE."

  echo "You've used up $days_used_up of your $days_of_life days."
  echo -e "\n"

  echo -e "Days left to live?\n\n"
  echo $days_left

  echo -e "\n\n\n"
}







