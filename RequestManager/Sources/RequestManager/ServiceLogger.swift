//
//  ServiceLogger.swift
//  RequestManager
//
//  Created by Jorge Luis Rivera Ladino on 24/07/25.
//

public enum ServiceLogger {

    #if DEBUG
    public static func debugError(_ error: Error) {
        print("❌ \(error.localizedDescription)")
    }
    #endif
}
