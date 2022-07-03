import csv
import sys
from datetime import datetime

csv.field_size_limit(100000000)
vacs = list(csv.DictReader(open('vacancy.csv', encoding='utf-8')))
vacs [0]
print (vacs[0])
# Насколько свежие эти вакансии?
#вывели список дат из столбца 'vacdate'
b = []
for row in vacs:
    date_vacs = row['vacdate']
    b.append(date_vacs)
b= list(set(b))

#создали новый список, преобразовали str в дату, отсортировали по убыванию
q =[]
for date_b in b:
    if date_b:
        dt = datetime.strptime(date_b, '%Y-%m-%d').date()
        q.append(dt)
sorted(q, reverse = True)
# Сколько вакансий с позициями на которых вы работаете?
a =[]
for row in vacs:
    nazvanie_vacs = row['vactitle']
    if nazvanie_vacs.lower().find('аналитик (контактные центры)') !=-1:
        a.append(nazvanie_vacs)
print(len(a))
# Сколько вакансий для аналатика данных?
from collections import Counter
c = Counter()
a =[]
for row in vacs:
    nazvanie_vacs = row['vactitle']
    if nazvanie_vacs.lower().find('аналитик данных') !=-1:
        a.append(nazvanie_vacs)
#print(len(a))
c = Counter(a)
print (c)
# Сколько вакансий для аналитика данных с использованием Python?
from collections import Counter
c = Counter()
a =[]
for row in vacs:
    nazvanie_vacs = row['vactitle']
    if nazvanie_vacs.lower().find('python') !=-1:
        a.append(nazvanie_vacs)
#print(len(a))
c = Counter(a)
print (c)