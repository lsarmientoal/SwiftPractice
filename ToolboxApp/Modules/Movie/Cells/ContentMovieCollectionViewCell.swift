//
//  ContentMovieCollectionViewCell.swift
//  ToolboxApp
//
//  Created by Laura Sarmiento Almanza on 10/13/19.
//  Copyright © 2019 Laura Sarmiento Almanza. All rights reserved.
//

import UIKit
import RxSwift
import RxCocoa

class ContentMovieCollectionViewCell: UICollectionViewCell {

    @IBOutlet weak var collectionView: UICollectionView! {
        didSet {
            collectionView.register(R.nib.movieCollectionViewCell)
        }
    }
    fileprivate let selectedItem = PublishRelay<Movie.Item>()
    var movie: Movie?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        collectionView.rx.setDelegate(self)
            .disposed(by: disposeBag)
        
        collectionView.rx.modelSelected(Movie.Item.self)
            .bind(to: selectedItem)
            .disposed(by: disposeBag)
    }
    
    func setUpCell(movie: Movie) {
        self.movie = movie
        Observable<[Movie.Item]>.just(movie.items)
            .bind(to: collectionView.rx.items(
                cellIdentifier: R.reuseIdentifier.movieCollectionViewCell.identifier,
                cellType: MovieCollectionViewCell.self)) { (raw: Int, item: Movie.Item, cell: MovieCollectionViewCell) in
                    cell.setUpCell(item: item)
            }
            .disposed(by: disposeBag)
    }

    override func prepareForReuse() {
        super.prepareForReuse()
        disposeBag = DisposeBag()
    }
}

extension ContentMovieCollectionViewCell: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        collectionView.bounds.size.with {
            $0.width = movie?.type == .thumb ? 182.0 : 112.0
        }
    }
}

extension Reactive where Base: ContentMovieCollectionViewCell {
    
    var selectedItem: Observable<Movie.Item> {
        return base.selectedItem.asObservable()
    }
}
