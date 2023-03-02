let apiKey = "3fc3bc971616515ad41319a582373ef9"

struct City: Decodable {
    var name: String?
    var temp_min: Double?
    var temp_max: Double?
    var temp: Double?
    init(name: String?, temp_min:Double?,temp_max:Double?,temp:Double?) {
        self.name = name
        self.temp_min = temp_min
        self.temp_max = temp_max
        self.temp = temp
    }
    init(from city: [String:Any]) {
        let main = city["main"] as! [String: Any]
        temp_max = main["temp_max"] as? Double
        temp_min = main["temp_min"] as? Double
        name = city["name"] as? String
        temp = main["temp"] as? Double
    }
}
