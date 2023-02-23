//
//  MainCollectionViewController.swift
//  alamofireApp
//
//  Created by Айдар Нуркин on 19.02.2023.
//

import UIKit

class MainViewController: UIViewController {
    var cities: [City] = []
    private var shouldEndEditing = true
    @IBOutlet weak var textField: UITextField! {
        didSet {
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
        }
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        textField.delegate = self
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(hideKeyboard))
        view.addGestureRecognizer(tapGesture)
        
        
    }
    @IBAction func ThreeDotsItemAction(_ sender: Any) {
        
    }
}


// MARK: TextField Delegate
extension MainViewController: UITextFieldDelegate {
    
    @objc func hideKeyboard(){
        view.endEditing(true)
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        shouldEndEditing = false
        textField.resignFirstResponder()
        if let text = textField.text {
            addNewCity(text)
            print(text)
        }
        return true
    }
    
    func textFieldDidEndEditing(_ textField: UITextField, reason: UITextField.DidEndEditingReason) {
        if shouldEndEditing {
            if let text = textField.text {
                addNewCity(text)
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
        collectionView.reloadItems(at: [indexPath])
        return cell
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let width = collectionView.bounds.width
        let height = collectionView.bounds.height / 6
        return CGSize(width: width, height: height)
    }
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return cities.count
    }
    func addNewCity(_ text: String) {
        guard let text = textField.text else { return }
        cities.append(City(name: text,
                           temp_min: "15",
                           temp_max: "15",
                           temp: "23"))
        
    }
}
