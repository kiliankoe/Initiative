import SwiftUI

enum RollResult {
    case unrolled
    case roll(Int)
}

enum RollType {
    case criticalFailure
    case normal
    case criticalSuccess
}

struct RollButton: View {
    @Binding var selectedDiceCount: Int
    @Binding var selectedDie: Int

    @State var result: RollResult = .unrolled
    @State var type: RollType = .normal

    var stateIcon: Image {
        switch type {
        case .normal:
            return Image(systemName: "arrow.triangle.2.circlepath")
        case .criticalFailure:
            return Image(systemName: "xmark.circle")
        case .criticalSuccess:
            return Image(systemName: "checkmark.circle")
        }
    }

    var backgroundColor: Color {
        switch type {
        case .normal:
            return .black
        case .criticalSuccess:
            return .green
        case .criticalFailure:
            return .red
        }
    }

    var foregroundColor: Color {
        switch type {
        case .normal:
            return .white
        default:
            return .black
        }
    }

    var body: some View {
        Button {
            var rollResult = 0
            for _ in (1...selectedDiceCount) {
                rollResult += Int.random(in: 1...selectedDie)
            }
            self.result = .roll(rollResult)

            let max = selectedDiceCount * selectedDie
            let min = selectedDiceCount

            if rollResult == max {
                type = .criticalSuccess
                WKInterfaceDevice.current().play(.success)
            } else if rollResult == min {
                type = .criticalFailure
                WKInterfaceDevice.current().play(.failure)
            } else {
                type = .normal
            }
        } label: {
            switch result {
            case .unrolled:
                Text("Roll!")
            case .roll(let roll):
                HStack {
                    stateIcon
                    Text(String(roll))
                }
            }
        }
        .font(.system(.headline, design: .rounded))
        .background(backgroundColor)
        .foregroundColor(foregroundColor)
        .cornerRadius(20)
    }
}

struct RollButton_Previews: PreviewProvider {
    static var previews: some View {
        Group {
            RollButton(
                selectedDiceCount: .constant(1),
                selectedDie: .constant(20))
            RollButton(
                selectedDiceCount: .constant(1),
                selectedDie: .constant(20),
                result: .roll(1),
                type: .criticalFailure)
            RollButton(
                selectedDiceCount: .constant(1),
                selectedDie: .constant(20),
                result: .roll(20),
                type: .criticalSuccess)
        }
        .padding()
//        .previewLayout(.sizeThatFits)
    }
}
