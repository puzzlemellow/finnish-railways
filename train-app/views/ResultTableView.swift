import SwiftUI

struct ResultTableView: View {
    let date = Date()
    let calendar = Calendar.current
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
                    //TODO
                }) {
                    HStack {
                        if (commons.day == calendar.component(.day, from: date) && commons.month == calendar.component(.month, from: date)) {
                            Spacer()
                            Text("Today")
                        }
                        else {
                            Image(systemName: "chevron.left.2")
                            .padding()
                            Spacer()
                            Text("\(commons.day).\(commons.month)")
                        }
                        Spacer()
                    }
                }
                Divider()
                
                Button(action: {
                    //TODO
                }) {
                    HStack {
                        Spacer()
                        Text("\(commons.day + 1).\(commons.month)")
                        Spacer()
                        if (commons.day <= 31 && commons.month <= 12) {
                            Image(systemName: "chevron.right.2")
                            .padding()
                        }
                    }
                }
            }
            .frame(height: 70)
            .background(Color("bg_dark_green"))
        .foregroundColor(Color("fg_highlight"))
        }
    }
}

private extension ResultTableView {
    var labelCell: some View {
        HStack {
            Text("Train no.")
            .frame(width: 140, alignment: .leading)
            Text("Departing")
            .frame(width: 120, alignment: .leading)
            Text("Arriving")
            .frame(width: 100, alignment: .leading)
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
                .frame(width: 140, alignment: .leading)
                
                VStack(alignment: .leading) {
                    Text(stationNameParser(name: commons.departingStation.stationName))
                    Text(getStoppingTime(timetable: connection.timeTableRows, stationCode: commons.departingStation.stationShortCode))
                    Text("Platform: " + getPlatform(timetable: connection.timeTableRows, stationCode: commons.departingStation.stationShortCode))
                }
                .frame(width: 120, alignment: .leading)
                
                VStack(alignment: .leading) {
                    Text(stationNameParser(name: commons.destinationStation.stationName))
                    Text(getStoppingTime(timetable: connection.timeTableRows, stationCode: commons.destinationStation.stationShortCode))
                    Text("Platform: " + getPlatform(timetable: connection.timeTableRows, stationCode: commons.destinationStation.stationShortCode))
                }
                .frame(width: 90, alignment: .leading)
                Image(systemName: "chevron.right")
                .foregroundColor(Color("bg_dark_green"))
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
