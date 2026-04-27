2026-04-27 в 17:24
Теги:[[Уровни изоляции и особые режимы]]

----

## Уровень изоляции READ UNCOMMITTED

### Общая характеристика

Это самый низкий уровень изоляции. Согласно стандарту SQL, на этом уровне допускается чтение **«грязных» (незафиксированных) данных**.

> **Важное примечание о PostgreSQL:** В PostgreSQL реализация уровня `READ UNCOMMITTED` более строгая, чем того требует стандарт SQL. Фактически он работает как `READ COMMITTED` — «грязное» чтение не происходит.

---

### Пример 1: Демонстрация на таблице aircrafts_tmp

**На первом терминале:**

```sql
BEGIN ISOLATION LEVEL READ COMMITTED;
BEGIN
SHOW transaction_isolation;

UPDATE aircrafts_tmp SET range = range + 100
WHERE aircraft_code = 'SU9';

UPDATE 1

SELECT * FROM aircrafts_tmp WHERE aircraft_code = 'SU9';
```

**Результат:**

| aircraft_code | model | range |
|---------------|-------|-------|
| SU9 | Sukhoi SuperJet-100 | 3100 |

> Пояснение: `3000 + 100 = 3100`. Транзакция видит незафиксированные изменения, выполненные в ней самой.

```
transaction_isolation
read committed
```

---

### Пример 2: Вторая транзакция не видит изменений

**На втором терминале:**

```sql
BEGIN;
BEGIN

SET TRANSACTION ISOLATION LEVEL READ UNCOMMITTED;

SELECT * FROM aircrafts_tmp WHERE aircraft_code = 'SU9';
```

**Результат:**

| aircraft_code | model | range |
|---------------|-------|-------|
| SU9 | Sukhoi SuperJet-100 | 3000 |

**Вывод:** Вторая транзакция **не видит** изменения значения атрибута `range`, произведённое в первой незафиксированной транзакции.

---

### Пример 3: Светофор (таблица lights)

**Создание таблицы:**

```sql
CREATE TABLE lights(id serial, lamp text, state text);
CREATE TABLE

INSERT INTO lights(lamp,state) VALUES ('red', 'on'), ('green', 'off');
INSERT 0 2

SELECT * FROM lights ORDER BY id;
```

**Результат:**

| id | lamp | state |
|----|------|-------|
| 1 | red | on |
| 2 | green | off |

---

### Установка уровня транзакции

Один из способов установить определённый уровень транзакции – команда `SET TRANSACTION`:

```sql
BEGIN;
BEGIN

SET TRANSACTION ISOLATION LEVEL READ UNCOMMITTED;
SET
```

Проверить текущий уровень можно, посмотрев значение параметра:

```sql
SHOW transaction_isolation;
```

```
transaction_isolation
read uncommitted
```

---

### Попытка прочитать «грязные» данные

**В первой транзакции гасим красный свет:**

```sql
UPDATE lights SET state = 'off' WHERE lamp = 'red';
UPDATE 1
```

**Во втором сеансе откроем ещё одну транзакцию с тем же уровнем Read Uncommitted.** Можно указать уровень прямо в команде `BEGIN`:

```bash
student$ psql mvcc_isolation
```

```sql
BEGIN ISOLATION LEVEL READ UNCOMMITTED;
BEGIN

SELECT * FROM lights ORDER BY id;
```

**Результат:**

| id | lamp | state |
|----|------|-------|
| 1 | red | on |
| 2 | green | off |

**Вывод:** Вторая транзакция **не видит незафиксированных изменений**. Установить уровень `Read Uncommitted` можно, но работает он так же, как и `Read Committed`.
