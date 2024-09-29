//
//  LoginViewController.swift
//  KCDragonball
//
//  Created by José Antonio Aravena on 29-09-24.
//

import UIKit

class LoginViewController: UIViewController {
    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    @IBOutlet weak var button: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        emailTextField.placeholder = "Goku@dragonball.com"
        passwordTextField.placeholder = "Contraseña"
        button.setTitle("Continuar", for: .normal)
    }
    @IBAction func didPressButton(_ sender: Any) {
        let heroesListViewController = HeroesListViewController()
        self.view.window?.rootViewController = heroesListViewController
        self.view.window?.makeKeyAndVisible()
    }
    
}
