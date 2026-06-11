import wollok.game.*
import utilidades.*
import nivel_bloques.*
import nivel_llaves.*
import elementos.*


// en la implementación real, conviene tener un personaje por nivel
// los personajes probablemente tengan un comportamiendo más complejo que solamente
// imagen y posición

/* personaje generico */
class Personaje {
	var property position = utilidadesParaJuego.posicionArbitraria()
	const property image = "player.png"
	var proximaPosicion = self.position()
	
	/* MOVIMIENTOS */
	method moverDerecha() {
		proximaPosicion = game.at(self.position().x() + 2, self.position().y())
		self.moverA_Haciendo(self.position().right(1))
	}

	method moverIzquierda() {
		proximaPosicion = game.at(self.position().x() - 2, self.position().y())
		self.moverA_Haciendo(self.position().left(1))
	}

	method moverArriba() {
		proximaPosicion = game.at(self.position().x(), self.position().y() + 2)
		self.moverA_Haciendo(self.position().up(1))
	}

	method moverAbajo() {
		proximaPosicion = game.at(self.position().x(), self.position().y() - 2)
		self.moverA_Haciendo(self.position().down(1))
	}
	
	method moverA_Haciendo(posicion) {
		if (utilidadesParaJuego.sePuedeMover(posicion)) {
			self.hacerSiHayObjetoEn(posicion)
		}
	}

	method hacerSiHayObjetoEn(posicion)

	method moverA(posicion) {
		self.position(posicion)
	}
}


/* CON personajes como Clases heredadas */
class PersonajeNivelLlaves inherits Personaje {

	var property energia = 40
	var property llavesConseguidas = 0

	var efectoModificador = {
		unPollo, energiaActual => unPollo.energia()
	}
	
	method nivelDeEnergia() =
		"Energia: " +
		self.energia().toString() +
		" | Llaves: " +
		self.llavesConseguidas().toString()
	
	method incorporaEfecto(unElemento) {
		efectoModificador = unElemento.efecto()
	}

	method perderEnergia() {
		self.energia(self.energia() - 1)
	}

	method ganarEnergia(cantidad) {
		self.energia(self.energia() + cantidad)
	}

	method perderEnergia(cantidad) {
		self.energia(self.energia() - cantidad)
	}
	
	method comerPollo(unPollo) {
		const energiaPolloModificada =
			efectoModificador.apply(
				unPollo,
				self.energia()
			)

		self.ganarEnergia(energiaPolloModificada)

		nivelLlaves.AgregarPollo()
	}
	
	method guardarLlave() {

		self.llavesConseguidas(
			self.llavesConseguidas() + 1
		)

		if (self.llavesConseguidas() == 3) {

			game.say(
				self,
				"Conseguiste todas las llaves. Busca la salida."
			)

			nivelLlaves.ponerSalida()
		}
	}
	
	/* EVALUADORES */

	method puedeGanar() =
		self.llavesConseguidas() == 3
		and self.position() == salida.position()

	/* MOVIMIENTOS */

	override method hacerSiHayObjetoEn(posicion) {

		if (nivelLlaves.hayElementoEn(posicion)) {

			const unElemento =
				nivelLlaves.elementoDe(posicion)

			unElemento.reaccionarA(self)

		} else {

			self.moverA(posicion)

		}
	}

	override method moverA(posicion) {

		self.perderEnergia()

		super(posicion)

		nivelLlaves.celdaSorpresaPisada()

		if (self.energia() <= 0) {
			nivelLlaves.perder()
		}

		if (self.puedeGanar()) {
			nivelLlaves.ganar()
		}
	}
}


class PersonajeNivelBloques inherits Personaje {

	/* MOVIMIENTOS */

	override method hacerSiHayObjetoEn(posicion) {

		if (
			nivelBloques.hayBloque(posicion)
			and
			not nivelBloques.hayBloque(proximaPosicion)
		) {

			const unBloque =
				nivelBloques.bloquesEnTablero().find({
					b => b.position() == posicion
				})

			unBloque.empujar(proximaPosicion)
		}

		self.moverA(posicion)
	}

	override method moverA(posicion) {

		if (not nivelBloques.hayBloque(posicion)) {
			super(posicion)
		}
	}
}