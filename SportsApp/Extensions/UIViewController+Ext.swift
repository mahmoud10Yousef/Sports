//
//  UIViewController+Ext.swift
//  SportsApp
//
//  Created by Mahmoud Ghoneim on 3/1/22.
//

import UIKit
import ProgressHUD
import SafariServices

extension UIViewController{
    
    func openURL(_ urlString: String) {
        
        var strUrl : String = urlString
        
        if !strUrl.lowercased().hasPrefix("http://") || !strUrl.lowercased().hasPrefix("https://") {
            if(strUrl != ""){strUrl = "https://\(strUrl)"}
        }
        guard let url = URL(string: strUrl) else {
            ProgressHUD.showError("Invalid URL")
            return
        }
        let safariViewController = SFSafariViewController(url: url)
        self.present(safariViewController, animated: true)
        
    }
}
