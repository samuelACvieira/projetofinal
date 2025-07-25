import SwiftUI
import UIKit
struct TelaInicialView: View {
    @State private var saldo: Int?
    @State private var saldoTexto: String = ""

    var body: some View {
        VStack(spacing: 5) {
            
  
            ZStack {
                Color(hex: "4AB578").ignoresSafeArea()
                    .position(x:200, y:30)
                
                VStack {
                    Text("Orçamento:")
                        .font(.title2)
                        .bold()
                        .foregroundColor(Color(hex: "e8e8e8"))
                        .position(x:75, y: 3)
                    Text("1.599,99")
                        .font(.title)
                        .bold()
                        .foregroundColor(Color(hex: "e8e8e8"))
                        .position(x:75, y:10)
                    Button(action: {
                        if let valor = Int(saldoTexto) {
                            saldo = valor
                        }
                    }
                    ){
                        HStack{
                            Spacer()
                            VStack{
                                Text("+")
                                    .foregroundColor(.white)
                                    .frame(width: 50, height: 50)
                                    .background(Color(hex: "279d57"))
                                    .clipShape(Circle())
                                    .font(.headline)
                                    .multilineTextAlignment(.center)
                                    .position(x: 350, y:-45)
                            }
                        }
                        }
                    

                }
            }
            
            .frame(height: 90)
            if let saldo = saldo {
                Text("Saldo informado: R$ \(saldo)")
                    .font(.title2)
                    .foregroundColor(.green)
            }
            HStack(spacing: 70) {
                // GASTOS TOTAIS
                VStack{
                    Text("-958,89")
                        .font(.title)
                        .bold()
                        .foregroundColor(Color(hex: "e8e8e8"))
                        .background(  RoundedRectangle(cornerRadius: 12)
                            .frame(width:174, height:76)
                            .foregroundStyle(Color(hex: "e65252")))
                    Text("Gastos Totais")
                        .foregroundColor((Color(hex: "e8e8e8")))
                    
                }
              
                // ECONOMIAS TOTAIS
                VStack{
                    Text("958,89")
                        .font(.title)
                        .bold()
                        .foregroundColor(Color(hex: "5eb169"))
                        .background(RoundedRectangle(cornerRadius: 12)
                            .frame(width:174, height:76)
                            .foregroundStyle(Color(hex: "e8e8e8")))
                    Text("Economias Totais")
                        .foregroundStyle(Color(hex: "5eb169"))
                }
                
                
            }
            .padding(.top, 25)
            Spacer()
         
        }
    }
}

// ✅ Preview fora da struct principal
#Preview {
    TelaInicialView()
}

