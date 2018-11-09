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

