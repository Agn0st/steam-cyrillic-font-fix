<h1 align="center">Steam Cyrillic Font Fix</h1>

<p align="center">
  <a href="README.md">English</a> · <a href="README.uk.md">Українська</a> · <b>Español</b>
</p>

<p align="center">
  <strong>El texto cirílico en Steam vuelve a verse como el resto de la página.</strong><br>
  Un solo archivo de fuente para macOS corrige el texto cirílico que aparece en Times en el cliente de Steam y en Google Chrome.
</p>

<p align="center">
  <img alt="Steam client and web" src="https://shieldcn.dev/badge/Steam-Client%20%26%20Web-1B2838.svg?logo=steam&amp;size=xs">
  <img alt="Google Chrome" src="https://shieldcn.dev/badge/Google%20Chrome-4285F4.svg?logo=googlechrome&amp;size=xs">
  <img alt="macOS" src="https://shieldcn.dev/badge/macOS-000000.svg?logo=apple&amp;size=xs">
  <img alt="Fixes Cyrillic text" src="https://shieldcn.dev/badge/Fix-Cyrillic%20text-16A34A.svg?logo=ri:RiTranslate2&amp;size=xs">
  <a href="#licencia"><img alt="Fuente bajo Apache 2.0, proyecto bajo MIT" src="https://shieldcn.dev/badge/License-Apache%202.0%20%2B%20MIT-6B7280.svg?logo=ri:RiScales3Line&amp;size=xs"></a>
</p>

<p align="center">
  <a href="https://github.com/Agn0st/steam-cyrilic-font-fix/raw/main/Font/MotivaSansfallback-Regular.ttf"><img alt="Descargar la fuente" src="https://shieldcn.dev/badge/Download-Font-7C3AED.svg?logo=ri:RiDownload2Line&amp;size=default"></a>
</p>

<p align="center">
  <a href="#el-problema">El problema</a> · <a href="#solución">Solución</a> · <a href="#instalación">Instalación</a> · <a href="#desinstalación">Desinstalación</a>
</p>

## El problema

En macOS, algunas páginas de Steam muestran el texto cirílico en **Times**, una fuente
con serifa, mientras que el texto latino de la misma página se ve normal. Ocurre en el
**cliente de Steam** y en el sitio web de Steam en **Google Chrome**.

La página pide una fuente llamada **Motiva Sans fallback**. macOS no la tiene, así que
para los caracteres cirílicos el navegador acaba usando la fuente con serifa del sistema.

| Antes | Después |
|-------|---------|
| ![Texto cirílico en una página de Steam mostrado en Times](Images/before.png) | ![El mismo texto mostrado correctamente tras instalar la fuente](Images/after.png) |

## Solución

Este repositorio contiene una versión modificada de la fuente **Motiva Sans fallback**
con caracteres cirílicos añadidos. Una vez instalada, Steam y Chrome toman de ella los
caracteres cirílicos y el texto se muestra correctamente.

> [!NOTE]
> No se reemplaza nada más. Las fuentes del sistema y las que usan otras apps siguen igual.
> Las demás apps no piden esta fuente, así que se ven como siempre.

## Instalación

1. Descarga [`MotivaSansfallback-Regular.ttf`](https://github.com/Agn0st/steam-cyrilic-font-fix/raw/main/Font/MotivaSansfallback-Regular.ttf).
2. Haz doble clic en el archivo y pulsa **Instalar tipo de letra** en Font Book.
   También puedes copiarlo a `~/Library/Fonts`.
3. Cierra **Steam** y **Chrome** por completo con <kbd>⌘</kbd> <kbd>Q</kbd> y vuelve a abrirlos.

> [!NOTE]
> Cerrar la ventana no basta. Ambas apps cargan las fuentes al arrancar, así que hay que reiniciarlas del todo.

### Si el texto cirílico sigue apareciendo en Times

- Abre Font Book y comprueba que **Motiva Sans fallback** está instalada y activada,
  y que no hay una copia duplicada marcada con un signo de advertencia.
- Borra la caché de fuentes de macOS y reinicia el Mac:

  ```bash
  sudo atsutil databases -remove
  ```

## Desinstalación

1. Abre **Font Book** y busca **Motiva Sans fallback**.
2. Haz clic derecho y elige **Eliminar**.
3. Reinicia Steam y Chrome.

## Probado

| App | Versión | macOS |
|-----|---------|-------|
| Cliente de Steam | noviembre de 2026 | 27.0.1 |
| Google Chrome | 157.0.8103.38 | 27.0.1 |
| Google Chrome Beta | 158.0.8127.18 | 27.0.1 |
| Google Chrome Canary | 159.0.8149.0 | 27.0.1 |

> [!NOTE]
> La corrección no depende de estas versiones. Es una fuente normal del sistema, así que
> debería funcionar con otras versiones de Steam, Chrome y macOS.

## Licencia

Este repositorio usa dos licencias:

- **La fuente** de `Font/` se distribuye bajo la [licencia Apache 2.0](Font/LICENSE) de sus autores originales. No es obra mía.
- **Todo lo demás**, incluido este README, se distribuye bajo la [licencia MIT](LICENSE).

Steam Cyrillic Font Fix es un proyecto no oficial, independiente de Valve y de Steam.
