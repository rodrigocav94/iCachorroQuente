//
//  CachorroQuenteClasse.swift
//  iCachorroQuente
//
//  Created by Rodrigo Cavalcanti on 30/05/21.
//

import Foundation

class CachorroQuente: ObservableObject {
    let sabor = ["Salgado", "Doce"]
    @Published var saborEscolhido = 0
    
    let tipoSalgado = ["Misto","Vinagrete","Queijo","Abobrinha","Yakisoba"]
    let tipoDoce = ["Chocolate", "Pé de moleque", "Doce de leite","Abacaxi", "Goiabada"]
    @Published var tipoEscolhido = 0
    
    @Published var salsichasOuMorangos = 1
    
    @Published var querExtras = false
    let extraSalgado = ["Ovo", "Batata palha"]
    let extraDoce = ["Cobertura", "Granulado"]
    @Published var extra1 = false
    @Published var extra2 = false
}
