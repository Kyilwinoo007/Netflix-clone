//
//  TitleCollectionViewCell.swift
//  Netflix Clone
//
//  Created by boss1234 on 08/10/2022.
//

import UIKit
import SDWebImage

class TitleCollectionViewCell: UICollectionViewCell {

    static let identifier = "TitleCollectionViewCell"
    private let imageUrl = "https://image.tmdb.org/t/p/w500/"
    let posterView:UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFill
        return imageView
    }()
    required init?(coder: NSCoder) {
        fatalError()
    }
    override init(frame: CGRect) {
        super.init(frame: frame)
        contentView.addSubview(posterView)
    }
    override func layoutSubviews() {
        super.layoutSubviews()
        posterView.frame = contentView.bounds
    }
    public func configure(with model:String){
        guard let url = URL(string: self.imageUrl + model) else {return}
        posterView.sd_setImage(with: url,completed: nil)
    }
}
