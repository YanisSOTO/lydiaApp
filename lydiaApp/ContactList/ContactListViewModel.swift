//
//  ContactListViewModel.swift
//  lydiaApp
//
//  Created by Yanis Soto on 27/11/2019.
//  Copyright © 2019 Yanis Soto. All rights reserved.
//

import Foundation
import RxSwift
import RxCocoa
import RealmSwift

protocol ContactListViewModelProtocol {
    var apiFetcher: ApiFetcher { get }
    var contactList: Driver<[ContactCellData]> { get }
    func getContactList()
    func getViewModel(at index: Int) -> ContactDetailViewModelProtocol
}

final class ContactListViewModel: ContactListViewModelProtocol {
    
    var apiFetcher = ApiFetcher()
    var contactList: Driver<[ContactCellData]>
    var loadingState: Driver<LoadingViewState>
    
    private var contactListRelay = BehaviorRelay<[Contact]>(value: [])
    private var loadingRelay = BehaviorRelay<Bool>(value: false)
    private let disposeBag = DisposeBag()

    init() {
        self.contactList = .empty()
        self.loadingState = .empty()
        self.fetchFromCache()
        self.setBindings()
    }
    
    private func setBindings() {
        self.contactList = self.contactListRelay
            .map({ $0 as [ContactCellData] })
            .asDriver(onErrorJustReturn: [])
        
        self.loadingState = Observable.combineLatest(loadingRelay, contactListRelay).map { (loading, contactList) -> LoadingViewState in
            if loading {
                return .loading
            } else if contactList.isEmpty {
                return .error
            } else {
                return .finished
            }
        }.distinctUntilChanged().asDriver(onErrorJustReturn: .error)
    }
    
    func getContactList() {
        self.loadingRelay.accept(true)
        self.apiFetcher.getContactList().subscribe(onNext: {[weak self] contactList in
            guard let self = self else { return }
            do {
                let realm = try Realm()
                RContact.cache(contactList: contactList, realm: realm)
                self.loadingRelay.accept(false)
            } catch(let error) {
                print(error)
            }
        }, onError: { [weak self] error in
            guard let self = self else { return }
            print(error)
            self.loadingRelay.accept(false)
        }).disposed(by: self.disposeBag)

    }
    
    private func fetchFromCache() {
        do {
            let realm = try Realm()
            RContact.fetchContact(realm: realm).asObservable().ignoreNil().subscribe(onNext: { [weak self] contactList in
                guard let self = self else { return }
                let sortedC = contactList.sorted(by: { $0.name.first < $1.name.first })
                self.contactListRelay.accept(sortedC)
            }).disposed(by: self.disposeBag)
        } catch {
            print("ERROR : \(type(of: self)): \(#function)")
        }
    }
    
    func getViewModel(at index: Int) -> ContactDetailViewModelProtocol {
        return ContactDetailViewModel(contact: self.contactListRelay.value[index])
    }
}
