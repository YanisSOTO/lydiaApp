//
//  ContactCell.swift
//  lydiaApp
//
//  Created by Yanis Soto on 27/11/2019.
//  Copyright © 2019 Yanis Soto. All rights reserved.
//

import UIKit

class ContactCell: UITableViewCell {
    private(set) var contactImage: UIImageView!
    private var infoStackView: UIStackView?
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setSubviews()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setData(_ cellData: ContactCellData) {
        infoStackView?.removeFromSuperview()
        infoStackView = createInfoStackView(with: cellData)
    }
    
    // MARK: Private
    private func setSubviews() {
        self.backgroundColor = .clear
        self.contactImage = createPicture()
    }
    
    private func createInfoStackView(with cellData: ContactCellData) -> UIStackView {
        let subviews: [UIView] = [
            createLabel(with: cellData.firstName + " " + cellData.lastName),
            createLabel(with: cellData.phoneNumber)
        ]
        
        let stackView = UIStackView(arrangedSubviews: subviews)
        stackView.axis = .vertical
        stackView.distribution = .equalSpacing
        stackView.spacing = 8.0
        stackView.translatesAutoresizingMaskIntoConstraints = false
        self.contentView.addSubview(stackView)
        NSLayoutConstraint.activate([
            stackView.leadingAnchor.constraint(equalTo: self.contactImage.trailingAnchor,
                                        constant: 10),
            stackView.centerYAnchor.constraint(equalTo: self.contentView.centerYAnchor)
        ])
        
        return stackView
    }
    
    private func createPicture() -> UIImageView {
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        self.contentView.addSubview(imageView)
        NSLayoutConstraint.activate([
            imageView.leadingAnchor.constraint(equalTo: self.contentView.leadingAnchor,
                                        constant: 10),
            imageView.centerYAnchor.constraint(equalTo: self.contentView.centerYAnchor),
            imageView.widthAnchor.constraint(equalToConstant: 56),
            imageView.heightAnchor.constraint(equalToConstant: 56)
        ])
        
        return imageView
    }
    
    private func createLabel(with title: String) -> UILabel {
        let label = UILabel()
        label.text = title
        label.textAlignment = .left
        return label
    }
}
