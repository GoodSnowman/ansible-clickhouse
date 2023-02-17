# Ansible Playbook: Clickhouse HA cluster mode for dns-as-a-service

```
Решает задачи:

- Инсталляция и настройка сервисов для запуска высокодоступного кластера Clickhouse, метаданные реплик хранятся в Zookeeper;
- Возможность установки пакетов как из внешних, так и из внутренних источников;
- Управление административными ресурсами компонентов: создание бд, пользователей, выдача прав или настройка аутентификации между сервисами; 
```
## Версии устанавливаемых пакетов:
----------------------------------

| Имя | Версия |
| ---      | ---   |
| **JAVA** | 19.0.2 |
| **Zookeeper** | 3.8.1 |
| **Clickhouse** | 22.12.3.5 |
| **Haprox** | 2.7.3 |
| **Keepalived** | 2.0.19-2 |

## Список протестированных ОС:
------------------------------

```
Ububtu20.04(focal)
```

## Запуск playbook:
-------------------

```
ansible-playbook -i inventories/t1-p1/hosts clickhouse_infra.yml
ansible-playbook -i inventories/t1-p1/hosts clickhouse_infra.yml -vv -D # Подробный вывод, с diff функцией и переменными debug.
```

## Групповые переменные
-----------------------

Групповые переменные определены в следующих файлах:

- [all.yml](https://git.service.t1-cloud.ru/sre/infra/clickhouse/dns-as-a-service/-/blob/main/inventories/t1-p1/group_vars/all.yml).
- [clickhouse/zookeeper.yml](https://git.service.t1-cloud.ru/sre/infra/clickhouse/dns-as-a-service/-/blob/main/inventories/t1-p1/group_vars/clickhouse/zookeeper.yml).
- [clickhouse/clickhouse.yml](https://git.service.t1-cloud.ru/sre/infra/clickhouse/dns-as-a-service/-/blob/main/inventories/t1-p1/group_vars/clickhouse/clickhouse.yml).
- [clickhouse/haproxy.yml](https://git.service.t1-cloud.ru/sre/infra/clickhouse/dns-as-a-service/-/blob/main/inventories/t1-p1/group_vars/clickhouse/haproxy.yml).
- [clickhouse/keepalived-lb.yml](https://git.service.t1-cloud.ru/sre/infra/clickhouse/dns-as-a-service/-/blob/main/inventories/t1-p1/group_vars/clickhouse/keepalived-lb.yml).
- [clickhouse/repository.yml](https://git.service.t1-cloud.ru/sre/infra/clickhouse/dns-as-a-service/-/blob/prod/inventories/t1-p1/group_vars/clickhouse/repository.yml). # Управление настройками репозиториев, в т.ч переклчение на внутренний источник
- [clickhouse/version.yml](https://git.service.t1-cloud.ru/sre/infra/clickhouse/dns-as-a-service/-/blob/main/inventories/t1-p1/group_vars/clickhouse/version.yml). # Управление версиями компонентов


