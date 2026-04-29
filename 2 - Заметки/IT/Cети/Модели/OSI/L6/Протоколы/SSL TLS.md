2025-10-21 в 18:16
Теги:[[Протоколы L6]]

----
**SSL/TLS (Secure Sockets Layer / Transport Layer Security)** — это криптографические протоколы, предназначенные для обеспечения защищённой передачи данных в сети. Они работают между транспортным (например, TCP) и прикладным уровнями, предоставляя любому приложению возможность создать безопасный, зашифрованный канал связи[](https://link.springer.com/referenceworkentry/10.1007/0-387-23483-7_375?page=18)[](https://textbook.cs161.org/network/tls.html). SSL — исторически первая версия, разработанная компанией Netscape, а TLS — его современный преемник, ставший отраслевым стандартом[](https://help.reg.ru/support/ssl-sertifikaty/obshchaya-informatsiya-po-ssl/chto-takoye-secure-sockets-layer).

---

### Принцип работы

Работа SSL/TLS не сводится к простому "шифрованию всего подряд". Это сложный протокол, состоящий из двух основных фаз, которые проходят поверх TCP-соединения.

**Первая фаза: Рукопожатие (TLS Handshake)**  
Это самая важная и ресурсоёмкая часть, во время которой клиент и сервер "договариваются" о том, как они будут общаться[](https://help.hcl-software.com/onedb/current/sec/c_bckgrnd_keystore_knowledge_c2.html).

1. **ClientHello**: Клиент отправляет серверу список поддерживаемых версий TLS и криптографических алгоритмов (шифров)[](https://serverspace.uz/support/glossary/tsl/).
    
2. **ServerHello**: Сервер выбирает из предложенного списка наиболее подходящие алгоритмы и версию и отправляет их клиенту, а также свой цифровой сертификат. Этот сертификат содержит открытый ключ сервера и подтверждает его подлинность[](https://www.ssl.com/ru/%D1%81%D1%82%D0%B0%D1%82%D1%8C%D1%8E/%D1%87%D1%82%D0%BE-%D1%82%D0%B0%D0%BA%D0%BE%D0%B5-ssl-tls-an-in-depth-guide/#elementor-action%3Aaction%3Dpopup%3Aclose%26settings%3DeyJkb19ub3Rfc2hvd19hZ2FpbiI6IiJ9)[](https://serverspace.uz/support/glossary/tsl/).
    
3. **Проверка сертификата и генерация секрета**: Клиент проверяет сертификат сервера через доверенный центр сертификации (CA)[](https://aws.amazon.com/ru/what-is/ssl-certificate/#:~:text=SSL%2FTLS%20stands%20for%20secure,using%20the%20SSL%2FTLS%20protocol.). Затем клиент генерирует случайный "предварительный секрет" (Premaster Secret), шифрует его открытым ключом сервера и отправляет обратно[](https://www.ssl.com/ru/%D1%81%D1%82%D0%B0%D1%82%D1%8C%D1%8E/%D1%87%D1%82%D0%BE-%D1%82%D0%B0%D0%BA%D0%BE%D0%B5-ssl-tls-an-in-depth-guide/#elementor-action%3Aaction%3Dpopup%3Aclose%26settings%3DeyJkb19ub3Rfc2hvd19hZ2FpbiI6IiJ9).
    
4. **Вычисление сессионных ключей**: Сервер расшифровывает "предварительный секрет" своим закрытым ключом. Теперь и клиент, и сервер имеют одинаковый секрет, из которого они вычисляют **симметричные сеансовые ключи**[](https://www.ssl.com/ru/%D1%81%D1%82%D0%B0%D1%82%D1%8C%D1%8E/%D1%87%D1%82%D0%BE-%D1%82%D0%B0%D0%BA%D0%BE%D0%B5-ssl-tls-an-in-depth-guide/#elementor-action%3Aaction%3Dpopup%3Aclose%26settings%3DeyJkb19ub3Rfc2hvd19hZ2FpbiI6IiJ9). Рукопожатие завершается обменом проверочными сообщениями (Finished)[](https://serverspace.uz/support/glossary/tsl/).
    

**Вторая фаза: Защищённая передача данных**  
Как только рукопожатие завершено и сеансовые ключи сгенерированы, начинается передача данных. С этого момента все сообщения шифруются и расшифровываются с помощью быстрых симметричных алгоритмов (например, AES), используя тот самый сеансовый ключ[](https://www.ssl.com/ru/%D1%81%D1%82%D0%B0%D1%82%D1%8C%D1%8E/%D1%87%D1%82%D0%BE-%D1%82%D0%B0%D0%BA%D0%BE%D0%B5-ssl-tls-an-in-depth-guide/#elementor-action%3Aaction%3Dpopup%3Aclose%26settings%3DeyJkb19ub3Rfc2hvd19hZ2FpbiI6IiJ9).

---

### Особенности

1. **Пограничное положение в модели OSI**  
    SSL/TLS занимает уникальное место в модели OSI, находясь между транспортным и прикладным уровнями. Инициализация протокола происходит на сеансовом уровне (Layer 5), а непосредственное шифрование данных — на уровне представления (Layer 6)[](https://security.stackexchange.com/questions/95345/is-sending-a-string-representing-a-http-message-over-ssl-the-same-as-sending-a/95350#comment162812_95350). Поскольку исходная модель OSI не учитывала безопасность, SSL/TLS часто называют протоколом "уровня 6.5"[](https://textbook.cs161.org/network/tls.html).
    
2. **Гибридная криптография**  
    Протокол умно сочетает в себе два типа шифрования[](https://www.ssl.com/ru/%D1%81%D1%82%D0%B0%D1%82%D1%8C%D1%8E/%D1%87%D1%82%D0%BE-%D1%82%D0%B0%D0%BA%D0%BE%D0%B5-ssl-tls-an-in-depth-guide/#elementor-action%3Aaction%3Dpopup%3Aclose%26settings%3DeyJkb19ub3Rfc2hvd19hZ2FpbiI6IiJ9):
    
    - **Асимметричное шифрование** (с открытым ключом): Используется только для безопасной передачи "предварительного секрета" на этапе рукопожатия. Оно надёжно, но медленно.
        
    - **Симметричное шифрование**: Используется для шифрования всех данных после установления соединения. Оно очень быстрое, но требует общего секретного ключа у обеих сторон[](https://help.hcl-software.com/onedb/current/sec/c_bckgrnd_keystore_knowledge_c2.html).
        
3. **Стандартизация и эволюция**  
    Текущим и единственным безопасным стандартом является TLS, который прошёл путь от версии 1.0 (1999) до 1.3 (2018)[](https://help.reg.ru/support/ssl-sertifikaty/obshchaya-informatsiya-po-ssl/chto-takoye-secure-sockets-layer). Версии SSL 2.0 и 3.0 имеют критические уязвимости и считаются устаревшими и опасными для использования[](https://help.reg.ru/support/ssl-sertifikaty/obshchaya-informatsiya-po-ssl/chto-takoye-secure-sockets-layer).
    
4. **Защита от атак**  
    Протокол гарантирует три основных свойства безопасности[](https://serverspace.uz/support/glossary/tsl/):
    
    - **Конфиденциальность**: Перехваченные данные невозможно прочитать без ключа.
        
    - **Аутентификация**: Клиент может быть уверен, что он подключился именно к нужному серверу.
        
    - **Целостность**: Данные не могут быть изменены незаметно во время передачи.
        

---

### Как и где применяется

1. **Всемирная паутина (HTTPS)** — Самое массовое применение. Протокол HTTP поверх TLS/SSL образует HTTPS, который защищает все веб-сайты, где вы видите значок замка в адресной строке браузера[](https://aws.amazon.com/ru/what-is/ssl-certificate/#:~:text=SSL%2FTLS%20stands%20for%20secure,using%20the%20SSL%2FTLS%20protocol.)[](https://ru.vstack.com/glossary/transport-layer-security-tls/#rt-1).
    
2. **Электронная почта** — Протоколы отправки (SMTP) и получения (POP3, IMAP) почты используют TLS для шифрования как самих писем, так и процесса аутентификации на сервере[](https://serverspace.uz/support/glossary/tsl/).
    
3. **VPN** — TLS является основой для многих современных VPN-решений, таких как OpenVPN, обеспечивая гибкое и безопасное шифрование туннеля[](https://textbook.cs161.org/network/tls.html).
    
4. **Другие приложения** — Защита VoIP-звонков в протоколе SIP, безопасная передача SQL-запросов, шифрование мессенджеров и многих других приложений, где требуется конфиденциальность данных[](https://serverspace.uz/support/glossary/tsl/)