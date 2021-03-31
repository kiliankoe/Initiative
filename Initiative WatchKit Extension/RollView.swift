import ComposableArchitecture
import SwiftUI

struct RollView: View {
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
                .frame(height: 25)

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
                .frame(height: 50)

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
        RollView(
            store: Store(
                initialState: AppState(),
                reducer: appReducer,
                environment: AppEnvironment(
                    random: { range in range.upperBound },
                    device: WKInterfaceDevice.current
                )
            )
        )
    }
}
