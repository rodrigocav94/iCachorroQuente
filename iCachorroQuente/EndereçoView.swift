//
//  EndereçoView.swift
//  iCachorroQuente
//
//  Created by Rodrigo Cavalcanti on 30/05/21.
//

import SwiftUI
import AlertToast

struct Enderec_oView: View {
    @ObservedObject var cachorroQuente = CachorroQuente()
    
    @State private var mostrandoAlerta = false
    @State private var mensagemAlerta = ""
    @State private var bemSucedido = false
    @State private var cor: Color = .blue
    @Environment(\.colorScheme) var colorScheme
    
    let dispositivoLargura = UIScreen.main.bounds.width
    let dispositivoAltura = UIScreen.main.bounds.height
    
    func comprar() {
        let numerosMasculinos = ["zero","um", "dois", "três", "quatro", "cinco"]
        let numerosFemininos = ["zero", "uma", "duas", "três", "quatro", "cinco"]
        
        guard let codificado = try? JSONEncoder().encode(cachorroQuente) else {
                print("Falha ao codificar cachorroQuente")
                return
            }
        let url = URL(string: "https://reqres.in/api/iCachorroQuente")!
        var tarefa = URLRequest(url: url)
        tarefa.setValue("application/json", forHTTPHeaderField: "Content-Type")
        tarefa.httpMethod = "POST"
        tarefa.httpBody = codificado
        
        URLSession.shared.dataTask(with: tarefa) { data, response, error in
            guard let data = data else {
                self.mensagemAlerta = "Nenhum dado em resposta: \(error?.localizedDescription ?? "Erro desconhecido")."
                print("Nenhum dado em resposta: \(error?.localizedDescription ?? "Erro desconhecido").")
                self.bemSucedido = false
                self.mostrandoAlerta = true
                return
            }
            
            if let pedidoDecodificado = try? JSONDecoder().decode(CachorroQuente.self, from: data) {
                self.mensagemAlerta = "O seu cachorro quente de \(pedidoDecodificado.saborEscolhido == 0 ? pedidoDecodificado.tipoSalgado[pedidoDecodificado.tipoEscolhido].lowercased() : pedidoDecodificado.tipoDoce[pedidoDecodificado.tipoEscolhido].lowercased()) com \(pedidoDecodificado.saborEscolhido == 0 ? numerosFemininos[pedidoDecodificado.salsichasOuMorangos] : numerosMasculinos[pedidoDecodificado.salsichasOuMorangos]) \(pedidoDecodificado.saborEscolhido == 0 ? "salsicha" : "morango")\(pedidoDecodificado.salsichasOuMorangos > 1 ? "s":"")\(pedidoDecodificado.querExtras ? ", \(pedidoDecodificado.extra1 ? "\(pedidoDecodificado.saborEscolhido == 0 ? pedidoDecodificado.extraSalgado[0].lowercased() : pedidoDecodificado.extraDoce[0].lowercased())" : "")\(pedidoDecodificado.extra1 && pedidoDecodificado.extra2 ? " e " : "")\(pedidoDecodificado.extra2 ? "\(pedidoDecodificado.saborEscolhido == 0 ? pedidoDecodificado.extraSalgado[1].lowercased() : pedidoDecodificado.extraDoce[1].lowercased())" : "")" : "") está a caminho!"
                self.bemSucedido = true
                self.mostrandoAlerta = true
            } else {
                print("Invalid response from server")
            }
        }.resume()
    }
    
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
                    Spacer()
                    Image(cachorroQuente.saborEscolhido == 0 ? "salgado" : "doce")
                        .resizable()
                        .scaledToFit()
                        .listRowInsets(EdgeInsets())
                        .frame(height: 200, alignment: .center)
                        .shadow(color: .black.opacity(0.3), radius: 10, x: 7.0, y: 10.0)
                    Spacer()
                }
                
                HStack {
                    Text("O valor total é:")
                        .foregroundColor(!cachorroQuente.entrega.informaçãoCompleta ? Color.gray : Color.primary)
                    Spacer()
                    Text("R$\(cachorroQuente.preço, specifier: "%.2f")")
                        .foregroundColor(!cachorroQuente.entrega.informaçãoCompleta ? Color.gray : Color.primary)
                        .bold()
                }
                
                HStack {
                    Spacer()
                    Button(action: comprar, label: {
                        Text("Finalizar pedido")
                            .foregroundColor(.white)
                            .bold()
                    })
                    Spacer()
                }
                .listRowBackground(!cachorroQuente.entrega.informaçãoCompleta ? Color.gray : Color.blue)
            }.disabled(!cachorroQuente.entrega.informaçãoCompleta)
        }
        .navigationBarTitle("Detalhes da entrega", displayMode: .inline)
        .toast(isPresenting: $mostrandoAlerta, duration: 4, tapToDismiss: true) {
            AlertToast(type: bemSucedido ? .complete(.blue) : .error(.red), title: "\(bemSucedido ? "Obrigado" : "Erro")", subTitle: mensagemAlerta)
        }
        .background(
            ZStack {
                    if colorScheme == .light {
                        Color(red: 0.95, green: 0.95, blue: 0.97)
                            .edgesIgnoringSafeArea(/*@START_MENU_TOKEN@*/.all/*@END_MENU_TOKEN@*/)
                    }
                Image("padraoCachorroQuente")
                    .resizable(resizingMode: .tile)
                    .frame(width: dispositivoLargura, height: dispositivoAltura, alignment: .leading)
                    .edgesIgnoringSafeArea(/*@START_MENU_TOKEN@*/.all/*@END_MENU_TOKEN@*/)
                    .colorMultiply(colorScheme == .light ? .black : .white)
                    .opacity(0.2)
            }
        )
    }
}

struct Enderec_oView_Previews: PreviewProvider {
    static var previews: some View {
        Enderec_oView(cachorroQuente: CachorroQuente())
    }
}
