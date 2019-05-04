//
//  BackendService.swift
//  happyhouse
//
//  Copyright © 2019 Depromeet. All rights reserved.
//

import RxSwift
import Alamofire

class BackendService {
    
    // /signIn
    static func signIn(kakaoToken: String) -> Single<User> {
        
        return Single<User>.create { observer in
            let utilityQueue = DispatchQueue.global(qos: .utility)
            
            let call = AF.request(Router.createUser(kakaoToken: kakaoToken))
                .validate()
                .responseData(queue: utilityQueue) { response in
                    guard let data = response.data else {
                        observer(.error(HappyError.unknown))
                        return
                    }
                    
                    let decoder = JSONDecoder()
                    
                    do {
                        let response = try decoder.decode(Response<User>.self, from: data)
                        guard let user = response.result else {
                            observer(.error(HappyError.unknown))
                            return
                        }
                        
                        observer(.success(user))
                    } catch {
                        observer(.error(HappyError.unknown))
                    }
            }
            return Disposables.create() { call.cancel() }
        }
        
    }
}
