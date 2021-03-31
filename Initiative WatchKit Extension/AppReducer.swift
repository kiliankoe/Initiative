import ComposableArchitecture

let appReducer = Reducer<AppState, AppAction, AppEnvironment> { state, action, environment in
    switch action {
    case .changeDiceCount(let count):
        state.diceCount = count
        return .none
    case .changeDie(let die):
        state.die = die
        return .none
    case .roll:
        var rollResult = 0
        for _ in (1...state.diceCount) {
            rollResult += environment.random(1...state.die)
        }

        let max = state.diceCount * state.die
        let min = state.diceCount

        var type: RollType
        if rollResult == max {
            type = .criticalSuccess
            environment.device().play(.success)
        } else if rollResult == min {
            type = .criticalFailure
            environment.device().play(.failure)
        } else {
            type = .normal
            environment.device().play(.click)
        }

        state.rollResult = .roll(rollResult, type)
        return .none
    }
}
