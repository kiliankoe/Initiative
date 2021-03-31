import SwiftUI

enum SFSymbol: String, View {
    case reroll = "arrow.triangle.2.circlepath"
    case criticalFail = "xmark.circle"
    case criticalSuccess = "checkmark.circle"

    var body: some View {
        Image(systemName: self.rawValue)
    }
}
