import SwiftUI

struct SearchView: View {
    /*
     Searchfield bindings
     */
    @State private var depSearchValue: String = ""
    @State private var desSearchValue: String = ""
    @State private var activeDepartingSearch: Bool = false
    @State private var activeDestinationSearch: Bool = false
    
    let queryService = QueryService()
    
    @State private var stations: [Station] = []
    @EnvironmentObject var commons: CommonState
    
    var body: some View {
        ZStack {
            self.background
                .edgesIgnoringSafeArea(.top)
            self.destinationSearch
                .padding()
                .offset(y: 70)
            self.departingSearch
                .padding()
            if(!activeDepartingSearch && commons.departingStation.type != Type.CUSTOM &&
                !activeDestinationSearch && commons.destinationStation.type != Type.CUSTOM)
            {
                self.switchButton
                    .offset(x: 115, y: 55)
            }
        }
        .onAppear {
            UITableView.appearance().separatorColor = .clear
            
            self.queryService.loadTrainStationData {
                data in
                self.stations = filteredByPassengerAvailability(stations: data)
            }
        }
    }
}

private extension SearchView {
    var departingSearch: some View {
        VStack {
            SearchBarView(
                hint: commons.departingStation.type == Type.CUSTOM ? "Choose Departure" : stationNameParser(name: commons.departingStation.stationName),
                icon: "mappin.circle.fill",
                stations: self.$stations,
                searchValue: self.$depSearchValue,
                activity: self.$activeDepartingSearch)
            
            if(activeDepartingSearch) {
                DropdownTableView(stations: self.$stations)
                {
                    self.commons.departingStation = $0
                    self.activeDepartingSearch = false
                }
            }
            Spacer()
        }
    }
    
    var destinationSearch: some View {
        VStack {
            SearchBarView(
                hint: commons.destinationStation.type == Type.CUSTOM ? "Choose Destination" : stationNameParser(name: commons.destinationStation.stationName),
                icon: "map.fill",
                stations: self.$stations,
                searchValue: self.$desSearchValue,
                activity: self.$activeDestinationSearch)
            
            if(activeDestinationSearch) {
                DropdownTableView(stations: self.$stations)
                {
                    self.commons.destinationStation = $0
                    self.activeDestinationSearch = false
                }
            }
            Spacer()
        }
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

struct DropdownTableView: View {
    @Binding var stations: [Station]
    let action: (Station) -> Void
    
    var body: some View {
        List {
            ForEach(stations, id: \.self) { station in
                Button(action: {
                    self.action(station)
                }) {
                    HStack {
                        Text(stationNameParser(name: station.stationName))
                        Spacer()
                    }
                }
            }
        }
        .frame(height: 250)
        .cornerRadius(10)
    }
}

struct SearchBarView: View{
    let hint: String
    let icon: String
    @Binding var stations: [Station]
    @Binding var searchValue: String
    @Binding var activity: Bool
    
    var body: some View {
        HStack {
            Image(systemName: icon)
                .resizable()
                .frame(width: 25, height: 25)
                    
            ZStack {
                if(searchValue.isEmpty) {
                    Text(hint)
                }
                
                TextField("", text: $searchValue, onEditingChanged: {
                    typing in
                    self.activity = true
                })
            }
            .font(.system(size: 20))
            
                    
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
}

struct SearchView_Previews: PreviewProvider {
    static var previews: some View {
        SearchView()
        .environmentObject(CommonState())
    }
}
