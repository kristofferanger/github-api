//
//  NetworkManager.swift
//  github-api
//
//  Created by Kristoffer Anger on 2023-02-21.
//

import Foundation


class NetworkManager {
    
    // add your personal data here
    private static let owner = "kristofferanger"
    private static let token = "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"

    // public methods
    static func getRepos(completion: @escaping(Result<[Repo], Error>) -> Void) {
        NetworkManager.getData(endpoint: "/users/\(owner)/repos", completion: completion)
    }

    // constants
    static let baseUrl = "https://api.github.com"
    
    // calculated stuff
    static var headers: [String: String] {
        return ["Accept": "application/vnd.github+json", "Authorization": "Bearer \(token)", "X-GitHub-Api-Version": "2022-11-28"]
    }
    
    static var headerTestRequest: URLRequest {
        return URLRequest(urlString: baseUrl, headers: headers)
    }
    
    // private methods
    private static func getData<T: Decodable>(endpoint: String, parameters: [String: String]? = nil, completion: @escaping(Result<T, Error>) -> Void)  {
        
        let request = URLRequest(urlString: baseUrl + endpoint, method: .get, parameters: parameters, headers: headers, body: nil)
        
        let task = URLSession.shared.dataTask(with: request) { data, response, error in
            guard let data else {
                // return error on main thread
                DispatchQueue.main.async {
                    completion(.failure(error ?? fallbackError(response: response)))
                }
                return
            }
            let result = data.decodedResult(type: T.self)
            // return decoded result on main thread
            DispatchQueue.main.async {
                completion(result)
            }
        }
        task.resume()
    }
    
    private static func fallbackError(response: URLResponse?) -> Error {
        return NSError(domain:"", code: (response as? HTTPURLResponse)?.statusCode ?? NSNotFound, userInfo: nil) as Error
    }
}

// public methods
extension NetworkManager {
    
}


// MARK: - Helpers

fileprivate extension URLRequest {
    
    static let timeoutInterval = TimeInterval(10)
    
    enum Method: String {
        case get = "Get", post = "Post", put = "Put", delete = "Delete"
    }
    
    init(urlString: String, method: Method = .get, parameters: [String: String]? = nil, headers: [String: String]? = nil, body: [String: String]? = nil) {
        // create query
        var url = URL(string: urlString)!
        if let parameters {
            let queryItems = parameters.map { key, value in
                return URLQueryItem(name: key, value: value)
            }
            url.append(queryItems: queryItems)
        }
        // init self
        self.init(url: url, timeoutInterval: URLRequest.timeoutInterval)
        self.httpMethod = method.rawValue
        // add body
        if let body {
            self.httpBody = Data(dictionary: body)
        }
        // add headers
        if let headers {
            headers.forEach { key, value in
                self.setValue(value, forHTTPHeaderField: key)
            }
        }
    }
}

extension Decodable {
    // failable init with a dictionary
    init?(dictionary: [String: Any]) {
        // this shouldn't normally fail though unless the dictionary contains corrupt data
        do {
            // try to serialize (dictionary to data)
            let data = try JSONSerialization.data(withJSONObject: dictionary, options: .fragmentsAllowed)
            let decodingResult = data.decodedResult(type: Self.self)
            
            switch decodingResult {
            case .success(let decodedObject):
                self = decodedObject
            case .failure:
                return nil
            }
        }
        catch {
            return nil
        }
    }
}

extension Data {
    func decodedResult<T: Decodable>(type: T.Type, dateDecodingStrategy: JSONDecoder.DateDecodingStrategy = .iso8601) -> Result<T, Error>  {
        
        do {
            let decoder = JSONDecoder()
            decoder.dateDecodingStrategy = dateDecodingStrategy
            decoder.keyDecodingStrategy = .convertFromSnakeCase
            let modelObject = try decoder.decode(type, from: self)
            return Result.success(modelObject)
        }
        catch let error {
            // error logs
            var errorMessage = ""
            switch error {
            case DecodingError.dataCorrupted(let context):
                errorMessage = "Corrupted data: \(context.debugDescription)"
            case DecodingError.typeMismatch( _, let context) :
                errorMessage = "Type mismatch: \(context.debugDescription)"
            case DecodingError.keyNotFound(let key, let context):
                errorMessage = "Key not found for: '\(key.stringValue)', \(context.debugDescription)"
            case DecodingError.valueNotFound(let type, let context):
                errorMessage = "Value not found for: '\(type)', \(context.debugDescription)"
            default:
                errorMessage = "Unknown error: \(error.localizedDescription)"
            }
            // print error message
            print(errorMessage)
            // return decode error
            return Swift.Result.failure(error)
        }
    }
}

