import Foundation

func filteredByPassengerAvailability(stations: [Station]) -> [Station] {
    stations.filter { $0.passengerTraffic }
}

func stationNameParser(name: String) -> String {
    name.replacingOccurrences(of: " asema", with: "")
}

func getStoppingTime(timetable: [Train.TimeTableRow], stationCode: String) -> String {
    for station in timetable {
        if station.stationShortCode == stationCode {
            guard let time = station.scheduledTime else {
                return "unknown"
            }
            
            let dateFormatter = DateFormatter()
            dateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss.SSS'Z'"
            dateFormatter.timeZone = TimeZone(abbreviation: "UTC")
            
            let dt = dateFormatter.date(from: time)
            dateFormatter.timeZone = TimeZone.current
            dateFormatter.dateFormat = "h:mm a"
            
            return dateFormatter.string(from: dt!)
        }
    }
    
    return "unknown"
}
