//
//  BancodeDados.swift
//  projetofinal
//
//  Created by found on 15/07/25.
//

import Foundation
import SwiftData

enum Category: String, Codable, CaseIterable{
    case Alimentacao = "Alimentação"
    case Assinaturas = "Assinaturas"
    case Cuidados_Pessoais = "Cuidados Pessoais"
    case Dividas = "Dívidas"
    case Economias = "Economias"
    case Educacao = "Educação"
    case Hobbies = "Hoobies"
    case Lazer = "Lazer"
    case Pets = "Pets"
    case Roupas = "Roupas"
    case Tecnologia = "Tecnologia"
    case Transporte = "Transporte"
}
@Model
class Gasto: Identifiable {
    var name: String
    var value: Double
    var category: Category
    var date: Date
    var comentary: String
    
    init(name: String, value: Double, category: Category, date: Date, comentary: String) {
        self.name = name
        self.value = value
        self.category = category
        self.date = date
        self.comentary = comentary
    }
}
