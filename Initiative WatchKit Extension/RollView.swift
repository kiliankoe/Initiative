import SwiftUI

struct RollView: View {
    @State var diceCount = 0
    @State var eyeCount = 20

    @State var isCrit = false
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

            HStack {
                Picker("", selection: $diceCount) {
                    ForEach(1..<21) { val in
                        Text(String(val)).tag(val)
                    }
                }
                Text("d")
                    .font(.system(.title, design: .rounded))
                Picker("", selection: $eyeCount) {
                    Text("1").tag(1)
                    Text("4").tag(4)
                    Text("6").tag(6)
                    Text("8").tag(8)
                    Text("10").tag(10)
                    Text("12").tag(12)
                    Text("20").tag(20)
                    Text("100").tag(100)
                }
            }

            Button(action: {
                var rollResult = 0
                for _ in (0..<self.diceCount) {
                    rollResult += Int.random(in: 1...self.eyeCount)
                }

                self.result = String(rollResult)

                let max = self.diceCount * self.eyeCount
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
