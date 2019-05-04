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
    
    // /task
    static func createTask(taskName: String, assigneeId: Int) -> Single<HouseWork> {
        
        return Single<HouseWork>.create { observer in
            let utilityQueue = DispatchQueue.global(qos: .utility)
            
            let call = AF.request(Router.createTask(name: taskName, assigneeId: assigneeId))
                .validate()
                .responseData(queue: utilityQueue) { response in
                    guard let data = response.data else {
                        observer(.error(HappyError.unknown))
                        return
                    }
                    
                    let decoder = JSONDecoder()
                    
                    do {
                        let response = try decoder.decode(Response<HouseWork>.self, from: data)
                        guard let housework = response.result else {
                            observer(.error(HappyError.unknown))
                            return
                        }
                        
                        observer(.success(housework))
                    } catch {
                        observer(.error(HappyError.unknown))
                    }
            }
            return Disposables.create() { call.cancel() }
        }
        
    }
    
    //  sign up for family
    static func createFamily(myId: Int, friendId: Int) -> Single<Family> {
        return Single<Family>.create { observer in
            let utilityQueue = DispatchQueue.global(qos: .utility)
            
            let call = AF.request(Router.createFamily(myId: myId, friendId: friendId))
                .validate()
                .responseData(queue: utilityQueue) { response in
                    guard let data = response.data else {
                        observer(.error(HappyError.unknown))
                        return
                    }
                    
                    let decoder = JSONDecoder()
                    
                    do {
                        let response = try decoder.decode(Response<Family>.self, from: data)
                        guard let family = response.result else {
                            observer(.error(HappyError.unknown))
                            return
                        }
                        
                        observer(.success(family))
                    } catch {
                        observer(.error(HappyError.unknown))
                    }
            }
            return Disposables.create() { call.cancel() }
        }
    }
}
