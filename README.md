# 🎮 Oh Qué Aventura

---

# 🚀 Ejecución

Desde Visual Studio Code:
* Abrir el archivo `programa_juego_aventura.wpgm`
* Clic en `Ejecutar programa`
```wollok
        Ejecutar programa | Depurar programa
        program juego_aventura
```
* Abrir la URL mostrada en consola
 
---

Juego desarrollado en **Wollok Game** como ejercicio de Programación con Objetos.

El jugador deberá superar dos niveles diferentes, cada uno con desafíos y mecánicas particulares.

---

# 📦 Nivel 1 - Mover Cajas

El primer nivel está inspirado en el clásico Sokoban.

El tablero contiene:

* Un personaje controlado por el jugador.
* Varias cajas.
* Un depósito.
* Una salida.

El objetivo consiste en empujar todas las cajas hasta el depósito. Una vez que todas estén correctamente ubicadas, el personaje deberá dirigirse a la salida para avanzar al siguiente nivel.

## Objetivo

* Llevar las 5 cajas al depósito.
* Llegar a la salida.
* Presionar la tecla **N** para finalizar el nivel.

---

# 🔑 Nivel 2 - Buscar Llaves

En el segundo nivel el personaje deberá explorar el tablero para reunir las tres llaves necesarias para escapar.

La salida no aparece desde el inicio.

Solamente se habilita cuando el personaje consigue las tres llaves.

## Energía

Cada movimiento consume una unidad de energía.

El personaje comienza con:

```text
40 puntos de energía
```

Si la energía llega a cero, el jugador pierde la partida.

Para recuperar energía deberá encontrar pollos distribuidos por el tablero.

---

# 🍗 Pollos

Los pollos restauran energía.

Cada pollo posee una cantidad de energía propia, generada aleatoriamente.

Además, cada vez que se consume un pollo aparece uno nuevo en una posición aleatoria del tablero.

---

# 🪙 Modificadores

Existen distintos objetos que alteran el efecto energético de los pollos.

Cuando el personaje obtiene un modificador, éste reemplaza al modificador anterior.

## Duplicador

Duplica la energía obtenida al consumir un pollo.

## Reforzador

Duplica la energía obtenida.

Además, si el personaje tiene menos de 10 puntos de energía, obtiene 20 puntos extra.

## Triple o Nada

* Si la energía actual es impar, el pollo otorga el triple de energía.
* Si la energía actual es par, no otorga energía.

---

# ❓ Celdas Sorpresa

Las celdas sorpresa poseen una apariencia idéntica, por lo que el jugador no sabe qué efecto producirán hasta acercarse a ellas.

Cada celda puede activar alguno de los siguientes efectos:

* Teletransportar al personaje.
* Agregar energía.
* Quitar energía.
* Generar un nuevo pollo.

Una vez utilizadas cambian de apariencia para indicar que ya fueron activadas.

---

# ⌨️ Controles

| Tecla       | Acción                 |
| ----------- | ---------------------- |
| ⬅️ ➡️ ⬆️ ⬇️ | Mover al personaje     |
| E           | Mostrar energía actual |
| N           | Finalizar el nivel 1   |
| ENTER       | Comenzar la partida    |

---

# 🧩 Conceptos de Programación con Objetos

El proyecto utiliza diversos conceptos trabajados durante la cursada:

* Objetos y mensajes.
* Encapsulamiento.
* Polimorfismo.
* Herencia.
* Delegación.
* Objetos como estrategia.
* Colecciones.
* Recursividad.
* Eventos.
* Colisiones.
* Juegos basados en objetos con Wollok Game.

---

# 🛠️ Tecnologías

* Wollok
* Wollok Game
* Wollok TS

---

# 👨‍💻 Créditos

Proyecto desarrollado originalmente como trabajo práctico integrador de Programación con Objetos 1 - 2021s1.

Posteriormente adaptado y actualizado para funcionar con las versiones actuales de Wollok Game.

---