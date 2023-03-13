# os
**Node Exporter**

**Ansible-роль для установки node_exporter**
*Роль установит node_exporter на Ubuntu (создаст юнит, добавит его в автозагрузку), настройки iptables не добавляются*
В переменных установлен адрес экспортета на PROD nexus. Запустить роль можно из репозитория [sre/deploy/infra](https://git.service.t1-cloud.ru/sre/deploy/infra) 

Переменные
| Name           | Default Value | Description                        |
| -------------- | ------------- | -----------------------------------|
| `node_exporter_version` | 1.5.0 | версия архива|
| `node_exporter_repository_url` | https://nexus.t1.cloud/repository/node-exporter/ | url, где хранится архив |
| `node_exporter_group_name` | node-exporter | имя группы unix |
| `node_exporter_user_name` | node-exporter | имя пользователя unix |
| `node_exporter_dir` | /opt/node-exporter |  Директория, где будут храниться файлы |
| `node_exporter_checksum` | 68f3802c2dd3980667e4ba65ea2e1fb03f4a4ba026cca375f15a0390ff850949 | sha256 контрольная сумма для скачивания файла |
| `node_exporter_binary_dir` | /usr/local/bin | Путь по которому будет лежать бинарный файл |
| `node_exporter_web_listen_address` | 0.0.0.0:9100 | IP + port, который будет слушать демон |
| `node_exporter_web_telemetry_path` | /metrics | web-путь, по которому будут доступны метрики|
| `node_exporter_enabled_collectors` | { systemd, mountstats, ethtool } | Список включенных коллекторов[collectors](https://github.com/prometheus/node_exporter#collectors) |
| `node_exporter_disabled_collectors` | { } | список отключенных коллекторов [collectors](https://github.com/prometheus/node_exporter#collectors) 

**Пример playbook**

```yml
---
- hosts: redis_cluster
  gather_facts: true
  remote_user: akanshin
  become: true
  roles:
    - node_exporter
```