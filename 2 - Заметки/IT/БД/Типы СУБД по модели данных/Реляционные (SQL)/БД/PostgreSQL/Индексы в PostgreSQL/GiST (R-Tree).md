2026-04-27 в 16:58
Теги:[[Типы индексов (B-tree, Hash, GiST, GIN, SP-GiST, BRIN, Bloom)]]

----
Вот ваш текст, оформленный в красивый структурированный Markdown:


## Индексирование: GiST (R-Tree)

### Пример создания индекса GiST в PostgreSQL

```sql
CREATE TABLE city (
  id SERIAL PRIMARY KEY,
  name TEXT NOT NULL,
  area polygon
);

CREATE INDEX idx_city_area
ON city USING gist (area);
```

> В PostgreSQL GiST позволяет создать для любого собственного типа данных индекс, основанный на R-Tree.

---

### Структура R-Tree

![[Pasted image 20260427165925.png]]


---

## Индексирование: GIN (инвертированный индекс)

### Принцип работы

| key | ids |
|-----|-----|
| Action | 589 |
| Animation | 1, 741, 45517 |
| Children | 1, 45517 |
| Comedy | 1, 45517 |
| Sci-Fi | 589, 741 |

### Данные

| id | title | genres |
|----|-------|--------|
| 1 | Toy Story | {'Animation', 'Children', 'Comedy'} |
| 589 | Terminator 2: Judgment Day | {'Action', 'Sci-Fi'} |
| 741 | Ghost in the Shell | {'Animation', 'Sci-Fi'} |
| 45517 | Cars | {'Animation', 'Children', 'Comedy'} |
![[Pasted image 20260427165941.png]]
