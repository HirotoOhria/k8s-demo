COUNT=0

if [ -z "$INTERVAL" ]; then
    INTERVAL=3
fi

while [ true ];
do
    TM=`date | awk '{print $4}'`
    printf "%s : %s \n" $TM $COUNT
    let COUNT=COUNT+1
    sleep $INTERVAL
done