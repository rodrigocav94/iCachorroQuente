//
//  CachorroQuenteClasse.swift
//  iCachorroQuente
//
//  Created by Rodrigo Cavalcanti on 30/05/21.
//

import Foundation

class CachorroQuente: ObservableObject, Codable {

    struct ValorAntigo: Codable {
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
    
    var preço: Double {
        var tempPreço = 2.0
        tempPreço += Double(tipoEscolhido + 1) * 0.5
        tempPreço += Double(salsichasOuMorangos) * 0.75
        if querExtras == true {
            if extra1 == true {
                tempPreço += 1.5
            }
            if extra2 == true {
                tempPreço += 1
            }
        }
        return tempPreço
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
    
    enum CodingKeys: CodingKey {
        case valorAntigo, saborEscolhido, tipoEscolhido, salsichasOuMorangos,querExtras, extra1, extra2, notas, entrega
    }
    
    required init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        valorAntigo = try container.decode(ValorAntigo.self, forKey: .valorAntigo)
        saborEscolhido = try container.decode(Int.self, forKey: .saborEscolhido)
        tipoEscolhido = try container.decode(Int.self, forKey: .tipoEscolhido)
        salsichasOuMorangos = try container.decode(Int.self, forKey: .salsichasOuMorangos)
        querExtras = try container.decode(Bool.self, forKey: .querExtras)
        extra1 = try container.decode(Bool.self, forKey: .extra1)
        extra2 = try container.decode(Bool.self, forKey: .extra2)
        notas = try container.decode(String.self, forKey: .notas)
        entrega = try container.decode(InformaçõesDeEntrega.self, forKey: .entrega)
    }
    
    func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try container.encode(valorAntigo, forKey: .valorAntigo)
        try container.encode(saborEscolhido, forKey: .saborEscolhido)
        try container.encode(tipoEscolhido, forKey: .tipoEscolhido)
        try container.encode(salsichasOuMorangos, forKey: .salsichasOuMorangos)
        try container.encode(querExtras, forKey: .querExtras)
        try container.encode(extra1, forKey: .extra1)
        try container.encode(extra2, forKey: .extra2)
        try container.encode(notas, forKey: .notas)
        try container.encode(entrega, forKey: .entrega)
    }
}
