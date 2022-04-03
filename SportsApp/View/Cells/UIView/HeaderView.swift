//
//  HeaderView.swift
//  SportsApp
//
//  Created by Mahmoud Ghoneim on 3/1/22.
//

import UIKit

class HeaderView: UICollectionReusableView {
    
    static let reuseID = "HeaderView"
    
    @IBOutlet weak var sectionTitlelabel: UILabel!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    
    func setTitle(title:String){
        sectionTitlelabel.text = title
    }
}
