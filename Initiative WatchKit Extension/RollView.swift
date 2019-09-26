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
                self.result = "20"
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
