# Анализ данных для агенства недвижимости

Цель проекта - изучить рынок недвижимости Санкт-Петербурга и Ленинградской области, сезонность и время активности объявлений о продаже недвижимости.

Для анализа использовались SQL-запросы в PostgreSQL, а также был доработан и дополнен дашборд в DataLens.

### Ссылка на дашборд: 

Автор: Лазарева Елизавета Сергеевна

## Задача 1. Время активности объявлений

Чтобы спланировать эффективную бизнес-стратегию на рынке недвижимости, заказчику нужно определить — по времени активности объявления — самые привлекательные для работы сегменты недвижимости Санкт-Петербурга и городов Ленинградской области.

### 1. Какие сегменты рынка недвижимости Санкт-Петербурга и городов Ленинградской области имеют наиболее короткие или длинные сроки активности объявлений?

В Санкт-Петербурге наиболее короткие сроки активности объявлений чаще всего имеют двухкомнатные квартиры с 1 балконом, находящиеся на 5 этаже из 10, с площадью 54,38 квадратных метров и высотой потолков 2,76 метров, средней стоимостью 6 124 412 рублей и стоимостью одного квадратного метра 110 569 рублей. Доля таких объявлений составляет 0,15.

Наиболее длинные сроки активности объявлений чаще всего имеют двухкомнатные квартиры с 1 балконом, находящиеся на 5 этаже из 9, с площадью 67,8 квадратных метров и высотой потолков 2,84 метра, средней стоимостью 8 312 360 рублей и стоимостью одного квадратного метра 116 366 рублей. Доля таких объявлений составляет 0,18.

В городах Ленинградской области наиболее короткие сроки активности объявлений чаще всего имеют двухкомнатные квартиры с 1 балконом, находящиеся на 4 этаже из 5, с площадью 48,72 квадратных метров и высотой потолков 2,7 метров, средней стоимостью 3 561 720 рублей и стоимостью одного квадратного метра 73 275 рублей. Доля таких объявлений составляет 0,03.

Наиболее длинные сроки активности объявлений чаще всего имеют двухкомнатные квартиры с 1 балконом, находящиеся на 3 этаже из 5, с площадью 55,85 квадратных метров и высотой потолков 2,72 метра, средней стоимостью 3 836 511 рублей и стоимостью одного квадратного метра 68 126 рублей. Доля таких объявлений составляет 0,04.

### 2. Какие характеристики недвижимости, включая площадь недвижимости, среднюю стоимость квадратного метра, количество комнат и балконов и другие параметры, влияют на время активности объявлений? Как эти зависимости варьируют между регионами?

В Санкт-Петербурге более активно покупают менее дорогие квартиры с меньшей ценой за квадратный метр и меньшей площадью. Разница между самой дорогой и самой дешевой ценой составляет 2 187 948 рублей, разница между самой дорогой и самой дешевой стоимостью одного квадратного метра составляет 5 797 рублей, разница между самой большой и самой маленькой площадью составляет 13,42 квадратных метра. Также чаще покупают квартиры с более низким потолком, скорее всего квартиры с более высоким потолком имеют более высокую цену, поэтому их покупают реже. Количество балконов и комнат в среднем во всех объявлениях одинаково, поэтому проследить связь между этими значениями и временем активности объявлений невозможно.

В городах Ленинградской области более активно покупают менее дорогие квартиры с меньшей ценой за квадратный метр и меньшей площадью. Разница между самой дорогой и самой дешевой ценой составляет 2 187 948 рублей, разница между самой дорогой и самой дешевой стоимостью одного квадратного метра составляет 5 797 рублей, разница между самой большой и самой маленькой площадью составляет 13,42 квадратных метра. Количество балконов и комнат в среднем во всех объявлениях одинаково, поэтому проследить связь между этими значениями и временем активности объявлений невозможно.

### 3. Есть ли различия между недвижимостью Санкт-Петербурга и Ленинградской области по полученным результатам?

