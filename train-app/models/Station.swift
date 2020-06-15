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
