import SwiftUI

struct RollView: View {
    @State var selectedDiceCount = 1
    @State var selectedDie = 20

    @State var isCrit = false
    @State var result = "Roll!"

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

            DicePicker(selectedDiceCount: $selectedDiceCount,
                       selectedDie: $selectedDie)

            RollButton(selectedDiceCount: $selectedDiceCount,
                       selectedDie: $selectedDie,
                       isCrit: $isCrit,
                       result: $result)
        }
    }
}

struct RollView_Previews: PreviewProvider {
    static var previews: some View {
        RollView()
    }
}
