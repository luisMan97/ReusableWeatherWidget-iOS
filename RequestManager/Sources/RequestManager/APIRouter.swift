//
//  APIRouter.swift
//  ReusableWeatherWidget-iOS
//
//  Created by Jorge Luis Rivera Ladino on 23/07/25.
//

import Foundation

public enum APIRouter {

    case weather
    case customURL(URL)

    private var method: HTTPMethod {
        switch self {
        case .weather, .customURL:
            return .get
        }
    }

    private var path: String {
        switch self {
        case .weather: return "points/37.2883,-121.8434"
        case .customURL: return String()
        }
    }

    private var url: String {
        switch self {
        case .weather:
            return APIConstants.endpoint + path
        case .customURL(let url):
            return url.absoluteString
        }
    }

    var urlRequest: URLRequest? {
        guard let url = URL(string: url) else { return nil }
        var urlRequest = URLRequest(url: url)
        urlRequest.httpMethod = method.rawValue
        return urlRequest
    }
}
