# create_iot_structure.ps1
# Скрипт создаёт полную структуру папок и файлов для раздела IOT
# с заполнением содержимого по правилу: дата + тег + разделитель

$date = "2026-05-04 в 14:44"

function Write-FileWithTags {
    param([string]$filePath)
    $dir = Split-Path $filePath -Parent
    if (-not (Test-Path $dir)) {
        New-Item -Path $dir -ItemType Directory -Force | Out-Null
    }
    $fileName = Split-Path $filePath -Leaf
    $fileNameBase = $fileName -replace '\.md$', ''
    $currentFolder = Split-Path $dir -Leaf
    $parentFolder = Split-Path (Split-Path $dir -Parent) -Leaf

    # Правило определения тега
    if ($dir -eq $PWD.Path -or $dir -eq "." -or $dir -eq "") {
        $tag = "[[IOT]]"
    } else {
        if ($fileNameBase -eq $currentFolder) {
            if ($parentFolder -eq "" -or $parentFolder -eq $null) {
                $tag = "[[IOT]]"
            } else {
                $tag = "[[$parentFolder]]"
            }
        } else {
            $tag = "[[$currentFolder]]"
        }
    }

    $content = @"
$date
Теги:$tag

----
"@
    $utf8NoBom = New-Object System.Text.UTF8Encoding $false
    [System.IO.File]::WriteAllText($filePath, $content, $utf8NoBom)
}

$root = $PWD.Path

