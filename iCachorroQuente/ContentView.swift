//
//  ContentView.swift
//  iCachorroQuente
//
//  Created by Rodrigo Cavalcanti on 30/05/21.
//

import SwiftUI

struct ContentView: View {
    @ObservedObject var cachorroQuente = CachorroQuente()
    @Environment(\.colorScheme) var colorScheme
    
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
                    
                    Picker(selection: $cachorroQuente.tipoEscolhido, label: HStack {
                        Text("Selecione o tipo:")
                            .foregroundColor(.primary)
                        Spacer()
                        Text(cachorroQuente.saborEscolhido == 0 ? cachorroQuente.tipoSalgado[cachorroQuente.tipoEscolhido] : cachorroQuente.tipoDoce[cachorroQuente.tipoEscolhido])
                    }, content: {
                        ForEach(0 ..< 5) { tipo in
                            Text(cachorroQuente.saborEscolhido == 0 ? cachorroQuente.tipoSalgado[tipo] : cachorroQuente.tipoDoce[tipo])
                        }
                    })
                    .pickerStyle(MenuPickerStyle())
                    
                    Stepper("Quant. de \(cachorroQuente.saborEscolhido == 0 ? "salsichas" : "morangos"): \(cachorroQuente.salsichasOuMorangos)", value: $cachorroQuente.salsichasOuMorangos, in: 1...5)
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
                Section(header: Text("Revisar informações")) {
                    NavigationLink(
                        destination: Enderec_oView(cachorroQuente: cachorroQuente),
                        label: {
                            Text("Detalhes da entrega")
                                .bold()
                                .foregroundColor(.white)
                        })
                        .opacity(0)
                        .background(
                          HStack {
                             Text("Revise suas informações")
                                .foregroundColor(.white)
                                .bold()
                             Spacer()
                             Image(systemName: "chevron.right")
                               .resizable()
                               .aspectRatio(contentMode: .fit)
                               .frame(width: 7)
                               .foregroundColor(.white)
                           }
                        )
                }
                .listRowBackground(Color.blue)
            }
            .navigationBarTitle("iCachorroQuente")
            .background(
                ZStack {
                    if colorScheme == .light {
                        Color(red: 0.95, green: 0.95, blue: 0.97)
                                .edgesIgnoringSafeArea(/*@START_MENU_TOKEN@*/.all/*@END_MENU_TOKEN@*/)
                    }
                }
            )
        }
    }
    init() {
        UITableView.appearance().backgroundColor = UIColor.clear
        UITableViewCell.appearance().backgroundColor = UIColor.clear
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
