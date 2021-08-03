//
//  VocabSmallLettersVC.swift
//  Kids_Animation
//
//  Created by mind-288 on 7/15/21.
//

import UIKit

final class LettersVC: UIViewController {

    // MARK: - IBOutlet
    @IBOutlet weak var vwAnimate2: UIView!
    @IBOutlet weak var vwAnimate1: UIView!
    @IBOutlet weak var vw2: UIView!
    @IBOutlet weak var vwSmallLettersMatching: UIView!
    @IBOutlet weak var lblLetterMeaning1: UILabel!
    @IBOutlet weak var lblLetterMeaning2: UILabel!
    @IBOutlet weak var imgBigLetter2: UIImageView!
    @IBOutlet weak var imgBigLetter1: UIImageView!
    @IBOutlet weak private var btnBack: UIButton!
    @IBOutlet weak private var lblSmallLetters: UILabel!
    @IBOutlet weak private var lblMatch: UILabel!
    @IBOutlet weak var collSmallLetters: CollLetters!
    @IBOutlet weak private var constCollSmallLettersTop: NSLayoutConstraint!
    @IBOutlet weak private var constBtnBackLeading: NSLayoutConstraint!
    @IBOutlet weak private var constBtnBackTop: NSLayoutConstraint!
    @IBOutlet weak private var constCollSmallLettersWidth: NSLayoutConstraint!
    @IBOutlet weak private var constCollSmallLettersBottom: NSLayoutConstraint!
    @IBOutlet weak var constLetterMeaning2Leading: NSLayoutConstraint!
    @IBOutlet weak var constLetterMeaning1Leading: NSLayoutConstraint!

    // MARK: - Properties
    let smallLettersData = [SmallLetters(image: UIImage(named: "ic_bigA") ?? UIImage()),
                            SmallLetters(image: UIImage(named: "ic_smallB") ?? UIImage()),
                            SmallLetters(image: UIImage(named: "ic_smallC") ?? UIImage()),
                            SmallLetters(image: UIImage(named: "ic_smallD") ?? UIImage()),
                            SmallLetters(image: UIImage(named: "ic_BigE") ?? UIImage()),
                            SmallLetters(image: UIImage(named: "ic_smallF") ?? UIImage()),
                            SmallLetters(image: UIImage(named: "ic_smallG") ?? UIImage()),
                            SmallLetters(image: UIImage(named: "ic_smallH") ?? UIImage()),
                            SmallLetters(image: UIImage(named: "ic_smallI") ?? UIImage()),
                            SmallLetters(image: UIImage(named: "ic_smallJ") ?? UIImage()),
                            SmallLetters(image: UIImage(named: "ic_smallK") ?? UIImage()),
                            SmallLetters(image: UIImage(named: "ic_smallL") ?? UIImage()),
                            SmallLetters(image: UIImage(named: "ic_smallM") ?? UIImage()),
                            SmallLetters(image: UIImage(named: "ic_smallN") ?? UIImage()),
                            SmallLetters(image: UIImage(named: "ic_smallO") ?? UIImage()),
                            SmallLetters(image: UIImage(named: "ic_smallP") ?? UIImage()),
                            SmallLetters(image: UIImage(named: "ic_smallQ") ?? UIImage()),
                            SmallLetters(image: UIImage(named: "ic_smallR") ?? UIImage()),
                            SmallLetters(image: UIImage(named: "ic_smallS") ?? UIImage()),
                            SmallLetters(image: UIImage(named: "ic_smallT") ?? UIImage()),
                            SmallLetters(image: UIImage(named: "ic_smallU") ?? UIImage()),
                            SmallLetters(image: UIImage(named: "ic_smallV") ?? UIImage()),
                            SmallLetters(image: UIImage(named: "ic_smallW") ?? UIImage()),
                            SmallLetters(image: UIImage(named: "ic_smallX") ?? UIImage()),
                            SmallLetters(image: UIImage(named: "ic_smallY") ?? UIImage()),
                            SmallLetters(image: UIImage(named: "ic_smallZ") ?? UIImage())]

