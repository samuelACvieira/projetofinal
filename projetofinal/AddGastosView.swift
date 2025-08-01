import SwiftUI
import SwiftData

struct AddGastosView: View {
    @Environment(\.modelContext) private var modelContext
    @Environment(\.dismiss) private var dismiss

    @State private var gastoName: String = ""
    @State private var gastoValueText: String = ""
    @State private var gastoCategory: Category = .Lazer
    @State private var gastoDate: Date = Date()
    @State private var gastoComentary: String = ""

    var body: some View {
        NavigationStack {
            Form {
                Section("Nome do gasto") {
                    TextField("Nome", text: $gastoName)
                }
                Section("Valor do gasto") {
                    TextField("Valor", text: $gastoValueText)
                        .keyboardType(.decimalPad)
                }
                Section("Categoria") {
                    Picker("Categoria", selection: $gastoCategory) {
                        ForEach(Category.allCases, id: \.self) { categoria in
                            Text(categoria.rawValue).tag(categoria)
                        }
                    }
                    .pickerStyle(.menu)
                }
                Section("Data") {
                    DatePicker("Data do gasto", selection: $gastoDate, displayedComponents: .date)
                }
                Section("Comentário") {
                    TextEditor(text: $gastoComentary)
                        .frame(height: 100)
                }
            }
            .navigationTitle("Novo Gasto")
            .toolbar {
                ToolbarItem(placement: .cancellationAction) {
                    Button("Cancelar") {
                        dismiss()
                    }
                }
                ToolbarItem(placement: .confirmationAction) {
                    Button("Salvar") {
                        salvarGasto()
                    }
                    .disabled(gastoName.isEmpty || gastoValueText.isEmpty)
                }
            }
        }
    }

    private func salvarGasto() {
        let valorString = gastoValueText.replacingOccurrences(of: ",", with: ".")
        guard let valor = Double(valorString) else {
            print("Valor inválido")
            return
        }

        let newGasto = Gasto(
            name: gastoName,
            value: valor,
            category: gastoCategory,
            date: gastoDate,
            comentary: gastoComentary
        )

        modelContext.insert(newGasto)
        print("🟢 Novo gasto salvo: \(newGasto.name), R$ \(String(format: "%.2f", newGasto.value))")
        dismiss()
    }
}

#Preview {
    AddGastosView()
}
