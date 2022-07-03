import requests
import json
from tqdm.auto import tqdm
from collections import defaultdict
import pickle
import pandas as pd
sber = '3529'
page = 1
num_per_page = 100
moscow = 1
url = f'https://api.hh.ru/vacancies?employer_id={sber}&page={page}&per_page={num_per_page}&area={moscow}'


def main():
    res = requests.get(url)
    print(res.json())
    vacancies = res.json()
    num_pages = vacancies.get('pages')
    print (num_pages)
    print (vacancies.keys())
    # vacancies.get('alternate_url')
    num_pages = vacancies.get('pages')
    vacancy_ids = [el.get('id') for el in vacancies.get('items')]
    df = pd.DataFrame(vacancy_ids)
    # Вытащите все описания этих вакансий
    all_vacancies = []
    for i in tqdm(range(vacancies.get('pages'))):
       # url = f'https://api.hh.ru/vacancies?employer_id={sber}&page={i}&per_page={num_per_page}&area={moscow}'
        vacancies = res.json()
        num_pages = vacancies.get('pages')
        vacancy_snippet = [el.get('snippet') for el in vacancies.get('items')]
        all_vacancies.extend(vacancy_snippet)
    df = pd.DataFrame(all_vacancies)
    print (df)
    # Создайте аналогичный vacancy DataFrame только добавьте поле skills

    df = pd.DataFrame(all_vacancies)
    df['skills'] = ''
    print (df)

    # Переведите даты публикаций в datetime
    all_vacancies = []
    for i in tqdm(range(vacancies.get('pages'))):
       # url = f'https://api.hh.ru/vacancies?employer_id={sber}&page={i}&per_page={num_per_page}&area={moscow}'
        vacancies = res.json()
        num_pages = vacancies.get('pages')
        vacancy_snippet = [el.get('published_at') for el in vacancies.get('items')]
        all_vacancies.extend(vacancy_snippet)

    df = pd.DataFrame(all_vacancies)
    df = df.rename({0: 'Date_published'}, axis=1)

    df['Date_published'] = pd.to_datetime(df.Date_published)
    df['date'] = df['Date_published'].dt.date
    print (df)

    print(df.dtypes)

    # Постройте график опубликованных вакансий по датам
    import matplotlib.pyplot as plt
    s = pd.to_datetime(df['Date_published'])
    df = s.groupby(s.dt.floor('d')).size().reset_index(name='count')
    df.plot(x='Date_published', y='count')

    # Переведите даты в дни недели, и определите день недели, в который больше всего публикуют вакансий

    df['day_of_week'] = df['Date_published'].dt.dayofweek
    days = {0: 'Mon', 1: 'Tues', 2: 'Weds', 3: 'Thurs', 4: 'Fri', 5: 'Sat', 6: 'Sun'}
    df['day_of_week'] = df['day_of_week'].apply(lambda x: days[x])
    print (df)

    df.day_of_week.value_counts()

    # Найдите те вакансии с использованием python, которые вам интересны
    all_vacancies = []
    for i in tqdm(range(vacancies.get('pages'))):
        #url = f'https://api.hh.ru/vacancies?employer_id={sber}&page={i}&per_page={num_per_page}&area={moscow}'
        vacancies = res.json()
        num_pages = vacancies.get('pages')
        vacancy_snippet = [el.get('snippet') for el in vacancies.get('items')]
        all_vacancies.extend(vacancy_snippet)

    df = pd.DataFrame(all_vacancies)
    mask = df['requirement'].str.contains(r"python")
    res = df.loc[mask]
    res
    print (df)


if __name__ == '__main__':
    main()
