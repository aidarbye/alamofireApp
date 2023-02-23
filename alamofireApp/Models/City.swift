
struct City: Decodable {
    let name: String?
    let temp_min: Double?
    let temp_max: Double?
    let temp: Double?
    
    init(from city: [String:Any]) {
        let main = city["main"] as! [String: Any]
        temp_max = main["temp_max"] as? Double
        temp_min = main["temp_min"] as? Double
        name = city["name"] as? String
        temp = main["temp"] as? Double
    }
}
