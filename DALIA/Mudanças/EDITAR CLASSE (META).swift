@Model
class Meta {
    var titulo: String
    var materia: Materia?
    var tempoAlvo: TimeInterval
    var criadoEm: Date

    init(titulo: String, materia: Materia?, tempoAlvo: TimeInterval, criadoEm: Date = .now) {
        self.titulo = titulo
        self.materia = materia
        self.tempoAlvo = tempoAlvo
        self.criadoEm = criadoEm
    }

    // Simulando progresso até conectar com sessões de estudo
    var progressoAtual: TimeInterval {
        return tempoAlvo * 0.65 // 65% feito, só para visualização
    }
}
