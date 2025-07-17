import SwiftUI
import SwiftData

struct ListaMetasView: View {
    @Environment(\.modelContext) var modelContext
    @Query var metas: [Meta]

    @State private var metaParaEditar: Meta? = nil

    var body: some View {
        NavigationStack {
            List {
                ForEach(metas) { meta in
                    Button {
                        metaParaEditar = meta
                    } label: {
                        VStack(alignment: .leading) {
                            Text(meta.titulo)
                                .font(.headline)
                            if let materia = meta.materia {
                                Text("Matéria: \(materia.nome)")
                                    .font(.subheadline)
                            }
                            Text("Alvo: \(formatarTempo(meta.tempoAlvo))")
                                .font(.footnote)
                        }
                    }
                }
                .onDelete { indexSet in
                    for index in indexSet {
                        modelContext.delete(metas[index])
                    }
                }
            }
            .navigationTitle("Metas")
            .sheet(item: $metaParaEditar) { meta in
                EditarMetaView(meta: meta)
            }
        }
    }

    func formatarTempo(_ tempo: TimeInterval) -> String {
        let horas = tempo / 3600
        return String(format: "%.1f horas", horas)
    }
}
