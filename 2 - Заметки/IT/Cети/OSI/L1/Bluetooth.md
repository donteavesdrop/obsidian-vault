2025-10-21 в 18:16
Теги:[[Физический (L1, Physical Layer)]]
#L1

----
**Bluetooth** — это технология беспроводной связи малого радиуса действия, предназначенная для создания персональных сетей (PAN, Personal Area Network) и замены кабельных соединений между портативными и стационарными электронными устройствами[](https://www.bluetooth.com/wp-content/uploads/Files/Specification/HTML/Core-62/out/en/architecture,-change-history,-and-conventions/architecture.html). На физическом уровне (PHY) технология определяет радиочастотные характеристики для передачи и приёма сигнала по радиоволнам, скрывая аппаратные детали связи от вышестоящих уровней[](https://ru.muyumodule.com/archives/6683).

---

### Особенности

Работа в ISM-диапазоне 2,4 ГГц:  
Физический уровень Bluetooth, включая классическую версию (BR/EDR) и версию с низким энергопотреблением (LE), функционирует в международном диапазоне 2,400–2,4835 ГГц, который не требует лицензирования[](https://cloud.tencent.cn/developer/article/1889869?from=15425)[](https://www.rohde-schwarz.com/cac/solutions/wireless-communications-testing/wireless-standards/bluetooth/bluetooth-testing_124320.html?form=Feedback).

Методы модуляции и кодирования:  
PHY определяет методы преобразования цифровых символов в радиосигнал[](https://developerhelp.microchip.com/xwiki/bin/view/applications/ble/introduction/bluetooth-architecture/bluetooth-controller-layer/physical/).

- Классический Bluetooth (BR/EDR): использует частотную манипуляцию с гауссовской фильтрацией (GFSK) для базовой скорости (BR), а для повышенной скорости (EDR) — фазовую манипуляцию (PSK)[](https://www.rohde-schwarz.com/cac/solutions/wireless-communications-testing/wireless-standards/bluetooth/bluetooth-testing_124320.html?form=Feedback).
    
- Bluetooth Low Energy (BLE): базовая модуляция — GFSK[](https://developerhelp.microchip.com/xwiki/bin/view/applications/ble/introduction/bluetooth-architecture/bluetooth-controller-layer/physical/). В версии 5.0 добавлены режимы LE 2M PHY для удвоения скорости и LE Coded PHY с кодированием S=2 или S=8 для увеличения дальности[](https://software-dl.ti.com/simplelink/esd/simplelink_wifi_sdk/9.22.00.15/exports/docs/simplelink_mcu_sdk/html/ble/phy.html)[](https://academy.nordicsemi.com/courses/bluetooth-low-energy-fundamentals/lessons/lesson-1-bluetooth-low-energy-introduction/topic/phy-radio-modes/?version=v3.2.0-v3.0.0#forgot-password).
    

Структура каналов и частота:  
Технология использует адаптивную псевдослучайную перестройку рабочей частоты (AFH) для устойчивости к помехам[](https://www.rohde-schwarz.com/cac/solutions/wireless-communications-testing/wireless-standards/bluetooth/bluetooth-testing_124320.html?form=Feedback).

- Классический Bluetooth (BR/EDR): диапазон разбит на 79 каналов с шагом 1 МГц[](https://cloud.tencent.cn/developer/article/1889869?from=15425)[](https://www.rohde-schwarz.com/cac/solutions/wireless-communications-testing/wireless-standards/bluetooth/bluetooth-testing_124320.html?form=Feedback).
    
- Bluetooth Low Energy (BLE): диапазон разбит на 40 каналов с шагом 2 МГц, среди которых выделены три выделенных широковещательных канала[](https://developerhelp.microchip.com/xwiki/bin/view/applications/ble/introduction/bluetooth-architecture/bluetooth-controller-layer/physical/)[](https://www.rohde-schwarz.com/cac/solutions/wireless-communications-testing/wireless-standards/bluetooth/bluetooth-testing_124320.html?form=Feedback).
    

Физическая скорость передачи данных:

- BR: до 1 Мбит/с[](https://www.rohde-schwarz.com/cac/solutions/wireless-communications-testing/wireless-standards/bluetooth/bluetooth-testing_124320.html?form=Feedback).
    
- EDR: до 3 Мбит/с[](https://www.rohde-schwarz.com/cac/solutions/wireless-communications-testing/wireless-standards/bluetooth/bluetooth-testing_124320.html?form=Feedback).
    
- BLE 1M PHY: 1 Мбит/с[](https://software-dl.ti.com/simplelink/esd/simplelink_wifi_sdk/9.22.00.15/exports/docs/simplelink_mcu_sdk/html/ble/phy.html).
    
- BLE 2M PHY: 2 Мбит/с[](https://software-dl.ti.com/simplelink/esd/simplelink_wifi_sdk/9.22.00.15/exports/docs/simplelink_mcu_sdk/html/ble/phy.html).
    
- BLE Coded PHY (S=2): 500 кбит/с (дальность увеличена в 2 раза)[](https://software-dl.ti.com/simplelink/esd/simplelink_wifi_sdk/9.22.00.15/exports/docs/simplelink_mcu_sdk/html/ble/phy.html).
    
- BLE Coded PHY (S=8): 125 кбит/с (дальность увеличена в 4 раза)[](https://software-dl.ti.com/simplelink/esd/simplelink_wifi_sdk/9.22.00.15/exports/docs/simplelink_mcu_sdk/html/ble/phy.html).
    

---

### Как и где применяется

Технология широко используется для беспроводной связи на небольших расстояниях[](https://www.rohde-schwarz.com/cac/solutions/wireless-communications-testing/wireless-standards/bluetooth/bluetooth-testing_124320.html?form=Feedback):

1. Подключение периферии  
    Замена кабелей для подключения беспроводных мышей, клавиатур, гарнитур и колонок к компьютерам и мобильным устройствам.
    
2. Носимые устройства и Интернет вещей (IoT)  
    Технология Bluetooth Low Energy (BLE) позволяет создавать компактные датчики и трекеры активности с длительным временем работы от батареи.
    
3. Управление и передача данных  
    Обеспечивает связь между смартфонами и бытовой электроникой, в системах «умный дом», а также для обмена файлами.
    
4. Аудиопотоки  
    Используется для передачи звука в беспроводных наушниках, колонках и автомобильных мультимедийных системах.