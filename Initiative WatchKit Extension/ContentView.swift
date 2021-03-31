import ComposableArchitecture
import SwiftUI

enum RollResult: Equatable {
    case unrolled
    case roll(Int, RollType)
}

enum RollType {
    case criticalFailure
    case normal
    case criticalSuccess
}

struct AppState: Equatable {
    var diceCount = 1
    var die = 20
    var rollResult: RollResult = .unrolled
}

enum AppAction: Equatable {
    case changeDiceCount(Int)
    case changeDie(Int)
    case roll
}

protocol Device {
    func play(_ type: WKHapticType)
}

extension WKInterfaceDevice: Device {}

struct AppEnvironment {
    var device: () -> Device
}

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
            rollResult += Int.random(in: 1...state.die)
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
        }

        state.rollResult = .roll(rollResult, type)
        return .none
    }
}

struct ContentView: View {
    let store: Store<AppState, AppAction>

    var body: some View {
        WithViewStore(self.store) { viewStore in
            VStack {
                HStack {
                    Image("d20")
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                    Text("Roll Initiative")
                        .font(.system(.caption, design: .rounded))
                    Spacer()
                }
                .frame(height: 30)

                DicePicker(
                    selectedDiceCount: viewStore.binding(
                        get: \.diceCount,
                        send: AppAction.changeDiceCount
                    ),
                    selectedDie: viewStore.binding(
                        get: \.die,
                        send: AppAction.changeDie
                    )
                )

                RollButton(
                    result: viewStore.rollResult,
                    rollAction: {
                        viewStore.send(.roll)
                    }
                )
            }
            .padding()
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView(
            store: Store(
                initialState: AppState(),
                reducer: appReducer,
                environment: AppEnvironment(
                    device: WKInterfaceDevice.current
                )
            )
        )
    }
}
