//
//  File.swift
//  StudyPad
//
//  Created by Roman Levinzon on 06/02/2019.
//  Copyright © 2019 Roman Levinzon. All rights reserved.
//

import Foundation
import Alamofire
enum Error {
    
    case network, api(_ message : String), generic
    
    var title: String {
        set {} 
        get {
            switch self {
            case .api:
                return"Server Error"
            case .generic:
                return "Unknown Error"
            default:
                return "Network Error"
            }
        }
    }
    
    
    
}

enum AppResult<T>  {
    case success(_ data: T)
    case failure(_ error: Error)
    
    
    public static func fromDataResponse<T : Codable>(_ response: Data?) -> AppResult<T> {
        if let data = response {
            do {
                let jsonDecoder = JSONDecoder()
                let data = try jsonDecoder.decode(T.self, from: data)
                print(data)
                return .success(data)
                
            } catch {
                print("catch")
                return .failure(.generic)
            }
        } else {
            return .failure(.generic)
        }
    }
    
}
