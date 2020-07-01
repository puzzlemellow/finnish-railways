import Foundation

func filteredByPassengerAvailability(stations: [Station]) -> [Station] {
    stations.filter { $0.passengerTraffic }
}

func stationNameParser(name: String) -> String {
    name.replacingOccurrences(of: " asema", with: "")
}
