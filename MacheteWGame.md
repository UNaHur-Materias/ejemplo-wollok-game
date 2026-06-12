# 🧪  Machete Rápido de Wollok Game (VSCode + Wollok TS)

Una guía rápida para comenzar a desarrollar juegos simples con Wollok Game.

---

# 🎮  Crear un proyecto Game desde cero

Abrir una terminal y ejecutar:

```bash
wollok init --project wgame --game
```

Esto genera una estructura similar a:

```text
wgame/
│
├── .github/
├── assets/
│
├── .gitignore
├── example.wlk
├── mainExample.wpgm
├── package.json
├── README.md
└── testExample.wtest
```

---

# 📁 Estructura del proyecto

## 🖼️ assets/

Contiene recursos gráficos y de sonido:

```text
assets/
│
├── player.png
├── fondo.png
├── enemigo.png
├── moneda.png
├── ganar.mp3
└── perder.mp3
```

---

## 📄 Archivos Wollok

Los archivos pueden ubicarse directamente en la raíz del proyecto.

```text
juego.wpgm
personajes.wlk
elementos.wlk
utilidades.wlk
```

También pueden organizarse en carpetas:

```text
personajes/
elementos/
niveles/
utilidades/
```

⚠️ No existe obligación de usar una carpeta `src`.

---

# 🖼️ Recursos gráficos

Las imágenes deben estar dentro de:

```text
assets/
```

Y se referencian únicamente por nombre:

```wollok
const property image = "player.png"
```

✅ Correcto

```wollok
"player.png"
```

❌ Incorrecto

```wollok
"assets/player.png"
"/assets/player.png"
"./assets/player.png"
```

Wollok busca automáticamente los recursos dentro de la carpeta `assets`.

---

# 🎮 Programa principal

Siempre importar:

```wollok
import wollok.game.*
```

Ejemplo:

```wollok
import wollok.game.*

program miJuego {

	game.title("Mi Juego")

	game.width(15)
	game.height(10)

	game.start()
}
```

---

# 🏟️ Configuración del tablero

## 🏷️ Título

```wollok
game.title("Mi Juego")
```

## ↔️ Ancho

```wollok
game.width(15)
```

## ↕️ Alto

```wollok
game.height(10)
```

---

# 🌄 Fondos

## Fondo repetido (mosaico)

```wollok
game.ground("fondo.png")
```

## Fondo completo

```wollok
game.boardGround("fondo.png")
```

---

# 📍 Posiciones

Crear una posición:

```wollok
game.at(x, y)
```

Ejemplo:

```wollok
var property position = game.at(5,3)
```

---

# 🎭 Objetos visuales

Todo objeto visible debe tener:

```wollok
var property position
const property image
```

Ejemplo:

```wollok
class Auto {

	var property position = game.at(2,5)

	const property image = "auto.png"
}
```

---

# ➕ Agregar visuales

Agregar un objeto al tablero:

```wollok
game.addVisual(unObjeto)
```

Ejemplo:

```wollok
game.addVisual(jugador)
```

---

# ➖ Eliminar visuales

Eliminar un objeto:

```wollok
game.removeVisual(unObjeto)
```

---

# 🧹 Limpiar el tablero

Elimina:

* 🎭 Visuales
* ⌨️ Acciones de teclado
* 💥 Colisiones
* ⏱️ Eventos programados

```wollok
game.clear()
```

Muy útil para:

* Cambiar de nivel.
* Mostrar pantallas de victoria.
* Mostrar pantallas de derrota.

---

# ⌨️ Teclado

Asignar una acción a una tecla:

```wollok
keyboard.x().onPressDo({
	objeto.accion()
})
```

## ⏎ Enter

```wollok
keyboard.enter().onPressDo({
	iniciarJuego()
})
```

## 🚀 Barra espaciadora

```wollok
keyboard.space().onPressDo({
	jugador.disparar()
})
```

## ⬅️➡️⬆️⬇️ Flechas

```wollok
keyboard.right().onPressDo({
	jugador.moverDerecha()
})

keyboard.left().onPressDo({
	jugador.moverIzquierda()
})

keyboard.up().onPressDo({
	jugador.moverArriba()
})

keyboard.down().onPressDo({
	jugador.moverAbajo()
})
```

---

# ➡️ Movimiento

Mover una posición una celda:

```wollok
posicion.right(1)
posicion.left(1)
posicion.up(1)
posicion.down(1)
```

Ejemplo:

```wollok
self.position(
	self.position().right(1)
)
```

---

# 💬 Mensajes

Mostrar un globo de diálogo:

```wollok
game.say(personaje, "Hola")
```

⚠️ IMPORTANTE

```text
game.say NO imprime texto libre en pantalla.

Muestra un globo asociado a un visual.
```

Ejemplo:

```wollok
game.say(jugador, "Tengo poca energia")
```

---

# 🔊 Sonidos

Reproducir un sonido:

```wollok
game.sound("ganar.mp3").play()
```

---

# 💥 Colisiones

Detectar colisiones:

```wollok
game.whenCollideDo(
	jugador,
	{
		objeto =>
			objeto.reaccionarA(jugador)
	}
)
```

---

# ⏱️ Temporizadores

Ejecutar una acción después de cierto tiempo:

```wollok
game.schedule(
	1000,
	{
		game.clear()
	}
)
```

⏱️ Referencia rápida

```text
1000 ms = 1 segundo
2000 ms = 2 segundos
3000 ms = 3 segundos
5000 ms = 5 segundos
```

---

# 🏁 Finalizar el juego

```wollok
game.stop()
```

---

# 🎲 Números aleatorios

Número entre 0 y 30:

```wollok
0.randomUpTo(30)
```

Número entero:

```wollok
0.randomUpTo(30).truncate(0)
```

---

# 🧪 Ejemplo mínimo completo

```wollok
import wollok.game.*

object jugador {

	var property position = game.at(5,5)

	const property image = "player.png"
}

program ejemplo {

	game.title("Mi Primer Juego")

	game.width(15)
	game.height(10)

	game.addVisual(jugador)

	keyboard.right().onPressDo({
		jugador.position(
			jugador.position().right(1)
		)
	})

	game.start()
}
```

---

# 💡 Ideas para practicar

## 🟢 Fácil

* Mover un personaje.
* Recolectar monedas.

## 🟡 Intermedio

* Buscar llaves.
* Administrar energía.
* Empujar cajas.

## 🔴 Desafiante

* Crear enemigos.
* Crear varios niveles.
* Detectar colisiones.
* Usar herencia.
* Usar polimorfismo.
* Utilizar objetos como estrategias.
* Aplicar colecciones para manejar elementos del tablero.

---

# 📚 Recordatorio

🎮 Wollok Game es una excusa divertida para practicar Programación con Objetos.

No hace falta desarrollar el próximo Minecraft.

Lo importante es aprender:

* 📦 Objetos
* 📨 Mensajes
* 🔒 Encapsulamiento
* 📚 Colecciones
* 👪 Herencia
* 🎭 Polimorfismo
* 🤝 Delegación
* 🧠 Modelado orientado a objetos
