//
//  Constants.swift
//  WeatherAlamofireApp
//
//  Created by TeachMeSkills on 23.06.22.
//

import Foundation

struct Constants {

    static var baseURL = "https://api.openweathermap.org/"
    
    static var getCodingURL: String {
        return baseURL.appending("geo/1.0/direct")
    }
    
    static var weatherURL: String {
        return baseURL.appending("data/2.5/onecall")
    }

}
 
