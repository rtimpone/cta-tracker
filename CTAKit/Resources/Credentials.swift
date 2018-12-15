//
//  Credentials.swift
//  CTAKit
//
//  Created by Rob Timpone on 12/15/18.
//  Copyright © 2018 Rob Timpone. All rights reserved.
//

import Foundation

class Credentials {
    
    static let apiKey = file.contents.apiKey
    private static let file = CredentialsFile()
}

private class CredentialsFile {
    
    struct CredentialsFileContents: Decodable {
        var apiKey: String
    }
    
    let contents: CredentialsFileContents
    
    init() {
        
        let bundle = Bundle(for: CredentialsFile.self)
        
        guard let path = bundle.path(forResource: "credentials", ofType: "json") else {
            fatalError("Unable to find path for credentials json file")
        }
        
        do {
            let content = try String(contentsOfFile: path)
            guard let data = content.data(using: .utf8) else {
                fatalError("Unable to convert credentials json file content into utf8 data")
            }
            let decoder = JSONDecoder()
            decoder.keyDecodingStrategy = .convertFromSnakeCase
            contents = try decoder.decode(CredentialsFileContents.self, from: data)
        }
        catch(let error) {
            fatalError("Unable to get extract api key from credentials json file: \(error)")
        }
    }
}
