//
//  APIProvider.swift
//  WeatherAlamofireApp
//
//  Created by TeachMeSkills on 23.06.22.
//

import Foundation
import Alamofire
import UIKit

protocol RestAPIProviderProtocol {
    //изменил тип на Error, т.е. для Moya и Alamofile используется свой кастомный тип ошибки, но все наследуются от Error
    func getCoordinatesByName(name: String, completion: @escaping (Result<[Geocoding], Error>) -> Void)
    func getWeatherForCityCoordinates(lat: Double, lon: Double, completion: @escaping (Result<WeatherData, Error>) -> Void)
}

class AlamofireProvider: RestAPIProviderProtocol {
    

    func getCoordinatesByName(name: String, completion: @escaping (Result<[Geocoding], Error>) -> Void) {
        
        let params = addParams(queryItems: ["q": name])
        
        AF.request(Constants.getCodingURL, method: .get, parameters: params).responseDecodable(of: [Geocoding].self) { response in
            //т.к у нас изменился тип ошибки, стал Error вместо AFError пришлось разбирать result и передавать отдельно по результату
            switch response.result {
            case .success(let result):
                completion(.success(result))
            case .failure(let error):
                completion(.failure(error))
            }
        }
        
    }
    
    func getWeatherForCityCoordinates(lat: Double, lon: Double, completion: @escaping (Result<WeatherData, Error>) -> Void) {
    
        
        let params = addParams(queryItems: ["lat": lat.description, "lon": lon.description, "exlcude":"minutely,alerts"])
        
        AF.request(Constants.weatherURL, method: .get, parameters: params).responseDecodable(of: WeatherData.self){ response in
            switch response.result {
            case .success(let result):
                completion(.success(result))
            case .failure(let error):
                completion(.failure(error))
            }
        }
    }
    
    private func addParams(queryItems: [String: String]) -> [String: String] {
        var params: [String: String] = [:]
        params = queryItems
        params["appid"] = "d737953228b0402486ab03b798106761"
        return params
    }
    
//    private func getDecodable<T: Codable>(_ type: T.Type, data: Data) -> T {
//        return try! JSONDecoder().decode(T.self, from: data)
//    }





//    execute(url: URL(http:ssds), Geocoding.self, param: ["q" : "Minsk"])
//
//    execute(url: URL(http:sdldflfsdkl), WeatherData.self, param: ["q" : "Minsk"])
    
//    func execute<T: Codable>(url: URL, _ type: T.Type, param: [String: String], completion: (T) -> Void) {
//    let request = URLRequest(url: url)
//    let session = URLSession.shared.dataTask(with: request) { data, response, error in
//        if let data = data {
//           let value = try! JSONDecoder().decode(T.self, from: data)
//            completion(value)
//        }
//    }
//}

}
