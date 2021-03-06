//
//  APIClient.swift
//  CTAKit
//
//  Created by Rob Timpone on 12/15/18.
//  Copyright © 2018 Rob Timpone. All rights reserved.
//

import Foundation

infix operator -=>

func -=><T>(result: ApiResult<T>, completion: @escaping ApiCompletionBlock<T>) {
    DispatchQueue.main.async {
        completion(result)
    }
}

public enum ApiResult<T> {
    case success(T)
    case failure(ApiError)
}

public enum ApiError : Error {
    case notFound
    case serverError(Int)
    case requestError
    case responseFormatInvalid(String)
    case connectionError(Error)
    case invalidData
}

typealias ApiCompletionBlock<T: Decodable> = (ApiResult<T>) -> Void

public class ApiClient {
    
    let session: URLSession
    let jsonDecoder: JSONDecoder
    let logger: ApiLogger
    
    public init(session: URLSession = .shared, jsonDecoder: JSONDecoder = JSONDecoder(), logger: ApiLogger = ConsoleApiLogger()) {
        self.session = session
        self.jsonDecoder = jsonDecoder
        self.logger = logger
    }
    
    func fetchObject<T: Decodable>(ofType type: T.Type, from url: URL, completion: @escaping ApiCompletionBlock<T>) {
        
        let request = URLRequest(url: url)
        let task = session.dataTask(with: request) { data, response, error in
            
            if let error = error {
                self.logger.logHttpResponse(nil, toRequest: request)
                ApiResult.failure(.connectionError(error)) -=> completion
            }
            else {
                let httpResponse = response as! HTTPURLResponse
                self.logger.logHttpResponse(httpResponse, toRequest: request)
                
                switch httpResponse.statusCode {
                case 200:
                    do {
                        let decodedObject = try self.jsonDecoder.decode(type, from: data!)
                        ApiResult.success(decodedObject) -=> completion
                    } catch let error {
                        print(error)
                        let bodyString = String(data: data!, encoding: .utf8)
                        ApiResult.failure(.responseFormatInvalid(bodyString ?? "<no body>")) -=> completion
                    }
                default:
                    ApiResult.failure(.serverError(httpResponse.statusCode)) -=> completion
                }
            }
        }
        task.resume()
    }
}
