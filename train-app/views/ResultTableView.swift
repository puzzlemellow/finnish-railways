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
                    ForEach(connections, id: \.self) { connection in
                        Text(connection.trainType)
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
        .foregroundColor(Color("bg_dark_green"))
    }
}

struct ResultTableView_Previews: PreviewProvider {
    static var previews: some View {
        ResultTableView()
        .environmentObject(CommonState())
    }
}
