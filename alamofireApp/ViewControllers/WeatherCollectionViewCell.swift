//
//  WeatherCollectionViewCell.swift
//  alamofireApp
//
//  Created by Айдар Нуркин on 23.02.2023.
//

import UIKit

class WeatherCollectionViewCell: UICollectionViewCell {
    @IBOutlet weak var nameOfTheCity: UILabel!
    @IBOutlet weak var tempOfTheCity: UILabel!
    @IBOutlet weak var maxTempOfTheCity: UILabel!
    @IBOutlet weak var minTempOfTheCity: UILabel!
    override func layoutSubviews() {
        layer.cornerRadius = 23
    }
    func configure(with city: City) {
        nameOfTheCity.text = city.name
        tempOfTheCity.text = "\(String(city.temp!))K"
        maxTempOfTheCity.text = "Макс:\(String(city.temp_max!))K"
        minTempOfTheCity.text = "Мин:\(String(city.temp_min!))K"
    }
    
}
