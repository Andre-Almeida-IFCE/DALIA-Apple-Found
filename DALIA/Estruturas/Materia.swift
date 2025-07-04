//
//  Materia.swift
//  DALIA
//
//  Created by found on 11/07/25.
//

import Foundation
import SwiftData

@Model
class Materia {
    var nome: String
    var cor: String? // opcional, para personalização futura
    var criadaEm: Date

    init(nome: String, cor: String? = nil, criadaEm: Date = .now) {
        self.nome = nome
        self.cor = cor
        self.criadaEm = criadaEm
    }
}

@Model
class SessaoEstudo {
    var data: Date
    var duracao: TimeInterval // tempo em segundos
    var materia: Materia?

    init(data: Date = .now, duracao: TimeInterval, materia: Materia?) {
        self.data = data
        self.duracao = duracao
        self.materia = materia
    }
}

@Model
class Meta {
    var titulo: String
    var materia: Materia?
    var tempoAlvo: TimeInterval // tempo em segundos
    var criadoEm: Date

    init(titulo: String, materia: Materia?, tempoAlvo: TimeInterval, criadoEm: Date = .now) {
        self.titulo = titulo
        self.materia = materia
        self.tempoAlvo = tempoAlvo
        self.criadoEm = criadoEm
    }

    // Computado (soma total do tempo estudado)
    var progressoAtual: TimeInterval {
        // Para implementar depois, com consultas ao SwiftData
        return 0
    }
}
