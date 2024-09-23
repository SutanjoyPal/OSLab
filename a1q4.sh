calculate_age() {
    birth_date=$(echo "$1" | awk -F/ '{print $3"-"$2"-"$1}')
    birth_year=$(date -d "$birth_date" +%Y)
    birth_month=$(date -d "$birth_date" +%-m)
    birth_day=$(date -d "$birth_date" +%-d)

    current_date=$(date +%Y-%m-%d)
    current_year=$(date -d "$current_date" +%Y)
    current_month=$(date -d "$current_date" +%-m)
    current_day=$(date -d "$current_date" +%-d)
    
    age_years=$((current_year - birth_year))
    age_months=$((current_month - birth_month))
    age_days=$((current_day - birth_day))

    if [ "$age_days" -lt 0 ]; then
        age_months=$((age_months - 1))
        age_days=$((age_days + 30))
    fi
    if [ "$age_months" -lt 0 ]; then
        age_years=$((age_years - 1))
        age_months=$((age_months + 12))
    fi
    
    echo "$age_years years, $age_months months, $age_days days"
}

day_of_week() {
    formatted_date=$(echo "$1" | awk -F/ '{print $3"-"$2"-"$1}')
    date -d "$formatted_date" +%A
}

echo "Enter the first birth date (DD/MM/YYYY):"
read birth_date1
echo "Enter the second birth date (DD/MM/YYYY):"
read birth_date2

day1=$(day_of_week "$birth_date1")
day2=$(day_of_week "$birth_date2")

if [ "$day1" == "$day2" ]; then
    echo "Both birthdays fall on the same day of the week: $day1"
else
    echo "The birthdays fall on different days: $day1 and $day2"
fi

echo "Age for first birth date: $(calculate_age "$birth_date1")"
echo "Age for second birth date: $(calculate_age "$birth_date2")"
