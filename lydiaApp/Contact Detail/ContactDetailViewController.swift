//
//  ContactDetailViewController.swift
//  lydiaApp
//
//  Created by Yanis Soto on 28/11/2019.
//  Copyright © 2019 Yanis Soto. All rights reserved.
//

import UIKit
import Nuke

final class ContactDetailViewController: UIViewController {
    
    private let viewModel: ContactDetailViewModelProtocol
    private var mainView: ContactDetailView!
    
    init(viewModel: ContactDetailViewModelProtocol) {
        print("\(type(of: self)): \(#function)")
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    deinit {
        print("\(type(of: self)): \(#function)")
    }
    
    override func loadView() {
        self.mainView = ContactDetailView(with: self.viewModel)
        self.view = mainView
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.mainView.setSubviews()
        self.setImage()
    }
    
    private func setImage() {
        guard let url = self.viewModel.imageContact else { return }
        let request = ImageRequest(
            url: url,
            processors: [ImageProcessor.Circle()],
            priority: .low
        )
        Nuke.loadImage(with: request, options: ImageLoadingOptions(transition: .fadeIn(duration: 0.2)), into: self.mainView.contactImageView)
    }

}
