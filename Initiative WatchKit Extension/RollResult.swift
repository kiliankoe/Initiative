enum RollResult: Equatable {
    case unrolled
    case roll(Int, RollType)
}

enum RollType {
    case criticalFailure
    case normal
    case criticalSuccess
}
