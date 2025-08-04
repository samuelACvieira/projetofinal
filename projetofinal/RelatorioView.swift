import SwiftUI
import Charts
import SwiftData

// MARK: - MODELOS
struct BudgetData: Identifiable {
    let id = UUID()
    let name: String
    let value: Double
}

struct CategoryExpense: Identifiable {
    let id = UUID()
    let category: String
    let amount: Double
}

// MARK: - VIEW PRINCIPAL
struct RelatorioView: View {
    // Armazenamento dinâmico
    @Environment(\.modelContext) private var modelContext
    @Environment(\.dismiss) private var dismiss
    @State private var budget: Double = 0
    @State private var spent: Double = 0
    
    @State private var categoryName = ""
    @State private var categoryValue = ""
    @State private var categories: [CategoryExpense] = []
    
    var budgetData: [BudgetData] {
        [
            BudgetData(name: "Orçamento", value: budget),
            BudgetData(name: "Gasto", value: spent)
        ]
    }

    var body: some View {
        NavigationView {
            ScrollView {
                VStack(spacing: 30) {
                    Divider()

                    Text("📊 Orçamento x Gasto")
                        .font(.title2.bold())
                    BarChartView(data: budgetData)

                    Text("🥧 Distribuição por Categoria")
                        .font(.title2.bold())
                    PieChartView(expenses: categories)
                }
                .padding()
            }
            .navigationTitle("Relatório Financeiro")
            .toolbar{
                ToolbarItem(placement: .cancellationAction) {
                    Button("Voltar") {
                        dismiss()
                    }
                }
            }
        }
    }
}

struct BarChartView: View {
    let data: [BudgetData]

    var body: some View {
        Chart(data) { item in
            BarMark(
                x: .value("Tipo", item.name),
                y: .value("Valor", item.value)
            )
            .foregroundStyle(by: .value("Tipo", item.name))
        }
        .frame(height: 250)
        .padding()
    }
}

struct PieChartView: View {
    let expenses: [CategoryExpense]

    var body: some View {
        let total = expenses.reduce(0) { $0 + $1.amount }

        Chart(expenses) { expense in
            SectorMark(
                angle: .value("Valor", expense.amount),
                innerRadius: .ratio(0.5),
                angularInset: 1.5
            )
            .foregroundStyle(by: .value("Categoria", expense.category))
            .annotation(position: .overlay) {
                Text("\(Int((expense.amount / total) * 100))%")
                    .font(.caption2)
                    .foregroundColor(.white)
            }
        }
        .frame(height: 250)
        .padding()
    }
}
//    .toolbar{
//        ToolbarItem(placement: .navigationBarTrailing) {
//            NavigationLink(destination: RelatorioView()) {
//                Image(systemName: "list.clipboard.fill")
//                    .foregroundColor(Color(hex: "e8e8e8"))
//            }
//        }
//    }
#Preview {
    RelatorioView()
        .modelContainer(for: Gasto.self)
}
