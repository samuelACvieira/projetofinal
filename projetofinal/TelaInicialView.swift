import SwiftUI
import SwiftData

struct TelaInicialView: View {
    @Query var gastos: [Gasto]

    @State private var textoOrcamento: String = ""
    @State private var orcamento: Double? = nil
    @State private var editandoOrcamento: Bool = false
    @FocusState private var campoFocado: Bool
    @Environment(\.modelContext) private var modelContext

    var body: some View {
        NavigationStack {
            VStack(spacing: 5) {
                
                // Cabeçalho Orçamento
                ZStack {
                    Color(hex: "4AB578")
                        .ignoresSafeArea()
                        .frame(height: 100)

                    VStack(alignment: .leading, spacing: 0) {
                        HStack(spacing: 20) {
                            Text(orcamento != nil ? formatarMoeda(orcamento!) : "")
                                .font(.title)
                                .bold()
                                .foregroundColor(Color(hex: "e8e8e8"))

                            Button {
                                editandoOrcamento.toggle()
                                campoFocado = true
                            } label: {
                                Image(systemName: "pencil")
                                    .foregroundColor(.white)
                            }
                        }
                        
                        if editandoOrcamento {
                            VStack(spacing: 8) {
                                TextField("R$", text: $textoOrcamento)
                                    .keyboardType(.decimalPad)
                                    .multilineTextAlignment(.center)
                                    .padding(8)
                                    .background(Color.white)
                                    .cornerRadius(8)
                                    .frame(width: 100)
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
                                .padding(.horizontal, 10)
                                .padding(.vertical, 5)
                                .background(Color(hex: "279d57"))
                                .cornerRadius(10)
                            }
                        }
                    }
                    .padding(.horizontal)
                    .frame(maxWidth: .infinity, alignment: .leading)
                }

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
                                Text(formatarMoeda(total))
                                    .bold()
                            }
                        }
                    }
                }

                Spacer()
            }
            .navigationTitle("Orçamento")
            .toolbar {
                ToolbarItem(placement: .navigationBarTrailing) {
                    NavigationLink(destination: AddGastosView()) {
                        Image(systemName: "plus")
                            .foregroundColor(Color(hex: "e8e8e8"))
                    }
                }
                ToolbarItem(placement: .navigationBarTrailing) {
                    NavigationLink(destination: RelatorioView()) {
                        Image(systemName: "list.clipboard.fill")
                            .foregroundColor(Color(hex: "e8e8e8"))
                    }
                }
            }
        }
        .onAppear {
            print("🔵 Gastos atuais na Tela Inicial: \(gastos.count)")
        }
        .onChange(of: gastos) {
            print("🔵 Gastos atualizados: \(gastos.count)")
        }

    }

    func formatarMoeda(_ valor: Double) -> String {
        let formatter = NumberFormatter()
        formatter.numberStyle = .currency
        formatter.locale = Locale(identifier: "pt_BR")
        return formatter.string(from: NSNumber(value: valor)) ?? "R$ 0,00"
    }
}

#Preview {
    TelaInicialView()
        .modelContainer(for: Gasto.self)
}
