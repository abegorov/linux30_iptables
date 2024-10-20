# Сценарии iptables

## Задание

1. Реализовать **knocking port**. **centralRouter** может попасть на **ssh** **inetRouter** через **knock** скрипт.
2. Добавить **inet2Router**, который виден(маршрутизируется (**host-only** тип сети для виртуалки)) с хоста или форвардится порт через локалхост.
3. Запустить nginx на **centralServer**.
4. Пробросить 80й порт на **inet2Router** 8080.
5. Дефолт в инет оставить через **inetRouter**.

Реализовать проход на 80й порт без маскарадинга.

## Реализация

Задание сделано на **rockylinux/9** версии **v4.0.0**. Для автоматизации процесса написан **Ansible Playbook** [playbook.yml](playbook.yml) который:

- включает **ip forwarding** на маршрутизаторах;
- настраивает **masquerade** на **inetRouter;
- настраивает сеть на всех узлах (через **nmcli**).

**Playbook** использует конфигурацию сети, определённую в [host_vars](host_vars):

- [inetRouter](host_vars/inetRouter.yml);
- [centralRouter](host_vars/centralRouter.yml);
- [office2Router](host_vars/office2Router.yml);
- [office1Router](host_vars/office1Router.yml);
- [centralServer](host_vars/centralServer.yml);
- [office2Server](host_vars/office2Server.yml);
- [office1Server](host_vars/office1Server.yml).

## Запуск

Необходимо скачать **VagrantBox** для **rockylinux/9** версии **v4.0.0** и добавить его в **Vagrant** под именем **rockylinux/9/v4.0.0**. Сделать это можно командами:

```shell
curl -OL https://app.vagrantup.com/rockylinux/boxes/9/versions/4.0.0/providers/virtualbox/amd64/vagrant.box
vagrant box add vagrant.box --name "rockylinux/9/v4.0.0"
rm vagrant.box
```

Для того, чтобы **vagrant 2.3.7** работал с **VirtualBox 7.1.0** необходимо добавить эту версию в **driver_map** в файле **/usr/share/vagrant/gems/gems/vagrant-2.3.7/plugins/providers/virtualbox/driver/meta.rb**:

```ruby
          driver_map   = {
            "4.0" => Version_4_0,
            "4.1" => Version_4_1,
            "4.2" => Version_4_2,
            "4.3" => Version_4_3,
            "5.0" => Version_5_0,
            "5.1" => Version_5_1,
            "5.2" => Version_5_2,
            "6.0" => Version_6_0,
            "6.1" => Version_6_1,
            "7.0" => Version_7_0,
            "7.1" => Version_7_0,
          }
```

После этого нужно сделать **vagrant up**.

Протестировано в **OpenSUSE Tumbleweed**:

- **Vagrant 2.3.7**
- **VirtualBox 7.1.4_SUSE r165100**
- **Ansible 2.17.5**
- **Python 3.11.10**
- **Jinja2 3.1.4**

## Проверка
