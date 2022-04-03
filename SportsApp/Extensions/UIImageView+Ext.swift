//
//  UIImageView+Ext.swift
//  SportsApp
//
//  Created by Mahmoud Ghoneim on 2/28/22.
//

import UIKit
import Kingfisher

extension UIImageView{
    
    func  setImage(with url : String){
        guard let url = URL(string: url) else { return }
        let placeHolderImage = UIImage(named: "sportsLogo")
        kf.indicatorType = .activity
        self.kf.setImage(with: url, placeholder: placeHolderImage, options: [.transition(.fade(1))])
    }
    
}

