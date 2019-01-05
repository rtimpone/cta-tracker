//
//  RequestHandlers.swift
//  CTATracker
//
//  Created by Rob Timpone on 1/5/19.
//  Copyright © 2019 Rob Timpone. All rights reserved.
//

import CTAKit
import Foundation

enum RequestHandlerResult<T> {
    case success([T])
    case error
}

class StatusRequestHandler {
    
    static let linesToShow = ["Red Line", "Brown Line", "Purple Line"]
    
    static func requestTrainStatus(completion: @escaping (RequestHandlerResult<TrainLine>) -> Void) {
        
        CtaClient().getTrainLines() { result in
            switch result {
            case .success(let lines):
                let filteredLines = lines.filter { self.linesToShow.contains($0.title) }
                completion(.success(filteredLines))
            case .failure(_):
                completion(.error)
            }
        }
    }
}
