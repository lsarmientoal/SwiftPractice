//
//  ApiServices.swift
//  ToolboxApp
//
//  Created by Laura Sarmiento Almanza on 10/13/19.
//  Copyright © 2019 Laura Sarmiento Almanza. All rights reserved.
//

import Foundation
import Moya
import RxSwift

protocol ApiServicesType {
    func request(to target: ToolboxApiTarget) -> Observable<Response>
    func request(imageUrl url: URL) -> Observable<UIImage>
}

let provider = MoyaProvider<ToolboxApiTarget>()
private let queue = DispatchQueue(label: "com.toolbox.ios.api.services", qos: .userInitiated)
private var disposable: Disposable?

struct ApiServices: ApiServicesType {
    
    func request(to target: ToolboxApiTarget) -> Observable<Response> {
        provider.rx.request(target)
            .subscribeOn(ConcurrentDispatchQueueScheduler(queue: queue))
            .observeOn(MainScheduler.instance)
            .retryWhenFailAuth()
            .asObservable()
    }
    
    func request(imageUrl url: URL) -> Observable<UIImage> {
        Observable<UIImage>.create { (observer: AnyObserver<UIImage>) -> Disposable in
            
            let configuration: URLSessionConfiguration = .default
            configuration.requestCachePolicy = .reloadIgnoringLocalAndRemoteCacheData
            let session = URLSession(configuration: configuration)
            
            let task = session.dataTask(with: url, completionHandler: { (data: Data?, response: URLResponse?, error: Error?) in
                if let error = error {
                    observer.on(.error(error))
                    return
                }
                guard
                    (response?.mimeType ?? "").hasPrefix("image"),
                    let data = data,
                    let image = UIImage(data: data)
                    else {
                        observer.on(.error(RxError.noElements))
                        return
                    }
                
                observer.on(.next(image))
                observer.on(.completed)
            })
            task.resume()
            return Disposables.create {
                task.cancel()
            }
        }
        .observeOn(MainScheduler.instance)
    }
}

extension PrimitiveSequence where Trait == SingleTrait, Element == Response {
    
    func retryWhenFailAuth() -> PrimitiveSequence<SingleTrait, Response> {
        filterSuccessfulStatusCodes()
            .retryWhen { (observable: Observable<Error>) -> Observable<AuthToken> in
                observable.flatMapLatest { (error: Error) -> Observable<AuthToken> in
                    if case MoyaError.statusCode(let response) = error,
                    response.statusCode == 401 || response.statusCode == 403 {
                        return Api.services.request(to: .authorization)
                            .mapObject(AuthToken.self)
                            .do(onNext: { (token :AuthToken) in
                                UserDefaults.standard.set(token.token, forKey: "authToken")
                                
                                UserDefaults.standard.set(token.type, forKey: "authType")
                            })
                    }
                    return Observable<AuthToken>.error(error)
                }
        }
    }
}

