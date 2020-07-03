import SwiftUI

struct ResultTableView: View {
    let queryService = QueryService()
    @State private var connections: [Train] = []
    
    @EnvironmentObject var commons: CommonState
    
    var body: some View {
        VStack(spacing: 0) {
            self.labelCell
            Divider()
            
            if(commons.departingStation.type != Type.CUSTOM && commons.destinationStation.type != Type.CUSTOM)
            {
                List {
                    ForEach(connections, id: \.self) {
                        listItemView(connection: $0)
                            .listRowInsets(EdgeInsets())
                    }
                }
                .onAppear {
                    self.queryService.loadConnectionsBetweenStations(depShortCode: self.commons.departingStation.stationShortCode, desShortCode: self.commons.destinationStation.stationShortCode)
                    {
                        data in
                        self.connections = data
                    }
                }
            }
            else {
                Spacer()
            }
            
            HStack {
                Button(action: {
                    
                }) {
                    HStack {
                        Spacer()
                        Text("backwards")
                        Spacer()
                    }
                }
                
                Button(action: {
                    
                }) {
                    HStack {
                        Spacer()
                        Text("forwards")
                        Spacer()
                    }
                }
            }
            .frame(height: 70)
        }
    }
}

private extension ResultTableView {
    var labelCell: some View {
        HStack {
            Text("Train no.")
            Spacer()
            Spacer()
            Text("Departing")
            Spacer()
            Text("Arriving")
            Spacer()
        }
        .padding(10)
        .foregroundColor(Color("bg_dark_green"))
    }
}

struct listItemView: View {
    let connection: Train
    
    @EnvironmentObject var commons: CommonState

    var body: some View {
        VStack {
            HStack {
                VStack(alignment: .leading) {
                    Text(connection.trainType + " \(connection.trainNumber)")
                    Text((connection.commuterLineID ?? "n/a") + "-line")
                    Text(connection.trainCategory + " train")
                    .lineLimit(1)
                }

                Spacer()
                Spacer()
                
                VStack(alignment: .leading) {
                    Text(stationNameParser(name: commons.departingStation.stationName))
                    Text(getStoppingTime(timetable: connection.timeTableRows, stationCode: commons.departingStation.stationShortCode))
                    Text("Platform: " + getPlatform(timetable: connection.timeTableRows, stationCode: commons.departingStation.stationShortCode))
                }
                Spacer()
                
                VStack(alignment: .leading) {
                    Text(stationNameParser(name: commons.destinationStation.stationName))
                    Text(getStoppingTime(timetable: connection.timeTableRows, stationCode: commons.destinationStation.stationShortCode))
                    Text("Platform: " + getPlatform(timetable: connection.timeTableRows, stationCode: commons.destinationStation.stationShortCode))
                }
                Spacer()
            }
            .padding(EdgeInsets(top: 10,leading: 10,bottom: 0,trailing: 10))
            Divider()
        }
        
    }
}

struct ResultTableView_Previews: PreviewProvider {
    static var previews: some View {
        ResultTableView()
        .environmentObject(CommonState())
    }
}