# ----------------------------------------------------------------------
# ИЕРАРХИЯ
# ----------------------------------------------------------------------
$structure = @{
    "Интернет вещей.md" = $null
    "1_Устройства и сенсоры" = @{
        "Устройства и сенсоры.md" = $null
        "Микроконтроллеры" = @{
            "Микроконтроллеры.md" = $null
            "AVR (Arduino).md" = $null
            "ARM Cortex-M" = @{
                "ARM Cortex-M.md" = $null
                "STM32.md" = $null
                "NXP LPC.md" = $null
                "TI Tiva.md" = $null
            }
            "ESP8266_ESP32" = @{
                "ESP8266_ESP32.md" = $null
                "ESP8266.md" = $null
                "ESP32.md" = $null
                "ESP32-S3_Сравнение.md" = $null
            }
            "RISC-V (GD32V, ESP32-C3).md" = $null
            "Одноплатные компьютеры" = @{
                "Одноплатные компьютеры.md" = $null
                "Raspberry Pi.md" = $null
                "BeagleBone.md" = $null
                "NanoPi, OrangePi.md" = $null
            }
        }
        "Сенсоры и актуаторы" = @{
            "Сенсоры и актуаторы.md" = $null
            "Температура и влажность" = @{
                "Температура и влажность.md" = $null
                "DHT11_DHT22.md" = $null
                "BME280_BMP280.md" = $null
                "DS18B20.md" = $null
            }
            "Давление и высота" = @{
                "Давление и высота.md" = $null
                "BMP180_BMP280.md" = $null
                "LPS22HB.md" = $null
            }
            "Газ и качество воздуха" = @{
                "Газ и качество воздуха.md" = $null
                "MQ-2, MQ-135.md" = $null
                "CCS811, SGP30.md" = $null
                "PM2.5 (PMS5003).md" = $null
            }
            "Движение и положение" = @{
                "Движение и положение.md" = $null
                "PIR-датчики (HC-SR501).md" = $null
                "Акселерометры (MPU6050).md" = $null
                "Гироскопы, магнитометры.md" = $null
            }
            "Оптические и камеры" = @{
                "Оптические и камеры.md" = $null
                "Датчики освещенности (BH1750).md" = $null
                "Камеры (ESP32-CAM, OV7670).md" = $null
                "LiDAR (VL53L0X).md" = $null
            }
            "Актуаторы" = @{
                "Актуаторы.md" = $null
                "Реле и твердотельные реле.md" = $null
                "Серводвигатели и моторы.md" = $null
                "Соленоиды, клапаны.md" = $null
                "Светодиоды (RGB, адресные).md" = $null
            }
            "Датчики тока, напряжения и энергопотребления" = @{
                "Датчики тока, напряжения и энергопотребления.md" = $null
                "INA219, INA260.md" = $null
                "ZMPT101B (переменное напряжение).md" = $null
            }
        }
        "Питание IoT-устройств" = @{
            "Питание IoT.md" = $null
            "Батарейки и аккумуляторы" = @{
                "Батарейки и аккумуляторы.md" = $null
                "Li-ion, Li-Pol.md" = $null
                "NiMH, щелочные.md" = $null
            }
            "Энергосберегающие режимы" = @{
                "Энергосберегающие режимы.md" = $null
                "Deep Sleep (ESP, Arduino).md" = $null
                "ULP-сопроцессор (ESP32).md" = $null
            }
            "Энергосбор (Energy Harvesting)" = @{
                "Энергосбор (Energy Harvesting).md" = $null
                "Солнечные панели.md" = $null
                "Термоэлектрические генераторы.md" = $null
                "Пьезоэлектричество.md" = $null
            }
        }
    }
    "2_Сетевые протоколы и связь" = @{
        "Протоколы и связь.md" = $null
        "Ближний радиус (PAN, LAN)" = @{
            "Ближний радиус (PAN, LAN).md" = $null
            "Bluetooth_Bluetooth Low Energy" = @{
                "Bluetooth_Bluetooth Low Energy.md" = $null
                "Bluetooth.md" = $null
                "BLE (4.0–5.3).md" = $null
                "iBeacon, Eddystone.md" = $null
                "Стек BlueZ, NimBLE.md" = $null
            }
            "Wi-Fi (IEEE 802.11)" = @{
                "Wi-Fi (IEEE 802.11).md" = $null
                "Wi-Fi для IoT.md" = $null
                "Wi-Fi 6 (802.11ax) для IoT.md" = $null
                "Проверка подлинности (WPA3, Enterprise).md" = $null
            }
            "Zigbee (IEEE 802.15.4)" = @{
                "Zigbee (IEEE 802.15.4).md" = $null
                "Zigbee.md" = $null
                "Профили (ZCL, ZDP).md" = $null
                "Стеки (Zigbee 3.0).md" = $null
                "Шлюзы (Coordinator, Router).md" = $null
            }
            "Z-Wave (Z-Wave Plus, Long Range).md" = $null
            "Thread и Matter" = @{
                "Thread и Matter.md" = $null
                "Thread.md" = $null
                "Matter (бывший Project CHIP).md" = $null
                "Отличия Thread от Zigbee.md" = $null
            }
            "NFC (Near Field Communication).md" = $null
            "Другие (EnOcean, Dash7).md" = $null
        }
        "Дальний радиус (LPWAN)" = @{
            "Дальний радиус (LPWAN).md" = $null
            "LoRa_LoRaWAN" = @{
                "LoRa_LoRaWAN.md" = $null
                "LoRaWAN.md" = $null
                "LoRa-модули (SX127x, SX126x).md" = $null
                "Шлюзы и сетевые серверы (TTN, ChirpStack).md" = $null
                "Классы устройств (A, B, C).md" = $null
            }
            "NB-IoT и LTE-M (Cellular IoT)" = @{
                "NB-IoT и LTE-M (Cellular IoT).md" = $null
                "NB-IoT.md" = $null
                "LTE-M.md" = $null
                "Модулы (Quectel, SIMCom).md" = $null
            }
            "Sigfox.md" = $null
            "Weightless-N, Weightless-P.md" = $null
            "MIoTy (Telecom).md" = $null
        }
        "Традиционные промышленные протоколы" = @{
            "Традиционные промышленные протоколы.md" = $null
            "Modbus (RTU, TCP).md" = $null
            "Profibus, Profinet.md" = $null
            "EtherCAT, Ethernet Powerlink.md" = $null
            "CAN bus, CANopen.md" = $null
        }
        "Маршрутизация и туннелирование" = @{
            "Маршрутизация и туннелирование.md" = $null
            "6LoWPAN (IPv6 over Low-Power Wireless).md" = $null
            "RPL (Routing Protocol for LLNs).md" = $null
            "MQTT-SN (сенсорная версия).md" = $null
        }
        "Сравнительные таблицы протоколов" = @{
            "Сравнительные таблицы протоколов.md" = $null
            "Сравнение LPWAN.md" = $null
            "Сравнение Mesh-протоколов.md" = $null
            "Выбор протокола по сценарию.md" = $null
        }
    }
    "3_Платформы и облачные решения" = @{
        "Платформы и облако.md" = $null
        "Облачные решения" = @{
            "Облачные решения.md" = $null
            "AWS IoT Core" = @{
                "AWS IoT Core.md" = $null
                "Device Shadow, Registry.md" = $null
                "Rules Engine и Lambda.md" = $null
                "Fleet Provisioning.md" = $null
            }
            "Azure IoT Hub" = @{
                "Azure IoT Hub.md" = $null
                "Device Twins, Direct Methods.md" = $null
                "IoT Edge и модули.md" = $null
                "DPS (Device Provisioning Service).md" = $null
            }
            "Google Cloud IoT Core (закрыт, аналоги)" = @{
                "Google Cloud IoT Core (закрыт, аналоги).md" = $null
                "Google Cloud IoT.md" = $null
                "Альтернативы (Pub/Sub, Cloud Run).md" = $null
                "Миграция на другие платформы.md" = $null
            }
            "IBM Watson IoT.md" = $null
            "Alibaba Cloud IoT.md" = $null
            "Yandex IoT Core, SberCloud.md" = $null
        }
        "Открытые и локальные платформы" = @{
            "Открытые и локальные платформы.md" = $null
            "ThingsBoard (Open-source).md" = $null
            "Kaa IoT.md" = $null
            "DeviceHive.md" = $null
            "Mainflux (LF Edge).md" = $null
            "Node-RED (визуальное программирование).md" = $null
        }
        "Управление устройствами (Device Management)" = @{
            "Управление устройствами (Device Management).md" = $null
            "OTA обновления (Microchip, AWS OTA).md" = $null
            "Remote SSH, WebShell.md" = $null
            "Удаленная диагностика и логи.md" = $null
            "Политики конфигурации.md" = $null
        }
        "Шлюзы (Gateways) и Edge" = @{
            "Шлюзы (Gateways) и Edge.md" = $null
            "Шлюзы IoT.md" = $null
            "ПО шлюзов (OpenWrt, Balena, Rancher).md" = $null
            "Оборудование (Dell Edge, Advantech).md" = $null
            "Пример конфигурации шлюза.md" = $null
        }
    }
    "4_Безопасность в IoT" = @{
        "Безопасность IoT.md" = $null
        "Уязвимости и атаки" = @{
            "Уязвимости и атаки.md" = $null
            "Firmware атаки (извлечение, модификация).md" = $null
            "Физические атаки (JTAG, UART, распайка).md" = $null
            "Сетевые атаки (Replay, DoS на LPWAN).md" = $null
            "Side-channel (по питанию, времени).md" = $null
            "Атаки на облачный бэкенд.md" = $null
        }
        "Аппаратная защита" = @{
            "Аппаратная защита.md" = $null
            "TPM (Trusted Platform Module).md" = $null
            "Secure Element (ATECC608).md" = $null
            "Защита от чтения флеш-памяти (CRP, eFuse).md" = $null
            "Аппаратное шифрование (AES, SHA).md" = $null
        }
        "Программная защита" = @{
            "Программная защита.md" = $null
            "Безопасная загрузка (Secure Boot).md" = $null
            "Шифрование данных (TLS, DTLS).md" = $null
            "Аутентификация устройств (X.509, Pre-shared key).md" = $null
            "Управление сертификатами и ротация ключей.md" = $null
            "Микро-контейнеры (Docker на шлюзах).md" = $null
        }
        "Стандарты безопасности для IoT" = @{
            "Стандарты безопасности для IoT.md" = $null
            "OWASP IoT Top 10.md" = $null
            "NISTIR 8259 (Безопасность устройств).md" = $null
            "ETSI EN 303 645.md" = $null
            "IEC 62443 (промышленный IoT).md" = $null
        }
        "Практики безопасной разработки" = @{
            "Практики безопасной разработки.md" = $null
            "Моделирование угроз (STRIDE).md" = $null
            "Безопасное хранение секретов.md" = $null
            "Аудит и пентест прошивок.md" = $null
        }
    }
    "5_Обработка и анализ данных" = @{
        "Обработка данных.md" = $null
        "Edge Computing и Fog Computing" = @{
            "Edge Computing и Fog Computing.md" = $null
            "Edge Computing.md" = $null
            "Fog Computing.md" = $null
            "Frameworks (Azure IoT Edge, AWS Greengrass).md" = $null
            "Обработка в реальном времени на шлюзе.md" = $null
        }
        "Потоковая обработка (Streaming)" = @{
            "Потоковая обработка (Streaming).md" = $null
            "Apache Kafka (MQTT-Kafka bridge).md" = $null
            "Apache Flink (для IoT-событий).md" = $null
            "TimescaleDB (сжатие, continuous aggregates).md" = $null
            "InfluxDB (Telegraf, Flux, Kapacitor).md" = $null
        }
        "Аналитика и ML на граничных устройствах" = @{
            "Аналитика и ML на граничных устройствах.md" = $null
            "TensorFlow Lite Micro (TFLM).md" = $null
            "Edge Impulse (машинное обучение для MCU).md" = $null
            "Аномалии датчиков (STL, Prophet).md" = $null
            "Прогнозирование износа (Predictive Maintenance).md" = $null
        }
        "Агрегация и визуализация" = @{
            "Агрегация и визуализация.md" = $null
            "Grafana (дашборды для IoT).md" = $null
            "Kibana (логи и геоданные).md" = $null
            "Redash (SQL-запросы к телеметрии).md" = $null
            "Другие (Metabase, Superset).md" = $null
        }
        "Управление временными рядами" = @{
            "Управление временными рядами.md" = $null
            "Концепция временных рядов.md" = $null
            "Сжатие и downsampling.md" = $null
            "Retention policies и TTL.md" = $null
        }
    }
    "6_Стандарты и организации" = @{
        "Стандарты и организации.md" = $null
        "Организации" = @{
            "Организации.md" = $null
            "IEEE (802.15.4, 802.11).md" = $null
            "IETF (6LoWPAN, CoAP, LwM2M).md" = $null
            "OCF (Open Connectivity Foundation).md" = $null
            "LoRa Alliance.md" = $null
            "Zigbee Alliance (Connectivity Standards Alliance).md" = $null
            "Thread Group, Matter.md" = $null
            "Industrial Internet Consortium (IIC).md" = $null
        }
        "Протоколы прикладного уровня" = @{
            "Протоколы прикладного уровня.md" = $null
            "MQTT (3.1.1, 5.0)" = @{
                "MQTT (3.1.1, 5.0).md" = $null
                "MQTT.md" = $null
                "QoS уровни (0,1,2).md" = $null
                "Retained messages, Last Will.md" = $null
                "Брокеры (Mosquitto, EMQX, VerneMQ).md" = $null
            }
            "CoAP (RFC 7252)" = @{
                "CoAP (RFC 7252).md" = $null
                "CoAP.md" = $null
                "Observe Option (push).md" = $null
                "Block-Wise Transfers.md" = $null
                "Реализации (Californium, libcoap).md" = $null
            }
            "AMQP (Advanced Message Queuing Protocol).md" = $null
            "DDS (Data Distribution Service).md" = $null
            "XMPP (для управления).md" = $null
            "LwM2M (Lightweight M2M, OMA).md" = $null
        }
        "Форматы данных (JSON, CBOR, Protobuf, MessagePack)" = @{
            "Форматы данных (JSON, CBOR, Protobuf, MessagePack).md" = $null
            "Сравнение эффективности.md" = $null
            "Схемы данных (JSON Schema, ASN.1).md" = $null
        }
    }
    "7_Применение и сценарии" = @{
        "Применение.md" = $null
        "Умный дом (Smart Home)" = @{
            "Умный дом (Smart Home).md" = $null
            "Умный дом.md" = $null
            "Умное освещение (Philips Hue, Ikea).md" = $null
            "Климат-контроль (термостаты, кондиционеры).md" = $null
            "Безопасность (датчики открытия, камеры, сигнализации).md" = $null
            "Управление голосом (Alexa, Google Home, Siri).md" = $null
            "Экосистемы (Home Assistant, OpenHAB, Apple HomeKit).md" = $null
        }
        "Промышленный IoT (IIoT, Industry 4.0)" = @{
            "Промышленный IoT (IIoT, Industry 4.0).md" = $null
            "IIoT.md" = $null
            "Цифровые двойники (Digital Twins).md" = $null
            "Мониторинг станков (вибрация, ток).md" = $null
            "Предиктивное обслуживание.md" = $null
            "SCADA и IIoT-шлюзы.md" = $null
            "Стандарты (OPC UA, MQTT Sparkplug).md" = $null
        }
        "Умный город (Smart City)" = @{
            "Умный город (Smart City).md" = $null
            "Умный город.md" = $null
            "Умное освещение улиц.md" = $null
            "Управление отходами (контейнеры с датчиками).md" = $null
            "Мониторинг транспорта и парковок.md" = $null
            "Экологический мониторинг (шум, воздух).md" = $null
            "Примеры (Барселона, Сингапур).md" = $null
        }
        "Медицина и здравоохранение (IoMT)" = @{
            "Медицина и здравоохранение (IoMT).md" = $null
            "Медицинский IoT.md" = $null
            "Носимые устройства (пульс, ЭКГ, глюкометры).md" = $null
            "Удаленный мониторинг пациентов (RPM).md" = $null
            "Умные таблетницы и дозаторы.md" = $null
            "Регуляторные требования (HIPAA, GDPR).md" = $null
        }
        "Сельское хозяйство (AgriTech)" = @{
            "Сельское хозяйство (AgriTech).md" = $null
            "Точное земледелие.md" = $null
            "Датчики почвы (влажность, pH).md" = $null
            "Метеостанции.md" = $null
            "Умный полив и дроны.md" = $null
            "Отслеживание скота (RFID, LoRa).md" = $null
        }
        "Логистика и отслеживание (Asset Tracking)" = @{
            "Логистика и отслеживание (Asset Tracking).md" = $null
            "GPS + LPWAN трекеры.md" = $null
            "RFID-метки и считыватели.md" = $null
            "Условия перевозок (температура, удары).md" = $null
            "Платформы (Tive, Roambee).md" = $null
        }
        "Энергетика (Smart Grid, Умные счетчики)" = @{
            "Энергетика (Smart Grid, Умные счетчики).md" = $null
            "Умные счетчики электроэнергии (AMI).md" = $null
            "Demand Response (управление нагрузкой).md" = $null
            "Мониторинг солнечных панелей.md" = $null
            "Протоколы (DLMS/COSEM, IEC 62056).md" = $null
        }
    }
    "8_Разработка и инструменты" = @{
        "Разработка IoT.md" = $null
        "SDK и фреймворки" = @{
            "SDK и фреймворки.md" = $null
            "Arduino Framework (популярные библиотеки).md" = $null
            "ESP-IDF (Espressif).md" = $null
            "PlatformIO (управление проектами).md" = $null
            "Zephyr RTOS (многоархитектурный).md" = $null
            "FreeRTOS и Amazon FreeRTOS (AWS).md" = $null
            "RIOT OS (для LPWAN).md" = $null
            "mbed OS (ARM).md" = $null
        }
        "Эмуляция и симуляция" = @{
            "Эмуляция и симуляция.md" = $null
            "Wokwi (Arduino, ESP32 online).md" = $null
            "QEMU (для Cortex-M, RISC-V).md" = $null
            "Cooja (Cooja Simulator для Contiki).md" = $null
            "Hardware-in-the-loop (HIL).md" = $null
        }
        "Отладка и анализ" = @{
            "Отладка и анализ.md" = $null
            "Анализаторы протоколов (Wireshark, 802.15.4).md" = $null
            "Логические анализаторы (Saleae, Sigrok).md" = $null
            "Осциллографы для I2C, SPI, UART.md" = $null
            "Отладка по SWD, JTAG (OpenOCD).md" = $null
            "Трассировка энергопотребления (Joulescope).md" = $null
        }
        "Интеграция с enterprise системами" = @{
            "Интеграция с enterprise системами.md" = $null
            "REST API для устройств.md" = $null
            "Webhooks и Server-Sent Events.md" = $null
            "RabbitMQ, Kafka как шины.md" = $null
        }
        "Примеры проектов и шаблоны кода" = @{
            "Примеры проектов и шаблоны кода.md" = $null
            "Пример_подключение_DHT22_к_ESP8266.md" = $null
            "Пример_MQTT_keepalive_и_QoS.md" = $null
            "Пример_OTA_обновление_на_ESP32.md" = $null
            "Пример_фрейм_с_шифрованием_AES.md" = $null
        }
    }
    "9_Ресурсы и сообщества" = @{
        "Ресурсы.md" = $null
        "Книги и курсы" = @{
            "Книги и курсы.md" = $null
            "Building IoT Systems (Vermesan, Friess).md" = $null
            "IoT and Edge Computing for Architects.md" = $null
            "Coursera, Stepik, OTUS.md" = $null
        }
        "Видеоблоги и YouTube каналы" = @{
            "Видеоблоги и YouTube каналы.md" = $null
            "Andreas Spiess (The guy with the Swiss accent).md" = $null
            "GreatScott!, Electronoobs.md" = $null
            "Русскоязычные (Хабр, Geektimes).md" = $null
        }
        "Подкасты и конференции" = @{
            "Подкасты и конференции.md" = $null
            "IoT Podcast (Stacey on IoT).md" = $null
            "ThingsCon.md" = $null
            "IoT Tech Expo.md" = $null
        }
        "GitHub репозитории и полезные ссылки.md" = $null
    }
}

function Create-Node {
    param(
        [string]$currentPath,
        [hashtable]$node
    )
    foreach ($key in $node.Keys) {
        $itemPath = Join-Path $currentPath $key
        if ($node[$key] -eq $null) {
            Write-FileWithTags -filePath $itemPath
        } else {
            New-Item -Path $itemPath -ItemType Directory -Force | Out-Null
            Create-Node -currentPath $itemPath -node $node[$key]
        }
    }
}

if (-not (Test-Path $root)) {
    New-Item -Path $root -ItemType Directory -Force | Out-Null
}
Create-Node -currentPath $root -node $structure

Write-Host "Структура IOT успешно создана в папке $root" -ForegroundColor Green