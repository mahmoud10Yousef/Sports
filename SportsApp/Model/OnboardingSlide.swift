//
//  OnboardingSlide.swift
//  SportsApp
//
//  Created by Mahmoud Ghoneim on 3/8/22.
//

import UIKit


struct OnboardingSlide {
    
    let image       : UIImage
    let title       : String
    let description : String
    
    
    static func getSlides() -> [OnboardingSlide] {
        return [OnboardingSlide(image: .add, title: "", description: "")]
    }
    
    
}
