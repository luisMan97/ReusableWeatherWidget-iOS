//
//  ReusableWeatherWidget_iOSApp.swift
//  ReusableWeatherWidget-iOS
//
//  Created by Jorge Luis Rivera Ladino on 23/07/25.
//

import SwiftUI
import SwiftData

@main
struct ReusableWeatherWidget_iOSApp: App {

    var body: some Scene {
        WindowGroup {
            WeatherFactory.getWeatherView()
        }
    }
}
