//
//  Views+Utils.swift
//  Pokedex
//
//  Created by Laura Sarmiento Almanza on 10/13/19.
//  Copyright © 2019 Laura Sarmiento Almanza. All rights reserved.
//

import Foundation
import UIKit
import RxSwift

protocol TransitionApplicable {}

extension TransitionApplicable where Self: UIView {
    
    func transition(_ callback: @escaping (Self) -> Void) {
        
        UIView.transition(with: self, duration: 0.33, options: [.curveEaseInOut, .transitionCrossDissolve], animations: {
            callback(self)
        }, completion: nil)
    }
}

extension UIView: TransitionApplicable {}

extension UIImageView {
    
    func setImage(with url: URL) -> Observable<UIImage> {
        Api.services.request(imageUrl: url)
            .do(onNext: { [weak self] (image: UIImage) in
                self?.image = image
            })
    }
}
