pg_restore --username=sa --dbname=creatio --no-owner --no-privileges ./docker-entrypoint-initdb.d/db.backup
echo "DB restored"
psql --username=sa --dbname=creatio -c "ALTER DATABASE creatio OWNER TO creatioroot"
psql --username=sa --dbname=creatio --file=/ownerSwap.sql --variable owner=creatioroot --variable ON_ERROR_STOP=1
echo "Owner changed"