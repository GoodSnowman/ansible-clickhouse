# Ansible Role: ZooKeeper

An Ansible Role that manages installation and configuration of [Apache ZooKeeper](https://zookeeper.apache.org/). Supports standalone configuration and cluster.

## Supported distributions
* Astra Linux Common Edition 2.12
* Debian 10, 11
* Ubuntu 22.04

## Supported zookeeper versions
* 3.8.0

## Role Variables

Available variables listed below, along with default values (see `defaults/main.yml`):
| Variable | Description | Default value |
| ---      | ---      | ---      |
| **zookeeper_version** | ZooKeeper application version | 3.8.0 |
| **zookeeper_dir** | Application files directory | /opt/zookeeper |
| **zookeeper_data_dir** | Server data directory | /var/zookeeper |
| **zookeeper_conf_dir** | Server configuration directory | /etc/zookeeper |
| **zookeeper_log_dir** | Server log directory | /var/log/zookeeper |
| **zookeeper_log_file** | Log file name | zookeeper.log |
| **zookeeper_log_level** | Logging level | INFO |
| **zookeeper_log_max_file_size** | Max log file size before rotation | 265MB |
| **zookeeper_log_max_backup_index** | Max log file number to keep | 20 |
| **zookeeper_client_port** | The port clients can connect to | 2181 |
| **zookeeper_init_limit** | Consult official [ZooKeeper documentation](https://zookeeper.apache.org/doc/r3.6.1/zookeeperAdmin.html#sc_configuration) for details | 5 |
| **zookeeper_sync_limit** | Consult official [ZooKeeper documentation](https://zookeeper.apache.org/doc/r3.6.1/zookeeperAdmin.html#sc_configuration) for details | 2 |
| **zookeeper_tick_time** | Consult official [ZooKeeper documentation](https://zookeeper.apache.org/doc/r3.6.1/zookeeperAdmin.html#sc_configuration) for details | 2000 |
| **zookeeper_members** | ZooKeeper cluster members. Accepts hostname, FQDN or IP list | "{{ groups['all'] \| map('extract', hostvars, 'ansible_default_ipv4') \| map(attribute='address') \| list }}" |
| **zookeeper_member_id** | ID of the current cluster member (index of the member's hostname, FQDN or IP in the `zookeeper_members` list) | "{{ ansible_default_ipv4.address }}" |
| **zookeeper_server_username** | SASL based authentication for the cluster member communication | zookeeper-server |
| **zookeeper_server_password** | SASL based authentication for the cluster member communication | P@$$w0rd |
| **zookeeper_clients** | SASL based authentication for the clients | - username: zookeeper-test |
|  |  | password: P@$$w0rd |
| **zookeeper_jmx_host** | Hostname/IP JMX will be exposed on | 127.0.0.1 |
| **zookeeper_jmx_port** | JMX remote agent port | 9181 |
| **zookeeper_jmx_rmi_port** | RMI connector port | 9182 |
| **zookeeper_jmx_username** | JMX username | zookeeper-jmx |
| **zookeeper_jmx_password** | JMX user password | P@$$w0rd |
| **zookeeper_jmx_role** | JMX user role | readonly |
| **zookeeper_4lw_commands_whitelist** | Whitelisting of ZooKeeper [4lw commands](https://zookeeper.apache.org/doc/current/zookeeperAdmin.html#sc_zkCommands) | srvr,stat,mntr |
| **zookeeper_global_outstanding_limit** | [ZooKeeper Administrator's Guide](https://zookeeper.apache.org/doc/r3.8.0/zookeeperAdmin.html) | 1000 |
| **zookeeper_prealloc_size** | [ZooKeeper Administrator's Guide](https://zookeeper.apache.org/doc/r3.8.0/zookeeperAdmin.html) | 64M |
| **zookeeper_snap_count** | [ZooKeeper Administrator's Guide](https://zookeeper.apache.org/doc/r3.8.0/zookeeperAdmin.html) | 100000 |
| **zookeeper_max_client_cnxns** | [ZooKeeper Administrator's Guide](https://zookeeper.apache.org/doc/r3.8.0/zookeeperAdmin.html) | 10 |
| **zookeeper_min_session_timeout** | [ZooKeeper Administrator's Guide](https://zookeeper.apache.org/doc/r3.8.0/zookeeperAdmin.html) | "{{ 2 * zookeeper_tick_time }}" |
| **zookeeper_max_session_timeout** | [ZooKeeper Administrator's Guide](https://zookeeper.apache.org/doc/r3.8.0/zookeeperAdmin.html) | "{{ 20 * zookeeper_tick_time }}" |
| **zookeeper_autopurge_snapretain_count** | [Clickhouse Usage Recommendations for Zookeper](https://clickhouse.com/docs/en/operations/tips/) | 10 |
| **zookeeper_purge_interval** | [Clickhouse Usage Recommendations for Zookeper](https://clickhouse.com/docs/en/operations/tips/) | 1 |
| **zookeeper_fsync_warning_threshold_ms** | [ZooKeeper Administrator's Guide](https://zookeeper.apache.org/doc/r3.8.0/zookeeperAdmin.html) | 1000 |
| **zookeeper_heap_size** | JVM heap size in MB | 1024 |
| **zookeeper_source** | Zookeeper download link | "https://dlcdn.apache.org/zookeeper/zookeeper-{{ zookeeper_version }}/apache-zookeeper-{{ zookeeper_version }}-bin.tar.gz" |
| **jdk_dir** | JDK files directory | /opt/jdk/ |
| **jdk_source** | JDK download link | "https://download.oracle.com/java/19/latest/jdk-19_linux-x64_bin.tar.gz" |


## Cluster status check
```
# /opt/zookeeper/3.7.1/bin/zkServer.sh status /etc/zookeeper/zookeeper.cfg
/usr/bin/java
ZooKeeper JMX enabled by default
Using config: /etc/zookeeper/zookeeper.cfg
Client port found: 2181. Client address: localhost. Client SSL: false.
Mode: leader
```
