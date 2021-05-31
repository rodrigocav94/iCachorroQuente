//
//  ContentView.swift
//  iCachorroQuente
//
//  Created by Rodrigo Cavalcanti on 30/05/21.
//

import SwiftUI

struct ContentView: View {
    @ObservedObject var cachorroQuente = CachorroQuente()
    
    var body: some View {
        NavigationView {
            Form {
                Section(header: Text("Monte o seu cachorro-quente")) {
                    Picker("Selecione o Sabor", selection: $cachorroQuente.saborEscolhido.animation()) {
                        ForEach(0 ..< 2) { sabor in
                            Text(cachorroQuente.sabor[sabor])
                        }
                    }
                    .pickerStyle(SegmentedPickerStyle())
                    Picker("Selecione o Tipo", selection: $cachorroQuente.tipoEscolhido) {
                        ForEach(0 ..< 5) { tipo in
                            Text(cachorroQuente.saborEscolhido == 0 ? cachorroQuente.tipoSalgado[tipo] : cachorroQuente.tipoDoce[tipo])
                        }
                    }
                    Stepper("Quantidade de \(cachorroQuente.saborEscolhido == 0 ? "salsichas" : "morangos"): \(cachorroQuente.salsichasOuMorangos)", value: $cachorroQuente.salsichasOuMorangos, in: 1...5)
                }
                
                Section(header: Text("Deseja adicionar algo mais?")) {
                    Toggle("Pedido especial", isOn: $cachorroQuente.querExtras.animation())
                    if cachorroQuente.querExtras {
                        Toggle("\(cachorroQuente.saborEscolhido == 0 ? cachorroQuente.extraSalgado[0] : cachorroQuente.extraDoce[0])", isOn: $cachorroQuente.extra1)
                        Toggle("\(cachorroQuente.saborEscolhido == 0 ? cachorroQuente.extraSalgado[1] : cachorroQuente.extraDoce[1])", isOn: $cachorroQuente.extra2)
                    }
                }
                Section(header: Text("Deseja deixar alguma nota?")) {
                    TextField("Deixe a sua nota aqui", text: $cachorroQuente.notas)
                }
                Section(header: Text("Revise suas informações")) {
                    NavigationLink("Detalhes da entrega", destination: Enderec_oView(cachorroQuente: cachorroQuente))
                }
            }
            .navigationBarTitle("iCachorroQuente")
            .preferredColorScheme(.dark)
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
