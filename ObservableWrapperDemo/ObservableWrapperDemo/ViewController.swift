//
//  ViewController.swift
//  ObservableWrapperDemo
//
//  Created by Piotr Błachewicz on 17/02/2019.
//  Copyright © 2019 Piotr Błachewicz. All rights reserved.
//

import UIKit
import ObservableWrapper

class ViewController: UIViewController {

    @IBOutlet weak var textField: UITextField!
    @IBOutlet weak var stopObserverButton: UIButton!
    
    let user = User(name: "unknown")
    
    var observer: Observer? = Observer()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        textField.delegate = self
        textField.returnKeyType = .done
        
        user.name.addObserver(observer!) { (name, change) in
            print("User's name is (\(name))")
        }
    }

    //MARK: - Button Action
    
    @IBAction func stopObservingButtonTap(_ sender: Any) {
        observer = nil
    }
}

//MARK: - Text Field Delegate

extension ViewController: UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        user.name.value = textField.text ?? ""
        
        textField.resignFirstResponder()
        return true
    }
}

//MARK: - Observer

/// Observer which does not rely on 'Foundation'
public class Observer {}

//MARK: - User

class User {
    let name: Observable<String>
    
    init(name: String) {
        self.name = Observable(name)
    }
}
