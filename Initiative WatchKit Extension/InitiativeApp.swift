import ComposableArchitecture
import SwiftUI

@main
struct InitiativeApp: App {
    var body: some Scene {
        WindowGroup {
            NavigationView {
                RollView(
                    store: Store(
                        initialState: AppState(),
                        reducer: appReducer,
                        environment: AppEnvironment(
                            random: Int.random,
                            device: WKInterfaceDevice.current
                        )
                    )
                )
            }
        }
    }
}
