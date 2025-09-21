object knightRider {
	method peso() { return 500 }

	method nivelPeligrosidad() { return 10 }

	method bultos() = 1 

	method accidentar() {}
}

object arenaAGranel {
	var property peso = 0 

	method nivelPeligrosidad() = 1

	method bultos() = 1 

	method accidentar() { peso += 20 }
}

object bumblebee {
	var property modo = auto
	
	method peso() = 800

	method nivelPeligrosidad() = modo.nivelPeligrosidad()

	method bultos() = 2

	method accidentar() { modo.cambiarAlOtroModo() }
}

object auto {
	method nivelPeligrosidad() = 15

	method cambiarAlOtroModo() { bumblebee.modo(robot) }
}

object robot {
	method nivelPeligrosidad() = 30

	method cambiarAlOtroModo() { bumblebee.modo(auto) }
}

object paqueteLadrillos {
	var property cantLadrillos = 0 
	
	method pesoXLadrillo() = 2

	method peso() = cantLadrillos * self.pesoXLadrillo()

	method nivelPeligrosidad() = 2

	method bultos() {
		if (0 <= cantLadrillos and cantLadrillos <= 100) {
			return 1
		}
        else if (101 <= cantLadrillos and cantLadrillos <= 300) {
			return 2
		}
		else {
			return 3 
		}        
	}

	method accidentar() { cantLadrillos = (cantLadrillos - 12).max(0) }
}

object bateriaAntiaerea {
	var property tieneMisiles = false

	method cargarBateria() { self.tieneMisiles(true) }

	method descargarBateria() { self.tieneMisiles(false) }

	method peso() = if(self.tieneMisiles()) 300 else 200

	method nivelPeligrosidad() = if(self.tieneMisiles()) 100 else 0 

	method bultos() = if(tieneMisiles) 2 else 1

	method accidentar() { self.descargarBateria() }
}

object residuosRadioactivos {
	var property peso = 0

	method nivelPeligrosidad() = 200 

	method bultos() = 1 

	method accidentar() { peso += 15 } 
}

object contenedor {
	const property contenido = #{} 
	
	method pesoPropio() = 100 

	method cargar(unaCosa) { contenido.add(unaCosa) }

	method nivelPeligrosidad() = if(contenido.isEmpty()) 0 else self.elementoMasPeligroso().nivelPeligrosidad()

	method elementoMasPeligroso() = contenido.max({obj => obj.nivelPeligrosidad()})

	method pesoDelContenido() = contenido.sum({obj => obj.peso()})

	method peso() = self.pesoPropio() + self.pesoDelContenido() 

	method bultos() = 1 + contenido.sum({obj => obj.bultos()})

	method accidentar() { contenido.forEach({obj => obj.accidentar()}) }
}
 
object embalajeDeSeguridad {
	var property contenido = null

	method peso() = contenido.peso()

	method nivelPeligrosidad() = contenido.nivelPeligrosidad() / 2

	method bultos() = 2

	method accidentar() { contenido.accidentar() }
}