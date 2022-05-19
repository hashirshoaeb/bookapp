//
//  BookApi.swift
//  bookapp
//
//  Created by Muhammad Hashir Shoaib on 25/04/2022.
//

import Foundation
//import Alamofire


// https://api.nasa.gov/
class API {
    private let apiKey = "GTBYPaYfx79x3DylgwRhFgAgWhRA3NzNCMG8r9av"
    //    let url = "http://openlibrary.org/subjects/love.json"
    let url: String
    
    init(){
        self.url = "https://api.nasa.gov/planetary/apod?api_key=\(apiKey)&start_date=2015-09-07&end_date=2015-10-09"
    }
    
}


extension URLSession {
    // just a wrapper
    func request<T: Codable> (
        url: URL?,
        expecting: T.Type,
        completion: @escaping (Result<T, Error>)-> Void
    ) -> Void {
        guard let url = url else {
            // throw error in completion function
            return
        }
        let task = self.dataTask(with: url) { data, response, error in
            guard let data = data else {
                // call completion with error
                   return
            }
            do {
                let result = try JSONDecoder().decode(T.self, from: data)
                completion(.success(result))
            } catch {
                //  call completion with error
            }
        }
        task.resume()
        
    }
}

