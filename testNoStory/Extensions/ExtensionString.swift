//
//  ExtensionString.swift
//  testNoStory
//
//  Created by Andres Valerio on 14/02/23.
//

import Foundation

extension String{
    func getDuration(runtime: Int) -> String {
        let seconds = runtime * 60
        let timeInterval = TimeInterval(seconds)
        let formatter = DateComponentsFormatter()
        formatter.unitsStyle = .abbreviated
        formatter.allowedUnits = [.hour, .minute]
        guard let duration = formatter.string(from: timeInterval) else { return "0" }
        return duration
    }
}
