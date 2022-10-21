//
//  UpCommingTableViewCell.swift
//  Netflix Clone
//
//  Created by boss1234 on 12/10/2022.
//

import UIKit

class TitleTableViewCell: UITableViewCell {
    static let identifier = "TitleTableViewCell"
    private let imageUrl = "https://image.tmdb.org/t/p/w500/"

    
    private let playTitleButton :UIButton = {
        let button = UIButton()
        let image = UIImage(systemName: "play.circle",withConfiguration: UIImage.SymbolConfiguration(pointSize: 30))
        button.setImage(image, for: .normal)
        button.tintColor = .label
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    private let titleLabel :UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    private let titlePosterUIImageView:UIImageView = {
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.contentMode = .scaleAspectFill
        imageView.clipsToBounds = true
        return imageView
    }()
    required init?(coder: NSCoder) {
        fatalError()
    }
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        contentView.addSubview(titlePosterUIImageView)
        contentView.addSubview(titleLabel)
        contentView.addSubview(playTitleButton)
        applyConstraints()

    }
    override func layoutSubviews() {
        super.layoutSubviews()
        titlePosterUIImageView.frame = contentView.bounds
        titleLabel.frame = contentView.bounds
    }

    private func applyConstraints(){
        let titlePosterUIImageViewConstraints = [
            titlePosterUIImageView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            titlePosterUIImageView.topAnchor.constraint(equalTo: contentView.topAnchor,constant: 5),
            titlePosterUIImageView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor,constant: -5),
            titlePosterUIImageView.widthAnchor.constraint(equalToConstant: 100)
        ]
        let titleLabelConstraints = [
            titleLabel.leadingAnchor.constraint(equalTo: titlePosterUIImageView.trailingAnchor,constant: 20),
            titleLabel.centerYAnchor.constraint(equalTo: contentView.centerYAnchor)
        ]
        let titlePlayButtonConstraints = [
            playTitleButton.trailingAnchor.constraint(equalTo: contentView.trailingAnchor,constant: -15),
            playTitleButton.centerYAnchor.constraint(equalTo: contentView.centerYAnchor)
        ]
        NSLayoutConstraint.activate(titlePosterUIImageViewConstraints)
        NSLayoutConstraint.activate(titleLabelConstraints)
        NSLayoutConstraint.activate(titlePlayButtonConstraints)
    }
    public func configure(with model:TitleViewModel){
        guard let url = URL(string: self.imageUrl + model.postUrl) else {return}
        titlePosterUIImageView.sd_setImage(with: url,completed: nil)
        titleLabel.text = model.titleName
        
    }
}
