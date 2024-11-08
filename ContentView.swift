//
//  ContentView.swift
//  Calculadora
//
//

import SwiftUI
import SwiftData

enum BotaoCalculadora: String {
    case um = "1"
    case dois = "2"
    case tres = "3"
    case quatro = "4"
    case cinco = "5"
    case seis = "6"
    case sete = "7"
    case oito = "8"
    case nove = "9"
    case zeroo = "0"
    case mais = "+"
    case menos = "-"
    case vezes = "×"
    case dividido = "÷"
    case igual = "="
    case zerar = "AC"
    case porcentagem = "%"
    case negativo = "-/+"
    case decimaal = ","
    
    var corBotao: Color{
        switch self {
        case .mais, .menos, .vezes, .dividido, .igual:
            return .orange
        case .zerar, .negativo, .porcentagem:
            return Color(.lightGray)
        default:
            return Color(UIColor(red: 55/255.0, green: 55/255.0, blue: 55/255.0, alpha: 1))
        }
    }
}

enum Operacoes{
    case mais, menos, vezes, dividido, nada
}

struct ContentView: View {
    
    @State var value = "0"
    @State var numDaHora = 0
    @State var operacaoAtual: Operacoes = .nada
    
    let botoes: [[BotaoCalculadora]] = [
        [.zerar, .negativo, .porcentagem, .dividido],
        [.sete, .oito, .nove, .vezes],
        [.quatro, .cinco, .seis, .menos],
        [.um, .dois, .tres, .mais],
        [.zeroo, .decimaal, .igual],
    ]

    var body: some View {
        ZStack{
            Color.black.ignoresSafeArea(.all)
            VStack{
                Spacer()
                //Text display
                HStack{
                    Spacer()
                    Text(value)
                        .bold()
                        .font(.system(size: 100))
                        .foregroundColor(.white)
                }
                .padding()
                //Buttons
                ForEach(botoes, id: \.self) { row in
                    HStack(spacing: 12){
                        ForEach(row, id: \.self) { item in
                            Button(action: {
                                self.click(button: item)
                            }, label: {
                                Text(item.rawValue)
                                    .font(.system(size: 32))
                                    .frame(
                                        width: self.larguraBotao(item: item),
                                        height: self.alturaBotao()
                                    )
                                    .background(item.corBotao)
                                    .foregroundColor(.white)
                                    .cornerRadius(self.larguraBotao(item: item)/2)
                            })
                        }
                    }
                    .padding(.bottom, 3)
                }
            }
        }
    }
    
    func click(button: BotaoCalculadora){
        switch button {
        case .mais, .menos, .vezes, .dividido, .igual:
            if (button == .mais){
                self.operacaoAtual = .mais
                self.numDaHora = Int(self.value) ?? 0
            }
            else if (button == .menos){
                self.operacaoAtual = .menos
                self.numDaHora = Int(self.value) ?? 0
            }
            else if (button == .vezes){
                self.operacaoAtual = .vezes
                self.numDaHora = Int(self.value) ?? 0
            }
            else if (button == .dividido){
                self.operacaoAtual = .dividido
                self.numDaHora = Int(self.value) ?? 0
            }
            else if (button == .igual){
                let numm = self.numDaHora
                let numAtual = Int(self.value) ?? 0
                switch self.operacaoAtual {
                    case .mais:
                        self.value = "\(numm + numAtual)"
                    case .menos:
                        self.value = "\(numm - numAtual)"
                    case .vezes:
                        self.value = "\(numm * numAtual)"
                    case .dividido:
                        self.value = "\(numm / numAtual)"
                    case .nada:
                        break
                }
            }
        
            if (button != .igual){
                self.value = "0"
            }
            
        case .zerar:
            self.value = "0"
        case .decimaal, .negativo, .porcentagem:
            break
        default:
            let number = button.rawValue
            if (self.value == "0") {
                value = number
            }else{
                self.value = "\(self.value)\(number)"
            }
        }
    }
    
    func larguraBotao(item: BotaoCalculadora) -> CGFloat{
        if (item == .zeroo){
            return ((UIScreen.main.bounds.width - (4*12))/4)*2
        }
        return (UIScreen.main.bounds.width - (5*12))/4
    }
    
    func alturaBotao() -> CGFloat{
        return (UIScreen.main.bounds.width - (5*12))/4
    }
}

#Preview {
    ContentView()
        .modelContainer(for: Item.self, inMemory: true)
}
