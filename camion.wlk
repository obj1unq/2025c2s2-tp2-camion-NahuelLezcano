import cosas.*

object camion {
	const property cosas = #{}
		
	method cargar(unaCosa) {	
		self.validarCargaDe(unaCosa)
		cosas.add(unaCosa)  
	}

	method descargar(unaCosa) {
		self.validarDescargaDe(unaCosa)
		cosas.remove(unaCosa)
	}

	method validarCargaDe(unaCosa) {
		if(cosas.contains(unaCosa)) {
			self.error("No se pude cargar algo que el camion ya contiene.")
		}
	}

	method validarDescargaDe(unaCosa) {
		if(!cosas.contains(unaCosa)) {
			self.error("No se pude descargar algo que no contiene el camion.")
		}
	}

	method todoPesoEsPar() = cosas.all({obj => obj.peso().even()}) 

	method algunoPesa(kilogramos) = cosas.any({obj => obj.peso() == kilogramos}) 

	method tara() = 1000

	method carga() = cosas.sum({obj => obj.peso()})

	method peso() = self.tara() + self.carga()

	method estaExcedido() = self.peso() > 2500

	method conNivel(unNivel) = cosas.find({obj => obj.nivelPeligrosidad() == unNivel})

	method superanElNivel(unNivel) = cosas.filter({obj => obj.nivelPeligrosidad() > unNivel}) 

	method masPeligrososQue(unObjeto) = cosas.filter({obj => obj.nivelPeligrosidad() > unObjeto.nivelPeligrosidad()})

	method puedeCircularEnRuta(limite) = !self.estaExcedido() and self.ningunoSupera(limite)

	method ningunoSupera(limite) = cosas.all({obj => obj.nivelPeligrosidad() < limite})  

	method hayAlgoQuePeseEntre(min, max) = cosas.any({obj => obj.peso() >= min and obj.peso() <= max}) 

	method cosaMasPesada() = cosas.max({obj => obj.peso()}) 

	method pesos() = cosas.map({obj => obj.peso()}) 

	method totalBultos() = cosas.sum({obj => obj.bultos()}) 

	method accidentarCamion() { cosas.forEach({obj => obj.accidentar()}) }

	method transportar(destino, camino) {	
		camino.soportaElViajeDe(self)
		self.descargarEnElAlmacen(destino)
	}

	method descargarEnElAlmacen(almacen) {
		almacen.almacen().addAll(cosas)
		cosas.clear()
	}
}


object almacen {
	const property almacen = #{}

	method agregarAlAlmacen(unaCosa) {	
		almacen.add(unaCosa)  
	}
}


object ruta9 {
	method soportaElViajeDe(unCamion) {
		
		if(!unCamion.puedeCircularEnRuta(20)) {
			self.error("El viaje por ruta 9 no se puede realizar.")
		}
	}
}


object caminosVecinales {
	var property maximoPermitido = 0
	
	method soportaElViajeDe(unCamion) {
		
		if(unCamion.peso() > maximoPermitido) {
			self.error("El viaje por los caminos vecinales no se puede realizar")
		}
	}
}