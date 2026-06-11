import wollok.game.*
import fondo.*
import personajes.*
import elementos.*
import nivel_llaves.*
import utilidades.*

object nivelBloques {

	const property personaje = new PersonajeNivelBloques()
	const property bloquesEnTablero = #{}

	method todosLosBloquesEnDeposito() =
		self.bloquesEnTablero().all({ b => b.estaEnDeposito() })

	method faltanRequisitos() {
		if (self.todosLosBloquesEnDeposito())
			game.say(
				personaje,
				"Todas las cajas estan listas. Debo ir a la salida."
			)
		else
			game.say(
				personaje,
				"Todavia faltan cajas en el deposito."
			)
	}

	method hayBloque(posicion) =
		self.bloquesEnTablero().any({ b => b.position() == posicion })

	method ponerBloques(cantidad) {
		if (cantidad > 0) {

			const unaPosicion = utilidadesParaJuego.posicionArbitraria()

			if (not self.hayBloque(unaPosicion)) {

				const unBloque = new Bloque(
					position = unaPosicion
				)

				bloquesEnTablero.add(unBloque)
				game.addVisual(unBloque)

				self.ponerBloques(cantidad - 1)

			} else {

				self.ponerBloques(cantidad)

			}
		}
	}

	method configurate() {

		// fondo - es importante que sea el primer visual que se agregue
		game.addVisual(new Fondo())

		// salida
		game.addVisual(salida)

		// bloques
		self.ponerBloques(5)

		// personaje - es importante que sea el último visual
		game.addVisual(personaje)

		game.say(
			personaje,
			"Lleva todas las cajas al deposito y luego ve a la salida."
		)

		// teclado

		keyboard.right().onPressDo({
			personaje.moverDerecha()
		})

		keyboard.left().onPressDo({
			personaje.moverIzquierda()
		})

		keyboard.up().onPressDo({
			personaje.moverArriba()
		})

		keyboard.down().onPressDo({
			personaje.moverAbajo()
		})

		keyboard.n().onPressDo({

			if (
				self.todosLosBloquesEnDeposito() and
				personaje.position() == salida.position()
			)
				self.terminar()
			else
				self.faltanRequisitos()

		})
	}

	method terminar() {

		// sonido pasar
		game.sound("pasar.mp3").play()

		game.clear()

		game.addVisual(
			new Fondo(image = "fondoCompleto.png")
		)

		game.addVisual(personaje)

		game.schedule(
			1000,
			{

				game.clear()

				game.addVisual(
					new Fondo(image = "finNivel1.png")
				)

				game.schedule(
					1500,
					{

						game.clear()

						nivelLlaves.configurate()

					}
				)

			}
		)
	}
}