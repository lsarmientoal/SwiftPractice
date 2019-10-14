//
//  MovieCollectionViewCell.swift
//  ToolboxApp
//
//  Created by Laura Sarmiento Almanza on 10/13/19.
//  Copyright © 2019 Laura Sarmiento Almanza. All rights reserved.
//

import UIKit

class MovieCollectionViewCell: UICollectionViewCell {

    @IBOutlet weak var titleImageLabel: UILabel!
    @IBOutlet weak var imageView: UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
    }
    
    func setUpCell(item: Movie.Item) {
        if let itemImage = item.imageUrl.toUrl() {
            imageView.setImage(with: itemImage)
                .subscribe()
                .disposed(by: disposeBag)
        }
        titleImageLabel.text = item.title
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        titleImageLabel.text = ""
        imageView.image = nil
    }
}
