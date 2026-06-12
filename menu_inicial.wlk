import fondo.Fondo
import nivel_bloques.nivelBloques
import wollok.game.*

object menuInicial {
  method mostrar() {
    game.clear()
    
    game.addVisual(new Fondo(image = "fondoInicio.png"))
    game.title("OH QUE AVENTURA")
   
    keyboard.enter().onPressDo({ 
        keyboard.enter().onPressDo({}) 
        game.clear()
        nivelBloques.configurate()
    })
  }
}
