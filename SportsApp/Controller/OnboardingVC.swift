//
//  OnboardingCollectionView.swift
//  SportsApp
//
//  Created by Mahmoud Ghoneim on 3/8/22.
//

import UIKit



class OnboardingVC: UIViewController {
    
    @IBOutlet weak var nextButton: UIButton!
    @IBOutlet weak var pageControl: UIPageControl!
    @IBOutlet weak var collectionView: UICollectionView!
    
    var slides: [OnboardingSlide] = []
    var currentPage = 0 {
        didSet{
            let buttonTitle = (currentPage == slides.count - 1) ? "Get Started" : "Next"
            nextButton.setTitle(buttonTitle, for: .normal)
            pageControl.currentPage = currentPage
        }
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        collectionView.delegate   = self
        collectionView.dataSource = self
        pageControl.currentPage   = currentPage
    }
    
    
    @IBAction func nextButtonClicked(_ sender: UIButton) {
        
        if currentPage == slides.count - 1 {
            // TODO ("Go To Main Screen")
        }else{
            currentPage += 1
            let indexPath = IndexPath(item: currentPage, section: 0)
            collectionView.scrollToItem(at: indexPath, at: .centeredHorizontally, animated: true)
        }
        
    }
    
    
}


extension OnboardingVC : UICollectionViewDelegate,UICollectionViewDataSource{
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        slides.count
    }
    
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: OnboardingCell.reuseID, for: indexPath) as! OnboardingCell
        cell.configureCell(with: slides[indexPath.row])
        return cell
    }
    
    
    func collectionView(_ collectionView: UICollectionView, willDisplay cell: UICollectionViewCell, forItemAt indexPath: IndexPath) {
        pageControl.currentPage = indexPath.item
        currentPage             = indexPath.item
    }
    
}


extension OnboardingVC: UICollectionViewDelegateFlowLayout{
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: collectionView.frame.width, height: collectionView.frame.height)
    }
    
}
