//
//  MovieWireframe.swift
//  ToolboxApp
//
//  Created by Laura Sarmiento Almanza on 10/13/19.
//  Copyright (c) 2019 Laura Sarmiento Almanza. All rights reserved.
//
//  This file was generated by the 🐍 VIPER generator
//

import UIKit
import AVKit
import AVFoundation

final class MovieWireframe: BaseWireframe {

    // MARK: - Module setup -

    init() {
        let moduleViewController = MovieViewController()
        super.init(viewController: moduleViewController)
        
        let interactor = MovieInteractor()
        interactor.apiService = Api.services
        let presenter = MoviePresenter(view: moduleViewController, interactor: interactor, wireframe: self)
        moduleViewController.presenter = presenter
    }

}

// MARK: - Extensions -

extension MovieWireframe: MovieWireframeInterface {
    func openVideo(url: URL) {
        let player = AVPlayer(url: url)
        let playerViewController = AVPlayerViewController()
        playerViewController.player = player
        navigationController?.present(playerViewController, animated: true) {
            playerViewController.player?.play()
        }
    }
    
    func showErrorMessage(_ message: String) {
        let alert = UIAlertController(title: "Error", message: message, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "Ok", style: .cancel, handler: { (_) in
            alert.dismiss(animated: true, completion: nil)
        }))
        navigationController?.present(alert, animated: true, completion: nil)
    }
}
