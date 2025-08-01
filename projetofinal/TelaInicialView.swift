import SwiftUI
import SwiftData

struct TelaInicialView: View {
    @Query var gastos: [Gasto]  // SwiftData traz os dados automaticamente

    @State private var textoOrcamento: String = ""
    @State private var orcamento: Double? = nil
    @State private var editandoOrcamento: Bool = false
    @FocusState private var campoFocado: Bool

    var body: some View {
        VStack(spacing: 5) {
            // 🔷 Cabeçalho com orçamento
            ZStack {
                Color(hex: "4AB578")
                    .ignoresSafeArea()
                    .frame(height: 200)

                VStack(alignment: .leading, spacing: 10) {
                    Text("Orçamento:")
                        .font(.title2)
                        .bold()
                        .foregroundColor(Color(hex: "e8e8e8"))

                    HStack(spacing: 8) {
                        Text(orcamento != nil ? String(format: "R$ %.2f", orcamento!) : "")
                            .font(.title)
                            .bold()
                            .foregroundColor(Color(hex: "e8e8e8"))

                        Button(action: {
                            editandoOrcamento.toggle()
                            campoFocado = true
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
                        }
                    }
                }
                .padding(.horizontal)
                .frame(maxWidth: .infinity, alignment: .leading)
            }

            // lista de categorias e gastos
            List {
                ForEach(Category.allCases, id: \.self) { categoria in
                    let total = gastos
                        .filter { $0.category == categoria }
                        .map { $0.value }
                        .reduce(0, +)
                    
                    if total > 0 {
                        HStack {
                            Text(categoria.rawValue)
                            Spacer()
                            Text(String(format: "R$ %.2f", total))
                                .bold()
                        }
                    }
                }
            }

            Spacer()
        }
    }
}

// ✅ Preview
#Preview {
    TelaInicialView()
}
