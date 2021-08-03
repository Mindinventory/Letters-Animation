//
//  CollSmallLetters.swift
//  Kids_Animation
//
//  Created by mind-288 on 7/20/21.
//

import UIKit

final class CollLetters: UICollectionView {
    
    var smallletterImages = [SmallLetters]()
    
    private var tapCount = 0
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        configure()
    }
}

//MARK: - Configure
//MARK: -
extension CollLetters {
    
    private func configure() {
        
        dataSource = self
        delegate = self
        register(LettersCell.nib, forCellWithReuseIdentifier: LettersCell.identifier)
    }
}

//MARK: - UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout Methods
//MARK: -
extension CollLetters: UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        
        return smallletterImages.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        if let SmallLettersCell = collectionView.dequeueReusableCell(withReuseIdentifier: LettersCell.identifier, for: indexPath) as? LettersCell {
            
            let data = smallletterImages[indexPath.row]
            SmallLettersCell.configureCell(img: data.image)
            
            return SmallLettersCell
        }
        return UICollectionViewCell()
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        tapCount += 1
        animateSelectedLetter(indexpath: indexPath)
    }
    
    //MARK: FlowLayout Methods
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        let size = (CScreenWidth * (148/414) / 2) - 38
        return CGSize(width: size, height: size)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        
        return 14
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        
        return 29
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        
        return UIEdgeInsets(top: 22, left: 24, bottom: 18, right: 24)
    }
}

//MARK: - Animation Methods
//MARK: -
extension CollLetters {
    
    // Animate Selected Letter accrording to Selection / Tap count
    private func animateSelectedLetter(indexpath: IndexPath) {
        
        let image = smallletterImages[indexpath.row].image
        
        if let lettersCell = self.cellForItem(at: indexpath) as? LettersCell {
            
            if let vocabLettersVC = UIApplication.topViewController() as? LettersVC {
                
                if tapCount % 2 != 0 {
                    
                    self.isUserInteractionEnabled = false
                    vocabLettersVC.lblLetterMeaning1.isHidden = true
                    vocabLettersVC.constLetterMeaning1Leading.constant = -380
                    animateFirstLetter(vcLetters: vocabLettersVC, frame: lettersCell.frame, image: image)
                    
                } else {
                    
                    self.isUserInteractionEnabled = false
                    vocabLettersVC.lblLetterMeaning2.isHidden = true
                    vocabLettersVC.constLetterMeaning2Leading.constant = -380
                    animateSecondLetter(vcLetters: vocabLettersVC, frame: lettersCell.frame, image: image)
                }
            }
        }
    }
    
    // Animate First Letter
    private func animateFirstLetter(vcLetters: LettersVC, frame: CGRect, image: UIImage) {
        
        animateViews(vwAnimate: vcLetters.vwAnimate1, fromVw: vcLetters.vw2, vcView: vcLetters.view,
                     vwSmallLettersMatching: vcLetters.vwSmallLettersMatching, imgBigLetter: vcLetters.imgBigLetter1,
                     image: image, lblLetterMeaning: vcLetters.lblLetterMeaning1, frameToConvert: frame,
                     constLetterMeaningLeading: vcLetters.constLetterMeaning1Leading)
    }
    
    // Animate Second Letter
    private func animateSecondLetter(vcLetters: LettersVC, frame: CGRect, image: UIImage) {
        
        animateViews(vwAnimate: vcLetters.vwAnimate2, fromVw: vcLetters.vw2, vcView: vcLetters.view,
                     vwSmallLettersMatching: vcLetters.vwSmallLettersMatching, imgBigLetter: vcLetters.imgBigLetter2,
                     image: image, lblLetterMeaning: vcLetters.lblLetterMeaning2, frameToConvert: frame,
                     constLetterMeaningLeading: vcLetters.constLetterMeaning2Leading)
    }
    
    // Animation
    private func animateViews(vwAnimate: UIView, fromVw: UIView, vcView: UIView,
                              vwSmallLettersMatching: UIView, imgBigLetter: UIImageView,
                              image: UIImage, lblLetterMeaning: UILabel, frameToConvert: CGRect,
                              constLetterMeaningLeading: NSLayoutConstraint) {
        
        // Initial setup before animation
        vwAnimate.isHidden = false
        imgBigLetter.isHidden = true
        
        let imgView = UIImageView(image: image)
        
        vwAnimate.frame = self.superview?.convert(frameToConvert, from: self) ?? CGRect()
        imgView.frame = CGRect(x: 0, y: 0, width: vwAnimate.frame.width, height: vwAnimate.frame.height)
        vwAnimate.addSubview(imgView)
        
        // Start animation
        UIView.animate(withDuration: 1.0, delay: 0.2, options: .curveEaseInOut, animations: {
            
            vwAnimate.frame = vwSmallLettersMatching.superview?.convert(imgBigLetter.frame, from: fromVw) ?? CGRect()
            imgView.frame = CGRect(x: 0, y: 0, width: vwAnimate.frame.width, height: vwAnimate.frame.height)
            
            vcView.layoutIfNeeded()
            
        }, completion: { _ in
            
            // On Completion
            lblLetterMeaning.isHidden = false
            imgBigLetter.isHidden = false
            imgBigLetter.image = imgView.image
            vwAnimate.subviews.forEach { $0.removeFromSuperview() }
            vwAnimate.isHidden = true
            
            UIView.animate(withDuration: 1, delay: 0, options: .curveEaseInOut, animations: {
                
                constLetterMeaningLeading.constant = 3
                vcView.layoutIfNeeded()
                
            }, completion: { [weak self] _ in
                
                self?.isUserInteractionEnabled = true
            })
        })
    }
}
