//
//  Viper.swift
//  ToolboxApp
//
//  Created by Laura Sarmiento Almanza on 10/13/19.
//  Copyright © 2019 Laura Sarmiento Almanza. All rights reserved.
//

import Foundation
import UIKit

protocol WireframeInterface: class {
}

class BaseWireframe {

    private unowned var _viewController: UIViewController

    // To retain view controller reference upon first access
    private var _temporaryStoredViewController: UIViewController?

    init(viewController: UIViewController) {
        _temporaryStoredViewController = viewController
        _viewController = viewController
    }
}

extension BaseWireframe: WireframeInterface {

}

extension BaseWireframe {

    var viewController: UIViewController {
        defer { _temporaryStoredViewController = nil }
        return _viewController
    }

    var navigationController: UINavigationController? {
        viewController.navigationController
    }

}

extension UIViewController {

    func presentWireframe(_ wireframe: BaseWireframe, animated: Bool = true, completion: (()->())? = nil) {
        present(wireframe.viewController, animated: animated, completion: completion)
    }
}

extension UINavigationController {

    func pushWireframe(_ wireframe: BaseWireframe, animated: Bool = true) {
        self.pushViewController(wireframe.viewController, animated: animated)
    }

    func setRootWireframe(_ wireframe: BaseWireframe, animated: Bool = true) {
        self.setViewControllers([wireframe.viewController], animated: animated)
    }
}

protocol ViewInterface: class {
}

protocol InteractorInterface: class {
}

protocol PresenterInterface: class {
}
