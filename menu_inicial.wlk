import fondo.Fondo
import nivel_bloques.nivelBloques

object menuInicial {
  method mostrar() {
    game.clear()
    
    game.addVisual(new Fondo(image = "fondoCompleto.png"))
    
    game.say(game.at(4, 13), "OH QUE AVENTURA")
    game.say(game.at(2, 11), "Nivel 1: llevar todas las cajas al deposito")
    game.say(game.at(2, 10), "y luego ir a la salida")
    
    game.say(game.at(2, 8), "Nivel 2: conseguir las 3 llaves")
    game.say(game.at(2, 7), "antes de quedarte sin energia")
    
    game.say(game.at(2, 5), "Flechas: mover")
    game.say(game.at(2, 4), "E: mostrar energia")
    game.say(
      game.at(2, 3),
      "N: salir del nivel 1 cuando todas las cajas esten en el deposito"
    )
    game.say(game.at(2, 2), "?: algunas casillas tienen sorpresas")
    
    game.say(game.at(2, 1), "ENTER para comenzar")
    
    keyboard.enter().onPressDo(
      { 
        keyboard.enter().onPressDo({   })
        game.clear()
        nivelBloques.configurate()
      }
    )
  }
}