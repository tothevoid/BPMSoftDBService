## Настройка

1. Положить в корневую директорию файл с бекапом бд и назвать его db.backup
2. Вызвать docker-compose up
3. Скорректировать ConnectionStrings

## Подключение к БД в pgadmin
1. Зайти на localhost:5050
2. Адрес: host.docker.internal. Порт: 5432 

## Настройка бд в ConnectionStrings.сonfig
`<add name="db" connectionString="Pooling=True;Database=creatio;Host=localhost;Port=5432;Username=creatioroot;Password=111;Timeout=500;Command Timeout=400" />
`

## Переустановка бд
docker-compose down --volumes
docker-compose up --build --force-recreate -d