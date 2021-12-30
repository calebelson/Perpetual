//
//  Icons.swift
//  Icons
//
//  Created by Caleb Elson on 9/15/21.
//

import Foundation
import UIKit


//struct IconManager {
    private let application = UIApplication.shared
    
    public enum AppIcon: String, CaseIterable {
        case defaultIcon = "AppIcon"
        case whiteBackground = "DefaultOnWhiteIcon"
        case blackBackground = "DefaultOnBlackIcon"
        case blackOnWhite = "BlackOnWhiteIcon"
        case darkBlueBackground = "DefaultOnDarkBlueIcon"
        case darkPupleBackground = "DefaultOnDarkPurpleIcon"
        case greenBackground = "DefaultOnGreenIcon"
        case pinkArrowsBackground = "DefaultOnPinkArrowsIcon"
        case tealBackground = "DefaultOnTealIcon"
        case discoBackground = "DiscoIcon"
        
        static var currentAppIcon: AppIcon {
            guard let name = UIApplication.shared.alternateIconName else { return .defaultIcon}
            
            guard let appIcon = AppIcon(rawValue: name) else {
                fatalError("Provided unknown app icon value")
            }
            
            return appIcon
        }
        
        var presentedName: String {
            switch self {
            case .whiteBackground:
                return "Light background"
            case .blackBackground:
                return "Dark background"
            case .blackOnWhite:
                return "Black on white"
            case .darkBlueBackground:
                return "Dark blue background"
            case .darkPupleBackground:
                return "Dark purple background"
            case .greenBackground:
                return "Green background"
            case .pinkArrowsBackground:
                return "Fully automated luxury gay space communism"
            case .tealBackground:
                return "Teal background"
            case .discoBackground:
                return "Disco"
            case .defaultIcon:
                return "Default"
            }
        }
        
        var thumbnail: UIImage {
            guard let image = UIImage(named: self.rawValue + "Thumb") else {
                print(self.rawValue, "error")
                
                return UIImage(systemName: "gear")!
            }
            return image
            //return UIImage(named: self.rawValue + "Thumb")
        }
    }
    
    public func changeIcon(to appIcon: AppIcon?) {
        // Setting to nil returns icon to default
        let iconName = appIcon?.rawValue == "AppIcon" ? nil : appIcon?.rawValue
        
        application.setAlternateIconName(iconName)
    }
    
    public func getIcon() -> AppIcon {
        switch application.alternateIconName {
        case "DefaultOnWhiteIcon":
            return .whiteBackground
        case "DefaultOnBlackIcon":
            return .blackBackground
        case "BlackOnWhiteIcon":
            return .blackOnWhite
        default:
            return .defaultIcon
        }
    }
    
    
//}
