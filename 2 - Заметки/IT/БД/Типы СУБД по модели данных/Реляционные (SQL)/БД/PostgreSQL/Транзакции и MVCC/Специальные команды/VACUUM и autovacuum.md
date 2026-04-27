2026-04-27 в 13:32
Теги:[[Специальные команды]]

----

## Обычная очистка (VACUUM)

Выполняется командой `VACUUM`:

- не конфликтует с обычной активностью в системе
- обрабатывает таблицу и все ее индексы
- очищает ненужные версии строк в табличных страницах (пропуская страницы, уже отмеченные в карте видимости)
- очищает индексные записи, ссылающиеся на очищенные версии строк
- освобождает указатели
- обновляет карту свободного пространства
- обновляет карту видимости

---

### До очистки

![[Pasted image 20260427174825.png]]

---

### Чтение таблицы

![[Pasted image 20260427174836.png]]

---

### Очистка индексов

![[Pasted image 20260427174846.png]]

---

### Очистка таблицы

![[Pasted image 20260427174858.png]]

---

### Мониторинг

- `VACUUM VERBOSE`
- Представление `pg_stat_progress_vacuum`

Отображает:
- полный размер таблицы
- число прочитанных страниц и число очищенных страниц
- количество уже завершенных циклов очистки индексов
- число идентификаторов версий строк, помещающихся в память, и текущее число идентификаторов в памяти
- текущую фазу очистки

---

### Регулирование нагрузки

Процесс чередует работу и ожидание: примерно `vacuum_cost_limit` условных единиц работы, затем засыпает на `vacuum_cost_delay` миллисекунд.

**Настройки:**

```
vacuum_cost_limit = 200
vacuum_cost_delay = 0 ms
```

**Стоимость обработки:**

| Параметр | Значение | Описание |
|----------|----------|----------|
| `vacuum_cost_page_hit` | 1 | страницы в кэше |
| `vacuum_cost_page_miss` | 10 | страницы на диске |
| `vacuum_cost_page_dirty` | 20 | грязной страницы |

---

## Анализ (ANALYZE)

Выполняется при `VACUUM ANALYZE` или `ANALYZE`:

- не конфликтует с обычной активностью в системе
- собирает статистику для планировщика

---

## Полная очистка (VACUUM FULL)

Выполняется командой `VACUUM FULL`:

- **не совместима** ни с какими операциями над таблицей, включая чтение
- полностью перестраивает таблицу и все ее индексы
- при работе потребуется дополнительное место для новых файлов
- освобожденное место возвращается операционной системе
- выполняется дольше, чем обычная очистка

---

### До полной очистки

![[Pasted image 20260427174938.png]]

### После полной очистки

![[Pasted image 20260427175008.png]]

---

## Начало транзакций

```sql
=> INSERT INTO t VALUES (1);
INSERT 0 1

=> UPDATE t SET id = 2;
UPDATE 1

=> UPDATE t SET id = 3;
UPDATE 1

=> BEGIN ISOLATION LEVEL REPEATABLE READ;
BEGIN

=> SELECT * FROM t;
id
---
 2

=> SELECT backend_xmin
   FROM pg_stat_activity
   WHERE pid = pg_backend_pid();
backend_xmin
--------------
    610
```

---

## Версии строк

```sql
=> SELECT * FROM t;
```

| ctid | state | xmin | xmax | hhu | hot | t_ctid |
|------|-------|------|------|-----|-----|--------|
| (0,1) | normal | 608 (c) | 609 (c) | | | (0,2) |
| (0,2) | normal | 609 (c) | 610 | | | (0,3) |
| (0,3) | normal | 610 | 0 | (a) | | (0,3) |

---

## VACUUM

```sql
=> VACUUM t;
VACUUM

=> SELECT * FROM t;
```

| ctid | state | xmin | xmax | hhu | hot | t_ctid |
|------|-------|------|------|-----|-----|--------|
| (0,1) | unused | | | | | |
| (0,2) | normal | 609 (c) | 610 | | | (0,3) |
| (0,3) | normal | 610 | 0 | (a) | | (0,3) |

---

## VACUUM индекс

```sql
=> SELECT * FROM t_id_v;
```

| itemoffset | ctid |
|------------|------|
| 1 | (0,2) |
| 2 | (0,3) |

