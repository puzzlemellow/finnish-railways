import SwiftUI

struct ContentView: View {
    var body: some View {
        ZStack {
            ResultTableView()
                .offset(y: 205)
            SearchView()
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
