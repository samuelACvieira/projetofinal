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
                    Text("Digitar valor do gasto:")
                    TextEditor(text: $gastoName)
                }
                Section{
                    DatePicker(
                        "Selecionar data",
                        selection: $gastoDate,
                        displayedComponents: .date
                    )
//                    .datePickerStyle(.wheel)
//                    .labelsHidden() // Esconde o rótulo, opcional
//
//                    .padding()
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
                Section{
                    Text("Adicionar comentário sobre o gasto:")
                    TextEditor(text: $gastoComentary)
                        .padding(7)
                                .frame(height: 200)
                                .background(Color.gray.opacity(0.2))
                                .cornerRadius(8)
                                .overlay(
                                    RoundedRectangle(cornerRadius: 8)
                                        .stroke(Color.gray, lineWidth: 0)
                                )

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
