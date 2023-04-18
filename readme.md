# Сервис для быстрого развёртывания БД разработки под BPMSoft

## Настройка

1. Положить в корневую директорию файл с бекапом бд и назвать его db.backup
2. Вызвать docker-compose up
3. Скорректировать ConnectionStrings необходимого стенда

## Взаимодействие с PgAdmin через веб-интерфейс
1. Зайти на localhost:5050
2. Подключиться к серверу бд. Адрес: host.docker.internal. Порт:5432. Уз: postgres/postgres

## Настройка бд в ConnectionStrings.сonfig
`<add name="db" connectionString="Pooling=True;Database=creatio;Host=localhost;Port=5432;Username=creatioroot;Password=root;Timeout=500;Command Timeout=400" />
`

## Учётные записпи

1. УЗ для восстановления бекапа serveradmin/admin - Задаётся в `initRoles.sql`
2. creatioroot/root - Задаётся в `initRoles.sql`
3. postgres/root - Задаётся в .ENV или `docker-compose.yml`

## Переустановка бд
1. docker-compose down --volumes
2. Удаление папки postgres
docker-compose up --build --force-recreate -d