#Практика
#Определение вероятности. События
#Требуется сгенерировать необходимые выборки и произвести по ним расчеты

#Задача 1
#Брошено две монеты. Найти вероятность того, что монеты выпали разными сторонами
import random

import pandas as pd
import numpy as np
import matplotlib.pyplot as plt
import scipy.stats as sts
n = 100000
bernoulli_rv1 = sts.bernoulli(0.5)
bernoulli_rv2 = sts.bernoulli(0.5)
b1 = bernoulli_rv1.rvs(n)
b2 = bernoulli_rv2.rvs(n)
df = pd.DataFrame (zip(b1, b2), columns = ["m1","m2"])
print (df)
print ('вероятность того, что монеты выпали разными сторонами =', df [df.m1 != df.m2 ].shape[0]/n)

#Задача 2
# Брошено три монеты. Описать множество всех элементарных событий. Найти вероятности следующих событий:

#A = {не выпало ни одного герба}
#B = {выпало четное число гербов}
#C = {на третьей монете выпал герб}
# Герб - 0
n = 100000
bernoulli_rv1 = sts.bernoulli(0.5)
bernoulli_rv2 = sts.bernoulli(0.5)
bernoulli_rv3 = sts.bernoulli(0.5)
b1 = bernoulli_rv1.rvs(n)
b2 = bernoulli_rv2.rvs(n)
b3 = bernoulli_rv3.rvs(n)

df = pd.DataFrame (zip(b1, b2, b3), columns = ["m1","m2","m3" ])
print (df)
print ('не выпало ни одного герба', df [(df.m1 != 0) & (df.m2 != 0) & (df.m3 != 0)].shape[0]/n)
print ('выпало четное число гербов', df [df.m1 + df.m2 + df.m3 == 1].shape[0]/n)
print ('на третьей монете выпал герб', df [(df.m3 == 0)].shape[0]/n)

#Задача 3
#Из двух претендентов E и L на ответственную должность три члена комиссии должны отобрать одного. Каждый член комиссии должен указать либо одного достойного, либо забраковать обоих. Претендент считается выбранным, если он был признана достойным хотя бы двумя членами комиссии. Найти вероятность событий:

#A = {рекомендован L}, B = {рекомендован E}

#варианты решений по кандидатам
a = [[0,1], [1,0], [0,0], [0,1], [1,0], [0,0]]
#выбираем любые 3 варианта
c = random.choices(a, k=3)

# 3 вероятности событий: рекоментуют L,рекомендуют E,никого не рекомендуют
n = 3
df = pd.DataFrame(c, columns = ["E","L" ])
L = np.count_nonzero(df["L"])
E = np.count_nonzero(df["E"])
print (L)
print (E)

print (df)
print ('рекомендован L', df [(df.L >=2)].shape[1]/n)
print ('рекомендован E', df [(df.E >=2)].shape[1]/n)

#Задача 4
#Брошено две игральных кости. Описать множество элементарных событий.Найти вероятности событий:

#A = {вышло две "шестерки"}
#B = {сумма выпавших очков не меньше 11}
#C = {не выпала ни одна "шестерка"}
#Вероятность суммы событий

n = 100000
values1 = []
values2 = []

for x in range(n):
    values1.append(np.random.randint(1, 7))
    values2.append(np.random.randint(1, 7))

df = pd.DataFrame(zip(values1, values2), columns=["cub1", "cub2"])

print(df)

print('вышло две "шестерки"', df[((df.cub1 == 6) & (df.cub2 == 6))].shape[0] / n)
print('сумма выпавших очков не меньше 11', df[((df.cub1 + df.cub2) >= 11)].shape[0] / n)
print('не выпала ни одна "шестерка"', df[(df.cub1 != 6) & (df.cub2 != 6)].shape[0] / n)

# Задача 5 Брошены две игральные кости.Найти вероятность события D = {выпала хотя бы одна шестёрка}

n = 10000
values1 = []
values2 = []

for x in range(n):
    values1.append(np.random.randint(1, 7))
    values2.append(np.random.randint(1, 7))

df = pd.DataFrame(zip(values1, values2), columns=["cub1", "cub2"])

print(df)

print('выпала хотя бы одна шестёрка', \
      df[((df.cub1 == 6) & (df.cub2 != 6)) | ((df.cub1 != 6) & (df.cub2 == 6)) | (
                  (df.cub1 == 6) & (df.cub2 == 6))].shape[0] / n)

#Задача 6 В телефонном номере три последние цифры стерлись. Считая, что все возможные значения стершихся цифр равновероятны, найти вероятность событий:

#A = {Стерлись различные цифры},
#B = {Стерлись одинаковые цифры},
#C = {Среди стершихся цифр хотя бы две совпадают},
#D = {Среди стершихся цифр хотя бы две различны}

n=100000
num1 = []
num2 = []
num3 = []

for x in range(n):
    num1.append (np.random.randint(0, 10))
    num2.append (np.random.randint(0, 10))
    num3.append (np.random.randint(0, 10))
df = pd.DataFrame(zip(num1, num2, num3 ), columns = ["num1","num2", "num3"] )

print (df)

print ('Стерлись различные цифры',\
       df [(df.num1 != df.num2)& (df.num1 != df.num3)& (df.num2 != df.num3)].shape[0]/n)
print ('Стерлись одинаковые цифры',\
       df [(df.num1 == df.num2)& (df.num1 == df.num3)& (df.num2 == df.num3)].shape[0]/n )
print ('Среди стершихся цифр хотя бы две совпадают',\
       df [(df.num1 == df.num2)|(df.num1 == df.num3)|(df.num2 == df.num3)].shape[0]/n )
print ('Среди стершихся цифр хотя бы две различны',\
       df [(df.num1 != df.num2)| (df.num1 != df.num3)|(df.num2 != df.num3)].shape[0]/n )

#Случайные величины
#Задача 7
#В лотерее имеется 10 билетов, из которых один выигрышный. Размер выигрыша 10 ден. ед.; стоимость билета 1 ден ед. Найти закон распределения случайной величины X, равной чистому выигрышу участника лотереи, который вытаскивает билет первым.

import random
lst = [0,0,0,0,0,0,0,0,0,1]
n = len(lst)
random.shuffle(lst, random.random)
df = pd.DataFrame(lst)
print (df)

#возможные значения X: x1 = 10, x2= 0.
#Вероятности   этих   возможных   значений таковы: p1=0.1, p2=0,9.
print ('вероятность выигрыша 10 ден.ед: ', df [df[0] ==1 ].shape[0]/n)
print ('вероятность проигрыша ', df [df[0] ==0 ].shape[0]/n)

#Задача 8
#Брошены две игральные кости. Найти закон распределения случайной величины , равной сумме выпавших очков. Найти вероятности событий X<=4, X>4
n=10000
values = []

for x in range(n):
    values.append(np.random.randint(1, 7) + np.random.randint(1, 7))
df = pd.DataFrame(values)

print(df)
print ('вероятности событий  𝑋<=4 ', df [df[0] <= 4 ].shape[0]/n)
print ('вероятности событий  𝑋>4 ', df [df[0] > 4 ].shape[0]/n)