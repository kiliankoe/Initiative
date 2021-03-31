import WatchKit

protocol Device {
    func play(_ type: WKHapticType)
}

extension WKInterfaceDevice: Device {}
