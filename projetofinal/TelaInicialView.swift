import SwiftUI

struct TelaInicialView: View {
    @State private var textoOrcamento: String = ""
    @State private var orcamento: Double? = nil
    @State private var editandoOrcamento: Bool = false
    @FocusState private var campoFocado: Bool
    var body: some View {
        VStack(spacing: 5) {
            ZStack {
                Color(hex: "4AB578")
                    .ignoresSafeArea()
                    .frame(height: 160)
                HStack {
                    Text("Orçamento:")
                        .font(.title2)
                        .bold()
                        .foregroundColor(Color(hex: "e8e8e8"))
                    Spacer()
                }
                .padding(.horizontal)
                        

                    HStack(spacing: 8) {
                        Text(orcamento != nil ? String(format: "R$ %.2f", orcamento!) : "")
                            .font(.title)
                            .bold()
                            .foregroundColor(Color(hex: "e8e8e8"))

                        Button(action: {
                            editandoOrcamento.toggle()
                        }) {
                            Image(systemName: "pencil")
                                .foregroundColor(.white)
                        }
                    }

                    if editandoOrcamento {
                        VStack(spacing: 8) {
                            TextField("Novo orçamento", text: $textoOrcamento)
                                .keyboardType(.decimalPad)
                                .multilineTextAlignment(.center)
                                .padding(8)
                                .background(Color.white)
                                .cornerRadius(8)
                                .frame(width: 200)
                                .focused($campoFocado)
                            
                            Button("Salvar") {
                                let valor = textoOrcamento.replacingOccurrences(of: ",", with: ".")
                                if let numero = Double(valor) {
                                    orcamento = numero
                                    textoOrcamento = ""
                                    editandoOrcamento = false
                                }
                            }
                            .foregroundColor(.white)
                            .padding(.horizontal, 16)
                            .padding(.vertical, 8)
                            .background(Color(hex: "279d57"))
                            .cornerRadius(10)
                            .ignoresSafeArea()
                        }
                    }
                
            }

            HStack(spacing: 70) {
                // GASTOS TOTAIS
                VStack {
                    Text("-958,89")
                        .font(.title)
                        .bold()
                        .foregroundColor(Color(hex: "e8e8e8"))
                        .background(
                            RoundedRectangle(cornerRadius: 12)
                                .frame(width: 174, height: 70)
                                .foregroundStyle(Color(hex: "e65252"))
                        )
                    Text("Gastos Totais")
                        .foregroundColor(Color(hex: "e8e8e8"))
                        .font(.caption)
                }

                // ECONOMIAS TOTAIS
                VStack {
                    Text("+958,89")
                        .font(.title)
                        .bold()
                        .foregroundColor(Color(hex: "5eb169"))
                        .background(
                            RoundedRectangle(cornerRadius: 12)
                                .frame(width: 174, height: 70)
                                .foregroundStyle(Color(hex: "e8e8e8"))
                        )
                    Text("Economias Totais")
                        .foregroundStyle(Color(hex: "454545"))
                        .font(.caption)
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

