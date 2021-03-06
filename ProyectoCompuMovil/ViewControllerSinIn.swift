//
//  ViewControllerSinIn.swift
//  ProyectoCompuMovil
//  Copyright © 2018 Gerardo Castillo. All rights reserved.
//

import UIKit
import RealmSwift

class ViewControllerSinIn: UIViewController, UINavigationControllerDelegate, UIImagePickerControllerDelegate {
    
    var imageData = Data()
    var userTemp = User()
    @IBOutlet weak var imgPerfil: UIImageView!
    

    @IBOutlet weak var lblUser: UITextField!
    
    
    
    @IBOutlet weak var lblLastName: UITextField!
    @IBOutlet weak var lblName: UITextField!
    
    @IBOutlet weak var lblAddres: UITextField!
    
    @IBOutlet weak var lblPayment: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    


    @IBAction func btnSignIn(_ sender: UIButton) {
       if (lblUser.text != "" && lblName.text != "" && lblLastName.text != "" && lblAddres.text != "" && lblPayment.text != "") {
        
            userTemp.imagePerfil = imageData
        
           userTemp.user = lblUser.text!
           userTemp.name = lblName.text!
            userTemp.lastName = lblLastName.text!
            userTemp.Addres = lblAddres.text!
            userTemp.paymentMethod = lblPayment.text!
            // Get the default Realm
        let config = Realm.Configuration(
            schemaVersion: 2,
            migrationBlock: { migration, oldSchemaVersion in
        })
        Realm.Configuration.defaultConfiguration = config
           let realm = try! Realm()
//            // Persist your data easily
           try! realm.write {
               realm.add(userTemp)
           }
            lblUser.text = ""
            lblName.text = ""
            lblLastName.text = ""
            lblAddres.text = ""
            lblPayment.text = ""
            imgPerfil.image = UIImage(named: "foto-perfil")
        let alertController = UIAlertController(title: "Succes", message: "Tu registro fue exitoso", preferredStyle: .alert)
        
        let action1 = UIAlertAction(title: "Aceptar", style: .default) { (action:UIAlertAction) in
        }
        alertController.addAction(action1)
        self.present(alertController, animated: true, completion: nil)
  
          

                }else{
        let alertController = UIAlertController(title: "Llenar todos los campos", message: "Vuelve a Intentarlo", preferredStyle: .alert)
        
        let action1 = UIAlertAction(title: "Aceptar", style: .default) { (action:UIAlertAction) in
        }
        alertController.addAction(action1)
        self.present(alertController, animated: true, completion: nil)
        
            }

    }
    
    @IBAction func gstAction(_ sender: UITapGestureRecognizer) {
        
        let image = UIImagePickerController()
        image.delegate = self
        
        image.sourceType = UIImagePickerControllerSourceType.photoLibrary
        
        image.allowsEditing = false
        
        self.present(image, animated: true)
        {
            //After it is complete
        }
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any])
    {
        if let image = info[UIImagePickerControllerOriginalImage] as? UIImage
        {
            imgPerfil.image = image
            imageData =  UIImagePNGRepresentation(image)!
        }
        else
        {
            let alertController = UIAlertController(title: "Imagen muy pesada", message: "Intenta con otra imagen", preferredStyle: .alert)
            
            let action1 = UIAlertAction(title: "Aceptar", style: .default) { (action:UIAlertAction) in
            }
            alertController.addAction(action1)
            self.present(alertController, animated: true, completion: nil)
        }
        
        self.dismiss(animated: true, completion: nil)
    }
}
