import requests
%matplotlib inline
import sns as sns
import yfinance as yf
import pandas as pd
import matplotlib.pyplot as plt
import seaborn; seaborn.set()
from pandas_datareader import data as pdr
from bs4 import BeautifulSoup

# Котировки нефти, курс eur/usd
dbc = pd.read_excel('cur_oil.xlsx')
dbc


# Затраты на производство
PRODUCTION_COST = 400 # (EUR)

# Расходы на логистику
EU_LOGISTIC_COST_EUR = 30 # в Европу в евро
CN_LOGISTIC_COST_USD = 130 # в Китай в долларах

# * Справочная информация по клиентам(объемы, локации, комментарии)
customers = {
    'Monty': {
        'location': 'EU',
        'volumes': 200,
        'comment': 'moving_average'
    },

    'Triangle': {
        'location': 'CN',
        'volumes': 30,
        'comment': 'monthly'
    },
    'Stone': {
        'location': 'EU',
        'volumes': 150,
        'comment': 'moving_average'
    },
    'Poly': {
        'location': 'EU',
        'volumes': 70,
        'comment': 'monthly'
    }
}

df_cust = pd.DataFrame(customers)
df_cust

# Скидки
discounts = {'up to 100': 0.01, # 1%
             'up to 300': 0.05, # 5%
             '300 plus': 0.1}   #10%

#скидка
df_dis = pd.DataFrame(discounts, index=['discounts'])
df_dis

#цена на новый продукт - затраты нефть + производство
cost_mwp_eur = dbc['OIL']*16 + PRODUCTION_COST

cost_mwp_usd = cost_mwp_eur/ dbc['EURUSD=X']
dbc['cost_mwp_eur'] = cost_mwp_eur
dbc['cost_mwp_usd'] = cost_mwp_usd
dbc

sns.set(style='darkgrid')

sns.relplot(
    x='Date',
    y='cost_mwp_eur',
    data=dbc,
    kind='line'
)
plt.title('Себестоимость "ВБП" в EUR', size=20, color='g');


sns.set(style='darkgrid')

sns.relplot(
    x='Date',
    y='cost_mwp_usd',
    data=dbc,
    kind='line'
)
plt.title('Себестоимость "ВБП" в USD', size=20, color='g');

#Сделать расчет возможной цены по формуле для каждого из клиентов на условиях DDP (цена с доставкой).
#Записать все в один эксель файл, на разных листах. Каждый лист - название клиента.
#цена для клиента = цена в зависимости от локации* доставка в зависимости от локации*дисконт в завис от обьема
df_cust['Monty'].location

col = df_cust.columns
col

new_cust = df_cust.T
new_cust

def price(new_cust):
    if new_cust.location == 'EU':
        return 'cost_mwp_eur'
    else:
        return 'cost_mwp_usd'
new_cust['price'] = new_cust.apply(price,axis=1)
def discont(new_cust):
    if new_cust.volumes < 100:
        return 0.01
    elif new_cust.volumes >=300:
        return 0.1
    else:
        return 0.05

    new_cust['discont'] = new_cust.apply(discont, axis=1)
    new_cust

# Создаем файл
#writer = pd.ExcelWriter('medal_on_sheets.xlsx', engine='xlsxwriter')
# Записываем на листы
#gold.to_excel(writer, sheet_name='gold', index=False)
#silver.to_excel(writer, sheet_name='silver', index=False)
#bronze.to_excel(writer, sheet_name='bronze', index=False)
# Сохраняем и закрвыаем
#writer.save()