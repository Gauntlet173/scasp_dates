#! /bin/sh
success=0
fail=0

echo
echo "-----------------------------------------------------------"
echo " Running tests from ${1:-tests} in scasp..."
echo " Usage: ./run_test.sh filename"
echo "-----------------------------------------------------------"
echo

STARTTIME=$(date +%s)
for i in ${1:-tests}/*.pl; do
    echo "TEST DESCRIPTION: $i"
    grep "DESCRIPTION" $i | sed 's/\%\% DESCRIPTION: //'
    scasp -s1 $i $1 > temp.out
    echo
    echo "TEST RESULT:"
    grep -A 1 "QUERY:" temp.out
    grep "no models" temp.out
    if [ $? -eq 0 ]
    then
        fail=$((fail + 1))
    fi
    grep "ANSWER:" temp.out
    if [ $? -eq 0 ]
    then
        success=$((success + 1))
    fi
    echo
    echo "----------------------------------"
    echo
    rm temp.out
done


ENDTIME=$(date +%s)
echo
echo "Tests Complete. ${success} successes, ${fail} failures. Processing time $(($ENDTIME - $STARTTIME)) seconds."
echo