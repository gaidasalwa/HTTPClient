
import Foundation
import Alamofire

protocol HTTPClientProtocol {
    func sendRequest<T: Decodable>(to url: URL, method: HTTPMethod, body: Data?) async throws -> T
}

final class HTTPClient: HTTPClientProtocol {
    public init() {}
    
    func sendRequest<T: Decodable>(to url: URL, method: HTTPMethod, body: Data?) async throws -> T {
        var urlRequest = URLRequest(url: url)
        urlRequest.httpMethod = method.rawValue
        urlRequest.setValue("application/json", forHTTPHeaderField: "Content-Type")
        
        if let body = body {
            urlRequest.httpBody = body
        }
        
        let request = AF.request(urlRequest)
        
        let data = try await withCheckedThrowingContinuation { continuation in
            request.responseData { response in
                switch response.result {
                case .success(let data):
                    if let jsonString = String(data: data, encoding: .utf8) {
                        print("🔍 JSON reçu : \(jsonString)")
                    }
                    continuation.resume(returning: data)
                case .failure(let error):
                    continuation.resume(throwing: error)
                }
            }
        }
        
        do {
            return try JSONDecoder().decode(T.self, from: data)
        } catch {
            print("❌ Erreur de décodage : \(error)")
            
        }
    }
}
