//
//  LoginViewController.swift
//  AppTiendaOnline
//
//  Created by Moises on 5/30/18.
//  Copyright © 2018 AppTiendaOnline. All rights reserved.
//

import UIKit
import  Alamofire


class LoginViewController: UIViewController {

    
    @IBOutlet weak var txtCorreo: UITextField!
    @IBOutlet weak var txtClave:UITextField!
    
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = UIColor(patternImage: UIImage(named: "menu_bg.jpg")!)
        
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    	
    @IBAction func Ingresar() {
        
        let userEmail = txtCorreo.text
        let userPassword = txtClave.text
        
        var url = "https://mongoios-services.azurewebsites.net/api/usuarios/login"
        var parametros:Parameters = ["correo":userEmail , "clave":userPassword]
        
        if ( isValidEmail(string: userEmail! ) == true  ){
            
            request(url, method: .post, parameters: parametros, encoding: JSONEncoding.default, headers: nil).responseJSON(completionHandler: { (resultado) in
                
                switch(resultado.result) {
                case .failure(let error):
                    self.mostrardialogo(titulo: "Error", mensaje: "error en el servicio")
                case .success(let value):
                 
                    if(resultado.response?.statusCode == 200){
                        self.performSegue(withIdentifier: "segueIrMenu", sender: self)
                    }else{
                      self.mostrardialogo(titulo: "Error", mensaje: "Correo o Clave Incorrecto")
                   
                    }
                    
                }
                
                
            })
            
        }else{
            self.mostrardialogo(titulo: "Error", mensaje:"Correo incorrecto")
          
        }
        
        
    } 
    
    func isValidEmail(string: String) -> Bool {
        let emailReg = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,}"
        let emailTest = NSPredicate(format:"SELF MATCHES %@", emailReg)
        return emailTest.evaluate(with: string)
    }
    
    func mostrardialogo(titulo:String,mensaje:String){
        let ventana = UIAlertController(title:titulo, message: mensaje,preferredStyle: .alert     )
        let accionOk = UIAlertAction(title: "Aceptar", style: .default, handler: nil)
        ventana.addAction(accionOk)
        self.present(ventana, animated: true, completion: nil)
    }
    
}
