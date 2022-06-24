//
//  MoyaProvider.swift
//  WeatherAlamofireApp
//
//  Created by Vadim Khadyka on 24.06.22.
//

import Foundation
import Moya
import Alamofire

class MoyaAPIProvider: RestAPIProviderProtocol {
    
    //наш MoyaProvider является generic объектом принимающий любой TargetType тип
    private let provider: MoyaProvider<OpenWeather>
    
    init() {
       provider = MoyaProvider<OpenWeather>()
    }
    
    func getCoordinatesByName(name: String, completion: @escaping (Result<[Geocoding], Error>) -> Void) {
        provider.request(.getCoordinatesByName(name: name)) { result in
            switch result {
            case .success(let response):
                do {
                    //тут мы преобразуем наш респонс в нашу модель
                    let object = try response.map([Geocoding].self)
                    completion(.success(object))
                } catch let error {
                    completion(.failure(error))
                }
            case .failure(let error):
                completion(.failure(error))
            }
        }
    }
    
    func getWeatherForCityCoordinates(lat: Double, lon: Double, completion: @escaping (Result<WeatherData, Error>) -> Void) {
        
        provider.request(.getWeatherByCoodinates(lat: lat, lon: lon)) { result in
            switch result {
            case .success(let response):
                do {
                    let object = try response.map(WeatherData.self)
                    completion(.success(object))
                } catch let error {
                    completion(.failure(error))
                }
            case .failure(let error):
                completion(.failure(error))
            }
        }
        
    }
    
    
}
