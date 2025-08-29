//
//  WeatherItemView.swift
//  CommonUI
//
//  Created by Jorge Luis Rivera Ladino on 24/07/25.
//

import SwiftUI

public struct WeatherItemView: View {
    var logo: String
    var name: String
    var value: String
    var icon: String

    public init(
        logo: String,
        name: String,
        value: String,
        icon: String
    ) {
        self.logo = logo
        self.name = name
        self.value = value
        self.icon = icon
    }

    public var body: some View {
        if !value.isEmpty {
            HStack(spacing: 20) {
                Image(systemName: logo)
                    .font(.title2)
                    .frame(
                        width: 20,
                        height: 20
                    )
                    .padding()
                    .background(
                        Color(
                            hue: 1.0,
                            saturation: 0.0,
                            brightness: 0.888
                        )
                    )
                    .cornerRadius(50)

                VStack(
                    alignment: .leading,
                    spacing: 8
                ) {
                    Text(name)
                        .font(.caption)

                    Text("\(value) \(icon)")
                        .bold()
                        .font(.title)
                }

                Spacer()
            }
            .frame(width: UIScreen.main.bounds.width / 2 - 20)
        }
    }
}

#Preview {
    WeatherItemView(
        logo: "sun.max",
        name: "Temperature",
        value: "25°C",
        icon: "🌡️"
    )
}
