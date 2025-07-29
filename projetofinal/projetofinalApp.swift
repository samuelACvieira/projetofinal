//
//  projetofinalApp.swift
//  projetofinal
//
//  Created by Foundation on 04/07/25.
//

import SwiftUI
import SwiftData


@main
struct projetofinalApp: App {
    var body: some Scene {
        WindowGroup {
            TelaInicialView()
                .modelContainer(for: Gasto.self)
        }
    }
}
