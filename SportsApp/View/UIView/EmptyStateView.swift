//
//  EmptyStateView.swift
//  SportsApp
//
//  Created by Mahmoud Ghoneim on 3/10/22.
//

import UIKit
import Lottie

class EmptyStateView: UIView {

    
    @IBOutlet  var animationView: AnimationView!
    @IBOutlet weak var messageLabel: UILabel!
    
    var message : String!
    var iconName: String!
    
    init(lottieName: String , message:String) {
        super.init(frame: .zero)
        self.iconName = lottieName
        self.message  = message
        configureUI(iconName: self.iconName, message: self.message)
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
    
    
    
    private func configureUI(iconName:String,message:String){
       // messageLabel.text = message
        animationView = .init(name: iconName)
        animationView?.frame = self.bounds
        self.addSubview(animationView)
        animationView?.animationSpeed = 1
        animationView?.play()
    }
    

}
