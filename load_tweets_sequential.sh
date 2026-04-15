#!/bin/bash

files=$(find data/*)

echo '================================================================================'
echo 'load denormalized'
echo '================================================================================'
time for file in $files; do
    echo "$file"
    sh load_denormalized.sh "$file"
done

echo '================================================================================'
echo 'load pg_normalized'
echo '================================================================================'
time for file in $files; do
    echo "$file"
    python3 -u load_tweets.py --db postgresql+psycopg2://postgres:pass@localhost:58433/postgres --inputs "$file"
done

echo '================================================================================'
echo 'load pg_normalized_batch'
echo '================================================================================'
time for file in $files; do
    echo "$file"
    python3 -u load_tweets_batch.py --db=postgresql://postgres:pass@localhost:58434/postgres --inputs "$file"
done
