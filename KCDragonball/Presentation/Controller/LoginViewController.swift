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
        guard let email = emailTextField.text else {
            return
        }
        guard let password = passwordTextField.text else {
            return
        }
        NetworkModel.shared.login(user: email, password: password) { result in
            switch result {
            case .success(_):
                DispatchQueue.main.async {
                    let navigation = UINavigationController()
                    let heroesListViewController = HeroesListViewController()
                    navigation.viewControllers = [heroesListViewController]
                    
                    navigation.navigationBar.topItem?.title = "Heroes"
                    navigation.navigationBar.tintColor = .black
            
                    self.view.window?.rootViewController = navigation
                    self.view.window?.makeKeyAndVisible()
                }
            case let .failure(error):
                print(error)
            }
        }
        
    }
    
}
