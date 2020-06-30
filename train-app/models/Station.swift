import Foundation

/**
 * Station type response.
 * API description: https://rata.digitraffic.fi/swagger/index.html
 */
struct Station: Decodable, Hashable {
    let passengerTraffic: Bool
    let type: Type
    let stationName: String
    let stationShortCode: String
    let stationUICCode: Int
    let countryCode: String
    let longitude: Double
    let latitude: Double
}

enum Type: String, Decodable {
    case STATION, STOPPING_POINT, TURNOUT_IN_THE_OPEN_LINE
    case CUSTOM //flag for custom-made options
}

let PLACEHOLDER_STATION = Station(
    passengerTraffic: false,
    type: Type.CUSTOM,
    stationName: "Select a station",
    stationShortCode: "001",
    stationUICCode: -1,
    countryCode: "N/A",
    longitude: 0.0,
    latitude: 0.0)
