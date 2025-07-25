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
                    MateriaView(materia: materia)
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

#Preview {
    ListaMateriasView()
}