---

## Дополнительные команды

| Команда | Описание |
|---------|----------|
| `CLUSTER` | полностью перестраивает таблицу и все ее индексы, дополнительно физически упорядочивает версии строк в соответствии с одним из индексов |
| `REINDEX` | полностью перестраивает отдельный индекс |
| `TRUNCATE` | «опустошает» таблицу |

**Особенности:** все команды полностью блокируют работу с таблицей, все команды создают новые файлы для данных.

---

## VACUUM VERBOSE

```sql
=> VACUUM VERBOSE t;
```

```
INFO: vacuuming "public.t"
INFO: index "t_id" now contains 2 row versions in 2 pages
DETAIL: 0 index row versions were removed.
0 index pages have been deleted, 0 are currently reusable.
CPU: user: 0.00 s, system: 0.00 s, elapsed: 0.00 s.
INFO: "t": found 0 removable, 2 nonremovable row versions in 1 out of 1 pages
DETAIL: 1 dead row versions cannot be removed yet, oldest xmin: 610
There were 1 unused item pointers.
Skipped 0 pages due to buffer pins, 0 frozen pages.
0 pages are entirely empty.
CPU: user: 0.00 s, system: 0.00 s, elapsed: 0.00 s.
VACUUM
```

---

## VACUUM VERBOSE после коммита

```sql
=> VACUUM VERBOSE t;
```

```
INFO: vacuuming "public.t"
INFO: scanned index "t_id" to remove 1 row versions
DETAIL: CPU: user: 0.00 s, system: 0.00 s, elapsed: 0.00 s
INFO: "t": removed 1 row versions in 1 pages
DETAIL: CPU: user: 0.00 s, system: 0.00 s, elapsed: 0.00 s
INFO: index "t_id" now contains 1 row versions in 2 pages
DETAIL: 1 index row versions were removed.
0 index pages have been deleted, 0 are currently reusable.
CPU: user: 0.00 s, system: 0.00 s, elapsed: 0.00 s.
INFO: "t": found 1 removable, 1 nonremovable row versions in 1 out of 1 pages
DETAIL: 0 dead row versions cannot be removed yet, oldest xmin: 611
There were 1 unused item pointers. Skipped 0 pages due to buffer pins, 0 frozen pages.
0 pages are entirely empty. CPU: user: 0.00 s, system: 0.00 s, elapsed: 0.00 s.
VACUUM
```

---

## Версии строк (после VACUUM)

```sql
=> SELECT * FROM t_v;
```

| ctid | state | xmin | xmax | hhu | hot | t_ctid |
|------|-------|------|------|-----|-----|--------|
| (0,1) | unused | | | | | |
| (0,2) | unused | | | | | |
| (0,3) | normal | 610 (c) | 0 | (a) | | (0,3) |

---

## Файлы, занимаемые таблицей и индексом

```sql
=> SELECT pg_relation_filepath('t'), pg_relation_filepath('t_id');
```

| pg_relation_filepath | pg_relation_filepath |
|---------------------|----------------------|
| base/16495/16496 | base/16495/16499 |

---

## VACUUM FULL

```sql
=> VACUUM FULL VERBOSE t;
```

```
INFO: vacuuming "public.t"
INFO: "t": found 0 removable, 1 nonremovable row versions in 1 pages
DETAIL: 0 dead row versions cannot be removed yet.
CPU: user: 0.00 s, system: 0.00 s, elapsed: 0.00 s.
VACUUM
```

---

## Версии строк (после VACUUM FULL)

```sql
=> SELECT * FROM t_v;
```

| ctid | state | xmin | xmax | hhu | hot | t_ctid |
|------|-------|------|------|-----|-----|--------|
| (0,1) | normal | 610 (c) | 0 | (a) | | (0,1) |

```sql
=> SELECT * FROM t_id_v;
```

| itemoffset | ctid |
|------------|------|
| 1 | (0,1) |

---

## Файлы, занимаемые таблицей и индексом (после VACUUM FULL)

```sql
=> SELECT pg_relation_filepath('t'), pg_relation_filepath('t_id');
```

| pg_relation_filepath | pg_relation_filepath |
|---------------------|----------------------|
| base/16495/16536 | base/16495/16539 |
