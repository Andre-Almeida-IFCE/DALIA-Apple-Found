import SwiftUI
import SwiftData

struct ListaMateriasView: View {
    @Environment(\.modelContext) var modelContext
    @Query var materias: [Materia]

    @State private var materiaParaEditar: Materia? = nil

    var body: some View {
        NavigationStack {
            List {
                ForEach(materias) { materia in
                    Button {
                        materiaParaEditar = materia
                    } label: {
                        VStack(alignment: .leading) {
                            Text(materia.nome)
                                .font(.headline)
                            if let cor = materia.cor {
                                Text("Cor: \(cor)")
                                    .font(.footnote)
                            }
                        }
                    }
                }
                .onDelete { indexSet in
                    for index in indexSet {
                        modelContext.delete(materias[index])
                    }
                }
            }
            .navigationTitle("Matérias")
            .sheet(item: $materiaParaEditar) { materia in
                EditarMateriaView(materia: materia)
            }
        }
    }
}
