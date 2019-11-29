//
//  ContactDetailView.swift
//  lydiaApp
//
//  Created by Yanis Soto on 28/11/2019.
//  Copyright © 2019 Yanis Soto. All rights reserved.
//

import UIKit

final class ContactDetailView: UIView {
    
    private let data: ContactDetailViewModelProtocol
    
    private(set) var contactImageView: UIImageView!
    private var nameView: UILabel!
    private var phoneStack: UIStackView!
    private var birthdayStack: UIStackView!
    private var emailStack: UIStackView!
    
    init(with data: ContactDetailViewModelProtocol) {
        self.data = data
        super.init(frame: .zero)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setSubviews() {
        self.backgroundColor = .white
        self.contactImageView = self.createImageView()
        self.nameView = self.createInfoNameView()
        self.phoneStack = self.createPhoneStackView()
        self.birthdayStack = self.createBirthDayStackView()
        self.emailStack = self.createEmailStackView()
    }
    
    private func createImageView() -> UIImageView {
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        self.addSubview(imageView)
        NSLayoutConstraint.activate([
            imageView.centerXAnchor.constraint(equalTo: self.centerXAnchor),
            imageView.topAnchor.constraint(equalTo: self.safeAreaLayoutGuide.topAnchor, constant: 10),
            imageView.widthAnchor.constraint(equalToConstant: 200),
            imageView.heightAnchor.constraint(equalToConstant: 200)
        ])
        return imageView
    }
    
    private func createInfoNameView() -> UILabel {
        let label = self.createLabelmainTitle(self.data.firstName + " " + self.data.lastName)
        self.addSubview(label)
        label.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            label.topAnchor.constraint(equalTo: self.contactImageView.bottomAnchor, constant: 20),
            label.centerXAnchor.constraint(equalTo: self.centerXAnchor)
        ])
        return label
    }
    
    private func createPhoneStackView() -> UIStackView {
        let subViews = [
                  self.createLabelTitle("Phone number:"),
                  self.createLabelsubTitle(self.data.phone)
              ]
              
              let stackView = UIStackView(arrangedSubviews: subViews)
              stackView.axis = .vertical
              stackView.distribution = .equalSpacing
              stackView.spacing = 10
              self.addSubview(stackView)

              stackView.translatesAutoresizingMaskIntoConstraints = false
              NSLayoutConstraint.activate([
                  stackView.topAnchor.constraint(equalTo: self.nameView.bottomAnchor, constant: 20),
                  stackView.leadingAnchor.constraint(equalTo: self.leadingAnchor,constant: 20),
                  stackView.trailingAnchor.constraint(equalTo: self.trailingAnchor)
              ])
              return stackView
    }
    
    private func createBirthDayStackView() -> UIStackView {
           let subViews = [
               self.createLabelTitle("Birthday:"),
               self.createLabelsubTitle(self.data.birthDay)
           ]
           
           let stackView = UIStackView(arrangedSubviews: subViews)
           stackView.axis = .vertical
           stackView.distribution = .equalSpacing
           stackView.spacing = 10
           self.addSubview(stackView)

           stackView.translatesAutoresizingMaskIntoConstraints = false
           NSLayoutConstraint.activate([
               stackView.topAnchor.constraint(equalTo: self.phoneStack.bottomAnchor, constant: 20),
               stackView.leadingAnchor.constraint(equalTo: self.leadingAnchor,constant: 20),
               stackView.trailingAnchor.constraint(equalTo: self.trailingAnchor)
           ])
           return stackView
       }
    
    
    private func createEmailStackView() -> UIStackView {
        let subViews = [
            self.createLabelTitle("Email:"),
            self.createLabelsubTitle(self.data.email)
        ]
        
        let stackView = UIStackView(arrangedSubviews: subViews)
        stackView.axis = .vertical
        stackView.distribution = .equalSpacing
        stackView.spacing = 10
        self.addSubview(stackView)

        stackView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            stackView.topAnchor.constraint(equalTo: self.birthdayStack.bottomAnchor, constant: 20),
            stackView.leadingAnchor.constraint(equalTo: self.leadingAnchor,constant: 20),
            stackView.trailingAnchor.constraint(equalTo: self.trailingAnchor)
        ])
        return stackView
    }
    
    private func createSeparator() {
        let view = UIView()
        view.backgroundColor = .lightGray
    }
    
    private func createLabelTitle(_ title: String) -> UILabel {
        let label = UILabel()
        label.text = title
        label.attributedText = .labelTitle(with: title)
        return label
    }
    
    private func createLabelsubTitle(_ title: String) -> UILabel {
        let label = UILabel()
        label.text = title
        label.attributedText = .labelSubtitle(with: title)
        return label
    }
    
    private func createLabelmainTitle(_ title: String) -> UILabel {
        let label = UILabel()
        label.text = title
        label.attributedText = .mainTitle(with: title)
        return label
    }
}
