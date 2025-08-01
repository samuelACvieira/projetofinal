import SwiftUI
import Charts

struct ContentView: View {
    @State private var saldo: Double = 1599.99
    @State private var saldoTexto: String = ""

    var body: some View {
        ZStack {
            Color(hex: "4AB578").ignoresSafeArea()
                .position(x: 200, y: 30)
            
            VStack {
                Text("Orçamento:")
                    .font(.title2)
                    .bold()
                    .foregroundColor(Color(hex: "e8e8e8"))
                    .position(x: 75, y: 3)

                Text("R$ \(saldo, specifier: "%.2f")")
                    .font(.title)
                    .bold()
                    .foregroundColor(Color(hex: "e8e8e8"))
                    .position(x: 75, y: 10)

                Button(action: {
                    if let valor = Double(saldoTexto.replacingOccurrences(of: ",", with: ".")) {
                        saldo = valor
                    }
                }) {
                    HStack {
                        Spacer()
                        VStack {
                            Text("+")
                                .foregroundColor(.white)
                                .frame(width: 50, height: 50)
                                .background(Color(hex: "279d57"))
                                .clipShape(Circle())
                                .font(.headline)
                                .multilineTextAlignment(.center)
                                .position(x: 350, y: -45)
                        }
                    }
                }

                TextField("Novo valor", text: $saldoTexto)
                    .keyboardType(.decimalPad)
                    .textFieldStyle(.roundedBorder)
                    .padding()
            }
        }
    }
}

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

struct RelatorioView: View {

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
#Preview {
    RelatorioView()
}
