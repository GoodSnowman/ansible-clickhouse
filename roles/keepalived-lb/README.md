# Keepalived role

 Роль установки и настройки keepalived

## Использование

| WARNING: !!!!Любое изменение конфига ведет к перезагрузке кластера!!!!!|

[keepalive-docs](https://keepalived.readthedocs.io/en/latest/configuration_synopsis.html)

Для создания конфигурационного файла нужно заполнить следующие переменные:

* ```keepalived_lb_garp_master_delay```: 5

* ```keepalived_lb_advert_int```: 1

* ```keepalived_lb_vrrp_instance_name```: VI20

* ```keepalived_lb_virtual_router_id```: 60

* ```keepalived_lb_track_interface```: ens192

* ```keepalived_lb_common_virtual_server``` - значения этого словаря подставляются в каждый list в переменной `keepalived_lb_virtual_servers`

  ```yaml
  keepalived_lb_common_virtual_server:
    lb_kind: NAT
    protocol: UDP
    check_method: HTTP_GET
    connect_port: 9090
    connect_timeout: 2
    url_path: /api/system/lbstatus
    url_status_code: "200"
    real_servers:
      - address: 10.12.49.31
      - address: 10.12.49.32
      - address: 10.12.49.35
  ```

* ```keepalived_lb_virtual_servers``` - описание virtual server, недостающие значения берутся из keepalived_lb_common_virtual_server

  ```yaml
  keepalived_lb_virtual_servers:
    - port: "12202"
      lb_kind: DR
      protocol: TCP
    - port: 12302
      lb_kind: DR
      protocol: TCP
  ```

Из этих переданных параметров сформируется конфиг
<details>
  <summary>Конфиг</summary>

    vrrp_instance VI20 {
      interface         ens192
      state             BACKUP
      virtual_router_id 60
      priority          100
      advert_int        1
      garp_master_delay 1
      nopreempt

      track_interface {
          ens192
        }

      virtual_ipaddress {
        10.12.49.201 label ens192:1 dev ens192
      }
              notify /etc/keepalived/scripts/nat-switch root
      }

    virtual_server 10.12.49.201 12202 {
      delay_loop 2
      lb_algo rr
      lb_kind DR
      protocol TCP

      real_server 10.12.49.31 12202 {
        HTTP_GET {
          connect_port 9090
          connect_timeout 2
          url {
            path /api/system/lbstatus
            status_code 200
          }
          }
        }
      real_server 10.12.49.32 12202 {
        HTTP_GET {
          connect_port 9090
          connect_timeout 2
          url {
            path /api/system/lbstatus
            status_code 200
          }
          }
        }
      real_server 10.12.49.35 12202 {
        HTTP_GET {
          connect_port 9090
          connect_timeout 2
          url {
            path /api/system/lbstatus
            status_code 200
          }
          }
        }
      }  
    virtual_server 10.12.49.201 12302 {
      delay_loop 2
      lb_algo rr
      lb_kind DR
      protocol TCP

      real_server 10.12.49.31 12302 {
        HTTP_GET {
          connect_port 9090
          connect_timeout 2
          url {
            path /api/system/lbstatus
            status_code 200
          }
          }
        }
      real_server 10.12.49.32 12302 {
        HTTP_GET {
          connect_port 9090
          connect_timeout 2
          url {
            path /api/system/lbstatus
            status_code 200
          }
          }
        }
      real_server 10.12.49.35 12302 {
        HTTP_GET {
          connect_port 9090
          connect_timeout 2
          url {
            path /api/system/lbstatus
            status_code 200
          }
          }
        }
      }
</details>

Добавления отдельных параметров в `vrrp_instace` можно передать список в `keepalived_lb_vrrp_instance_extra_parameters`

```yaml
keepalived_lb_vrrp_instance_extra_parameters:
  - "lvs_sync_daemon_interface eth0"
```

Для добавления track_script заполнить переменную:

```yaml
keepalived_lb_track_scripts:
  - name: "pg_check_script"
    path: "/usr/local/bin/pg_check_script.sh"
    interval: 5
    weight: 2
    fall: 2
    rise: 2
    body: |
      #!/usr/bin/env bash
      if ! pg_isready --dbname=postgres --username=postgres || [ -f "/opt/pg_data/recovery.conf" ]; then
          exit 1
      fi
```

Для использования `auth_type` и `auth_pass`, необходимо определить: 

```yaml
keepalived_lb_auth: true
keepalived_lb_auth_type: PASS | AH
keepalived_lb_auth_pass: <very-strong-password>
```

## Что делает роль

  1. Устанавливает keepalived

  2. Шаблонизирует конфиг для keepalived и включает его

## TODO

* Валидацию конфига перед шаблонизацией
