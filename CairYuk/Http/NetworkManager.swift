//
//  NetworkManager.swift
//  CairYuk
//
//  Created by hekang on 2026/3/8.
//

enum NetworkError: Error {
    case invalidURL
    case noData
}

import Foundation
import Alamofire

final class NetworkManager {
    
    static let shared = NetworkManager()
    
    private init() {}
    
    func get<T: Codable>(
        url: String,
        parameters: [String: Any]? = nil,
        headers: HTTPHeaders? = nil
    ) async throws -> T {
        
        guard let url = URL(string: url) else {
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
        
        guard let url = URL(string: url) else {
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
        
        guard let url = URL(string: url) else {
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
                        
                        if let data = image.jpegData(compressionQuality: 0.8) {
                            
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
