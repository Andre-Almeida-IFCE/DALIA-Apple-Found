
//ARQUIVO NA PASTA TELAS COM NOME "CadastroMetaView"

//
//  CadastroMetaView.swift
//  DALIA
//
//  Created by found on 17/07/25.
//


import SwiftUI
import SwiftData

struct CadastroMetaView: View {
    @Environment(\.dismiss) var dismiss
    @Environment(\.modelContext) var modelContext

    // Campos do formulário
    @State private var titulo: String = ""
    @State private var tempoAlvoEmMinutos: String = ""
    @Query(sort: \Materia.nome) var materias: [Materia]
    @State private var materiaSelecionada: Materia? = nil

    @State private var showAlert: Bool = false

    var body: some View {
        NavigationStack {
            Form {
                Section(header: Text("Título da Meta")) {
                    TextField("Ex: Estudar Álgebra", text: $titulo)
                }

                Section(header: Text("Tempo alvo (em minutos)")) {
                    TextField("Ex: 300", text: $tempoAlvoEmMinutos)
                        .keyboardType(.numberPad)
                }

                Section(header: Text("Matéria relacionada")) {
                    Picker("Matéria", selection: $materiaSelecionada) {
                        Text("Nenhuma").tag(Materia?.none)
                        ForEach(materias) { materia in
                            Text(materia.nome).tag(materia as Materia?)
                        }
                    }
                }

                Button("Salvar Meta") {
                    salvarMeta()
                }
                .disabled(titulo.isEmpty || tempoAlvoEmMinutos.isEmpty)
            }
            .navigationTitle("Nova Meta")
            .alert("Preencha todos os campos corretamente.", isPresented: $showAlert) {
                Button("OK", role: .cancel) { }
            }
        }
    }

    func salvarMeta() {
        guard let tempo = Double(tempoAlvoEmMinutos) else {
            showAlert = true
            return
        }

        let novaMeta = Meta(
            titulo: titulo,
            materia: materiaSelecionada,
            tempoAlvo: tempo * 60 // converte minutos para segundos
        )

        modelContext.insert(novaMeta)
        dismiss()
    }
}


