2026-04-28 в 11:03
Теги:[[Примеры]]

----
# Подбор объема блюд (реализация на Python с skfuzzy)

## Исходный код

```python
import numpy as np
import skfuzzy as fuzz
from skfuzzy import control as ctrl
import matplotlib.pyplot as plt

# Определение антецедентов (входных переменных)
cal = ctrl.Antecedent(np.arange(1, 7, 1), 'cal')
spicy = ctrl.Antecedent(np.arange(1, 20, 1), 'spicy')
number = ctrl.Antecedent(np.arange(1, 20, 1), 'number')

# Определение консеквента (выходной переменной)
vol = ctrl.Consequent(np.arange(1, 7, 1), 'vol')

# Автоматическое создание термов для выходной переменной (треугольная форма)
vol.automf(names=['low', 'mid', 'high'])

# Функции принадлежности для остроты (трапециевидная форма)
spicy['small'] = fuzz.trapmf(spicy.universe, [1, 2, 4, 6])
spicy['mid'] = fuzz.trapmf(spicy.universe, [2, 4, 9, 11])
spicy['big'] = fuzz.trapmf(spicy.universe, [8, 10, 14, 20])

# Функции принадлежности для калорийности (трапециевидная форма)
cal['low'] = fuzz.trapmf(cal.universe, [1, 2, 3, 4])
cal['mid'] = fuzz.trapmf(cal.universe, [2, 3, 4, 5])
cal['high'] = fuzz.trapmf(cal.universe, [4, 5, 6, 7])

# Функции принадлежности для количества едоков
number['small'] = fuzz.trapmf(spicy.universe, [1, 2, 4, 6])
number['mid'] = fuzz.trapmf(spicy.universe, [2, 4, 9, 11])
number['big'] = fuzz.trapmf(spicy.universe, [8, 10, 14, 20])

# Визуализация функций принадлежности
cal.view()
spicy.view()
number.view()
vol.view()

# База нечетких правил (27 правил для полного покрытия)
rule1 = ctrl.Rule(spicy['small'] & cal['low'] & number['small'], vol['mid'])
rule2 = ctrl.Rule(spicy['small'] & cal['mid'] & number['small'], vol['low'])
rule3 = ctrl.Rule(spicy['small'] & cal['high'] & number['small'], vol['low'])
rule4 = ctrl.Rule(spicy['mid'] & cal['low'] & number['small'], vol['mid'])
rule5 = ctrl.Rule(spicy['mid'] & cal['mid'] & number['small'], vol['low'])
rule6 = ctrl.Rule(spicy['mid'] & cal['high'] & number['small'], vol['low'])
rule7 = ctrl.Rule(spicy['big'] & cal['low'] & number['small'], vol['mid'])
rule8 = ctrl.Rule(spicy['big'] & cal['mid'] & number['small'], vol['mid'])
rule9 = ctrl.Rule(spicy['big'] & cal['high'] & number['small'], vol['low'])
rule10 = ctrl.Rule(spicy['small'] & cal['low'] & number['mid'], vol['mid'])
rule11 = ctrl.Rule(spicy['small'] & cal['mid'] & number['mid'], vol['low'])
rule12 = ctrl.Rule(spicy['small'] & cal['high'] & number['mid'], vol['low'])
rule13 = ctrl.Rule(spicy['mid'] & cal['low'] & number['mid'], vol['mid'])
rule14 = ctrl.Rule(spicy['mid'] & cal['mid'] & number['mid'], vol['mid'])
rule15 = ctrl.Rule(spicy['mid'] & cal['high'] & number['mid'], vol['low'])
rule16 = ctrl.Rule(spicy['big'] & cal['low'] & number['mid'], vol['high'])
rule17 = ctrl.Rule(spicy['big'] & cal['mid'] & number['mid'], vol['mid'])
rule18 = ctrl.Rule(spicy['big'] & cal['high'] & number['mid'], vol['mid'])
rule19 = ctrl.Rule(spicy['small'] & cal['low'] & number['big'], vol['high'])
rule20 = ctrl.Rule(spicy['small'] & cal['mid'] & number['big'], vol['mid'])
rule21 = ctrl.Rule(spicy['small'] & cal['high'] & number['big'], vol['low'])
rule22 = ctrl.Rule(spicy['mid'] & cal['low'] & number['big'], vol['high'])
rule23 = ctrl.Rule(spicy['mid'] & cal['mid'] & number['big'], vol['mid'])
rule24 = ctrl.Rule(spicy['mid'] & cal['high'] & number['big'], vol['mid'])
rule25 = ctrl.Rule(spicy['big'] & cal['low'] & number['big'], vol['high'])
rule26 = ctrl.Rule(spicy['big'] & cal['mid'] & number['big'], vol['high'])
rule27 = ctrl.Rule(spicy['big'] & cal['high'] & number['big'], vol['mid'])

# Создание системы управления
price_ctrl = ctrl.ControlSystem([
    rule1, rule2, rule3, rule4, rule5, rule6,
    rule7, rule8, rule9, rule10, rule11, rule12,
    rule13, rule14, rule15, rule16, rule17, rule18,
    rule19, rule20, rule21, rule22, rule23, rule24,
    rule25, rule26, rule27
])

# Создание симулятора
price_simulator = ctrl.ControlSystemSimulation(price_ctrl)

# Задание входных значений
price_simulator.input['spicy'] = 9
price_simulator.input['cal'] = 4
price_simulator.input['number'] = 10

# Выполнение нечеткого вывода
price_simulator.compute()

# Вывод результата
print(price_simulator.output['vol'])

# Визуализация результатов
cal.view(sim=price_simulator)
spicy.view(sim=price_simulator)
number.view(sim=price_simulator)
vol.view(sim=price_simulator)
```


![[Pasted image 20260428110806.png]]
![[Pasted image 20260428110816.png]]
![[Pasted image 20260428110826.png]]
![[Pasted image 20260428110835.png]]
![[Pasted image 20260428110844.png]]
![[Pasted image 20260428110854.png]]
![[Pasted image 20260428110906.png]]
![[Pasted image 20260428110921.png]]
