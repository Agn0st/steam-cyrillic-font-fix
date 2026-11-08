<h1 align="center">Steam Cyrillic Font Fix</h1>

<p align="center">
  <a href="README.md">English</a> · <a href="README.uk.md">Українська</a> · <b>Español</b>
</p>

<p align="center">
  <strong>Corrige el texto cirílico que aparece en Times en Steam para macOS.</strong>
</p>

<p align="center">
  <img alt="Steam client and web" src="https://shieldcn.dev/badge/Steam-Client%20%26%20Web-1B2838.svg?logo=steam&amp;size=xs">
  <img alt="Google Chrome" src="https://shieldcn.dev/badge/Google%20Chrome-4285F4.svg?logo=googlechrome&amp;size=xs">
  <img alt="macOS" src="https://shieldcn.dev/badge/macOS-000000.svg?logo=apple&amp;size=xs">
  <img alt="Fixes Cyrillic text" src="https://shieldcn.dev/badge/Fix-Cyrillic%20text-16A34A.svg?logo=ri:RiTranslate2&amp;size=xs">
  <a href="#licencia"><img alt="Fuente bajo Apache 2.0, proyecto bajo MIT" src="https://shieldcn.dev/badge/License-Apache%202.0%20%2B%20MIT-6B7280.svg?logo=ri:RiScales3Line&amp;size=xs"></a>
  <a href="https://www.npmjs.com/package/steam-cyrillic-font-fix"><img alt="Versión de npm" src="https://shieldcn.dev/npm/steam-cyrillic-font-fix.svg?logo=npm&amp;color=CB3837&amp;size=xs"></a>
</p>

<p align="center">
  <a href="https://github.com/Agn0st/steam-cyrillic-font-fix/releases/latest"><img alt="Descargar la última versión" src="https://shieldcn.dev/badge/Download-Latest%20release-7C3AED.svg?logo=ri:RiDownload2Line&amp;size=default"></a>
</p>

<p align="center">
  <a href="#el-problema">El problema</a> · <a href="#solución">Solución</a> · <a href="#instalación">Instalación</a> · <a href="#desinstalación">Desinstalación</a> · <a href="#soluciones-alternativas">Soluciones alternativas</a>
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

<br>

## Solución

Este repositorio contiene una versión modificada de la fuente **Motiva Sans fallback**
con caracteres cirílicos añadidos. Una vez instalada, Steam y Chrome toman de ella los
caracteres cirílicos y el texto se muestra correctamente.

> [!NOTE]
> No se reemplaza nada más. Las fuentes del sistema y las que usan otras apps siguen igual.
> Las demás apps no piden esta fuente, así que se ven como siempre.

## Instalación

### Automática

El instalador añade la fuente y pone Arial para el texto cirílico en el cliente de Steam
(ver [Soluciones alternativas](#2-solo-para-el-cliente-de-steam)). Si Steam está abierto,
lo cierra y lo vuelve a abrir.

**Sin Terminal**

1. Descarga `steam-cyrillic-font-fix-v1.2.zip` desde [Releases](https://github.com/Agn0st/steam-cyrillic-font-fix/releases/latest) y descomprímelo.
2. Haz doble clic en **Install Steam Cyrillic Font Fix.command**.
3. Cierra **Chrome** por completo con <kbd>⌘</kbd> <kbd>Q</kbd> y vuelve a abrirlo.

> [!NOTE]
> Si macOS dice que el archivo no se puede abrir, haz clic derecho, elige **Abrir** y pulsa **Abrir** de nuevo.

**Con Node.js**

```bash
npx steam-cyrillic-font-fix
```

Añade `--font-only` o `--client-only` para aplicar solo una parte, o `--chrome` para corregir
también Chrome (ver [Solo para Chrome](#1-solo-para-chrome)).

> [!NOTE]
> ¿No tienes Node.js? Instálalo desde [nodejs.org](https://nodejs.org) o con [Homebrew](https://brew.sh): `brew install node`.
> `npx` viene incluido.

### Manual

1. Descarga [`MotivaSansfallback-Regular.ttf`](https://github.com/Agn0st/steam-cyrillic-font-fix/releases/latest).
2. Haz doble clic en `MotivaSansfallback-Regular.ttf` y pulsa **Instalar tipo de letra** en Font Book.
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

Quita la corrección de la misma forma en que la instalaste.

### 1. Instalada con Node.js

```bash
npx steam-cyrillic-font-fix --undo
```

Si también corregiste Chrome, deshazlo aparte, por ejemplo con `npx steam-cyrillic-font-fix --undo --chrome`.

### 2. Instalada con el archivo .command

Arrastra **Install Steam Cyrillic Font Fix.command** a Terminal, añade `--undo` y pulsa <kbd>Return</kbd>.

### 3. Instalada a mano

1. Abre **Font Book** y busca **Motiva Sans fallback**.
2. Haz clic derecho y elige **Eliminar**.
3. Reinicia Steam y Chrome.

<br>

## Soluciones alternativas

Algunos elementos de Steam piden `"Motiva Sans", sans-serif` y se saltan **Motiva Sans fallback**,
así que la fuente de arriba no llega a ellos. Un ejemplo es el encabezado fino **En línea** de la
página de perfil. Estas opciones los corrigen sin instalar la fuente.

### 1. Solo para Chrome

Sin código. Abre `chrome://settings/fonts` y en **Sans-serif font** elige **Arial**.

O deja que el instalador lo haga en todos los perfiles de Chrome:

```bash
npx steam-cyrillic-font-fix --chrome
```

Usa `--chrome-beta` o `--chrome-canary` para esas versiones. Chrome se cierra y se vuelve a abrir.
Las pestañas abiertas vuelven solo si **Continuar donde lo dejaste** está activado en la configuración de Chrome.

> [!WARNING]
> Esto cambia `sans-serif` en todos los sitios web, no solo para el texto cirílico de Steam.

### 2. Solo para el cliente de Steam

El cliente de Steam está hecho con Chromium y guarda la configuración del navegador en un
archivo que se puede editar. El [instalador](#automática) pone Arial como su fuente
sans-serif por ti. Para cambiar solo el cliente de Steam:

```bash
npx steam-cyrillic-font-fix --client-only
```

A mano:

1. Cierra **Steam** por completo con <kbd>⌘</kbd> <kbd>Q</kbd>. Steam reescribe el archivo al salir.
2. Haz una copia de seguridad de `~/Library/Application Support/Steam/config/htmlcache/Default/Preferences`.
3. Añade esto al nivel superior del JSON de ese archivo:

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

4. Vuelve a abrir Steam.

Para deshacerlo, cierra Steam y restaura la copia de seguridad.

<br>

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

<br>

## Licencia

Este repositorio usa dos licencias:

- **La fuente** de `Font/` se distribuye bajo la [licencia Apache 2.0](LICENSE-APACHE) de sus autores originales. No es obra mía.
- **Todo lo demás**, incluido este README, se distribuye bajo la [licencia MIT](LICENSE-MIT).

Steam Cyrillic Font Fix es un proyecto no oficial, independiente de Valve y de Steam.
