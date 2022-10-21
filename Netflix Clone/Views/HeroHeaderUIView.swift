//
//  HeroHeaderUIView.swift
//  Netflix Clone
//
//  Created by boss1234 on 25/09/2022.
//

import UIKit

class HeroHeaderUIView: UIView {

    let downloadButton :UIButton = {
       let button = UIButton()
        button.setTitle("Download", for: .normal)
        button.layer.borderWidth = 1.5
        button.layer.cornerRadius = 5
        button.layer.borderColor = UIColor.white.cgColor
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    let playButton : UIButton = {
       let button = UIButton()
        button.setTitle("Play", for: .normal)
        button.layer.borderColor = UIColor.white.cgColor
        button.layer.borderWidth = 1.5
        button.layer.cornerRadius = 5
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    let heroImageView :UIImageView = {
      let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFill
        imageView.clipsToBounds = true
        imageView.image = UIImage(named: "dog")
        return imageView
    }()
   
    override func layoutSubviews() {
        super.layoutSubviews()
        heroImageView.frame = bounds

    }
    override init(frame: CGRect) {
        super.init(frame: frame)
        addSubview(heroImageView)
        addGradient()
        addSubview(playButton)
        addSubview(downloadButton)
        applyConstraints()
    }
    required init?(coder: NSCoder) {
        fatalError()
    }
    private func addGradient(){
        let gradient = CAGradientLayer()
        gradient.colors = [
            UIColor.clear.cgColor,
            UIColor.black.cgColor
        ]
        gradient.frame = bounds
        layer.addSublayer(gradient)
    }
    private func applyConstraints(){
        let constraint = [
            playButton.leadingAnchor.constraint(equalTo: leadingAnchor,constant: 70),
            playButton.bottomAnchor.constraint(equalTo: bottomAnchor,constant: -30),
            playButton.widthAnchor.constraint(equalToConstant: 120)
        ]
        let downloadConstraint = [
            downloadButton.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -70),
            downloadButton.bottomAnchor.constraint(equalTo: bottomAnchor,constant: -30),
            downloadButton.widthAnchor.constraint(equalToConstant: 120)
        ]
        NSLayoutConstraint.activate(constraint)
        NSLayoutConstraint.activate(downloadConstraint)
    }

}
