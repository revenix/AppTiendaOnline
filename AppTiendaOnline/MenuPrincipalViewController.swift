//
//  MenuPrincipalViewController.swift
//  AppTiendaOnline
//
//  Created by Moises on 5/30/18.
//  Copyright © 2018 AppTiendaOnline. All rights reserved.
//

import UIKit

class MenuPrincipalViewController: UIViewController {

    @IBOutlet weak var MenuButton: UIBarButtonItem!
    
    @IBOutlet weak var PedidoButton: UIBarButtonItem!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        sideMenu()
        costumizeNavBar()
        
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func sideMenu(){
        if revealViewController() != nil {
            MenuButton.target = revealViewController()
            MenuButton.action = #selector(SWRevealViewController.revealToggle(_ :))
            revealViewController().rearViewRevealWidth = 275
            revealViewController().rightViewRevealWidth = 168
            
            PedidoButton.target = revealViewController()
            PedidoButton.action = #selector(SWRevealViewController.rightRevealToggle(_ :))
            
            view.addGestureRecognizer(self.revealViewController().panGestureRecognizer())
            
        }
        
        
    }
 
    func costumizeNavBar(){
        
        navigationController?.navigationBar.tintColor = UIColor(displayP3Red: 193/255, green: 	151/255, blue: 94/255, alpha: 1)
         navigationController?.navigationBar.barTintColor = UIColor(displayP3Red: 30/255, green: 32/255, blue: 39/255, alpha: 1)

    /*let logo = UIImage(named: "ic_logo_cabecera.png")
        let imageView = UIImageView(image:logo)
        imageView = UIImageView(frame: CGRect(x: 0, y: 0, width: 40, height: 40))
        imageView.contentMode = .scaleAspectFit
        self.navigationItem.titleView = imageView
        */
        
       /* let imageView = UIImageView(frame: CGRect(x: 0, y: 0, width: 30, height: 30))
        imageView.contentMode =  .scaleAspectFit
        let image = UIImage(named: "ic_logo_cabecera.png")
        imageView.image = image
        navigationItem.titleView = imageView
        */
      // navigationController?.navigationBar.backgroundImage(
        
        let navController = navigationController!
        
        let image = UIImage(named: "ic_logo_cabecera.png") //Your logo url here
        let imageView = UIImageView(image: image)
        
        let bannerWidth = navController.navigationBar.frame.size.width
        let bannerHeight = navController.navigationBar.frame.size.height
        
        let bannerX = bannerWidth / 2 - (image?.size.width)! / 2
        let bannerY = bannerHeight / 2 - (image?.size.height)! / 2
        
        imageView.frame = CGRect(x: bannerX, y: bannerY, width: bannerWidth, height: bannerHeight)
        imageView.contentMode = .scaleAspectFit
        
        navigationItem.titleView = imageView
    }

}
