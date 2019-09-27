import SwiftUI

struct RollView: View {
    @State var selectedDiceCount = 1
    @State var selectedDie = 20

    @State var isCrit = false
    @State var result = "Roll!"

    let dice = [2, 4, 6, 8, 12, 20, 100]

    var body: some View {
        VStack {
            // MARK: Title
            HStack {
                Image("d20")
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                Text("Roll Initiative")
                    .font(.system(.caption, design: .rounded))
                Spacer()
            }

            // MARK: Dice Picker
            HStack {
                Picker("", selection: $selectedDiceCount) {
                    ForEach(1...20, id: \.self) { count in
                        Text(String(count)).tag(count)
                    }
                }
                Text("d")
                    .font(.system(.title, design: .rounded))
                Picker("", selection: $selectedDie) {
                    ForEach(dice, id: \.self) { die in
                        Text(String(die)).tag(die)
                    }
                }
            }

            // MARK: Roll Button
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
}

struct RollView_Previews: PreviewProvider {
    static var previews: some View {
        RollView()
    }
}
