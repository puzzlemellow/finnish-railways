import SwiftUI

struct ResultTableView: View {
    var body: some View {
        VStack(spacing: 0) {
            Divider()
            self.labelCell
            Divider()
            List {
                Text("")
            }
        }
    }
}

private extension ResultTableView {
    var labelCell: some View {
        HStack {
            Text("Train no.")
            Spacer()
            Text("Departing")
            Spacer()
            Text("Arriving")
            Spacer()
        }
        .padding(10)
        .background(Color("fg_bright_green"))
    }
}

struct ResultTableView_Previews: PreviewProvider {
    static var previews: some View {
        ResultTableView()
    }
}
