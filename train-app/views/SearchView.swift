import SwiftUI

struct SearchView: View {
    /*
     Searchfield bindings
     */
    @State private var depSearchValue: String = ""
    @State private var desSearchValue: String = ""
    @State private var activeDepartingSearch: Bool = false
    @State private var activeDestinationSearch: Bool = false
    
    var body: some View {
        ZStack {
            self.departingSearch
                .padding()
            self.destinationSearch
                .padding()
                .offset(y: 70)
        }
    }
}

private extension SearchView {
    var departingSearch: some View {
        SearchBarView(
            hint: "Choose Departing Station",
            searchValue: self.$depSearchValue,
            activity: self.$activeDepartingSearch)
    }
    
    var destinationSearch: some View {
        SearchBarView(
            hint: "Choose Destination",
            searchValue: self.$desSearchValue,
            activity: self.$activeDestinationSearch)
    }
}

struct SearchBarView: View {
    let hint: String
    @Binding var searchValue: String
    @Binding var activity: Bool
    
    var body: some View {
        VStack {
            VStack {
                HStack {
                    TextField(self.hint, text: $searchValue, onEditingChanged: {
                        typing in
                        self.activity = true
                    })
                    Button(action: {
                        self.searchValue = ""
                        self.activity = false
                    }) {
                        Image(systemName: "xmark.circle.fill").opacity(self.searchValue.isEmpty ? 0 : 1)
                    }
                }
                .padding()
                .background(Color(.secondarySystemBackground))
                .cornerRadius(5)
            }
            Spacer()
        }
    }
}

struct SearchView_Previews: PreviewProvider {
    static var previews: some View {
        SearchView()
    }
}
