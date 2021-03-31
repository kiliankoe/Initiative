import ComposableArchitecture
import SwiftUI

@main
struct InitiativeApp: App {
    var body: some Scene {
        WindowGroup {
            NavigationView {
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
    }
}