    // MARK: - ViewLifeCycle Methods
    override func viewDidLoad() {
        super.viewDidLoad()

        configure()
        setConstraints()
    }
}

// MARK: - Configure -
extension LettersVC {

    // Configure Views
    private func configure() {

        lblSmallLetters.changeFontSize(size: CScreenWidth * (36/414), weight: .regular)
        lblMatch.changeFontSize(size: CScreenWidth * (20/414), weight: .light)
        lblLetterMeaning1.changeFontSize(size: CScreenWidth * (30/414), weight: .regular)
        lblLetterMeaning2.changeFontSize(size: CScreenWidth * (30/414), weight: .regular)
        setAttributedTextOnLables()

        btnBack.setAlphaValue(alpha: 0)
        lblSmallLetters.setAlphaValue(alpha: 0)
        lblMatch.setAlphaValue(alpha: 0)

        constBtnBackTop.constant = 150
        constCollSmallLettersTop.constant = CScreenHeight
        constCollSmallLettersBottom.priority = .defaultLow

        configureLettersMeaningsViews()

        CMainThread.asyncAfter(deadline: .now() + 0.1, execute: {
            self.animateViews(btnBack: self.btnBack, lblSmallLetters: self.lblSmallLetters,
                              lblMatch: self.lblMatch, collSmallLettersBottom: self.constCollSmallLettersBottom, constraint: (btnBackTop: self.constBtnBackTop, collSmallLettersTop: self.constCollSmallLettersTop))
        })
    }

    // Set Constraints
    private func setConstraints() {

        constBtnBackLeading.constant = CScreenWidth * (30/414)
        constCollSmallLettersWidth.constant = CScreenWidth * (148/414)
    }

    // Set Attributed Texts on Labels
    private func setAttributedTextOnLables() {

        let attrStr1 = NSMutableAttributedString(string: lblLetterMeaning1.text ?? "")
        attrStr1.addAttribute(.foregroundColor, value: UIColor.init(red: 255/255,
                                                                    green: 111/255, blue: 77/255, alpha: 1),
                              range: NSRange(location: 1, length: 1))
        attrStr1.addAttribute(.foregroundColor, value: UIColor.init(red: 255/255,
                                                                    green: 179/255, blue: 87/255, alpha: 1),
                              range: NSRange(location: 5, length: 3))
        attrStr1.addAttribute(.font, value: UIFont.systemFont(ofSize: CScreenWidth * (30/414),
                                                              weight: .black), range: NSRange(location: 1, length: 1))
        lblLetterMeaning1.attributedText = attrStr1
        
        let attrStr2 = NSMutableAttributedString(string: lblLetterMeaning2.text ?? "")
        attrStr2.addAttribute(.foregroundColor, value: UIColor.init(red: 151/255,
                                                                    green: 107/255, blue: 207/255, alpha: 1),
                              range: NSRange(location: 1, length: 1))
        attrStr2.addAttribute(.foregroundColor, value: UIColor.init(red: 234/255,
                                                                    green: 91/255, blue: 112/255, alpha: 1),
                              range: NSRange(location: 5, length: 3))
        attrStr2.addAttribute(.font, value: UIFont.systemFont(ofSize: CScreenWidth * (30/414),
                                                              weight: .black), range: NSRange(location: 1, length: 1))
        lblLetterMeaning2.attributedText = attrStr2
    }

    private func configureLettersMeaningsViews() {

        imgBigLetter1.isHidden = true
        imgBigLetter2.isHidden = true
        lblLetterMeaning1.isHidden = true
        lblLetterMeaning2.isHidden = true
    }
}

// MARK: - Button's Actions -
extension LettersVC {

    @IBAction private func onBack(_ sender: UIButton) {
        self.navigationController?.popViewController(animated: true)
    }
}
