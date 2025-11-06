2025-10-20 в 16:40
Теги:[[Airflow]]

----
## 🎯 Базовая структура DAG файла

```python
from airflow import DAG
from airflow.operators.python import PythonOperator
from datetime import datetime, timedelta

# 1. Аргументы по умолчанию
default_args = {
    'owner': 'your_name',
    'retries': 3,
    'retry_delay': timedelta(minutes=5),
    'start_date': datetime(2024, 1, 1),
    'email_on_failure': True,
    'email': ['your@email.com']
}

# 2. Создание DAG
with DAG(
    'my_dag_id',                    # Уникальный идентификатор
    default_args=default_args,      # Аргументы по умолчанию
    description='Описание DAG',     # Человекочитаемое описание
    schedule_interval='0 * * * *',  # Расписание выполнения 
    catchup=False,                  # Запуск пропущенных выполнений
    tags=['etl', 'data'],          # Теги для организации
    max_active_runs=1,             # Максимум одновременных запусков
    dagrun_timeout=timedelta(hours=2)  # Таймаут для всего DAG
) as dag:

    # 3. Задачи (Tasks)
    def my_function():
        print("Выполняю задачу")
    
    task_1 = PythonOperator(
        task_id='my_task',          # Уникальный ID задачи
        python_callable=my_function # Функция для выполнения
    )
```

## ⚙️ Основные параметры DAG

### **Обязательные параметры:**
```python
dag_id='unique_dag_name'           # Уникальный идентификатор
start_date=datetime(2024, 1, 1)    # Дата начала выполнения
```

### **Расписание (schedule_interval):**

[[Cron и временные интервалы]]

```python
schedule_interval='@daily'         # Ежедневно в полночь
schedule_interval='0 * * * *'      # Каждый час (cron)
schedule_interval=timedelta(days=1) # Раз в день
schedule_interval=None             # Только ручной запуск
```

### **Управление выполнением:**
```python
catchup=True                       # Запуск пропущенных даг-ранов
catchup=False                      # Только новые выполнения
max_active_runs=3                  # Максимум одновременных запусков
concurrency=5                      # Максимум параллельных задач
```

## 📋 Default Args - общие настройки

```python
default_args = {
    # Базовые настройки
    'owner': 'data_team',           # Владелец DAG
    'depends_on_past': False,       # Зависимость от прошлых выполнений
    'start_date': datetime(2024, 1, 1),
    
    # Повторные попытки
    'retries': 3,                   # Количество повторных попыток
    'retry_delay': timedelta(minutes=5),
    'retry_exponential_backoff': True,  # Экспоненциальная задержка
    
    # Уведомления
    'email_on_failure': True,
    'email_on_retry': False,
    'email': ['team@company.com'],
    
    # Исполнение
    'pool': 'default_pool',         # Пул выполнения
    'priority_weight': 1,           # Приоритет в планировщике
    
    # Прочее
    'wait_for_downstream': False,
    'sla': timedelta(hours=1)       # Service Level Agreement
}
```

## 🎯 Практический пример 

```python
from airflow import DAG
from airflow.operators.python import PythonOperator
from datetime import datetime, timedelta

default_args = {
    'owner': 'airflow',
    'retries': 0,
    'retry_delay': timedelta(minutes=1),
    'start_date': datetime(2025, 3, 24, 0, 0)
}

with DAG(
    'wb_orders_etl',               # ID вашего DAG
    default_args=default_args,
    schedule_interval='0 * * * *', # Каждый час
    catchup=False,                 # Не догонять пропущенное
    tags=['wb', 'orders']         # Теги для фильтрации
) as dag:
    
    # Задачи будут здесь
    task1 = PythonOperator(
        task_id='extract_data',
        python_callable=extract_function
    )
```

### **Теги и организация:**
```python
tags=['etl', 'warehouse', 'hourly']  # Группировка в UI
tags=['project_x', 'api_ingestion']  # По проектам/источникам
```

## ⚠️ Частые ошибки

1. **Слишком частый запуск** - не используйте минуты для тяжелых ETL
2. **Отсутствие catchup=False** - может создать много запусков
3. **Неправильный start_date** - динамические даты ломают логику
4. **Слишком много задач в одном DAG** - разбивайте на несколько

---
