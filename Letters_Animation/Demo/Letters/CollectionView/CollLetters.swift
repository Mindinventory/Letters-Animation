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

// MARK: - Configure -
extension CollLetters {

    private func configure() {

        dataSource = self
        delegate = self
        register(LettersCell.nib, forCellWithReuseIdentifier: LettersCell.identifier)
    }
}

// MARK: - UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout Methods -
extension CollLetters: UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout {

    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return smallletterImages.count
    }

    func collectionView(_ collectionView: UICollectionView,
                        cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {

        if let smallLettersCell = collectionView.dequeueReusableCell(withReuseIdentifier: LettersCell.identifier,
                                                                     for: indexPath) as? LettersCell {
            let data = smallletterImages[indexPath.row]
            smallLettersCell.configureCell(img: data.image)
            return smallLettersCell
        }
        return UICollectionViewCell()
    }

    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        tapCount += 1
        animateSelectedLetter(indexpath: indexPath)
    }

    // MARK: - FlowLayout Methods 
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout,
                        sizeForItemAt indexPath: IndexPath) -> CGSize {
        let size = (CScreenWidth * (148/414) / 2) - 38
        return CGSize(width: size, height: size)
    }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout,
                        minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 14
    }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout,
                        minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 29
    }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout,
                        insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsets(top: 22, left: 24, bottom: 18, right: 24)
    }
}

// MARK: - Animation Methods -
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

        animateViews(views: (animate: vcLetters.vwAnimate1, fromVw: vcLetters.vw2),
                     views2: (vcLetters.view, smallLettersMatching: vcLetters.vwSmallLettersMatching),
                     imgs: (imgBigLetter: vcLetters.imgBigLetter1, image: image),
                     lbls: (lblLetterMeaning: vcLetters.lblLetterMeaning1,
                            vcLetters.constLetterMeaning1Leading), frameToConvert: frame)
    }

    // Animate Second Letter
    private func animateSecondLetter(vcLetters: LettersVC, frame: CGRect, image: UIImage) {

        animateViews(views: (animate: vcLetters.vwAnimate2, fromVw: vcLetters.vw2),
                     views2: (vcLetters.view, smallLettersMatching: vcLetters.vwSmallLettersMatching),
                     imgs: (imgBigLetter: vcLetters.imgBigLetter2, image: image),
                     lbls: (lblLetterMeaning: vcLetters.lblLetterMeaning2,
                            vcLetters.constLetterMeaning2Leading), frameToConvert: frame)
    }

    // Animation
    private func animateViews(views: (animate: UIView, fromVw: UIView),
                              views2: (vcView: UIView, smallLettersMatching: UIView),
                              imgs: (imgBigLetter: UIImageView, image: UIImage),
                              lbls: (lblLetterMeaning: UILabel, constLetterMeaningLeading: NSLayoutConstraint),
                              frameToConvert: CGRect) {

        // Initial setup before animation
        views.animate.isHidden = false
        imgs.imgBigLetter.isHidden = true

        let imgView = UIImageView(image: imgs.image)

        views.animate.frame = self.superview?.convert(frameToConvert, from: self) ?? CGRect()
        imgView.frame = CGRect(x: 0, y: 0, width: views.animate.frame.width,
                               height: views.animate.frame.height)
        views.animate.addSubview(imgView)

        // Start animation
        UIView.animate(withDuration: 1.0, delay: 0.2, options: .curveEaseInOut, animations: {
            views.animate.frame = views2.smallLettersMatching.superview?.convert(imgs.imgBigLetter.frame,
                                                                                 from: views.fromVw) ?? CGRect()
            imgView.frame = CGRect(x: 0, y: 0, width: views.animate.frame.width,
                                   height: views.animate.frame.height)
            views2.vcView.layoutIfNeeded()
        }, completion: { _ in

            // On Completion
            lbls.lblLetterMeaning.isHidden = false
            imgs.imgBigLetter.isHidden = false
            imgs.imgBigLetter.image = imgView.image
            views.animate.subviews.forEach { $0.removeFromSuperview() }
            views.animate.isHidden = true

            UIView.animate(withDuration: 1, delay: 0, options: .curveEaseInOut, animations: {
                lbls.constLetterMeaningLeading.constant = 3
                views2.vcView.layoutIfNeeded()
            }, completion: { [weak self] _ in
                self?.isUserInteractionEnabled = true
            })
        })
    }
}
