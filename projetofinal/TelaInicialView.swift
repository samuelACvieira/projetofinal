import SwiftUI
import UIKit
struct TelaInicialView: View {
    @State private var valorAtual: Double = 400
    let meta: Double = 1000
    @State private var valorParaAdicionar = ""
    var body: some View {
        VStack(spacing: 5) {
            
            //textao grande
//            Text("Saldo")
//                .font(.title)
//                .foregroundColor(Color(hex: "5EB169")   )
//            
            
            // Barra de progresso da meta
//            ProgressView(value: valorAtual, total: meta)
//                .progressViewStyle(LinearProgressViewStyle(tint: Color(hex: "5EB169")))
//                .padding(.horizontal, 0)
//                .scaleEffect(x: 1, y: 3)
                
            // texto abaixo da barra de progresso
//            Text("R$ \(String(format: "%.2f", valorAtual)) de R$ \(String(format: "%.2f", meta))")
//                .font(.subheadline)
//                .foregroundColor(Color(hex: "5EB169"))
            
//            TextField("digite o valor", text: $valorParaAdicionar)
//                .keyboardType(.numberPad)
//                .cornerRadius(0)
//                .textFieldStyle(PlainTextFieldStyle())
//                .padding()
            //gastos totais
            ZStack {
                Color(hex: "5EB169").ignoresSafeArea()
                
                VStack {
                    Text("Saldo")
                        .font(.title)
                        .bold()
                        .foregroundColor(Color(hex: "e8e8e8"))
                        .position(x:50, y: 30)
                    
                }
            }
            .frame(height: 100)
            
            HStack(spacing: 20) {
                RoundedRectangle(cornerRadius: 12)
                    .frame(width:174, height:76)
                    .foregroundStyle(Color(hex: "e65252"))
                // ECONOMIAS TOTAIS
                RoundedRectangle(cornerRadius: 12)
                    .frame(width:174, height:76)
                    .foregroundStyle(Color(hex: "e65252"))
            }
            .padding(.top, 12)
            Spacer()
            // botao para adicionar saldo
//            Button("Adicionar saldo") {
//                if let valorDigitado = Double(valorParaAdicionar.replacingOccurrences(of: ",", with: ".")) {
//                    if valorDigitado > 0 && valorAtual + valorDigitado <= meta {
//                        valorAtual += valorDigitado
//                        valorParaAdicionar = ""
//                    }
//                }
//            
//            }
        } //configuraçoes do botao
//        .padding()
//        .background(Color.white)
//        .foregroundStyle(Color(hex: "5eb169"))
//        .cornerRadius(40)
    }
}

// ✅ Preview fora da struct principal
#Preview {
    TelaInicialView()
}

