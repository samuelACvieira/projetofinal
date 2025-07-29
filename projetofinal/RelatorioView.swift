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
struct ContentView: View {
    // Armazenamento dinâmico
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
                    GroupBox("📥 Entrar orçamento e gasto") {
                        VStack(spacing: 12) {
                            HStack {
                                Text("Orçamento:")
                                TextField("Ex: 3000", value: $budget, format: .number)
                                    .keyboardType(.decimalPad)
                                    .textFieldStyle(.roundedBorder)
                            }
                            HStack {
                                Text("Gasto total:")
                                TextField("Ex: 2200", value: $spent, format: .number)
                                    .keyboardType(.decimalPad)
                                    .textFieldStyle(.roundedBorder)
                            }
                        }
                        .padding(.horizontal)
                    }
                    
                    GroupBox("➕ Adicionar categoria") {
                        VStack(spacing: 12) {
                            TextField("Categoria (ex: Alimentação)", text: $categoryName)
                                .textFieldStyle(.roundedBorder)
                            TextField("Valor (ex: 500)", text: $categoryValue)
                                .keyboardType(.decimalPad)
                                .textFieldStyle(.roundedBorder)
                            Button("Adicionar") {
                                if let value = Double(categoryValue), !categoryName.isEmpty {
                                    let newExpense = CategoryExpense(category: categoryName, amount: value)
                                    categories.append(newExpense)
                                    categoryName = ""
                                    categoryValue = ""
                                }
                            }
                            .buttonStyle(.borderedProminent)
                        }
                        .padding(.horizontal)
                    }

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
            .navigationTitle("Resumo Financeiro")
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
