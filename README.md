EnergyHack 2018 :: Robonomics workshop 
======================================


Основы ROS
----------

1.1 Установите ROS на Ubuntu (на виртуальную или хост-систему) по инструкции
```bash
http://wiki.ros.org/melodic/Installation/Ubuntu
```

1.2 Запустите ядро
```bash
$ roscore
```

1.3 Заведите виртуальную черепашку
```bash
$ rosrun turtlesim turtlesim_node
```
Здесь `rosrun` - утилита запуска, `turtlesim` - имя пакета, `turtlesim_node` - исполнимый файл в пакете.

1.4 Ознакомьтесь с API черепашки
```bash
$ rostopic list
$ rosservice list
```

1.5 Подтолкните черепашку
```bash
$ rostopic pub -1 /turtle1/cmd_vel geometry_msgs/Twist "linear: {x: 1.0, y: 0.0, z: 0.0}"
```

Robonomics basics
-----------------

1. `./liability.sh`
2. `rostopic pub /liability/infochan/eth/signing/offer robonomics_msgs/Offer "$(cat test_bid.yaml)" -1 &&  rostopic pub /liability/infochan/eth/signing/demand robonomics_msgs/Demand "$(cat test_ask.yaml)" -1` 
3. `rosservice call /liability/start "address: '0xB53AF1F456d1a1BE928feFDE9a9ffCB8FC0eEebB'"`
4. `rosservice call /liability/finish "address: '0xB53AF1F456d1a1BE928feFDE9a9ffCB8FC0eEebB' success: true"`
