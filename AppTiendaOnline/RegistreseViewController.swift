//
//  RegistreseViewController.swift
//  AppTiendaOnline
//
//  Created by Moises on 5/30/18.
//  Copyright © 2018 AppTiendaOnline. All rights reserved.
//

import UIKit
import CoreData
import Alamofire




class RegistreseViewController: UIViewController {

    
    @IBOutlet weak var txtDNI: UITextField!
    @IBOutlet weak var txtNombre: UITextField!
    @IBOutlet weak var txtApellido: UITextField!
    @IBOutlet weak var txtDireccion: UITextField!
    @IBOutlet weak var txtCorreo: UITextField!
    @IBOutlet weak var txtClave: UITextField!
    @IBOutlet weak var txtClaveConfir: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func Registrar() {
        
        let userEmail = txtCorreo.text
        
        let dni = txtDNI.text
        
        if txtClave.text != txtClaveConfir.text{
            
            let ventana = UIAlertController(title: "Error", message: "Claves no Coinciden",preferredStyle: .alert 	)
            let accionOk = UIAlertAction(title: "Aceptar", style: .default, handler: nil)
            ventana.addAction(accionOk)
            self.present(ventana, animated: true, completion: nil)
        }
        else
        {
            if ( isOnlyNumbers(string: dni! ) == true  ){
                
                if ( isValidEmail(string: userEmail! ) == true  ){
                    //llamada al servicio Rest
                    
                    var url = "https://mongoios-services.azurewebsites.net/api/usuarios"
                    var parametros:Parameters = ["dni":txtDNI.text,"nombre":txtNombre.text,"apellido":txtApellido.text,
                    "direccion":txtDireccion.text,"correo":txtCorreo.text,"clave":txtClave.text]
                    
                    request(url, method: .post, parameters: parametros, encoding: JSONEncoding.default	, headers: nil).responseJSON(completionHandler:{(resultado) in
                        
                            switch(resultado.result)
                            {
                            case .success(let value):
                                self.mostrardialogo(titulo:"Aviso", mensaje: "usuario registrado correctamente")
                                self.dismiss(animated: true, completion: nil)
                                
                            case .failure(let error):
                                self.mostrardialogo(titulo: "Error", mensaje: "Error al registra usuario")
                        }
                            
                    })
                    
                }else{
                    
                   self.mostrardialogo(titulo: "Error", mensaje: "ingresar correo valido")
                    
                   
                }
            }else{
                self.mostrardialogo(titulo: "Error", mensaje: "Ingresar DNI valido")
             
            }
            
        }
        
        
    }
    
    @IBAction func Regresar() {
        
        dismiss(animated: true, completion: nil)
        
    }
    
    func mostrardialogo(titulo:String,mensaje:String){
        let ventana = UIAlertController(title:titulo, message: mensaje,preferredStyle: .alert     )
        let accionOk = UIAlertAction(title: "Aceptar", style: .default, handler: nil)
        ventana.addAction(accionOk)
        self.present(ventana, animated: true, completion: nil)
    }
    
   
     func isOnlyNumbers(string: String) -> Bool {
        return NSPredicate(format: "SELF MATCHES %@", "\\d{8}").evaluate(with: string)
    }
    
     func isValidEmail(string: String) -> Bool {
        let emailReg = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,}"
        let emailTest = NSPredicate(format:"SELF MATCHES %@", emailReg)
        return emailTest.evaluate(with: string)
    }
    
    
    /* let delegado = UIApplication.shared.delegate as! AppDelegate
     let contexto = delegado.persistentContainer.viewContext
     //let contexto = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
     let entidad = NSEntityDescription.insertNewObject(forEntityName: "Usuarios", into: contexto)
     entidad.setValue(txtDNI.text, forKey: "dni")
     entidad.setValue(txtNombre.text, forKey: "nombre")
     entidad.setValue(txtApellido.text, forKey: "apellido")
     entidad.setValue(txtDireccion.text, forKey: "direccion")
     entidad.setValue(txtCorreo.text, forKey: "correo")
     entidad.setValue(txtClave.text, forKey: "clave")
     do{
     if ( isOnlyNumbers(string: dni! ) == true  ){
     
     if ( isValidEmail(string: userEmail! ) == true  ){
     
     try contexto.save()
     dismiss(animated:true, completion: nil)
     
     
     }else{
     let ventana = UIAlertController(title: "Error", message: "Ingresar Correo Valido",preferredStyle: .alert     )
     let accionOk = UIAlertAction(title: "Aceptar", style: .default, handler: nil)
     ventana.addAction(accionOk)
     self.present(ventana, animated: true, completion: nil)
     }
     }else{
     let ventana = UIAlertController(title: "Error", message: "Ingresar DNI valido",preferredStyle: .alert     )
     let accionOk = UIAlertAction(title: "Aceptar", style: .default, handler: nil)
     ventana.addAction(accionOk)
     self.present(ventana, animated: true, completion: nil)
     }
     }catch{
     let ventana = UIAlertController(title: "Error", message: "Error al Registrar al usuario",preferredStyle: .alert     )
     let accionOk = UIAlertAction(title: "Aceptar", style: .default, handler: nil)
     ventana.addAction(accionOk)
     self.present(ventana, animated: true, completion: nil)
     }
     */
}



