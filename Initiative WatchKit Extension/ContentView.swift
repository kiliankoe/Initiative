import ComposableArchitecture
import SwiftUI

struct AppState: Equatable {
    var diceCount = 1
    var die = 20
}

enum AppAction: Equatable {
    case changeDiceCount(Int)
    case changeDie(Int)
}

struct AppEnvironment {}

let appReducer = Reducer<AppState, AppAction, AppEnvironment> { state, action, _ in
    switch action {
    case .changeDiceCount(let count):
        state.diceCount = count
        return .none
    case .changeDie(let die):
        state.die = die
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
                    selectedDiceCount: viewStore.diceCount,
                    selectedDie: viewStore.die
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
                environment: AppEnvironment()
            )
        )
    }
}
