//
//  ViewController.swift
//  ProyectoCompuMovil
//  Copyright © 2018 Gerardo Castillo. All rights reserved.
//

import UIKit
import RealmSwift

class ViewController: UIViewController {
    
    
    @IBOutlet weak var lblPass: UITextField!
    @IBOutlet weak var lblUser: UITextField!
    override func viewDidLoad() {
        super.viewDidLoad()
      
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    @IBAction func btnLogIn(_ sender: UIButton) {
        let config = Realm.Configuration(
            schemaVersion: 2,
            migrationBlock: { migration, oldSchemaVersion in
        })
        Realm.Configuration.defaultConfiguration = config
        let realm = try! Realm()
        
        let user = realm.objects(User.self).filter("user = '\(lblUser.text!)' and lastName = '\(lblPass.text!)'")
       
        if !user.isEmpty{
            UserData.name = user[0].name
            UserData.passwd = user[0].lastName
            UserData.addres = user[0].Addres
            UserData.user = user[0].user
            UserData.paymentmethod = user[0].paymentMethod
            UserData.img = user[0].imagePerfil
           performSegue(withIdentifier: "login", sender: nil)
            
        }else{
            print("Usuario o Contraseña incorrecta")
            let alertController = UIAlertController(title: "Usuario o Contraseña incorrectos", message: "Vuelve a Intentarlo", preferredStyle: .alert)
            
            let action1 = UIAlertAction(title: "Aceptar", style: .default) { (action:UIAlertAction) in
            }
            alertController.addAction(action1)
            self.present(alertController, animated: true, completion: nil)
        }
       
        
    }
    
}

