//
//  ContactListViewController.swift
//  lydiaApp
//
//  Created by Yanis Soto on 27/11/2019.
//  Copyright © 2019 Yanis Soto. All rights reserved.
//

import UIKit
import RxCocoa
import RxSwift
import Nuke

final class ContactListViewController: UIViewController {
    
    private let viewModel: ContactListViewModel
    private let navigator: MainNavigator
    private var mainView: ContactListView!
    private let disposeBag = DisposeBag()

    init(viewModel: ContactListViewModel = ContactListViewModel(), navigator: MainNavigator) {
        print("\(type(of: self)): \(#function)")
        self.viewModel = viewModel
        self.navigator = navigator
        super.init(nibName: nil, bundle: nil)
    }
    
    deinit {
        print("\(type(of: self)): \(#function)")
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func loadView() {
        self.mainView = ContactListView()
        self.view = mainView
        mainView.delegate = self
    }
    
    override func viewDidLoad() {
        self.mainView.setSubviews()
        self.navigationController?.navigationBar.topItem?.title = "Contacts"
        self.viewModel.getContactList()
        self.setBindings()
    }
    
    private func setBindings() {
        self.viewModel.contactList.drive(mainView.tableView
        .rx
        .items(cellIdentifier: "ContactCellIdentifier", cellType: ContactCell.self)) { index, model, cell in
            cell.setData(model)
            if let url = model.image {
                let request = ImageRequest(
                          url: url,
                          processors: [ImageProcessor.Circle()],
                          priority: .low
                      )
               Nuke.loadImage(with: request, options: ImageLoadingOptions(transition: .fadeIn(duration: 0.2)), into: cell.contactImage)
            }
        }.disposed(by: disposeBag)
        
        self.viewModel.loadingState
            .asObservable()
            .subscribe(onNext: { [weak self] state in
                guard let self = self else { return }
                self.mainView.setViewState(state)
            }).disposed(by: disposeBag)
    }
}

extension ContactListViewController: ContactListViewDelegate {
    func goToDetailView(didSelectAt index: Int) {
        let viewModel = self.viewModel.getViewModel(at: index)
        self.navigator.navigate(to: .contactDetail(viewModel: viewModel))
    }
}
