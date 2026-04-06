2025-10-21 в 18:16
Теги:[[Сетевой (L3, Network Layer)]]

----
**ICMP (Internet Control Message Protocol)** — это вспомогательный протокол сетевого уровня, предназначенный для передачи диагностической информации и сообщений об ошибках в IP-сетях. Он не используется для передачи пользовательских данных, а выполняет служебные функции, помогая устройствам (маршрутизаторам, хостам) сообщать о проблемах связи и управлять сетевым трафиком. Протокол описан в RFC 792 (1981 год) и является стандартом де-факто для диагностики сетей.

---

### Особенности

1. Инкапсуляция в IP  
    В отличие от протоколов транспортного уровня (TCP, UDP), ICMP не использует номера портов и не устанавливает соединений. Его сообщения напрямую инкапсулируются в IP-дейтаграммы (протокол IP с номером 1), а IP-заголовок указывает на наличие ICMP-пакета в поле данных[](https://intuit.ru/studies/curriculums/10861/courses/2/lecture/38?page=1&keyword_content=TCP)[](https://www.firewall.cx/networking/network-protocols/icmp-protocol/icmp-introduction.html?highlight=WzFd).
    
2. Две категории сообщений  
    Все сообщения ICMP делятся на две большие группы:
    

- **Сообщения об ошибках** — уведомляют отправителя о проблемах при передаче пакета.
- **Запросы и ответы** — используются для диагностики и получения информации о состоянии сети[](https://intuit.ru/studies/curriculums/10861/courses/2/lecture/38?page=1&keyword_content=TCP).


3. Основные типы сообщений  
    ICMP поддерживает множество типов сообщений, каждый из которых имеет свой номер (type) и код (code) для уточнения причины[](https://man.openbsdhandbook.com/icmp/). Наиболее важные из них:
    

- **Echo Request (тип 8) и Echo Reply (тип 0)** — основа утилиты ping. Проверяют доступность узла и измеряют время отклика[](https://www.ibm.com/docs/en/aix/7.1.0?topic=protocol-internet-control-message-message-types)[](https://developer.baidu.com/article/details/3211352).
- **Destination Unreachable (тип 3)** — сообщает, что пакет не может быть доставлен получателю. Коды уточняют причину: сеть недоступна, хост недоступен, порт недоступен, требуется фрагментация и др.[](https://man.openbsdhandbook.com/icmp/)[](https://man.openbsdhandbook.com/icmp/).
- **Time Exceeded (тип 11)** — отправляется, когда истекло время жизни пакета (TTL). Используется в утилите traceroute для отслеживания пути пакета[](https://en.wikipedia.org/?curid=15107).
- **Redirect (тип 5)** — перенаправляет хост на более оптимальный маршрут к получателю[](https://www.ibm.com/docs/ru/aix/7.2.0?topic=protocols-internet-control-message-protocol).
- **Parameter Problem (тип 12)** — указывает на проблему в заголовке IP-пакета[](https://www.ibm.com/docs/en/aix/7.1.0?topic=protocol-internet-control-message-message-types).
- **Source Quench (тип 4)** — запрашивает уменьшение скорости отправки пакетов при перегрузке (устаревший механизм)[](https://www.ibm.com/docs/en/aix/7.1.0?topic=protocol-internet-control-message-message-types).

4. Структура сообщения  
    Каждое сообщение ICMP состоит из заголовка и поля данных:
    

- **Type (1 байт)** — тип сообщения.
- **Code (1 байт)** — код, уточняющий причину.
- **Checksum (2 байта)** — контрольная сумма для проверки целостности.
- **Идентификатор и последовательный номер** — используются для сопоставления запросов и ответов (например, в ping).
- **Данные** — содержат заголовок и первые байты исходного пакета, вызвавшего ошибку[](http://lk-domru.ru/protokol-upravleniya-soobshheniyami-internet/)[](https://cdn.haproxy.com/glossary/what-is-the-internet-control-message-protocol-icmp).

5. Ненадёжность протокола  
    ICMP не гарантирует доставки собственных сообщений. Если ICMP-пакет потерян или повреждён при передаче, новый не генерируется. Также сообщения ICMP не создаются в ответ на широковещательные, групповые запросы или на другие ICMP-пакеты (во избежание штормов)[](https://www.ibm.com/docs/ru/aix/7.2.0?topic=protocols-internet-control-message-protocol).
    
6. Две версии: ICMPv4 и ICMPv6  
    Для IPv4 используется ICMPv4, для IPv6 — ICMPv6. В IPv6 роль ICMP значительно расширена: он обеспечивает не только диагностику, но и такие функции, как обнаружение соседей (Neighbor Discovery), автоконфигурацию адресов и управление многоадресной рассылкой (MLD)[](https://en.wikipedia.org/?curid=15107).
    

---

### Как и где применяется

1. Диагностика сети (ping)  
    Утилита ping — самый известный инструмент на основе ICMP. Она отправляет Echo Request на целевой узел и ожидает Echo Reply. Если ответ получен, можно судить о доступности узла и задержке в сети[](https://aws.amazon.com/ru/what-is/icmp/)[](https://developer.baidu.com/article/details/3211352).
    
2. Трассировка маршрута (traceroute / tracert)  
    Traceroute использует сообщения Time Exceeded для определения пути следования пакетов. Утилита отправляет пакеты с последовательно увеличивающимся значением TTL, и каждый маршрутизатор на пути, обнулив TTL, возвращает ICMP-сообщение Time Exceeded, раскрывая свой IP-адрес[](https://developer.baidu.com/article/details/3211352)[](https://cqr.company/ru/wiki/protocols/internet-control-message-protocol-icmp/).
    
3. Автоматическое сообщение об ошибках  
    Когда пакет не может быть доставлен (например, хост или сеть недоступны), маршрутизатор автоматически отправляет отправителю сообщение Destination Unreachable с кодом, указывающим причину[](https://www.ibm.com/docs/ru/aix/7.2.0?topic=protocols-internet-control-message-protocol)[](https://en.wikipedia.org/?curid=15107).
    
4. Оптимизация маршрутов (Redirect)  
    Маршрутизатор может отправить хосту сообщение Redirect, информируя о том, что существует более короткий или эффективный маршрут к указанному получателю[](http://lk-domru.ru/protokol-upravleniya-soobshheniyami-internet/).
    
5. Управление перегрузками (Source Quench — исторически)  
    Ранее ICMP Source Quench использовался для запроса уменьшения скорости отправки при перегрузке. В современных сетях этот механизм считается устаревшим, и управление перегрузками возложено на TCP[](https://www.ibm.com/docs/en/aix/7.1.0?topic=protocol-internet-control-message-message-types).
    
6. Мониторинг и безопасность  
    ICMP активно используется сетевыми администраторами для мониторинга доступности устройств. Однако из-за возможности атак (например, ICMP Flood, Ping of Death, Smurf Attack) многие организации настраивают межсетевые экраны на блокировку или ограничение определённых типов ICMP-трафика[](https://cqr.company/ru/wiki/protocols/internet-control-message-protocol-icmp/)[](https://aws.amazon.com/ru/what-is/icmp/).