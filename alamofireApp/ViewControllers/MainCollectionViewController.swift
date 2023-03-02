//
//  MainCollectionViewController.swift
//  alamofireApp
//
//  Created by Айдар Нуркин on 19.02.2023.
//
import Alamofire
import UIKit

class MainViewController: UIViewController {
    // MARK: Properties
    @IBOutlet weak var MainCollectionView: UICollectionView!
    @IBOutlet weak var textField: UITextField! { didSet { setTextFieldUI() } }
    var cities: [City] = []
    private var Far_or_Cel: Bool = false
    private var shouldEndEditing = true
    private var topMenu = UIMenu()
    // MARK: ViewDidLoad
    override func viewDidLoad() {
        setupMenu()
        setupNavigationBar()
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(hideKeyboard))
        view.addGestureRecognizer(tapGesture)
    }
}
private extension MainViewController {
    func setupMenu() {
        let F = UIAction(title: "Фаренгейты", image: UIImage(systemName: "f.circle")) {_ in
            if self.Far_or_Cel {
                self.Far_or_Cel = false
                var new_cities:[City] = []
                for i in self.cities {
                    let city = City(name: i.name,
                                    temp_min: i.temp_min! + 273.0,
                                    temp_max: i.temp_max! + 273.0,
                                    temp: i.temp! + 273.0)
                    new_cities.append(city)
                }
                self.cities = new_cities
                self.MainCollectionView.reloadData()
            }
        }
        let C = UIAction(title: "Цельсий", image: UIImage(systemName: "c.circle")) {_ in
            if !self.Far_or_Cel {
                self.Far_or_Cel = true
                var new_cities:[City] = []
                for i in self.cities {
                    let city = City(name: i.name,
                                    temp_min: i.temp_min! - 273.0,
                                    temp_max: i.temp_max! - 273.0,
                                    temp: i.temp! - 273.0)
                    new_cities.append(city)
                }
                self.cities = new_cities
                self.MainCollectionView.reloadData()
            }
        }
        let D = UIAction(title: "Удалить",
                         image: UIImage(systemName: "minus.circle"),
                         attributes: .destructive) { _ in
            self.cities = []
            self.MainCollectionView.reloadData()
        }
        topMenu = UIMenu(title: "Options", children: [F,C,D])
    }
    func setupNavigationBar() {
        let barItemRight = UIBarButtonItem(image: UIImage(systemName: "list.bullet"), menu: topMenu)
        navigationItem.rightBarButtonItem = barItemRight
        navigationController?.navigationBar.tintColor = .white
        navigationController?.navigationBar.prefersLargeTitles = true
    }
}
// MARK: TextField Delegate
extension MainViewController: UITextFieldDelegate {
    func setTextFieldUI() {
        let leftImage = UIImageView(frame: CGRect(x: 8,
                                                  y: 12,
                                                  width: 27,
                                                  height: 25))
        leftImage.tintColor = .white
        leftImage.image = UIImage(systemName: "magnifyingglass")
        let leftView = UIView(frame: CGRect(x: 0,
                                            y: 0,
                                            width: 35,
                                            height: 50))
        leftView.addSubview(leftImage)
        textField.leftViewMode = .always
        textField.leftView = leftView
    
        textField.attributedPlaceholder = NSAttributedString(
            string: "Поиск города",
            attributes: [NSAttributedString.Key.foregroundColor: UIColor.gray])
        textField.layer.cornerRadius = 15
        textField.layer.masksToBounds = true
        textField.delegate = self
    }
    @objc func hideKeyboard(){
        view.endEditing(true)
    }
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        shouldEndEditing = false
        textField.resignFirstResponder()
        if let text = textField.text {
            addNewCity(name: text)
            print(text)
        }
        return true
    }
    func textFieldDidEndEditing(_ textField: UITextField, reason: UITextField.DidEndEditingReason) {
        if shouldEndEditing {
            if let text = textField.text {
                addNewCity(name: text)
                print(text)
            }
        }
        shouldEndEditing = true
    }
}
// MARK: Collection Delegate
extension MainViewController: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath) as! WeatherCollectionViewCell
        let city = cities[indexPath.row]
        cell.configure(with: city)
        return cell
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let width = collectionView.bounds.width
        let height = collectionView.bounds.height / 6.5
        return CGSize(width: width, height: height)
    }
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return cities.count
    }
    func addNewCity(name: String) {
        if name != "" {
            alamofireGet(cityname: name)
        }
    }
}
//MARK: Alamofire
extension MainViewController {
    func alamofireGet(cityname: String) {
        AF.request("https://api.openweathermap.org/data/2.5/weather?q=\(cityname)&appid=\(apiKey)")
            .validate()
            .responseJSON { dataResponse in
                switch dataResponse.result {
                case .success(let value):
                    if let json = value as? [String : Any] {
                        var new_city = City(from: json)
                        if self.Far_or_Cel {
                            new_city.temp! -= 273.0
                            new_city.temp_max! -= 273.0
                            new_city.temp_min! -= 273.0
                        }
                        self.cities.append(new_city)
                        DispatchQueue.main.async {
                            self.MainCollectionView.reloadData()
                            self.textField.text = nil
                        }
                        print(new_city)

                    }
                case .failure(let error):
                    print(error)
                    let alert = UIAlertController(title: nil, message: "Wrong", preferredStyle: .alert)
                    let cancel = UIAlertAction(title: "OK", style: .cancel)
                    alert.addAction(cancel)
                    self.present(alert, animated: true)
                    self.textField.text = nil
                    
                }
            }
        }
}
