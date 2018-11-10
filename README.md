EnergyHack 2018 :: Robonomics workshop 
======================================

Основы ROS
----------

1. Установите ROS на Ubuntu (на виртуальную или хост-систему) по инструкции
```bash
http://wiki.ros.org/melodic/Installation/Ubuntu
```

2. Запустите ядро
```bash
roscore
```

3. Заведите виртуальную черепашку
```bash
rosrun turtlesim turtlesim_node
```
Здесь `rosrun` - утилита запуска, `turtlesim` - имя пакета, `turtlesim_node` - исполнимый файл в пакете.

4. Ознакомьтесь с API черепашки
```bash
rostopic list
rosservice list
```

5. Подтолкните черепашку
```bash
rostopic pub -1 /turtle1/cmd_vel geometry_msgs/Twist "linear: {x: 1.0, y: 0.0, z: 0.0}"
```

Рынок обязательств
------------------

1. Скачиваем репозиторий с рабочим окружением

```
git clone --recursive https://github.com/airalab/energyhack_2018
```

2. Запускаем сервис исполнения обязательств Robonomics.network

> Зависимости: python3, [eth_keyfile](https://github.com/ethereum/eth-keyfile), [base58](https://github.com/keis/base58), [ipfsapi](https://github.com/ipfs/py-ipfs-api), [go-ipfs](https://dist.ipfs.io/#go-ipfs). `pip3 install eth-keyfile base58 ipfsapi`

```
cd energyhack_2018
./ipfs.sh
```

И в другом окне:

```
cd energyhack_2018
./liability.sh
```

3. Публикуем в сеть *Спрос* и *Предложение* из тестового набора 

```
. ws/devel/setup.bash
rostopic pub /liability/infochan/eth/signing/offer robonomics_msgs/Offer "$(cat test_bid.yaml)" -1
rostopic pub /liability/infochan/eth/signing/demand robonomics_msgs/Demand "$(cat test_ask.yaml)" -1
```

> В момент публикации важно отслеживать состояние соединения с сетью IPFS, например, так `ipfs pubsub peers energyhack2018.lighthouse.3.robonomics.eth`. Если пиры отсутствуют, необходимо выполнить переподключение командой `ipfs swarm connect /dns4/lighthouse.aira.life/tcp/4001/ipfs/QmdfQmbmXt6sqjZyowxPUsmvBsgSGQjm4VXrV7WGy62dv8`.

4. Наблюдаем процесс создания нового обязательства в сети через [Etherscan](https://kovan.etherscan.io/address/0x35db9531330637e3abde2c4a5baa5cf89672f2c4).

5. Наблюдаем, что модуль исполнения подхватил контракт обязательства.

```
[INFO] [1541801196.193975]: Append 0xB53AF1F456d1a1BE928feFDE9a9ffCB8FC0eEebB to liability queue.
[INFO] [1541801196.194399]: Prepare to start liability 0xB53AF1F456d1a1BE928feFDE9a9ffCB8FC0eEebB
```

6. Запускаем обязательство на исполнение.

```
rosservice call /liability/start "address: '0xB53AF1F456d1a1BE928feFDE9a9ffCB8FC0eEebB'"
```

7. Завершаем исполнение обязательства. 

```
rosservice call /liability/finish "address: '0xB53AF1F456d1a1BE928feFDE9a9ffCB8FC0eEebB' success: true"
```
