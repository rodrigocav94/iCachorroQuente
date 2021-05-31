//
//  CachorroQuenteClasse.swift
//  iCachorroQuente
//
//  Created by Rodrigo Cavalcanti on 30/05/21.
//

import Foundation

class CachorroQuente: ObservableObject {

    struct ValorAntigo {
        var tipoEscolhido = 0
        var salsichasOuMorangos = 1
        var querExtras = false
        var extra1 = false
        var extra2 = false

    }
    
    struct InformaçõesDeEntrega: Codable {
        let estados = ["Alagoas", "Bahia", "Ceará", "Maranhão", "Paraíba", "Pernambuco", "Piauí", "Rio Grande do Norte", "Sergipe"]
        var nome = ""
        var endereço = ""
        var cidade = ""
        var estadoEscolhido = 0
        var cep = ""
        
        var informaçãoCompleta: Bool {
            if nome != "" && endereço != "" && cidade != "" && cep != "" {
                return true
            } else {
                return false
            }
        }
    }
    
    
    var valorAntigo = ValorAntigo()
    
    let sabor = ["Salgado", "Doce"]
    @Published var saborEscolhido = 0 { didSet {
        let tempValor = ValorAntigo(tipoEscolhido: tipoEscolhido, salsichasOuMorangos: salsichasOuMorangos, querExtras: querExtras, extra1: extra1, extra2: extra2)
        
        tipoEscolhido = valorAntigo.tipoEscolhido
        salsichasOuMorangos = valorAntigo.salsichasOuMorangos
        querExtras = valorAntigo.querExtras
        extra1 = valorAntigo.extra1
        extra2 = valorAntigo.extra2
        
        valorAntigo = tempValor
        
    }}
    
    let tipoSalgado = ["Misto","Vinagrete","Queijo","Abobrinha","Yakisoba"]
    let tipoDoce = ["Chocolate", "Pé de moleque", "Doce de leite","Abacaxi", "Goiabada"]
    @Published var tipoEscolhido = 0
    
    @Published var salsichasOuMorangos = 1
    
    @Published var querExtras = false {
        didSet {
            if querExtras == false {
                extra1 = false
                extra2 = false
            }
        }
    }
    let extraSalgado = ["Ovos", "Batata palha"]
    let extraDoce = ["Cobertura", "Granulado"]
    @Published var extra1 = false
    @Published var extra2 = false
    
    @Published var notas = ""
    
    @Published var entrega = InformaçõesDeEntrega() {
        didSet {
            let encoder = JSONEncoder()
            if let data = try? encoder.encode(self.entrega) {
                UserDefaults.standard.set(data, forKey: "entrega")
            }
        }
    }
    
    init() {
        if let entregaDefault = UserDefaults.standard.data(forKey: "entrega") {
            let decoder = JSONDecoder()
            if let decoded = try? decoder.decode(InformaçõesDeEntrega.self, from: entregaDefault) {
                self.entrega = decoded
                return
            }
        }
    }
}
