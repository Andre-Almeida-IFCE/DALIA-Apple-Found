import SwiftUI
import SwiftData

struct EditarMetaView: View {
    @Environment(\.dismiss) var dismiss
    @Environment(\.modelContext) var modelContext

    @Bindable var meta: Meta
    @Query(sort: \Materia.nome) var materias: [Materia]

    @State private var horasTexto: String = ""

    var body: some View {
        Form {
            Section(header: Text("Título")) {
                TextField("Título", text: $meta.titulo)
            }

            Section(header: Text("Tempo alvo (horas)")) {
                TextField("Tempo", text: $horasTexto)
                    .keyboardType(.decimalPad)
                    .onAppear {
                        horasTexto = String(format: "%.1f", meta.tempoAlvo / 3600)
                    }
            }

            Section(header: Text("Matéria")) {
                Picker("Matéria", selection: $meta.materia) {
                    Text("Nenhuma").tag(Materia?.none)
                    ForEach(materias) { materia in
                        Text(materia.nome).tag(materia as Materia?)
                    }
                }
            }

            Button("Salvar") {
                if let horas = Double(horasTexto) {
                    meta.tempoAlvo = horas * 3600
                    dismiss()
                }
            }
        }
        .navigationTitle("Editar Meta")
    }
}
