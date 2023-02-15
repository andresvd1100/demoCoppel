//
//  Request.swift
//  testNoStory
//
//  Created by Andres Valerio on 11/02/23.
//

import Foundation

class Request{
    let session = URLSession.shared
    private static var messageSuccessfulRequest = "Success Message [Change message]"
    var statusCodeResponse: Int = 0
    var dataResponse: Data?

    func makeRequest<T: Decodable>(endpoint: String, headers: [String: String], model: T.Type, successRequest: @escaping(T) -> Void,
                                   errorCompletion: @escaping (Error) -> Void){
        
        let queryItems: [URLQueryItem] = headers.map { (key: String, value: String) -> URLQueryItem in
            URLQueryItem(name: key, value: value)
        }
        var urlComps = URLComponents(string: endpoint)
        urlComps?.queryItems = queryItems
        guard let url = urlComps?.url else { return }
        
        let task = session.dataTask(with: url) { (data, response, error) in
            if let error = error {
                print("Error with fetching: \(error)")
                return
            }
            
            guard let httpResponse = response as? HTTPURLResponse, (200...299).contains(httpResponse.statusCode) else {
                print("Error with response, unexpected status code: \(response)")
                return
            }
            if let data, let stringR = String(data: data, encoding: .utf8){
                print(stringR)
            }
            self.dataResponse = data
            self.printJSON(object: data)
            if let data = data {
                self.successRequest(model: model, data: data, successRequest,
                                    errorCompletion)
            }
        }
        task.resume()
    }
    
    func makeRequestPost<T: Decodable>(endpoint: String, headers: [String: String], params: [String : Any], model: T.Type, successRequest: @escaping(T) -> Void,
                                   errorCompletion: @escaping (Error) -> Void){
        
        let queryItems: [URLQueryItem] = headers.map { (key: String, value: String) -> URLQueryItem in
            URLQueryItem(name: key, value: value)
        }
        var urlComps = URLComponents(string: endpoint)
        urlComps?.queryItems = queryItems
        guard let url = urlComps?.url else { return }
        var request = URLRequest(url: url)
        request.setValue("application/x-www-form-urlencoded", forHTTPHeaderField: "Content-Type")
        request.setValue("application/json", forHTTPHeaderField: "Accept")
        request.httpMethod = "POST"
        request.httpBody = params.percentEncoded()
        
        let task = session.dataTask(with: request) { (data, response, error) in
            if let error = error {
                print("Error with fetching: \(error)")
                return
            }
            
            /*guard let httpResponse = response as? HTTPURLResponse, (200...299).contains(httpResponse.statusCode) else {
                print("Error with response, unexpected status code: \(response)")
                return
            }*/
            if let data, let stringR = String(data: data, encoding: .utf8){
                print(stringR)
            }
            self.dataResponse = data
            self.printJSON(object: data)
            if let data = data {
                self.successRequest(model: model, data: data, successRequest,
                                    errorCompletion)
            }
        }
        task.resume()
    }
    
    func successRequest<T: Decodable>(model: T.Type,
                                      data: Data,
                                      _ successRequest: @escaping (T) -> Void,
                                      _ errorCompletion: @escaping (Error) -> Void) {
        do {
            guard !data.isEmpty else {
                self.parseEmptyData(model: model, successRequest, errorCompletion)
                return
            }
            let json = try JSONSerialization.jsonObject(with: data,
                                                        options: .mutableContainers) as? [String: Any]
            debugPrint("JSON RESPONSE: \(String(describing: json))")
            if let error = self.checkErrorInJSON(json: json) {
                errorCompletion(error)
                return
            }
            self.parseData(model: model, data: data, successRequest, errorCompletion)
        } catch let error {
            errorCompletion(error)
        }
    }
    
    func parseEmptyData<T: Decodable>(model: T.Type,
                                      _ successRequest: @escaping (T) -> Void,
                                      _ errorCompletion: @escaping (Error) -> Void) {
        do {
            let decoder: JSONDecoder = JSONDecoder()
            decoder.keyDecodingStrategy = JSONDecoder.KeyDecodingStrategy.useDefaultKeys
            let response: [String: Any] = ["message": Request.messageSuccessfulRequest,
                                           "statusCode": 200]
            let data = try JSONSerialization.data(withJSONObject: response, options: .prettyPrinted)
            let results: T = try decoder.decode(model.self, from: data)
            successRequest(results)
        } catch let error {
            errorCompletion(error)
        }
    }
    
    func checkErrorInJSON(json: [String: Any]?) -> Error? {
        if let errorCode = json?["code"] as? String, errorCode == "token_not_valid" {
            let error = RequestError(status: .unauthorized)
            return error
        }
        return nil
    }
    
    func parseData<T: Decodable>(model: T.Type,
                                 data: Data,
                                 _ successRequest: @escaping (T) -> Void,
                                 _ errorCompletion: @escaping (Error) -> Void) {
        do {
            let decoder: JSONDecoder = JSONDecoder()
            decoder.keyDecodingStrategy = JSONDecoder.KeyDecodingStrategy.useDefaultKeys
            let results: T = try decoder.decode(model.self,
                                                from: data)
            
            successRequest(results)
        } catch let error {
            errorCompletion(error)
        }
    }
    
    func printJSON(object: Any) {
        if let params = object as? [String: Any] {
            let jsonData = try? JSONSerialization.data(withJSONObject: params,
                                                       options: [])
            guard let json = jsonData else { return }
            let body = String(data: json, encoding: .utf8)
            debugPrint("BODY: \(String(describing: body))")
        } else if let data = object as? Data {
            let jsonData = try? JSONSerialization.jsonObject(with: data,
                                                             options: .mutableContainers) as? [String: Any]
            guard let json = jsonData else { return }
            debugPrint("JSON RESPONSE: \(String(describing: json))")
        }
    }
}

public struct RequestError: Error {
    public var defaultMessage: String = ""
    public var statusError: ServicesStatus = .none
    
    public init(status: ServicesStatus) {
        statusError = status
    }
}

public enum ServicesStatus: Int {
    case notAssigned
    case undefined
    case ok
    case failConnection
    case failValidation
    case failAuthentication
    case serverError
    case notFound
    case failParser
    case gatewayTimeout
    case none
    case handledError
    case gone
    case noContent
    case conflict
    case forbidden
    case unauthorized = 401
    case badRequest = 400
}