В Санкт-Петербурге гораздо больше объявлений о продаже недвижимости - 48% от общего количества, в городах Ленинградской области их 12%. В Санкт-Петербурге выше средняя цена за квартиру – для квартир с самым коротким сроком активности разница составляет 2 562 692 рубля, это почти в два раза дороже, для объявлений с самым длинным сроком активности разница составляет 4 475 849 рублей, это дороже больше, чем в два раза. Средняя цена за квадратный метр также дороже в Санкт-Петербурге, разница в ценах составляет 37 294 рубля для объявлений с самым коротким сроком активности и 48 240 рублей для объявлений с самым длинным сроком активности. В Санкт-Петербурге также чуть больше средняя площадь квартир, выше этажность домов и меньшая доля квартир-студий, чем в городах Ленинградской области. И в Санкт-Петербурге, и в городах Ленинградской области чаще всего продают двухкомнатные квартиры с одним балконом. В Санкт-Петербурге, как и в городах Ленинградской области, большая доля объявлений активна в течение 1-3 месяцев.

## Задача 2. Сезонность объявлений

### 1. В какие месяцы наблюдается наибольшая активность в публикации объявлений о продаже недвижимости? А в какие — по снятию? 

В среднем за все годы больше всего объявлений публиковалось в ноябре(392), октябре(359) и феврале(342). Наибольшая активность по снятию объявлений в среднем наблюдалась в октябре(453), ноябре(434) и сентябре(413).

### 2. Совпадают ли периоды активной публикации объявлений и периоды, когда происходит повышенная продажа недвижимости (по месяцам снятия объявлений)?

Некоторые периоды активной публикации и повышенной продажи совпадают – самые активные месяцы публикации это ноябрь и октябрь, для продажи это октябрь и ноябрь.

### 3. Как сезонные колебания влияют на среднюю стоимость квадратного метра и среднюю площадь квартир? Что можно сказать о зависимости этих параметров от месяца?

Весной и летом средняя стоимость квадратного метра снижается относительно зимы, осенью средняя стоимость повышается относительно весны и лета, зимой средняя стоимость повышается относительно осени. Весной и летом средняя площадь квартир снижается относительно зимы, осенью средняя площадь квартир относительно весны и лета, зимой средняя площадь квартир снижается относительно осени. 

Самая высокая средняя стоимость квадратного метра наблюдалась в январе(109 566) руб), сентябре(108 063 руб) и июне(106 663 руб). Самая низкая - в марте(101 424 руб), мае(103 364 руб) и апреле(103 364 руб)
Самая высокая средняя площадь квартир наблюдалась в сентябре(65,14 кв.м.), январе(63,73 кв.м.) и марте(63,17 кв.м.) Самая низкая - в июне(58,11 кв. м.), мае(60,19 кв. м.) и декабре(60,37 кв. м.).


## Задача 3. Анализ рынка недвижимости Ленобласти

### 1. В каких населённые пунктах Ленинградской области наиболее активно публикуют объявления о продаже недвижимости?

Топ-5 населенных пунктов, в которых наиболее активно публикуют объявления:
1.	Мурино - 568 объявлений.
2.	Кудрово - 463 объявления.
3.	Шушары - 404 объявления.
4.	Всеволожск - 356 объявлений.
5.	Парголово - 311 объявлений.

### 2. В каких населённых пунктах Ленинградской области — самая высокая доля снятых с публикации объявлений? Это может указывать на высокую долю продажи недвижимости.

Топ-5 населенных пунктов с самой высокой долей снятых с публикации объявлений:
1.	Мурино - 0,94.
2.	Кудрово - 0.94.
3.	Шушары - 0,93.
4.	Парголово - 0,93.
5.	Колпино - 0,92.

### 3. Какова средняя стоимость одного квадратного метра и средняя площадь продаваемых квартир в различных населённых пунктах? Есть ли вариация значений по этим метрикам?

Самая высокая средняя стоимость квадратного метра в Пушкине - 104 159 рублей, самая низкая в Выборге - 58 670 рублей.

Самая большая средняя площадь квартир в Сестрорецке - 62,45 кв.м., самая маленькая в Мурино - 43,86.

### 4. Среди выделенных населённых пунктов какие пункты выделяются по продолжительности публикации объявлений? 

