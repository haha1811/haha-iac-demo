#!/bin/bash

for i in {1..500}; do
  psql \
    -h haha-iac-demo-aurora-pg-writer-1.cbzkloua6rqu.ap-northeast-1.rds.amazonaws.com \
    -U auroraadmin \
    -d appdb \
    -c "INSERT INTO connection_test (source_host, note)
        VALUES ('ap01', 'loop insert $i');"
done

# sudo chmod +x 
# check & update file .pgpass inside <DBPassword>