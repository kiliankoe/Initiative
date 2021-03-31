struct AppEnvironment {
    var random: (ClosedRange<Int>) -> Int
    var device: () -> Device
}