Быстрее всего недвижимость продается в:
1.	Колпино (в среднем 147 дней) - средняя стоимость за квадратный метр составляет 75 212 рублей, средняя площадь 52,55 кв.м., среднее количество комнат - 2, среднее количество балконов - 1.
2.	Мурино (в среднем 149 дней) - средняя стоимость  за квадратный метр составляет 85 968 рублей, средняя площадь 43,86 кв.м., среднее количество комнат - 1, среднее количество балконов - 1.
3.	Шушары (в среднем 152 дня) - средняя стоимость  за квадратный метр составляет 78 832 рубля, средняя площадь 53,93 кв.м., среднее количество комнат - 2, среднее количество балконов - 1.
   
Медленнее всего недвижимость продается в:
1.	Сестрорецке (в среднем 215 дней) - средняя стоимость  за квадратный метр составляет 103 848 рублей, средняя площадь 62,45 кв.м., среднее количество комнат - 2, среднее количество балконов - 1.
2.	Красном Селе (в среднем 206 дней) - средняя стоимость  за квадратный метр составляет 71 972 рубля, средняя площадь 53,2 кв.м., среднее количество комнат - 2, среднее количество балконов - 1.
3.	Петергофе (в среднем 197 дней) - средняя стоимость  за квадратный метр составляет 85 412 рублей, средняя площадь 51,77 кв.м., среднее количество комнат - 2, среднее количество балконов - 1.

## Общие выводы и рекомендации
### 1.	Сегменты недвижимости:
○	В Санкт-Петербурге и Ленинградской области быстрее всего продаются двухкомнатные квартиры с 1 балконом, меньшей площадью и более низкой стоимостью. Это указывает на высокий спрос на доступное жильё. Акцент на такие объекты ускорит продажи.

○	Квартиры с большей площадью, более высокой стоимостью и стоимостью за квадратный метр продаются медленнее, что может быть связано с ограниченным кругом покупателей, готовых инвестировать в более дорогую недвижимость. Увеличение спроса на данный сегмент может потребовать дополнительных маркетинговых усилий.

○	В Санкт-Петербурге недвижимость в среднем дороже, чем в Ленинградской области, что отражает более высокий уровень спроса и цен в столице региона. В Ленинградской области спрос сосредоточен на более доступных вариантах, что делает этот регион привлекательным для покупателей с ограниченным бюджетом.


### 2.	Сезонность:
○	Наибольшая активность продаж наблюдается в осенние месяцы. Рекомендуется планировать маркетинговые кампании на этот период.

○	Сезонностые колебания в целом не сильно влияют на среднюю стоимость квадратного метра и среднюю площадь, однако весной и летом эти показатели снижаются. Можно использовать это для привлечения покупателей.
### 3.	География:
○	В Ленинградской области наиболее активны Мурино, Кудрово и Шушары. Эти районы приоритетны для инвестиций и продвижения. Мурино, Кудрово и Шушары также лидируют по доле снятых объявлений, что указывает на высокий уровень продаж в этих районах.

○	Медленнее всего продажи идут в Сестрорецке, Красном Селе и Петергофе, что может быть связано с более высокой стоимостью или меньшим спросом.

○	Наибольшая стоимость квадратного метра наблюдается в Пушкине, а самая низкая — в Выборге. Это важно учитывать при планировании ценовой стратегии.

○	Наибольшая площадь квартир — в Сестрорецке, что делает его привлекательным для покупателей, ищущих более просторное жильё.
Рекомендации:
●	В Санкт-Петербурге и городах Ленинградской области сфокусироваться на продвижении доступных двухкомнатных квартир с 1 балконом.

●	Усилить маркетинг весной и осенью. В летний период можно предлагать скидки или акции для стимулирования спроса.

●	Сосредоточить усилия на продвижении недвижимости в Мурино, Кудрово и Шушарах, так как эти районы демонстрируют высокую активность и спрос. В Сестрорецке, Красном Селе и Петергофе можно рассмотреть стратегии снижения цен или улучшения маркетинговых предложений для ускорения продаж.
