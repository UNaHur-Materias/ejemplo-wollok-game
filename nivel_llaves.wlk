import wollok.game.*
import fondo.*
import personajes.*
import utilidades.*
import elementos.*

object nivelLlaves {

	const property personaje = new PersonajeNivelLlaves()
	const elementosEnNivel = []

	method ponerElementos(cantidad, elemento) {
		if (cantidad > 0) {
			const unaPosicion = utilidadesParaJuego.posicionArbitraria()

			if (not self.hayElementoEn(unaPosicion)) {

				const unaInstancia = elemento.instanciar(unaPosicion)

				elementosEnNivel.add(unaInstancia)
				game.addVisual(unaInstancia)

				self.ponerElementos(cantidad - 1, elemento)

			} else {

				self.ponerElementos(cantidad, elemento)

			}
		}
	}

	/* Metodos que tambien interactuan con los movimientos del personaje */

	method ponerSalida() {
		game.addVisual(salida)
	}

	method elementoDe(posicion) =
		elementosEnNivel.find({ e => e.position() == posicion })

	method hayElementoEn(posicion) =
		elementosEnNivel.any({ e => e.position() == posicion })

	method estado() {
		game.say(
			personaje,
			"Energia: " + personaje.nivelDeEnergia()
		)
	}

	method celdasSorpresa() {
		return elementosEnNivel.filter({
			e => e.esCeldaSorpresa()
		})
	}

	method entroEnZona(posicionPersonaje, posicionCelda) {

		return (
			posicionCelda.x().between(
				posicionPersonaje.x(),
				posicionPersonaje.x()
			)
			and
			posicionCelda.y().between(
				posicionPersonaje.y() - 1,
				posicionPersonaje.y() + 1
			)
		)
		or
		(
			posicionCelda.x().between(
				posicionPersonaje.x() - 1,
				posicionPersonaje.x() + 1
			)
			and
			posicionCelda.y().between(
				posicionPersonaje.y(),
				posicionPersonaje.y()
			)
		)
	}

	method configurate() {

		elementosEnNivel.clear()

		// fondo - es importante que sea el primer visual que se agregue
		game.addVisual(
			new Fondo(image = "fondoCompleto.png")
		)

		// llaves y objetos

		self.ponerElementos(3, llave)
		self.ponerElementos(1, pollo)

		self.ponerElementos(1, tripleOrNada)
		self.ponerElementos(1, reforzador)
		self.ponerElementos(1, duplicador)

		self.ponerElementos(1, sorpresaA)
		self.ponerElementos(2, sorpresaB)
		self.ponerElementos(1, sorpresaC)
		self.ponerElementos(1, sorpresaD)

		// personaje, es importante que sea el último visual
		game.addVisual(personaje)

		game.say(
			personaje,
			"Consegui las 3 llaves antes de quedarte sin energia"
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

		keyboard.e().onPressDo({
			self.estado()
		})

		// colisiones

		game.whenCollideDo(
			personaje,
			{
				objeto =>

				game.removeVisual(objeto)

				elementosEnNivel.remove(objeto)

				game.sound(objeto.sonido()).play()

				self.estado()
			}
		)
	}

	method celdaSorpresaPisada() {

		const celdas =
			self.celdasSorpresa().filter({

				e =>
					self.entroEnZona(
						personaje.position(),
						e.position()
					)
					and
					not e.fueActivada()

			})

		if (celdas.size() > 0) {
			celdas.forEach({
				celda => celda.activarSorpresa()
			})
		}
	}

	method AgregarPollo() {
		self.ponerElementos(1, pollo)
	}

	method EfectoPerderEnergia() {
		personaje.perderEnergia(15)
	}

	method EfectoAgregarEnergia() {
		personaje.ganarEnergia(30)
	}

	method Teletransportar() {
		personaje.position(
			utilidadesParaJuego.posicionArbitraria()
		)
	}

	method ganar() {

		game.sound("ganar.mp3").play()

		game.clear()

		game.addVisual(
			new Fondo(image = "fondoCompleto.png")
		)

		game.schedule(
			1000,
			{

				game.clear()

				game.addVisual(
					new Fondo(image = "ganamos.png")
				)

				game.schedule(
					1500,
					{
						game.stop()
					}
				)

			}
		)
	}

	method perder() {

		game.sound("perder.mp3").play()

		game.clear()

		game.addVisual(
			new Fondo(image = "fondoCompleto.png")
		)

		game.schedule(
			1000,
			{

				game.clear()

				game.addVisual(
					new Fondo(image = "perdimos.png")
				)

				game.schedule(
					3000,
					{
						game.stop()
					}
				)

			}
		)
	}
}