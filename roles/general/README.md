General
=======

Роль для базовой настройки нового сервера.

На текущий момент реализовано:

- Настройка имени хоста.
- Настройка DNS на хостах, а так же управление DNS записями.
- Создание локальных пользователей и групп.

Переменные роли
---------------

Описание переменных и примеры заполнения приведены в директории [defaults/main](defaults/main)

Пример Playbook
---------------

**hosts :**

```ini
[database]
prod-cloud-db-1.service.t1-cloud.ru ansible_host=10.89.10.51
```

Для того чтобы можно было управлять DNS записями inventory должен удовлетворять требованиям:

1. inventory_hostname - это DNS запись, которую мы хотим создать.
2. ansible_host - это IP адрес хоста.

В противном случае шаг с nsupdate будет пропущен.

**play.yml :**

```yaml
---
- hosts: database
  roles:
    - general
  vars:
    general_users:
      - name: ivanoviv
        password: '$6$lJeJRW9JLyHpxrfr$BquXNHPsbpHyhz0t61WfQzaqpMQMc/Z.BQMar4rclXwWWVo0kd.QvCTFUw4TBQWyQg.p2ZKC7woLI1rxcaG3Y/'
```

Разработка и тестирование роли
------------------------------

В процессе разработки роли рекомендуется проводить тестирование при помощи **molecule**, а так же добавлять новые тесты,
в случае появления дополнительного функционала.

Для тестов используется **docker**, поэтому он должен быть установлен на вашем хосте.

```shell
# Создание виртуального окружения и установка зависимостей.
python3 -m venv venv
source venv/bin/activate
pip install -r requirements.txt

# Запуск тестов.
molecule test
```
