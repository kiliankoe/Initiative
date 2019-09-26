import SwiftUI

struct RollView: View {
    @State var result = "Roll!"

    var body: some View {
        VStack {
            HStack {
                Image("d20")
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                Text("Roll Initiative")
                    .font(.system(.caption, design: .rounded))
                Spacer()
            }

            DicePickerView()

            Button(action: {
                // FIXME
                let diceCount = 1
                let diceEyes = 20

                var rollResult = 0
                for _ in (1...diceCount) {
                    rollResult += Int.random(in: 1...diceEyes)
                }

                self.result = String(rollResult)

                let max = diceCount * diceEyes
                if rollResult == max {
                    self.result += " 💥"
                }
            }, label: {
                HStack {
                    Image(systemName: "arrow.2.circlepath")
                    Text(result)
                }
            })
        }
    }
}

struct RollView_Previews: PreviewProvider {
    static var previews: some View {
        RollView()
    }
}
