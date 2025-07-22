//
//  ContentView.swift
//  DALIA
//
//  Created by found on 04/07/25.
//

import SwiftUI
import SwiftData

struct ContentView: View {
    @Environment(\.modelContext) private var context
    @Query var materias: [Materia]
    
    

    var body: some View {
        NavigationView {
            VStack {
              
            }
            .navigationTitle("Matérias")
        }
    }
}


#Preview {
    ContentView()
}
