//
//  EndereçoView.swift
//  iCachorroQuente
//
//  Created by Rodrigo Cavalcanti on 30/05/21.
//

import SwiftUI

struct Enderec_oView: View {
    @ObservedObject var cachorroQuente = CachorroQuente()
    var body: some View {
        Form {
            Section(header: Text("Revise suas informações")) {
                TextField("Nome", text: $cachorroQuente.entrega.nome)
                TextField("Endereço", text: $cachorroQuente.entrega.endereço)
                TextField("Cidade", text: $cachorroQuente.entrega.cidade)
                Picker("Estado", selection: $cachorroQuente.entrega.estadoEscolhido) {
                    ForEach(0..<cachorroQuente.entrega.estados.count) { estado in
                        Text(cachorroQuente.entrega.estados[estado])
                    }
                }
                TextField("CEP", text: $cachorroQuente.entrega.cep).keyboardType(.numberPad)
            }
            
            Section(header: Text("Revise seu pedido")) {
                HStack {
                    Text("O valor total é:")
                        .foregroundColor(!cachorroQuente.entrega.informaçãoCompleta ? Color.gray : Color.primary)
                    Spacer()
                    Text("R$10,00")
                        .foregroundColor(!cachorroQuente.entrega.informaçãoCompleta ? Color.gray : Color.primary)
                        .bold()
                }
                
                HStack {
                    Spacer()
                    Button(action: /*@START_MENU_TOKEN@*/{}/*@END_MENU_TOKEN@*/, label: {
                        Text("Realizar peido")
                    })
                    Spacer()
                }
            }.disabled(!cachorroQuente.entrega.informaçãoCompleta)
            
            Image(cachorroQuente.saborEscolhido == 0 ? "salgado" : "doce")
                .resizable()
                .scaledToFit()
                .listRowInsets(EdgeInsets())
                .colorMultiply(.blue)
        }
        .navigationBarTitle("Detalhes da entrega", displayMode: .inline)
    }
}

struct Enderec_oView_Previews: PreviewProvider {
    static var previews: some View {
        Enderec_oView(cachorroQuente: CachorroQuente())
    }
}
