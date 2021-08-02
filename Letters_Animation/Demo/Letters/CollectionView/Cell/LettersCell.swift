//
//  SmallLettersCell.swift
//  Kids_Animation
//
//  Created by mind-288 on 7/20/21.
//

import UIKit

final class LettersCell: UICollectionViewCell {
    
    @IBOutlet weak private var imgSmallLetters: UIImageView!
}

//MARK:- Configure
//MARK:-
extension LettersCell {
    
    func configureCell(img: UIImage) {
        
        imgSmallLetters.image = img
    }
}
