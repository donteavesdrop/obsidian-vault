2025-10-21 в 18:16
Теги:[[Канальный (L2, Data Link Layer)]], [[Сеансовый (L5, Session Layer)]]
#L2

---

**L2TP (Layer 2 Tunneling Protocol)** — это протокол туннелирования, который позволяет передавать пакеты канального уровня (L2) через IP-сети и другие сети с коммутацией пакетов, такие как ATM, X.25 и Frame Relay[](https://ru.wikipedia.org/w/index.php?diff=133957049&oldid=95972994&title=L2TP)[](https://encyclopedia.kaspersky.ru/glossary/l2tp/).

Он был разработан как усовершенствование устаревшего протокола PPTP. Для этого инженеры Cisco и Microsoft объединили проприетарные протоколы L2F (Cisco) и PPTP (Microsoft) в единый открытый стандарт L2TP[](https://www.checkpoint.com/tw/cyber-hub/network-security/layer-2-tunnel-protocol-l2tp/)[](https://wirexsystems.com/resource/protocols/l2tp/).

L2TP не имеет собственных средств шифрования и обычно используется в паре с IPsec (связка L2TP/IPsec) для обеспечения безопасности передаваемых данных[](https://encyclopedia.kaspersky.ru/glossary/l2tp/).

---

### Особенности

1. Туннелирование 2-го уровня  
    L2TP создает туннель на канальном уровне (L2) модели OSI. Это позволяет передавать через IP-сети данные практически любых протоколов, работающих поверх канального уровня, в первую очередь PPP (Point-to-Point Protocol)[](https://vasexperts.ru/resources/glossary/l2tp-layer-2-tunneling-protocol/).
    
2. Отсутствие шифрования и ключевая роль IPsec  
    Главная особенность L2TP заключается в том, что он занимается только туннелированием и не обеспечивает шифрование данных[](https://wirexsystems.com/resource/protocols/l2tp/)[](https://encyclopedia.kaspersky.ru/glossary/l2tp/). Для этого L2TP практически всегда комбинируют с IPsec, который берет на себя задачи шифрования и аутентификации. Именно эта связка (L2TP/IPsec) стала популярным и безопасным стандартом для VPN.
    
3. Инкапсуляция и двойные заголовки  
    L2TP/IPsec инкапсулирует данные дважды, что является причиной его более низкой производительности по сравнению с некоторыми современными протоколами. Схема инкапсуляции выглядит так:
    
    - Исходный IP-пакет инкапсулируется в PPP-кадр.
        
    - PPP-кадр инкапсулируется в L2TP-пакет (заголовок L2TP и данные).
        
    - L2TP-пакет инкапсулируется в UDP-дейтаграмму (порт 1701).
        
    - UDP-дейтаграмма шифруется и инкапсулируется в ESP-пакет IPsec.
        
    - ESP-пакет получает новый внешний IP-заголовок для маршрутизации по туннелю[](https://www.checkpoint.com/tw/cyber-hub/network-security/layer-2-tunnel-protocol-l2tp/)[](https://www.checkpoint.com/tw/cyber-hub/network-security/layer-2-tunnel-protocol-l2tp/).
        
4. Компоненты L2TP: LAC и LNS  
    Архитектура протокола подразумевает два ключевых элемента:
    
    - **LAC (L2TP Access Concentrator)**: Концентратор доступа. Устройство на стороне клиента или оператора, которое принимает трафик от пользователя и инкапсулирует его для отправки по туннелю[](https://vasexperts.ru/resources/glossary/l2tp-layer-2-tunneling-protocol/)[](https://www.checkpoint.com/tw/cyber-hub/network-security/layer-2-tunnel-protocol-l2tp/).
        
    - **LNS (L2TP Network Server)**: Сетевой сервер. Устройство на стороне сервера (например, в корпоративной сети), которое завершает туннель, декапсулирует трафик и передает его в локальную сеть[](https://vasexperts.ru/resources/glossary/l2tp-layer-2-tunneling-protocol/)[](https://www.checkpoint.com/tw/cyber-hub/network-security/layer-2-tunnel-protocol-l2tp/).
        
5. Широкая поддержка  
    L2TP поддерживается всеми современными операционными системами и сетевым оборудованием (Cisco, MikroTik, Huawei и др.), что делает его очень доступным и простым в развертывании решением[](https://vasexperts.ru/resources/glossary/l2tp-layer-2-tunneling-protocol/).
    

---

### Как и где применяется

1. Корпоративные VPN  
    Основное применение L2TP — организация защищенных VPN-соединений для удаленного доступа сотрудников к корпоративной сети[](https://www.checkpoint.com/tw/cyber-hub/network-security/layer-2-tunnel-protocol-l2tp/).
    
2. Провайдерские схемы доступа (L2TP for PPP)  
    Крупные интернет-провайдеры активно используют L2TP в своей инфраструктуре для предоставления услуг удаленного доступа, например, в DSL/FTTH-сетях. В этой модели LAC находится у провайдера, и он туннелирует PPP-сессии абонентов на центральный LNS[](https://vasexperts.ru/resources/glossary/l2tp-layer-2-tunneling-protocol/)[](https://docs.ecorouter.ru/%d0%a0%d1%83%d0%ba%d0%be%d0%b2%d0%be%d0%b4%d1%81%d1%82%d0%b2%d0%be/30-L2TP/).
    
3. Как альтернатива PPPoE  
    В некоторых сетях L2TP используется как альтернатива PPPoE, поскольку дает меньше накладных расходов и проще масштабируется[](https://vasexperts.ru/resources/glossary/l2tp-layer-2-tunneling-protocol/).