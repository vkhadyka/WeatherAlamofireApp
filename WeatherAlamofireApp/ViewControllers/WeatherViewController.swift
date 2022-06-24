//
//  ViewController.swift
//  WeatherAlamofireApp
//
//  Created by TeachMeSkills on 23.06.22.
//

import UIKit

class WeatherViewController: UIViewController {

    private var apiProvider: RestAPIProviderProtocol!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        if UIDevice.current.userInterfaceIdiom == .pad {
            apiProvider = AlamofireProvider()
        } else {
            apiProvider = MoyaAPIProvider()
        }
        
        
        getCoordinatesByName()
    }

    fileprivate func getCoordinatesByName() {
        apiProvider.getCoordinatesByName(name: "Minsk") { [weak self] result in
            guard let self = self else {return}
            switch result {
            case .success(let value):
                if let city = value.first {
                    self.getWeatherByCoordinates(city: city)
                }
            case .failure(let error):
                print(error.localizedDescription)
            }
        }
    }
    
    private func getWeatherByCoordinates(city: Geocoding) {
        apiProvider.getWeatherForCityCoordinates(lat: city.lat, lon: city.lon) { result in
            switch result {
            case .success(let value):
               // updateUI(value.current)
                let image =  "http://openweathermap.org/img/wn/\(value.current!.weather!.first!.icon!)@2x.png"
                print(image)
            case .failure(let error):
                print(error)
            }
            
        }
    }
    
}

