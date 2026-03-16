//
//  NetworkManager.swift
//  CairYuk
//
//  Created by David Jones on 2026/3/8.
//

import Foundation
import Alamofire

enum NetworkError: Error {
    case invalidURL
    case noData
}

let h5_url = "http://8.215.5.252:10903"
let base_url = "http://8.215.5.252:10903/breviency"

final class NetworkManager {
    
    static let shared = NetworkManager()
    
    private init() {}
    
    func get<T: Codable>(
        url: String,
        parameters: [String: Any]? = nil,
        headers: HTTPHeaders? = nil
    ) async throws -> T {
        
        let apiUrl = self.createRequestUrl(baseUrl: base_url + url)
        
        guard let url = apiUrl else {
            throw NetworkError.invalidURL
        }
        
        let request = AF.request(
            url,
            method: .get,
            parameters: parameters,
            encoding: URLEncoding.default,
            headers: headers,
            requestModifier: { $0.timeoutInterval = 10 }
        )
        
        return try await request.serializingDecodable(T.self).value
    }
    
    func post<T: Codable>(
        url: String,
        parameters: [String: Any],
        headers: HTTPHeaders? = nil
    ) async throws -> T {
        
        let apiUrl = self.createRequestUrl(baseUrl: base_url + url)
        
        guard let url = apiUrl else {
            throw NetworkError.invalidURL
        }
        
        return try await withCheckedThrowingContinuation { continuation in
            
            AF.upload(
                multipartFormData: { formData in
                    
                    for (key, value) in parameters {
                        
                        let data = "\(value)".data(using: .utf8)!
                        formData.append(data, withName: key)
                    }
                    
                },
                to: url,
                method: .post,
                headers: headers,
                requestModifier: { $0.timeoutInterval = 30 }
            )
            .responseDecodable(of: T.self) { response in
                
                switch response.result {
                    
                case .success(let value):
                    continuation.resume(returning: value)
                    
                case .failure(let error):
                    continuation.resume(throwing: error)
                }
            }
        }
    }
    
    func postWithImage<T: Decodable>(
        url: String,
        parameters: [String: Any],
        images: [UIImage],
        imageKey: String = "emotions",
        headers: HTTPHeaders? = nil
    ) async throws -> T {
        
        let apiUrl = self.createRequestUrl(baseUrl: base_url + url)
        
        guard let url = apiUrl else {
            throw NetworkError.invalidURL
        }
        
        return try await withCheckedThrowingContinuation { continuation in
            
            AF.upload(
                multipartFormData: { formData in
                    
                    for (key, value) in parameters {
                        
                        let data = "\(value)".data(using: .utf8)!
                        formData.append(data, withName: key)
                    }
                    
                    for (index, image) in images.enumerated() {
                        
                        if let data = image.jpegData(compressionQuality: 0.9) {
                            
                            formData.append(
                                data,
                                withName: imageKey,
                                fileName: "image\(index).jpg",
                                mimeType: "image/jpeg"
                            )
                        }
                    }
                    
                },
                to: url,
                method: .post,
                headers: headers,
                requestModifier: { $0.timeoutInterval = 30 }
            )
            .responseDecodable(of: T.self) { response in
                
                switch response.result {
                    
                case .success(let value):
                    continuation.resume(returning: value)
                    
                case .failure(let error):
                    continuation.resume(throwing: error)
                }
            }
        }
    }
}

extension NetworkManager {
    
    func createRequestUrl(baseUrl: String) -> URL? {
        let parameters = DeviceInfoCollector().collectAllParameters()
        
        guard var components = URLComponents(string: baseUrl) else { return nil }
        
        components.queryItems = parameters.map { URLQueryItem(name: $0.key, value: $0.value) }
        
        return components.url
    }
    
}
