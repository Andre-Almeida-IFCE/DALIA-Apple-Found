//
//  EditarMateriaView.swift
//  DALIA
//
//  Created by found on 22/07/25.
//



import SwiftUI
import SwiftData

struct EditarMateriaView: View {
    @Environment(\.dismiss) var dismiss
    @Bindable var materia: Materia

    var body: some View {
        Form {
            Section(header: Text("Nome")) {
                TextField("Nome", text: $materia.nome)
            }

            Section(header: Text("Cor (hex ou nome)")) {
                TextField("Cor", text: Binding(
                    get: { materia.cor ?? "" },
                    set: { materia.cor = $0 }
                ))
            }

            Button("Salvar") {
                dismiss()
            }
        }
        .navigationTitle("Editar Matéria")
    }
}