//
//  LettersAnimation.swift
//  Kids_Animation
//
//  Created by mind-288 on 7/29/21.
//

import UIKit

extension LettersVC {

    func animateViews(btnBack: UIButton, lblSmallLetters: UILabel, lblMatch: UILabel, collSmallLettersBottom: NSLayoutConstraint,
                      constraint: (btnBackTop: NSLayoutConstraint, collSmallLettersTop: NSLayoutConstraint)) {

        UIView.animate(withDuration: 1.0, delay: 0.1, options: .curveEaseInOut, animations: { [weak self] in

            guard let `self` = self else { return }

            btnBack.setAlphaValue(alpha: 1)
            lblSmallLetters.setAlphaValue(alpha: 1)
            lblMatch.setAlphaValue(alpha: 1)
            constraint.btnBackTop.constant = 11
            constraint.collSmallLettersTop.constant = 0
            collSmallLettersBottom.priority = .defaultHigh
            self.view.layoutIfNeeded()
            self.animateSmallLettersCollectionView()
        }, completion: nil)
    }

    // Animate and reload CollectionView
    func animateSmallLettersCollectionView() {

        UIView.animate(withDuration: 1, delay: 0.2, options: .curveEaseInOut, animations: { [weak self] in
            guard let `self` = self else { return }
            self.collSmallLetters.smallletterImages = self.smallLettersData
            self.collSmallLetters.reloadData()
        }, completion: nil)
    }
}
