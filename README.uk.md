<h1 align="center">Steam Cyrillic Font Fix</h1>

<p align="center">
  <a href="README.md">English</a> · <b>Українська</b> · <a href="README.es.md">Español</a>
</p>

<p align="center">
  <strong>Кирилиця в Steam знову виглядає так само, як решта сторінки.</strong><br>
  Один файл шрифту для macOS виправляє кириличний текст, який у клієнті Steam і в Google Chrome показується шрифтом Times.
</p>

<p align="center">
  <img alt="Steam client and web" src="https://shieldcn.dev/badge/Steam-Client%20%26%20Web-1B2838.svg?logo=steam&amp;size=xs">
  <img alt="Google Chrome" src="https://shieldcn.dev/badge/Google%20Chrome-4285F4.svg?logo=googlechrome&amp;size=xs">
  <img alt="macOS" src="https://shieldcn.dev/badge/macOS-000000.svg?logo=apple&amp;size=xs">
  <img alt="Fixes Cyrillic text" src="https://shieldcn.dev/badge/Fix-Cyrillic%20text-16A34A.svg?logo=ri:RiTranslate2&amp;size=xs">
  <a href="#ліцензія"><img alt="Шрифт під Apache 2.0, проєкт під MIT" src="https://shieldcn.dev/badge/License-Apache%202.0%20%2B%20MIT-6B7280.svg?logo=ri:RiScales3Line&amp;size=xs"></a>
</p>

<p align="center">
  <a href="https://github.com/Agn0st/steam-cyrilic-font-fix/raw/main/Font/MotivaSansfallback-Regular.ttf"><img alt="Завантажити шрифт" src="https://shieldcn.dev/badge/Download-Font-7C3AED.svg?logo=ri:RiDownload2Line&amp;size=default"></a>
</p>

<p align="center">
  <a href="#проблема">Проблема</a> · <a href="#рішення">Рішення</a> · <a href="#встановлення">Встановлення</a> · <a href="#видалення">Видалення</a>
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

## Рішення

Цей репозиторій містить модифіковану версію шрифту **Motiva Sans fallback** з доданою
кирилицею. Коли шрифт встановлено в системі, Steam і Chrome беруть кириличні символи
з нього, і текст відображається правильно.

> [!NOTE]
> Нічого іншого шрифт не замінює. Системні шрифти й шрифти інших програм лишаються як є.
> Інші програми цей шрифт не запитують, тож виглядають так само.

## Встановлення

1. Завантаж [`MotivaSansfallback-Regular.ttf`](https://github.com/Agn0st/steam-cyrilic-font-fix/raw/main/Font/MotivaSansfallback-Regular.ttf).
2. Двічі клацни файл і натисни **Встановити шрифт** у Font Book.
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

## Ліцензія

У цьому репозиторії дві ліцензії:

- **Шрифт** у `Font/` поширюється за [ліцензією Apache 2.0](Font/LICENSE) від його авторів. Це не моя робота.
- **Усе інше**, зокрема цей README, поширюється за [ліцензією MIT](LICENSE).

Steam Cyrillic Font Fix — неофіційний проєкт, не пов'язаний із Valve і Steam.
