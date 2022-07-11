#%matplotlib inline
import pandas as pd
import matplotlib.pyplot as plt
import seaborn as sns
import numpy as np
from scipy import stats
from tqdm.auto import tqdm

df = pd.read_csv('test_cluster.csv', encoding='cp1251', sep=';')
print (df.head())

df.info()

df = pd.read_csv('test_cluster.csv', encoding='cp1251', sep=';')
df_city = df.groupby('city_type').size().reset_index(name='count').sort_values(by='count', ascending=False).head()
df_city.plot(x="city_type", y="count", kind="bar", rot=5, fontsize=10)

plt.title('1. Распределение клиентов по типу города');

import matplotlib.pyplot as plt
import seaborn as sns
df = pd.read_csv('test_cluster.csv', encoding='cp1251', sep=';')
age_min = df['age'].min()
age_max = df['age'].max()

import matplotlib.pyplot as plt
import seaborn as sns
from pylab import rcParams
rcParams['figure.figsize'] = 20,9
df = pd.read_csv('test_cluster.csv', encoding='cp1251', sep=';')
sns.countplot(x='age', data=df);
plt.title('Распределение клиентов по возрасту');

import matplotlib.pyplot as plt
import seaborn as sns
df = pd.read_csv('test_cluster.csv', encoding='cp1251', sep=';')
sns.countplot(x='gender', data=df);
plt.title('Количество клиентов мужского и женского пола');

import matplotlib.pyplot as plt
import seaborn as sns
df = pd.read_csv('test_cluster.csv', encoding='cp1251', sep=';')
sns.boxplot(x='gender', y='age', data=df)
plt.title('Распределение по возрасту относительно каждого пола');

import matplotlib.pyplot as plt
import seaborn as sns
df = pd.read_csv('test_cluster.csv', encoding='cp1251', sep=';')
df_ml_balance_series = df.set_index('age')['ml_balance']
df_ml_balance_series.head()
sns.relplot(
    x='age',
    y='income',
    data=df.query("income > 0"),
    #kind='scatter'
     kind='line'
)
plt.title('зависимость доходов от возраста ', color='g');

import matplotlib.pyplot as plt
import seaborn as sns
df = pd.read_csv('test_cluster.csv', encoding='cp1251', sep=';')
df_ipiteka = df[['age', 'loan_balance_0m']]
count_ipoteka = df_ipiteka.query('loan_balance_0m > 0')
sns.relplot(
    x='age',
    y='loan_balance_0m',
    data=count_ipoteka ,
    #kind='scatter'
     kind='line'
)
plt.title('зависимость возраста и всех кредитов ', color='g');

import matplotlib.pyplot as plt
import seaborn as sns
from pylab import rcParams
rcParams['figure.figsize'] = 20,9
df = pd.read_csv('test_cluster.csv', encoding='cp1251', sep=';')
df_ipiteka = df[['age', 'loan_balance_0m']]
count_ipoteka = df_ipiteka.query('loan_balance_0m > 0')
sns.countplot(x='age', data=count_ipoteka);
plt.title('Распределение клиентов по возрасту и суммам всех кредитов');
