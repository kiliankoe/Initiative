import SwiftUI
import ComposableArchitecture

struct RollButton: View {
    let result: RollResult
    let rollAction: () -> Void

    init(result: RollResult, rollAction: @escaping () -> Void = {}) {
        self.result = result
        self.rollAction = rollAction
    }

    var body: some View {
        Button {
            rollAction()
        } label: {
            switch result {
            case .unrolled:
                Text("Roll!")
            case .roll(let roll, let type):
                HStack {
                    type.symbol
                    Text(String(roll))
                }
            }
        }
        .font(.system(.headline, design: .rounded))
        .background(result.buttonBackgroundColor)
        .foregroundColor(result.buttonForegroundColor)
        .cornerRadius(20)
    }
}

struct RollButton_Previews: PreviewProvider {
    static var previews: some View {
        Group {
            RollButton(result: .unrolled)
            RollButton(result: .roll(1, .criticalFailure))
            RollButton(result: .roll(10, .normal))
            RollButton(result: .roll(20, .criticalSuccess))
        }
        .padding()
        .previewLayout(.sizeThatFits)
    }
}

// MARK: Private Helpers

private extension RollType {
    var symbol: some View {
        switch self {
        case .normal:
            return SFSymbol.reroll
        case .criticalFailure:
            return SFSymbol.criticalFail
        case .criticalSuccess:
            return SFSymbol.criticalSuccess
        }
    }

    var buttonForegroundColor: Color {
        switch self {
        case .normal:
            return .white
        default:
            return .black
        }
    }
}

private extension RollResult {
    var buttonBackgroundColor: Color {
        switch self {
        case .roll(_, .criticalFailure):
            return .red
        case .roll(_, .criticalSuccess):
            return .green
        default:
            return .black
        }
    }

    var buttonForegroundColor: Color {
        switch self {
        case .unrolled, .roll(_, .normal):
            return .white
        default:
            return .black
        }
    }
}
