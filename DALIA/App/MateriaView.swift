//
//  MateriaView.swift
//  DALIA
//
//  Created by found on 11/07/25.
//
import SwiftUI

struct MateriaView: View {
    let materia: Materia
    
    var body: some View {
        VStack {
            ZStack {
                Rectangle()
                    .foregroundColor(Color(hex: materia.cor ?? "#007AFF")) // usa a cor da matéria
                    .frame(width: 146, height: 144)
                    .cornerRadius(20)
                    .shadow(color: .black.opacity(0.25), radius: 2, x: 0, y: 4)
                    .overlay(
                        RoundedRectangle(cornerRadius: 20)
                            .inset(by: 0.5)
                            .stroke(Color(red: 0.48, green: 0.03, blue: 0.03), lineWidth: 1)
                    )
                
                Text(materia.nome)
                    .font(.headline)
                    .foregroundColor(.white)
                    .multilineTextAlignment(.center)
                    .padding()
                
            }
        }
    }
}

#Preview {
    MateriaView(materia: Materia(nome: "Portugues", cor: "#007AFF" ,criadaEm: Date()))
}
