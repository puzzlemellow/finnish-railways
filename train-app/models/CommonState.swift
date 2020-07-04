import Foundation

class CommonState: ObservableObject {
    
    init()
    {
        departingStation = PLACEHOLDER_STATION
        destinationStation = PLACEHOLDER_STATION
        
        let date = Date()
        let calendar = Calendar.current
        
        day = calendar.component(.day, from: date)
        month = calendar.component(.month, from: date)
    }
    
    /*
     Current search options
     */
    @Published var departingStation: Station
    @Published var destinationStation: Station
    
    /*
     Search date
     */
    @Published var day: Int
    @Published var month: Int
    
}
