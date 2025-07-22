//
//  MateriaView.swift
//  DALIA
//
//  Created by found on 11/07/25.
//
import SwiftUI

struct MateriaView: View {
    @State var materia: Materia
    @State private var showMateria: Bool = false

    var body: some View {
        HStack {
            Text(materia.nome)
                .font(.headline)
                .foregroundColor(.white)
            Spacer()
            Button {
                showMateria = true
            } label: {
                Label("", systemImage: "chevron.right")
                    .foregroundColor(.white)
            }
        }
        .frame(width: 326, height: 56)
        .background(colorFromHex(materia.cor ?? "") ?? .gray)
        .cornerRadius(8)
        .padding()
        .sheet(isPresented: $showMateria) {
                    DetalhesMateriaView(materia: materia)
                }
    }
}

// View de detalhes da matéria
struct DetalhesMateriaView: View {
    var materia: Materia

    var body: some View {
        VStack(spacing: 20) {
            Text("Detalhes da Matéria")
                .font(.title)
            Text("Nome: \(materia.nome)")
            if let cor = materia.cor {
                Text("Cor: \(cor)")
            }
            Text("Criada em: \(materia.criadaEm.formatted())")
        }
        .padding()
    }
}

// Preview
#Preview {
    MateriaView(materia: Materia(nome: "Português", cor: "#007AFF", criadaEm: Date()))
}


func colorFromHex(_ hex: String) -> Color? {
    var hexString = hex.trimmingCharacters(in: .whitespacesAndNewlines)
    hexString = hexString.replacingOccurrences(of: "#", with: "")

    guard hexString.count == 6,
          let intCode = Int(hexString, radix: 16) else {
        return nil
    }

    let red = Double((intCode >> 16) & 0xFF) / 255.0
    let green = Double((intCode >> 8) & 0xFF) / 255.0
    let blue = Double(intCode & 0xFF) / 255.0

    return Color(red: red, green: green, blue: blue)
}


