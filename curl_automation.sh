input="hive_input_expected.txt"
while IFS= read -r var
do
var1=`echo $var | cut -f1 -d'|' `
var2=`echo $var | cut -f2 -d'|' `
var3=`echo $var | cut -f3 -d'|' `
var4=`echo $var | cut -f4 -d'|' `

echo "INPUT: $var1"

output_curl=`curl "https://sheetsu.com/apis/v1.0su/0f588f4e1bff/search?id=$var1" -w "\n" | sed "s/[^a-zA-Z0-9:,]/ /g" | tr -d ' ' `

API_op_SHOE_SIZE=`echo $output_curl | cut -f2 -d'=' | cut -f3 -d',' | cut -f2 -d':' `
API_ERROR_OR_NOT=`echo $output_curl | cut -f2 -d'=' | cut -f1 -d':' `

if [ "$var4" = "ERROR" ] && [ "$API_ERROR_OR_NOT" = "error" ]
then

echo "=========PASS=========="
echo "INPUT id : $var1 "
echo "INPUT US shoe size : $var3 "
echo "Expected INDIA shoe size : $var4 "
echo "API output is :  $output_curl "
echo "======================="

elif [ "$var4" != "ERROR" ] && [ "$API_ERROR_OR_NOT" = "error" ]
then

echo "=========FAIL=========="
echo "INPUT id : $var1"
echo "INPUT US shoe size : $var3"
echo "Expected INDIA shoe size : $var4"
echo "API output : $output_curl"
echo "API_output_shoe size : $API_op_SHOE_SIZE"
echo "======================="

elif [ "$API_op_SHOE_SIZE" -ne "$var4" ]
then

echo "=========FAIL=========="
echo "INPUT id : $var1"
echo "INPUT US shoe size : $var3"
echo "Expected INDIA shoe size : $var4"
echo "API output : $output_curl"
echo "API_output_shoe size : $API_op_SHOE_SIZE"
echo "======================="

elif [ "$API_op_SHOE_SIZE" -eq "$var4"  ]
then
echo "=========PASS=========="
echo "INPUT id : $var1"
echo "INPUT US shoe size : $var3"
echo "Expected INDIA shoe size : $var4"
echo "API output : $output_curl"
echo "API_output_shoe size : $API_op_SHOE_SIZE"
echo "======================="
else

echo "=========NOCLUE=========="
echo "INPUT id : $var1"
echo "INPUT US shoe size : $var3"
echo "Expected INDIA shoe size : $var4"
echo "API output : $output_curl"
echo "API_output_shoe size : $API_op_SHOE_SIZE"
echo "======================="

fi


done < "$input"
