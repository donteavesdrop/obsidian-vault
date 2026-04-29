2026-04-08 в 12:00
Теги: [[Генетический алгоритм]]

----

**Тема    практической    работы:**    Задача коммивояжера

 **Постановка задачи**

Задача коммивояжера заключается в поиске кратчайшего пути, при котором коммивояжер посетит каждый город ровно один раз и вернется в исходный город. Данная задача формулируется как симметричная задача коммивояжера: расстояние от города A до города B равно расстоянию от B до A.

**Описание генетического алгоритма и структуры программы**

Основные этапы решения задачи коммивояжера:

1. Инициализация популяции — создание начального множества маршрутов.

2. Расчёт фитнесс-функции — оценка качества каждого маршрута.

3. Отбор родителей — выбор маршрутов для дальнейшего размножения.

4. Кроссовер — создание потомков путём обмена генетической информации между родительскими маршрутами.

5. Мутация — внесение случайных изменений в потомков для обеспечения разнообразия.

6. Замена поколения — обновление популяции с целью улучшения решений.

import random  
import numpy as np  
  
# Задаем матрицу расстояний для симметричного графа  
distance_matrix = np.array([  
    [0, 10, 15, 20],  
    [10, 0, 35, 25],  
    [15, 35, 0, 30],  
    [20, 25, 30, 0]  
])  
  
# Параметры генетического алгоритма  
population_size = 10  # Размер популяции  
num_generations = 100  # Количество поколений  
mutation_rate = 0.1  # Вероятность мутации# Генерация случайного решения  
def random_route(num_cities):  
    route = list(range(num_cities))  
    random.shuffle(route)    return route  
  
  
# Вычисление длины маршрута  
def route_length(route, distance_matrix):  
    total_distance = 0    num_cities = len(route)    for i in range(num_cities):  
        total_distance += distance_matrix[route[i]][route[(i + 1) % num_cities]]    return total_distance  
  
  
# Генерация начальной популяции  
def generate_population(population_size, num_cities):    return [random_route(num_cities) for _ in range(population_size)]  
  
  
# Турнирный отбор  
def tournament_selection(population, distance_matrix):  
    tournament_size = 3    selected = random.sample(population, tournament_size)  
    selected.sort(key=lambda route: route_length(route, distance_matrix))    return selected[0]  
  
  
