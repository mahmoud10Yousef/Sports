//
//  CustomTabBarController.swift
//  SportsApp
//
//  Created by Mahmoud Ghoneim on 4/5/22.
//

import UIKit

class CustomTabBarController: UITabBarController {

    override func viewDidLoad() {
        super.viewDidLoad()
      
        self.tabBar.tintColor           = #colorLiteral(red: 0.2714514434, green: 0.4364624619, blue: 0.8446493149, alpha: 1)
        self.tabBar.layer.cornerRadius  = 30
        self.tabBar.layer.masksToBounds = true
        self.tabBar.layer.maskedCorners = [.layerMinXMinYCorner , .layerMaxXMinYCorner]
        self.tabBar.selectionIndicatorImage = UIImage(named: "selectedImage")?.withTintColor(#colorLiteral(red: 0.2714514434, green: 0.4364624619, blue: 0.8446493149, alpha: 1), renderingMode: .alwaysOriginal)
        self.additionalSafeAreaInsets.bottom = 10
        
    }
    

   

}
