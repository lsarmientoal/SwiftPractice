//
//  Rx+Utils.swift
//  Pokedex
//
//  Created by Laura Sarmiento Almanza on 10/13/19.
//  Copyright © 2019 Laura Sarmiento Almanza. All rights reserved.
//

import RxSwift

extension NSObject {

    private struct AssociatedKeys {
        static var DisposeBagKey = "bnd_DisposeBagKey"
        static var AssociatedObservablesKey = "bnd_AssociatedObservablesKey"
    }

    // A dispose bag will will dispose upon object deinit.
    var disposeBag: DisposeBag {
        get {
            if let disposeBag = objc_getAssociatedObject(self, &AssociatedKeys.DisposeBagKey)  as? DisposeBag {
                return disposeBag
            } else {
                let disposeBag = DisposeBag()
                objc_setAssociatedObject(self, &AssociatedKeys.DisposeBagKey, disposeBag, objc_AssociationPolicy.OBJC_ASSOCIATION_RETAIN_NONATOMIC)
                return disposeBag
            }
        }
        set {
            objc_setAssociatedObject(self, &AssociatedKeys.DisposeBagKey, newValue, objc_AssociationPolicy.OBJC_ASSOCIATION_RETAIN_NONATOMIC)
        }
    }
}
