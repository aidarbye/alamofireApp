import Alamofire

class NetworkManager {
    func alamofireGet(cityname: String) {
        AF.request("https://api.openweathermap.org/data/2.5/weather?q=\(cityname)&appid=\(apiKey)")
            .validate()
            .responseJSON { dataResponse in
                switch dataResponse.result {
                case .success(let value):
                    self.cities
                }
                
            }
    }
}
