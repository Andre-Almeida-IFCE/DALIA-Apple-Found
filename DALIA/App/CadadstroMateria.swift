import SwiftUI
import SwiftData

struct CadastroMateria: View {
    @Environment(\.dismiss) var dismiss
    @Environment(\.modelContext) var modelContext

    @State private var nome: String = ""
    @State private var corSelecionada: Color = .blue
    @State private var showAlertNomeVazio: Bool = false

    var body: some View {
        NavigationStack {
            Form {
                Section(header: Text("Informações da Matéria")) {
                    TextField("Nome da matéria", text: $nome)

                    ColorPicker("Cor da matéria", selection: $corSelecionada)
                }
            }
            .navigationTitle("Nova Matéria")
            .toolbar {
                ToolbarItem(placement: .confirmationAction) {
                    Button("Salvar") {
                        if nome.trimmingCharacters(in: .whitespaces).isEmpty {
                            showAlertNomeVazio = true
                        } else {
                            let hexColor = corSelecionada.toHex() ?? "#0000FF" // azul padrão
                            let novaMateria = Materia(nome: nome, cor: hexColor)
                            modelContext.insert(novaMateria)
                            try? modelContext.save()
                            dismiss()
                        }
                    }
                }

                ToolbarItem(placement: .cancellationAction) {
                    Button("Cancelar") {
                        dismiss()
                    }
                }
            }
            .alert("O nome da matéria não pode ficar em branco.", isPresented: $showAlertNomeVazio) {
                Button("OK", role: .cancel) { }
            }
        }
    }
}

// Extensão para converter Color em HEX string
extension Color {
    func toHex() -> String? {
        let uiColor = UIColor(self)
        var red: CGFloat = 0
        var green: CGFloat = 0
        var blue: CGFloat = 0
        var alpha: CGFloat = 0

        guard uiColor.getRed(&red, green: &green, blue: &blue, alpha: &alpha) else {
            return nil
        }

        let r = Int(red * 255)
        let g = Int(green * 255)
        let b = Int(blue * 255)

        return String(format: "#%02X%02X%02X", r, g, b)
    }
}
