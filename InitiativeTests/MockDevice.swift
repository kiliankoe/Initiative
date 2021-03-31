import enum WatchKit.WKHapticType
@testable import Initiative_WatchKit_Extension

class MockDevice: Device {
    var lastPlayedHaptic: WKHapticType?

    init() {}

    func play(_ type: WKHapticType) {
        self.lastPlayedHaptic = type
    }
}
