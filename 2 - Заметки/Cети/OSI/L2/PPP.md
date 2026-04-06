2025-10-21 в 18:16
Теги:[[Канальный (L2, Data Link Layer)]]

---
**PPP (Point-to-Point Protocol)** — это протокол канального уровня, предназначенный для передачи данных по прямым (point-to-point) соединениям между двумя узлами. Он был разработан как более совершенная замена устаревшему протоколу SLIP (Serial Line Internet Protocol) и стал стандартом де-факто для организации связи по последовательным линиям (dial-up, ISDN, DSL и др.)[](https://www.techphant.cn/blog/94211.html)[](https://info.support.huawei.com/info-finder/encyclopedia/zh/PPP.html).

В отличие от простых протоколов инкапсуляции, PPP не просто передаёт кадры, а представляет собой целое семейство протоколов, которое обеспечивает установление соединения, согласование параметров, аутентификацию сторон и поддержку множества сетевых протоколов поверх одной линии[](https://info.support.huawei.com/info-finder/encyclopedia/zh/PPP.html).

---

### Архитектура PPP

PPP состоит из трёх основных компонентов, которые работают согласованно:

1. **LCP (Link Control Protocol)** — протокол управления каналом. Он отвечает за установку, настройку, тестирование и разрыв физического соединения. LCP согласовывает параметры канала: максимальный размер кадра (MRU), метод аутентификации (PAP, CHAP), сжатие заголовков и т.д.[](https://www.h3c.com/cn/d_200805/605738_30003_0.htm)[](https://www.techphant.cn/blog/94211.html).
    
2. **AP (Authentication Protocol)** — протокол аутентификации. Он работает поверх LCP и обеспечивает проверку подлинности сторон. PPP поддерживает несколько методов аутентификации, от простых до криптографически стойких[](https://jumpcloud.com/it-index/what-is-point-to-point-protocol-ppp)[](https://www.baeldung.com/cs/ppp).
    
3. **NCP (Network Control Protocol)** — семейство протоколов управления сетью. Каждый сетевой протокол (IP, IPX, AppleTalk и др.) имеет свой собственный NCP. Например, IPCP (Internet Protocol Control Protocol) отвечает за назначение и согласование IP-адресов, DNS-серверов и других параметров сетевого уровня[](https://www.h3c.com/cn/d_200805/605738_30003_0.htm)[](https://www.techphant.cn/blog/94211.html).
    

---

### Формат кадра

PPP использует формат кадра, основанный на HDLC, но с важными отличиями[](https://www.techphant.cn/blog/92760.html).

Структура кадра PPP (в режиме HDLC-подобного обрамления, RFC 1662):

- **Флаг (Flag)** : `01111110` — отмечает начало и конец кадра.
    
- **Адрес (Address)** : всегда `11111111` (широковещательный адрес для всех станций) — поле является данью совместимости с HDLC и не используется для адресации в PPP.
    
- **Управление (Control)** : всегда `00000011` (ненумерованный кадр) — также не несёт функциональной нагрузки в PPP.
    
- **Протокол (Protocol)** : 1-2 байта — определяет тип протокола, инкапсулированного в поле данных. Например, `0x0021` для IP, `0xC021` для LCP, `0x8021` для IPCP[](https://www.techphant.cn/blog/92760.html)[](https://www.techphant.cn/blog/92760.html). Это ключевое отличие от HDLC, который не имеет такого поля.
    
- **Информация (Information)** : 0 и более байт — полезная нагрузка (данные верхнего уровня).
    
- **Контрольная сумма (FCS)** : 2 или 4 байта — для обнаружения ошибок.
    

---

### Режимы и фазы работы

Работа PPP строго детерминирована и проходит несколько обязательных фаз[](https://www.h3c.com/cn/d_200805/605738_30003_0.htm):

1. **Link Dead (Физически не подключен)** : линия неактивна. PPP ожидает сигнала от физического уровня (например, поднятия DTR).
    
2. **Link Establishment (Установление канала, LCP)** : отправка и согласование LCP-пакетов. Определяются параметры соединения, включая метод аутентификации.
    
3. **Authentication (Аутентификация, AP)** : этап опционален, но включается, если он был согласован LCP. Стороны проверяют подлинность друг друга.
    
4. **Network (Сетевой этап, NCP)** : после успешной аутентификации запускаются соответствующие NCP. Например, IPCP назначает IP-адрес и DNS.
    
5. **Link Termination (Разрыв канала)** : LCP или NCP могут инициировать корректное завершение соединения.
    

---

### Особенности

1. **Мультипротокольность**  
    PPP способен одновременно передавать данные разных сетевых протоколов (IPv4, IPv6, IPX, AppleTalk) через одно физическое соединение. Это стало возможным благодаря полю "Protocol" в заголовке кадра[](https://learningnetwork.cisco.com/s/question/0D53i00000KsrjGCAR/diiference-between-hdlc-and-ppp)[](https://info.support.huawei.com/info-finder/encyclopedia/zh/PPP.html).
    
2. **Аутентификация**
    
    - **PAP (Password Authentication Protocol)**: простая двухэтапная аутентификация с передачей пароля в открытом виде. Не рекомендуется для небезопасных сред[](https://www.h3c.com/cn/d_200805/605738_30003_0.htm)[](https://jumpcloud.com/it-index/what-is-point-to-point-protocol-ppp).
        
    - **CHAP (Challenge-Handshake Authentication Protocol)**: трёхэтапный протокол, использующий "вызов-ответ" с хэшированием (обычно MD5). Пароль не передаётся по сети[](https://www.h3c.com/cn/d_200805/605738_30003_0.htm)[](https://jumpcloud.com/it-index/what-is-point-to-point-protocol-ppp).
        
    - **EAP (Extensible Authentication Protocol)**: расширяемый фреймворк, позволяющий использовать различные методы аутентификации, включая сертификаты, токены и биометрию[](https://jumpcloud.com/it-index/what-is-point-to-point-protocol-ppp)[](https://www.baeldung.com/cs/ppp).
        
3. **Динамическая адресация (IPCP)**  
    В отличие от HDLC, который требует ручной настройки IP-адресов на обоих концах, PPP может динамически назначать IP-адрес клиенту через IPCP[](https://learningnetwork.cisco.com/s/question/0D53i00000KsrjGCAR/diiference-between-hdlc-and-ppp). Это было революционным для dial-up доступа в интернет.
    
4. **Сжатие и шифрование**
    
    - **Сжатие**: Поддерживаются алгоритмы сжатия данных (например, Stac LZS, Predictor) и сжатия заголовков (Van Jacobson) для повышения эффективности[](https://www.baeldung.com/cs/ppp)[](https://learningnetwork.cisco.com/s/question/0D53i00000KsrjGCAR/diiference-between-hdlc-and-ppp).
        
    - **Шифрование**: Может использоваться протокол ECP (Encryption Control Protocol) для шифрования передаваемых данных[](https://ipfs.io/ipfs/bafybeiemxf5abjwjbikoz4mc3a3dla6ual3jsgpdr4cjr3oz3evfyavhwq/wiki/Multilink_PPP.html).
        
5. **Обнаружение ошибок и контроль качества**
    
    - **Контрольная сумма FCS** позволяет обнаруживать повреждённые кадры[](https://www.baeldung.com/cs/ppp).
        
    - **LQM (Link Quality Monitoring)** позволяет отслеживать качество линии и разрывать соединение при превышении уровня ошибок[](https://learningnetwork.cisco.com/s/question/0D53i00000KsrjGCAR/diiference-between-hdlc-and-ppp).
        
6. **Мультилинкинг (Multilink PPP)**  
    MP (Multilink Protocol) позволяет объединять несколько физических PPP-соединений (например, два ISDN-канала B) в один логический канал для увеличения пропускной способности[](https://info.support.huawei.com/info-finder/encyclopedia/zh/PPP.html)[](https://ipfs.io/ipfs/bafybeiemxf5abjwjbikoz4mc3a3dla6ual3jsgpdr4cjr3oz3evfyavhwq/wiki/Multilink_PPP.html).
    
7. **Независимость от физической среды**  
    PPP может работать поверх различных физических сред: последовательные кабели (RS-232), телефонные линии (PSTN), ISDN, DSL, SONET/SDH, сотовые сети (GSM/CDMA), оптоволокно, а также поверх туннелей (L2TP, PPTP)[](https://zh.m.wikipedia.org/wiki/PPP%E5%8D%8F%E8%AE%AE)[](https://ipfs.io/ipfs/bafybeiemxf5abjwjbikoz4mc3a3dla6ual3jsgpdr4cjr3oz3evfyavhwq/wiki/Multilink_PPP.html).
    

---

### Как и где применяется

1. **Dial-up и DSL доступ в интернет (PPPoE/PPPoA)**  
    Исторически сложилось, что PPP был основным протоколом для коммутируемого доступа в интернет через модем. Сегодня он продолжает жить в виде протоколов PPPoE (PPP over Ethernet) и PPPoA (PPP over ATM), которые используются большинством провайдеров для авторизации и учёта трафика в сетях xDSL, FTTx и некоторых кабельных сетях[](https://zh.m.wikipedia.org/wiki/PPP%E5%8D%8F%E8%AE%AE)[](https://developer.baidu.com/article/details/3159693).
    
2. **Корпоративные и провайдерские WAN**  
    При организации выделенных каналов между офисами или маршрутизаторами провайдеров PPP часто используется в качестве протокола канального уровня, особенно в сетях T1/E1[](https://developer.baidu.com/article/details/3159693).
    
3. **Туннелирование и VPN**  
    PPP является транспортным протоколом для таких туннельных решений, как L2TP (Layer 2 Tunneling Protocol) и PPTP (Point-to-Point Tunneling Protocol). В этой роли PPP обеспечивает аутентификацию и назначение IP-адресов внутри защищённого туннеля[](https://www.techphant.cn/blog/94211.html)[](https://developer.baidu.com/article/details/3159693).
    
4. **Мобильные сети (2G/3G)**  
    В сетях сотовой связи второго и третьего поколений (GSM, CDMA, UMTS) PPP широко использовался для передачи данных между мобильным устройством и сетью оператора, обеспечивая IP-соединение[](https://www.techphant.cn/blog/94211.html).
    
5. **Специализированные и промышленные сети**  
    Благодаря своей гибкости, PPP применяется в военной связи, телеметрии, промышленной автоматизации и в системах управления (SCADA), где требуется надёжная связь по последовательным каналам.