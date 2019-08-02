# MindPhaser34_microservices
MindPhaser34 microservices repository

- [Занятие 15: Docker контейнеры. Docker под капотом]()

### Занятие 15: Docker контейнеры. Docker под капотом.

Для выполнения задания был создан файл docker-1.log. И описано задание со *

Данная команда открывает в контейнере утилиту Htop с локальными ресурсами контейнера (эмулируется окружение, pid начинается с 1)
```shell
docker run --rm -ti tehbilly/htop
```
При выполнении этой команды, окружение прокидывается в контейнер, pid не присваиваются новые значения и соотвественно HTOP отображает процессы хоста
```shell
docker run --rm --pid host -ti tehbilly/htop
```
Puma-server с mongodb доступны по адресу:
```shell
34.77.238.154
```
Dokcker образ запушен в наш Dockerhub и контейнер разворачивается командой
```shell
docker run --name reddit -d -p 9292:9292 mindphaser/otus-reddit:1.0
```

