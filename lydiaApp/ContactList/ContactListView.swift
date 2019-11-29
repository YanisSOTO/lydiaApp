//
//  ContactListView.swift
//  lydiaApp
//
//  Created by Yanis Soto on 27/11/2019.
//  Copyright © 2019 Yanis Soto. All rights reserved.
//

import UIKit

protocol ContactListViewDelegate: class {
    func goToDetailView(didSelectAt index: Int)
}

final class ContactListView: UIView {
    private(set) var tableView: UITableView!
    weak var delegate: ContactListViewDelegate?
    private var activityIndicator: UIActivityIndicatorView!


    func setSubviews() {
        self.backgroundColor = .white
        self.tableView = self.createTableView()
        self.activityIndicator = self.createActivityIndicator()
    }
    
    private func createTableView() -> UITableView {
        let tableView = UITableView(frame: .zero,style: .grouped)
        tableView.register(ContactCell.self,
                    forCellReuseIdentifier: "ContactCellIdentifier")
        tableView.backgroundColor = .clear
        tableView.delegate = self
        tableView.separatorInset = .zero
        tableView.translatesAutoresizingMaskIntoConstraints = false
        self.addSubview(tableView)
        NSLayoutConstraint.activate([
            tableView.leadingAnchor.constraint(equalTo: self.leadingAnchor),
            tableView.trailingAnchor.constraint(equalTo: self.trailingAnchor),
            tableView.bottomAnchor.constraint(equalTo: self.safeAreaLayoutGuide.bottomAnchor),
            tableView.topAnchor.constraint(equalTo: self.safeAreaLayoutGuide.topAnchor)
        ])
        return tableView
    }
    
    private func createActivityIndicator() -> UIActivityIndicatorView {
        let activityIndicator = UIActivityIndicatorView(style: .medium)
        activityIndicator.color = .black
        activityIndicator.translatesAutoresizingMaskIntoConstraints = false
        self.addSubview(activityIndicator)
        NSLayoutConstraint.activate([
            activityIndicator.centerXAnchor.constraint(equalTo: self.centerXAnchor),
            activityIndicator.centerYAnchor.constraint(equalTo: self.centerYAnchor)
        ])
        return activityIndicator
    }
    
    func setViewState(_ state: LoadingViewState) {
        switch state {
        case .finished:
            tableView.isHidden = false
            activityIndicator.stopAnimating()
        case .error:
            tableView.isHidden = true
            activityIndicator.stopAnimating()
        case .loading:
            activityIndicator.startAnimating()
            tableView.isHidden = true
        }
    }
}

extension ContactListView: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 80
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        self.delegate?.goToDetailView(didSelectAt: indexPath.row)
    }
}
