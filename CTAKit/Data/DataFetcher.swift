//
//  DataFetcher.swift
//  CTAKit
//
//  Created by Rob Timpone on 1/30/19.
//  Copyright © 2019 Rob Timpone. All rights reserved.
//

import Foundation

public class DataFetcher {
    
    static func decodeObject<T: Decodable>(ofType type: T.Type, fromFileNamed fileName: String, ofType fileType: String) -> T {
        let data = dataForFile(named: fileName, ofType: fileType)
        let decoder = JSONDecoder()
        return try! decoder.decode(T.self, from: data)
    }
}

private extension DataFetcher {
    
    static func dataForFile(named fileName: String, ofType fileType: String) -> Data {
        let bundle = Bundle(for: self)
        let path = bundle.path(forResource: fileName, ofType: fileType)!
        return FileManager.default.contents(atPath: path)!
    }
}
