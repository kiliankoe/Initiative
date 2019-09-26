import SwiftUI

struct DicePickerView: View {
    @State var diceCount = 1
    @State var eyeCount = 20

    var body: some View {
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

//        HStack {
//            Button("1d20", action: {})
//            Button("2d6", action: {})
//            Button("3d8", action: {})
//        }
    }
}

struct DicePickerView_Previews: PreviewProvider {
    static var previews: some View {
        DicePickerView()
    }
}
