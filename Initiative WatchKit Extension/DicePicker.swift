import SwiftUI

struct DicePicker: View {
    @Binding var selectedDiceCount: Int
    @Binding var selectedDie: Int

    let dice = [2, 4, 6, 8, 12, 20, 100]
    
    var body: some View {
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
    }
}

struct DicePicker_Previews: PreviewProvider {
    static var previews: some View {
        Text("")
//        DicePicker()
    }
}
