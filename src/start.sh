#!/bin/sh
PWDDIR="$(dirname "`readlink -f $0`")"
PARENTDIR="$(dirname "$PWDDIR")"
PROJECT=www

PIDDIR=$PARENTDIR/pid
LOGDIR=$PARENTDIR/log

mkdir -p $PIDDIR
mkdir -p $LOGDIR


echo ------$PROJECT_NAME stop------
# kill pid
for file in `ls $PIDDIR`
do
    kill -9 `cat $PIDDIR/$file 2>/dev/null` 2>/dev/null
    rm $PIDDIR/$file 2>/dev/null
done

echo ------$PROJECT_NAME start------
# run project
for pro in `ls $PWDDIR`
do
    if [ $pro = $PROJECT ];then
        revel run $PROJECT 2>>$LOGDIR/$PROJECT.log &
        # store pid
        PID=$!
        ps -p $PID >/dev/null
        echo $! > $PIDDIR/$PROJECT.pid
        break
    fi
done
