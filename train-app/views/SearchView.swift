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
            self.background
                .edgesIgnoringSafeArea(.top)
            self.departingSearch
                .padding()
            self.destinationSearch
                .padding()
                .offset(y: 70)
            self.switchButton
                .offset(x: 115, y: 55)
        }
    }
}

private extension SearchView {
    var departingSearch: some View {
        SearchBarView(
            hint: "Choose Departure",
            icon: "mappin.circle.fill",
            searchValue: self.$depSearchValue,
            activity: self.$activeDepartingSearch)
    }
    
    var destinationSearch: some View {
        SearchBarView(
            hint: "Choose Destination",
            icon: "map.fill",
            searchValue: self.$desSearchValue,
            activity: self.$activeDestinationSearch)
    }
    
    var switchButton: some View {
        VStack {
            Button(action: {
                
            }) {
                Image(systemName: "arrow.up.arrow.down.square.fill")
                    .resizable()
                    .frame(width: 50, height: 50)
                    .foregroundColor(Color("fg_highlight"))
                    .shadow(radius: 2)
            }
            Spacer()
        }
    }
    
    var background: some View {
        VStack {
            Rectangle()
                .foregroundColor(Color("bg_dark_green"))
                .frame(height: 240)
            Spacer()
        }
    }
}

struct SearchBarView: View {
    let hint: String
    let icon: String
    @Binding var searchValue: String
    @Binding var activity: Bool
    
    var body: some View {
        VStack {
            VStack {
                HStack {
                    Image(systemName: icon)
                        .resizable()
                        .frame(width: 25, height: 25)
                    
                    TextField(self.hint, text: $searchValue, onEditingChanged: {
                        typing in
                        self.activity = true
                    }).font(.system(size: 20))
                    
                    Button(action: {
                        self.searchValue = ""
                        self.activity = false
                    }) {
                        Image(systemName: "xmark.circle.fill")
                            .resizable()
                            .frame(width: 20, height: 20)
                            .opacity(self.searchValue.isEmpty ? 0 : 1)
                    }
                }
                .padding()
                .background(Color("fg_light_green"))
                .foregroundColor(Color("fg_highlight"))
                .cornerRadius(10)
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
