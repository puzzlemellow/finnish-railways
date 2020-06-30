import Foundation

class CommonState: ObservableObject {
    /*
     Current search options
     */
    @Published var departingStation: Station = PLACEHOLDER_STATION
    @Published var destinationStation: Station = PLACEHOLDER_STATION
}
