read -p "Please enter the value for uv1: " uv1
read -p "Please enter the value for uv2: " uv2

# Reverse strings using 'rev'
reversed_uv1=$(echo "$uv1" | rev)
reversed_uv2=$(echo "$uv2" | rev)

echo "Reversed uv1: $reversed_uv1"
echo "Reversed uv2: $reversed_uv2"

# Check if both inputs are numeric
if [[ $uv1 =~ ^[0-9]+([0-9]+)?$ ]] && [[ $uv2 =~ ^[0-9]+([0-9]+)?$ ]]; 
then
    sum=$(echo "$uv1 + $uv2" | bc)
    echo "The sum of uv1 and uv2 is: $sum"
else
    echo "Error: Both inputs must be numeric to perform addition."
fi