import SwiftUI
import SwiftData

struct CadastroMetaView: View {
    @Environment(\.dismiss) var dismiss
    @Environment(\.modelContext) var modelContext

    // Campos do formulário
    @State private var titulo: String = ""
    @State private var tempoAlvoEmHoras: String = ""
    @Query(sort: \Materia.nome) var materias: [Materia]
    @State private var materiaSelecionada: Materia? = nil

    @State private var showAlert: Bool = false

    var body: some View {
        NavigationStack {
            Form {
                Section(header: Text("Título da Meta")) {
                    TextField("Ex: Estudar Álgebra", text: $titulo)
                }

                Section(header: Text("Tempo alvo (em horas)")) {
                    TextField("Ex: 5", text: $tempoAlvoEmHoras)
                        .keyboardType(.decimalPad)
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
                .disabled(titulo.isEmpty || tempoAlvoEmHoras.isEmpty)
            }
            .navigationTitle("Nova Meta")
            .alert("Preencha todos os campos corretamente.", isPresented: $showAlert) {
                Button("OK", role: .cancel) { }
            }
        }
    }

    func salvarMeta() {
        guard let horas = Double(tempoAlvoEmHoras) else {
            showAlert = true
            return
        }

        let novaMeta = Meta(
            titulo: titulo,
            materia: materiaSelecionada,
            tempoAlvo: horas * 3600 // converte horas para segundos
        )

        modelContext.insert(novaMeta)
        dismiss()
    }
}
