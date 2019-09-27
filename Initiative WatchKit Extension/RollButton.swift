import SwiftUI

struct RollButton: View {
    @Binding var selectedDiceCount: Int
    @Binding var selectedDie: Int
    @Binding var isCrit: Bool
    @Binding var result: String

    var body: some View {
        Button(action: {
            var rollResult = 0
            for _ in (1...self.selectedDiceCount) {
                rollResult += Int.random(in: 1...self.selectedDie)
            }

            self.result = String(rollResult)

            let max = self.selectedDiceCount * self.selectedDie
            if rollResult == max {
                self.isCrit = true
                WKInterfaceDevice.current().play(.success)
            } else {
                self.isCrit = false
            }
        }, label: {
            HStack {
                Image(systemName: "arrow.2.circlepath")
                Text(result)
            }
        })
            .font(.system(.headline, design: .rounded))
            .background(isCrit ? Color.green : Color.black)
            .foregroundColor(isCrit ? .black : .white)
            .cornerRadius(20)
    }
}

struct RollButton_Previews: PreviewProvider {
    static var previews: some View {
        Text("")
//        RollButton()
    }
}
