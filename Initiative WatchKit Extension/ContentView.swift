import SwiftUI

struct ContentView: View {
    @State private var selectedDiceCount = 1
    @State private var selectedDie = 20

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

            DicePicker(
                selectedDiceCount: $selectedDiceCount,
                selectedDie: $selectedDie)

            RollButton(
                selectedDiceCount: $selectedDiceCount,
                selectedDie: $selectedDie)
        }
        .padding()
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
