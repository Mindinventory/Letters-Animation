//
//  LettersAnimation.swift
//  Kids_Animation
//
//  Created by mind-288 on 7/29/21.
//

import UIKit

extension LettersVC {
    
    func animateViews(btnBack: UIButton, lblSmallLetters: UILabel, lblMatch: UILabel, constBtnBackTop: NSLayoutConstraint, constCollSmallLettersTop: NSLayoutConstraint, constCollSmallLettersBottom: NSLayoutConstraint, collSmallLetters: CollLetters, lettersData: [SmallLetters]) {
        
        UIView.animate(withDuration: 1.0, delay: 0.1, options: .curveEaseInOut, animations: { [weak self] in
            
            guard let `self` = self else { return }
            
            btnBack.setAlphaValue(alpha: 1)
            lblSmallLetters.setAlphaValue(alpha: 1)
            lblMatch.setAlphaValue(alpha: 1)
            constBtnBackTop.constant = 11
            constCollSmallLettersTop.constant = 0
            constCollSmallLettersBottom.priority = .defaultHigh
            
            self.view.layoutIfNeeded()
            
            self.animateSmallLettersCollectionView(collSmallLetters: collSmallLetters, lettersData: lettersData)
            
        }, completion: nil)
    }
    
    // Animate and reload CollectionView
    func animateSmallLettersCollectionView(collSmallLetters: CollLetters, lettersData: [SmallLetters]) {
        
        UIView.animate(withDuration: 1, delay: 0.2, options: .curveEaseInOut, animations: {
            
            collSmallLetters.smallletterImages = lettersData
            collSmallLetters.reloadData()
            
        }, completion: nil)
    }
}
