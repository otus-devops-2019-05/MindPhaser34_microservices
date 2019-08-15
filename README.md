# MindPhaser34_microservices
MindPhaser34 microservices repository

- [Занятие 15: Docker контейнеры. Docker под капотом](https://github.com/otus-devops-2019-05/MindPhaser34_microservices#%D0%B7%D0%B0%D0%BD%D1%8F%D1%82%D0%B8%D0%B5-15-docker-%D0%BA%D0%BE%D0%BD%D1%82%D0%B5%D0%B9%D0%BD%D0%B5%D1%80%D1%8B-docker-%D0%BF%D0%BE%D0%B4-%D0%BA%D0%B0%D0%BF%D0%BE%D1%82%D0%BE%D0%BC)
- [Занятие 16: Docker образы. Микросервисы ](https://github.com/otus-devops-2019-05/MindPhaser34_microservices/tree/docker-3#%D0%B7%D0%B0%D0%BD%D1%8F%D1%82%D0%B8%D0%B5-16-docker-%D0%BE%D0%B1%D1%80%D0%B0%D0%B7%D1%8B-%D0%BC%D0%B8%D0%BA%D1%80%D0%BE%D1%81%D0%B5%D1%80%D0%B2%D0%B8%D1%81%D1%8B)
- [Занятие 17: Сетевое взаимодействие Docker контейнеров. Docker Compose. Тестирование образов]()

### Занятие 15: Docker контейнеры. Docker под капотом.

Для выполнения задания был создан файл docker-1.log. И описано задание со *

Данная команда открывает в контейнере утилиту Htop с локальными ресурсами контейнера (эмулируется окружение, pid начинается с 1)
```shell
docker run --rm -ti tehbilly/htop
```
При выполнении этой команды, неймспейсы и пиды хоста прокидывается в контейнер, pid не присваиваются новые значения и соотвественно HTOP отображает процессы хоста
```shell
docker run --rm --pid host -ti tehbilly/htop
```
Puma-server с mongodb доступны по адресу:
```shell
34.77.238.154:9292
```
Dokcker образ запушен в наш Dockerhub и контейнер разворачивается командой
```shell
docker run --name reddit -d -p 9292:9292 mindphaser/otus-reddit:1.0
```

### Занятие 16: Docker образы. Микросервисы

Для запуска контейнеров с основным заданием без звёздочки необходимо
1. Переключиться на docker-machine
```shell
eval $(docker-machine env docker-host)
```
2. Запустить сбилдить образы:
```shell
docker build -t mindphaser/post:1.0 ./post-py
docker build -t mindphaser/comment:1.0 ./comment
docker build -t mindphaser/ui:2.0 ./ui
```
3. Запустить контейнеры из образов
```shell
docker network create reddit && \
docker volume create reddit_db && \
docker run -d --network=reddit --network-alias=post_db --network-alias=comment_db -v reddit_db:/data/db mongo:latest && \
docker run -d --network=reddit --network-alias=post mindphaser/post:1.0 && \
docker run -d --network=reddit --network-alias=comment mindphaser/comment:1.0 && \
docker run -d --network=reddit -p 9292:9292 mindphaser/ui:2.0
```

Для выполнения задания со * достаточно развернуть контейнеры со следующими параметрами:
```shell
docker run -d -e POST_DATABASE_HOST=cool_post_db -e COMMENT_DATABASE_HOST=cool_comment_db --network=reddit --network-alias=cool_post_db --network-alias=cool_comment_db mongo:latest
docker run -d -e POST_SERVICE_HOST=cool_post --network=reddit --network-alias=cool_post mindphaser/post:1.0
docker run -d --network=reddit -e COMMENT_SERVICE_HOST=cool_comment --network-alias=cool_comment mindphaser/comment:1.0
docker run -d --network=reddit -p 9292:9292 mindphaser/ui:1.0
```
Для выполнени второго задания с * были созданы следующие файлы
```shell
ui/Dockerfile.1
comment/Dockerfile.1
post-py/Dockerfile.1
```

Размер сократился примерно вдове: 
```shell
Образ		     Было/Стало
mindphaser/comment   779MB/304MB
mindphaser/ui        452MB/240MB
mindphaser/post	     325MB/292MB
```

Для post был сделан Dockerfile на базе образа Alpine:3.10

### Занятие 17: Сетевое взаимодействие Docker контейнеров. Docker Compose. Тестирование образов

Проверить проект можно по адресу:
```shell
http://34.77.238.154:9292/
```

Базовое имя docker-compose образуетсяпо следующей маске:
```shell
project_name-container_name-project_id
``` 
,где

project_name - имя проекта, по-умолчанию соответствующее имени папки, в котором находится docker-compose.yml

container_name - имя контейнера

project_id - номер проекта


Чтобы изменить базовое имя, достаточно задать значение для переменной окружения COMPOSE_PROJECT_NAME, либо при запуске проекта, командой:
```shell
docker-compose -p MY_PROJECT_NAME
```
ещё 1 из вариантов, это задать имя контейнера в файлe docker-compose.yml с помощью параметра container_name.
