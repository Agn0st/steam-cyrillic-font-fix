<h1 align="center">Steam Cyrillic Font Fix</h1>

<p align="center">
  <a href="README.md">English</a> · <b>Українська</b> · <a href="README.es.md">Español</a>
</p>

<p align="center">
  <strong>Виправляє кирилицю, яка в Steam на macOS показується шрифтом Times.</strong>
</p>

<p align="center">
  <img alt="Steam client and web" src="https://shieldcn.dev/badge/Steam-Client%20%26%20Web-1B2838.svg?logo=steam&amp;size=xs">
  <img alt="Google Chrome" src="https://shieldcn.dev/badge/Google%20Chrome-4285F4.svg?logo=googlechrome&amp;size=xs">
  <img alt="macOS" src="https://shieldcn.dev/badge/macOS-000000.svg?logo=apple&amp;size=xs">
  <img alt="Fixes Cyrillic text" src="https://shieldcn.dev/badge/Fix-Cyrillic%20text-16A34A.svg?logo=ri:RiTranslate2&amp;size=xs">
  <a href="#ліцензія"><img alt="Шрифт під Apache 2.0, проєкт під MIT" src="https://shieldcn.dev/badge/License-Apache%202.0%20%2B%20MIT-6B7280.svg?logo=ri:RiScales3Line&amp;size=xs"></a>
</p>

<p align="center">
  <a href="https://github.com/Agn0st/steam-cyrillic-font-fix/releases/tag/v1.0"><img alt="Завантажити шрифт" src="https://shieldcn.dev/badge/Download-Font-7C3AED.svg?logo=ri:RiDownload2Line&amp;size=default"></a>
</p>

<p align="center">
  <a href="#проблема">Проблема</a> · <a href="#рішення">Рішення</a> · <a href="#встановлення">Встановлення</a> · <a href="#видалення">Видалення</a> · <a href="#альтернативні-рішення">Альтернативні рішення</a>
</p>

## Проблема

На macOS деякі сторінки Steam показують кириличний текст шрифтом **Times** (із
засічками), хоча латиниця на тій самій сторінці виглядає нормально. Це трапляється
в **клієнті Steam** і на сайті Steam у **Google Chrome**.

Сторінка просить шрифт **Motiva Sans fallback**. У macOS його немає, тому для
кириличних символів браузер підставляє системний шрифт із засічками.

| До | Після |
|----|-------|
| ![Кириличний текст на сторінці Steam відображається шрифтом Times](Images/before.png) | ![Той самий текст відображається правильно після встановлення шрифту](Images/after.png) |

<br>

## Рішення

Цей репозиторій містить модифіковану версію шрифту **Motiva Sans fallback** з доданою
кирилицею. Коли шрифт встановлено в системі, Steam і Chrome беруть кириличні символи
з нього, і текст відображається правильно.

> [!NOTE]
> Нічого іншого шрифт не замінює. Системні шрифти й шрифти інших програм лишаються як є.
> Інші програми цей шрифт не запитують, тож виглядають так само.

## Встановлення

1. Завантаж [`MotivaSansfallback-Regular.ttf`](https://github.com/Agn0st/steam-cyrillic-font-fix/releases/tag/v1.0).
2. Двічі клацни `MotivaSansfallback-Regular.ttf` і натисни **Встановити шрифт** у Font Book.
   Або скопіюй його в `~/Library/Fonts`.
3. Повністю закрий **Steam** і **Chrome** через <kbd>⌘</kbd> <kbd>Q</kbd> і відкрий їх знову.

> [!NOTE]
> Закрити вікно недостатньо. Обидві програми завантажують шрифти під час запуску, тому їх треба перезапустити повністю.

### Якщо кирилиця досі показується шрифтом Times

- Відкрий Font Book і перевір, що **Motiva Sans fallback** встановлено й
  увімкнено і що немає другої копії зі знаком попередження.
- Очисти кеш шрифтів macOS і перезавантаж Mac:

  ```bash
  sudo atsutil databases -remove
  ```

## Видалення

1. Відкрий **Font Book** і знайди **Motiva Sans fallback**.
2. Натисни правою кнопкою і вибери **Вилучити**.
3. Перезапусти Steam і Chrome.

<br>

## Альтернативні рішення

Деякі елементи Steam просять `"Motiva Sans", sans-serif` і пропускають **Motiva Sans fallback**,
тож шрифт вище до них не доходить. Наприклад, тонкий заголовок **Зараз у мережі** на сторінці
профілю. Ці варіанти виправляють такі елементи без встановлення шрифту.

### 1. Лише для Chrome

Код не потрібен. Відкрий `chrome://settings/fonts` і в полі **Sans-serif font** вибери **Arial**.

> [!WARNING]
> Це змінить `sans-serif` на всіх сайтах, а не лише для кирилиці в Steam.

### 2. Лише для клієнта Steam

Клієнт Steam побудований на Chromium і зберігає налаштування браузера у файлі, який можна
відредагувати. Признач Arial шрифтом sans-serif:

1. Повністю закрий **Steam** через <kbd>⌘</kbd> <kbd>Q</kbd>. Під час виходу Steam перезаписує файл.
2. Зроби резервну копію `~/Library/Application Support/Steam/config/htmlcache/Default/Preferences`.
3. Додай це на верхній рівень JSON у цьому файлі:

   ```json
   "webkit": {
     "webprefs": {
       "fonts": {
         "sansserif": {
           "Cyrl": "Arial",
           "Zyyy": "Arial"
         }
       }
     }
   }
   ```

4. Відкрий Steam знову.

Щоб повернути як було, закрий Steam і віднови резервну копію.

<br>

## Перевірено

| Програма | Версія | macOS |
|----------|--------|-------|
| Клієнт Steam | листопад 2026 | 27.0.1 |
| Google Chrome | 157.0.8103.38 | 27.0.1 |
| Google Chrome Beta | 158.0.8127.18 | 27.0.1 |
| Google Chrome Canary | 159.0.8149.0 | 27.0.1 |

> [!NOTE]
> Фікс не прив'язаний до цих версій. Це звичайний системний шрифт, тож він має
> працювати й з іншими версіями Steam, Chrome і macOS.

<br>

## Ліцензія

У цьому репозиторії дві ліцензії:

- **Шрифт** у `Font/` поширюється за [ліцензією Apache 2.0](LICENSE-APACHE) від його авторів. Це не моя робота.
- **Усе інше**, зокрема цей README, поширюється за [ліцензією MIT](LICENSE-MIT).

Steam Cyrillic Font Fix — неофіційний проєкт, не пов'язаний із Valve і Steam.
