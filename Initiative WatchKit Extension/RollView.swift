import SwiftUI

struct RollView: View {
    @State var selectedDiceCount = 1
    @State var selectedDie = 20

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

            DicePicker(selectedDiceCount: $selectedDiceCount,
                       selectedDie: $selectedDie)

            RollButton(selectedDiceCount: $selectedDiceCount,
                       selectedDie: $selectedDie)
        }
    }
}

struct RollView_Previews: PreviewProvider {
    static var previews: some View {
        RollView()
    }
}
