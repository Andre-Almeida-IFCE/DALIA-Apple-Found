//
//  ListaMateriasView.swift
//  DALIA
//
//  Created by found on 11/07/25.
//

import SwiftUI
import SwiftData

struct ListaMateriasView: View {

    @State var materiaSelecionada: Materia? = nil
    @State var mostrarCadastro = false

    @Environment(\.modelContext) var modelContext
    @Query var listaMaterias: [Materia]

    var body: some View {
        NavigationStack {
//            if listaMaterias.isEmpty {
//                Button(action: {
//                    mostrarCadastro = true
//                }) {
//                    BotaoAddMateriaView()
//                }
//                .navigationBarItems(trailing:
//                    Button(action: {
//                        mostrarCadastro = true
//                    }) {
//                        Image(systemName: "plus.circle.fill")
//                            .resizable()
//                            .aspectRatio(contentMode: .fit)
//                            .frame(width: 30, height: 30)
//                            .tint(.blue)
//                    }
//                )
//                .navigationTitle("Matérias")
//                .toolbarTitleDisplayMode(.inlineLarge)
//            } else {
            ScrollView(.horizontal, showsIndicators: false) {
                HStack(spacing: 16) {
                    ForEach(listaMaterias) { materia in
                        MateriaView(materia: materia)
                            .frame(width: 160, height: 160)
                            .background(Color.white)
                            .cornerRadius(20)
                            .shadow(radius: 3)
                            .contextMenu {
                                Button(role: .destructive) {
                                    modelContext.delete(materia)
                                } label: {
                                    Label("Deletar", systemImage: "trash")
                                }
                            }
                            .onTapGesture {
                                materiaSelecionada = materia
                            }
                    }
                }
                .padding(.horizontal)
            }

        }
    }
}


extension Color {
    init(hex: String) {
        let scanner = Scanner(string: hex)
        _ = scanner.scanString("#")

        var rgb: UInt64 = 0
        scanner.scanHexInt64(&rgb)

        let r = Double((rgb >> 16) & 0xFF) / 255.0
        let g = Double((rgb >> 8) & 0xFF) / 255.0
        let b = Double(rgb & 0xFF) / 255.0

        self.init(red: r, green: g, blue: b)
    }
}

#Preview {
    ListaMateriasView()
}


struct BotaoAddMateriaView: View {
    var body: some View {
        VStack {
            Spacer()
            
            Image(systemName: "book")
                .resizable()
                .aspectRatio(contentMode: .fit)
                .foregroundColor(Color.white.opacity(0.6)) // mantido conforme pedido
                .frame(width: 50.0, height: 50.0)
            
            Text("Clique para cadastrar sua primeira matéria!")
                .font(.headline)
                .foregroundColor(.white)
                .multilineTextAlignment(.center)
                .frame(width: 300)
            
            Image(systemName: "plus")
                .resizable()
                .aspectRatio(contentMode: .fit)
                .foregroundColor(.white)
                .frame(width: 30, height: 30)
            
            Spacer()
        }
        .frame(maxWidth: 300, maxHeight: 220)
        .background(
            LinearGradient(
                gradient: Gradient(colors: [
                    Color(hex: "#FF3C2B"),
                    Color(hex: "#C0392B")
                ]),
                startPoint: .topLeading,
                endPoint: .bottomTrailing
            )
        )
        .cornerRadius(30)
        .padding()
    }
}
