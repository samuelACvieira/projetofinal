//
//  AddGastosView.swift
//  projetofinal
//
//  Created by found on 15/07/25.
//

import SwiftUI
import SwiftData

struct AddGastosView: View {
    @Environment(\.modelContext) var modelcontext
    @Environment(\.dismiss) var closeView

    @State var gastoName: String = ""
    
    @State var gastoValue: Double = 0.0

    @State var gastoCategory: Category = .Lazer
    
    @State var gastoDate: Date = Date()

    @State var gastoComentary: String = ""

    var body: some View {
        NavigationStack {
            Form {
                Section{
                    TextField("Digitar valor do gasto", text: $gastoName)
                    TextField("Adicionar comentário sobre o gasto", text: $gastoComentary)
                }
                Section{
                    DatePicker(
                        "Selecionar data",
                        selection: $gastoDate,
                        displayedComponents: .date
                    )
                    Picker(
                        "Selecionar categoria",
                        selection: $gastoCategory
                    ){
                        Text("\(Category.Alimentacao.rawValue)").tag(Category.Alimentacao)
                        Text("\(Category.Assinaturas.rawValue)").tag(Category.Assinaturas)
                        Text("\(Category.Cuidados_Pessoais.rawValue)").tag(Category.Cuidados_Pessoais)
                        Text("\(Category.Dividas.rawValue)").tag(Category.Dividas)
                        Text("\(Category.Economias.rawValue)").tag(Category.Economias)
                        Text("\(Category.Educacao.rawValue)").tag(Category.Educacao)
                        Text("\(Category.Hobbies.rawValue)").tag(Category.Hobbies)
                        Text("\(Category.Lazer.rawValue)").tag(Category.Lazer)
                        Text("\(Category.Pets.rawValue)").tag(Category.Pets)
                        Text("\(Category.Roupas.rawValue)").tag(Category.Roupas)
                        Text("\(Category.Tecnologia.rawValue)").tag(Category.Tecnologia)
                        Text("\(Category.Transporte.rawValue)").tag(Category.Transporte)
                }
            }
        }
            .navigationTitle("NexFin")
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                ToolbarItem(placement: .cancellationAction) {
                    Button("Cancelar") {
                        closeView()
                    }
                }
                
                ToolbarItem(placement: .confirmationAction) {
                    Button("Salvar") {
                        let newGasto = Gasto(
                            name: gastoName,
                            value: gastoValue,
                            category: gastoCategory,
                            date: gastoDate,
                            comentary: gastoComentary
                        )
                        modelcontext.insert(newGasto)
                        closeView()
                        
                    }
                }
            }
    }
}

    
}

#Preview {
    AddGastosView()
}
