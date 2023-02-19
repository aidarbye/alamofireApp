//
//  MainCollectionViewController.swift
//  alamofireApp
//
//  Created by Айдар Нуркин on 19.02.2023.
//

import UIKit
// textField DONE action
class MainViewController: UIViewController {
    // верстка TextFieldа
    @IBOutlet var textField: UITextField! {
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
        }
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    @IBAction func ThreeDotsItemAction(_ sender: Any) {
        
    }
}

