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
            if listaMaterias.isEmpty {
                Button(action: {
                    mostrarCadastro = true
                }) {
                    VStack {
                        Spacer()

                        Image(systemName: "book")
                            .resizable()
                            .aspectRatio(contentMode: .fit)
                            .foregroundColor(Color.white.opacity(0.6))
                            .frame(width: 50.0, height: 50.0)

                        Text("Clique para cadastrar sua primeira matéria!")
                            .font(.headline)
                            .foregroundColor(.primary)
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
                        LinearGradient(gradient: Gradient(colors: [Color.blue, Color.cyan]), startPoint: .topLeading, endPoint: .bottomTrailing)
                    )
                    .cornerRadius(30)
                    .padding()
                }
                .navigationBarItems(trailing:
                    Button(action: {
                        mostrarCadastro = true
                    }) {
                        Image(systemName: "plus.circle.fill")
                            .resizable()
                            .aspectRatio(contentMode: .fit)
                            .frame(width: 30, height: 30)
                            .tint(.blue)
                    }
                )
                .navigationTitle("Minhas Matérias")
                .toolbarTitleDisplayMode(.inlineLarge)
            } else {
                List {
                    ForEach(listaMaterias) { materia in
                        HStack {
                            Circle()
                                .fill(Color(hex: materia.cor ?? "#007AFF"))
                                .frame(width: 20, height: 20)
                            Text(materia.nome)
                        }
                        .swipeActions(edge: .trailing) {
                            Button(role: .destructive) {
                                modelContext.delete(materia)
                            } label: {
                                Label("Deletar", systemImage: "trash")
                            }
                        }
                        .swipeActions(edge: .leading) {
                            Button {
                                materiaSelecionada = materia
                            } label: {
                                Label("Editar", systemImage: "pencil")
                            }
                            .tint(.yellow)
                        }
                    }
                }
                .navigationTitle("Dashboard")
                .toolbarTitleDisplayMode(.inlineLarge)
                .navigationBarItems(trailing:
                    Button(action: {
                        mostrarCadastro = true
                    }) {
                        Image(systemName: "plus")
                            .imageScale(.large)
                            .tint(.blue)
                    }
                )
                .sheet(isPresented: Binding(get: { mostrarCadastro }, set: { mostrarCadastro = $0 })) {
                    CadastroMateria()
                }

                // Tela de edição será adicionada futuramente
                .navigationBarBackButtonHidden(true)
            }
        }
    }
}

// Converte hex string para SwiftUI Color
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