# Кроссовер (однородное скрещивание)  
def crossover(parent1, parent2):  
    size = len(parent1)  
    child = [-1] * size  
    child[:size // 2] = parent1[:size // 2]    for gene in parent2:        if gene not in child:  
            child[child.index(-1)] = gene    return child  
  
  
# Мутация (перестановка двух городов)  
def mutate(route, mutation_rate):    if random.random() < mutation_rate:  
        i, j = random.sample(range(len(route)), 2)  
        route[i], route[j] = route[j], route[i]  
  
  
# Основной цикл генетического алгоритма  
def genetic_algorithm(distance_matrix, population_size, num_generations, mutation_rate):  
    num_cities = len(distance_matrix)  
    population = generate_population(population_size, num_cities)    for generation in range(num_generations):  
        new_population = []        for _ in range(population_size):            # Отбор родителей            parent1 = tournament_selection(population, distance_matrix)  
            parent2 = tournament_selection(population, distance_matrix)            # Кроссовер            child = crossover(parent1, parent2)            # Мутация            mutate(child, mutation_rate)            # Добавление нового потомка в популяцию            new_population.append(child)        # Замена старой популяции на новую        population = new_population        # Вывод лучшего решения в текущем поколении        best_route = min(population, key=lambda route: route_length(route, distance_matrix))        print(f"Поколение {generation + 1}, Длина лучшего маршрута: {route_length(best_route, distance_matrix)}")    # Финальное лучшее решение    best_route = min(population, key=lambda route: route_length(route, distance_matrix))    return best_route, route_length(best_route, distance_matrix)  
  
  
# Запуск алгоритма  
best_route, best_length = genetic_algorithm(distance_matrix, population_size, num_generations, mutation_rate)  
print("Лучший маршрут:", best_route)  
print("Длина лучшего маршрута:", best_length)

**Пояснение кода**

1. Матрица расстояний distance_matrix:

    distance_matrix = np.array([

        [0, 10, 15, 20],

        [10, 0, 35, 25],

        [15, 35, 0, 30],

        [20, 25, 30, 0]

    ])

   Здесь задаётся симметричная матрица, где distance_matrix[i][j] — расстояние между городами i и j.

2. Инициализация параметров алгоритма:

    population_size = 10      Размер популяции

    num_generations = 100     Количество поколений

    mutation_rate = 0.1       Вероятность мутации

   Здесь задаются ключевые параметры генетического алгоритма:

   - population_size: число маршрутов (особей) в популяции.

   - num_generations: количество итераций алгоритма.

   - mutation_rate: вероятность мутации для каждого маршрута.

3. Функция random_route — генерация случайного маршрута:

    def random_route(num_cities):

        route = list(range(num_cities))

        random.shuffle(route)

        return route

   Эта функция создаёт маршрут, представляющий случайную перестановку городов.

4. Функция route_length — вычисление длины маршрута:

    def route_length(route, distance_matrix):

        total_distance = 0

        num_cities = len(route)

        for i in range(num_cities):

            total_distance += distance_matrix[route[i]][route[(i + 1) % num_cities]]

        return total_distance

   Функция принимает маршрут и матрицу расстояний и возвращает общую длину пути. Маршрут замкнутый: коммивояжер должен вернуться в начальный город, поэтому расстояние от последнего города до первого также включается в расчёт.

5. Функция generate_population — генерация начальной популяции:

    def generate_population(population_size, num_cities):

        return [random_route(num_cities) for _ in range(population_size)]

   Функция создаёт заданное количество случайных маршрутов (начальная популяция).

6. Функция tournament_selection — отбор маршрутов:

    def tournament_selection(population, distance_matrix):

        tournament_size = 3

        selected = random.sample(population, tournament_size)

        selected.sort(key=lambda route: route_length(route, distance_matrix))

        return selected[0]

   Функция выбирает трёх случайных особей из популяции и возвращает маршрут с наименьшей длиной. Такой подход позволяет выбрать лучших для дальнейшего скрещивания.

7. Функция crossover — кроссовер (скрещивание):

    def crossover(parent1, parent2):

        size = len(parent1)

        child = [-1]  size

        child[:size // 2] = parent1[:size // 2]

        for gene in parent2:

            if gene not in child:

                child[child.index(-1)] = gene

        return child

   Для создания нового маршрута child функция комбинирует части маршрутов двух родителей. Первые половины parent1 и parent2 объединяются, затем добавляются оставшиеся элементы из второго родителя.

8. Функция mutate — мутация маршрута:

    def mutate(route, mutation_rate):

        if random.random() < mutation_rate:

            i, j = random.sample(range(len(route)), 2)

            route[i], route[j] = route[j], route[i]

   С вероятностью mutation_rate эта функция меняет местами два случайных города в маршруте, что предотвращает преждевременную сходимость к одному решению и улучшает исследование возможных маршрутов.

9. Основная функция genetic_algorithm:

    def genetic_algorithm(distance_matrix, population_size, num_generations, mutation_rate):

        num_cities = len(distance_matrix)

        population = generate_population(population_size, num_cities)

        for generation in range(num_generations):

            new_population = []

            for _ in range(population_size):

                parent1 = tournament_selection(population, distance_matrix)

                parent2 = tournament_selection(population, distance_matrix)

                child = crossover(parent1, parent2)

                mutate(child, mutation_rate)

                new_population.append(child)

            population = new_population

            best_route = min(population, key=lambda route: route_length(route, distance_matrix))

            print(f"Поколение {generation + 1}, Длина лучшего маршрута: {route_length(best_route, distance_matrix)}")

        best_route = min(population, key=lambda route: route_length(route, distance_matrix))

        return best_route, route_length(best_route, distance_matrix)

   Внутри функции происходит:

   - Создание начальной популяции.

   - Основной цикл, в котором:

   - Отбираются лучшие маршруты для создания потомков.

   - Происходит кроссовер и мутация.

   - Обновляется популяция.

   - Печать длины лучшего маршрута в каждом поколении.

   - Возврат наилучшего маршрута и его длины по завершении работы.

Вывод программы

Поколение 1, Длина лучшего маршрута: 80

Поколение 2, Длина лучшего маршрута: 80

Поколение 3, Длина лучшего маршрута: 80

Поколение 4, Длина лучшего маршрута: 80

…

Поколение 96, Длина лучшего маршрута: 80

Поколение 97, Длина лучшего маршрута: 80

Поколение 98, Длина лучшего маршрута: 80

Поколение 99, Длина лучшего маршрута: 80

Поколение 100, Длина лучшего маршрута: 80

Лучший маршрут: [3, 1, 0, 2]

Длина лучшего маршрута: 80

Из вывода видно, что лучший маршрут стабилизировался уже в первом поколении, и его длина составляет 80.

**Проверка работы генетического алгоритма на 20 городах**

Для более полной проверки алгоритма был увеличен масштаб задачи до 20 городов.

![](file:///C:/Users/Kate/AppData/Local/Temp/msohtmlclip1/01/clip_image006.png) 

В процессе эволюции алгоритм постепенно снижал длину лучшего маршрута, начиная с 720 и заканчивая на 450 к 100 поколению.

Наблюдалась следующая динамика улучшений:

В первые несколько поколений алгоритм находил маршруты длиной 720, затем постепенно улучшал результаты.

К 20 поколению минимальная длина маршрута снизилась до 590, затем алгоритм постепенно достиг 450 к 85 поколению.

С 85 по 100 поколение длина лучшего маршрута оставалась стабильной на значении 450.

![](file:///C:/Users/Kate/AppData/Local/Temp/msohtmlclip1/01/clip_image008.png)

**Заключение по результатам:**

Алгоритм успешно показал способность к улучшению решений с увеличением количества поколений и эффективно применим к задачам большего масштаба.