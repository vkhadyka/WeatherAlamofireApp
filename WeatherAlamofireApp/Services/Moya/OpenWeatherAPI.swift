//
//  OpenWeatherAPI.swift
//  WeatherAlamofireApp
//
//  Created by Vadim Khadyka on 24.06.22.
//

import Foundation
import Moya

//определяем наши запросы
enum OpenWeather {
    case getCoordinatesByName(name: String)
    case getWeatherByCoodinates(lat: Double, lon: Double)
}

extension OpenWeather: TargetType {
    /*базовый урл для составления полного пути.
     можно написать сразу же строку нашу https:api.openweather.org и думать как склеить урл
     */
    var baseURL: URL {
        URL(string: Constants.baseURL)!
    }
    
    
    var path: String {
        switch self {
        case .getCoordinatesByName:
            /*
             так же string можно вынести в Constants как отдельные переменные и вызывать оттуда
             но зачем создавать лишние объекты, если можно напрямую
             жирный плюс Moya в этом плане.
             */
            return "geo/1.0/direct"
        case .getWeatherByCoodinates:
            return "data/2.5/onecall"
        }
    }
    
    //
    var method: Moya.Method {
        .get
    }
    
    /*
     задаем параметры для наших запросов.
     все тот же словарь, но смотрике как можно добавить ключик сразу для всех запросов
    */
    var parameters: [String: Any]? {
        var params = [String: Any]()
        params["appid"] = "d737953228b0402486ab03b798106761"
        switch self {
        case .getWeatherByCoodinates(let lat, let lon):
            params["lat"] = lat
            params["lon"] = lon
            params["exclude"] = "minutely, alerts"
            
        case .getCoordinatesByName(let name):
            params["q"] = name
        }
        
        return params
    }
    
    //параметры декодирования URL
    var parameterEncoding: ParameterEncoding {
        URLEncoding.default
    }
    
    var task: Task {
        guard let params = parameters else {
            return .requestPlain
        }
        return .requestParameters(parameters: params, encoding: parameterEncoding)
    }
    
    //заголовки запроса.
    var headers: [String : String]? {
        nil
    }
    
    
}
