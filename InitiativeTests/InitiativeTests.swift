import ComposableArchitecture
import XCTest
@testable import Initiative_WatchKit_Extension

class InitiativeTests: XCTestCase {
    let device = MockDevice()

    func testChangeDiceCount() {
        let store = TestStore(
            initialState: AppState(),
            reducer: appReducer,
            environment: AppEnvironment(
                random: { _ in fatalError() },
                device: { fatalError() }
            )
        )

        store.assert(
            .send(.changeDiceCount(2)) {
                $0.diceCount = 2
            }
        )
    }

    func testChangeDie() {
        let store = TestStore(
            initialState: AppState(),
            reducer: appReducer,
            environment: AppEnvironment(
                random: { _ in fatalError() },
                device: { fatalError() }
            )
        )

        store.assert(
            .send(.changeDie(6)) {
                $0.die = 6
            }
        )
    }

    func testNormalRoll() {
        let store = TestStore(
            initialState: AppState(),
            reducer: appReducer,
            environment: AppEnvironment(
                random: { _ in 4 },
                device: { fatalError() }
            )
        )

        store.assert(
            .send(.roll) {
                $0.rollResult = .roll(4, .normal)
            }
        )
    }

    func testCriticalFailureRoll() {
        let store = TestStore(
            initialState: AppState(),
            reducer: appReducer,
            environment: AppEnvironment(
                random: { _ in 1 },
                device: { self.device }
            )
        )

        store.assert(
            .send(.roll) {
                $0.rollResult = .roll(1, .criticalFailure)
            }
        )

        XCTAssertEqual(self.device.lastPlayedHaptic, .failure)
    }

    func testCriticalSuccessRoll() {
        let store = TestStore(
            initialState: AppState(),
            reducer: appReducer,
            environment: AppEnvironment(
                random: { _ in 20 },
                device: { self.device }
            )
        )

        store.assert(
            .send(.roll) {
                $0.rollResult = .roll(20, .criticalSuccess)
            }
        )

        XCTAssertEqual(self.device.lastPlayedHaptic, .success)
    }

    func testChangeDieAndRollSuccess() {
        let store = TestStore(
            initialState: AppState(),
            reducer: appReducer,
            environment: AppEnvironment(
                random: { _ in 6 },
                device: { self.device }
            )
        )

        store.assert(
            .send(.changeDiceCount(4)) {
                $0.diceCount = 4
            },
            .send(.changeDie(6)) {
                $0.die = 6
            },
            .send(.roll) {
                $0.rollResult = .roll(24, .criticalSuccess)
            }
        )

        XCTAssertEqual(self.device.lastPlayedHaptic, .success)
    }
}
