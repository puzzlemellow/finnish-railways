import Foundation

struct Train: Decodable, Hashable {
    struct TimeTableRow: Decodable, Hashable {
        let stationShortCode: String
        let stationUICCode: Int
        let countryCode: String
        let type: String
        let trainStopping: Bool
        let commercialStop: Bool?
        let commercialTrack: String?
        let cancelled: Bool
        let scheduledTime: String?
        let actualTime: String?
        let differenceInMinutes: Int?
    }
    
    let trainNumber: Int
    let departureDate: String
    let operatorUICCode: Int
    let operatorShortCode: String
    let trainType: String
    let trainCategory: String
    let commuterLineID: String?
    let runningCurrently: Bool
    let cancelled: Bool
    let version: Int
    let timeTableRows: [TimeTableRow]
}
