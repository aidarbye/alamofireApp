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
        tempOfTheCity.text = "\(String(format:"%.1f", city.temp!))"
        maxTempOfTheCity.text = "Макс:\(String(format:"%.1f",city.temp_max!))"
        minTempOfTheCity.text = "Мин:\(String(format:"%.1f",city.temp_min!))"
    }
    
}
