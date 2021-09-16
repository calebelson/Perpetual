//
//  Icons.swift
//  Icons
//
//  Created by Caleb Elson on 9/15/21.
//

import Foundation
import UIKit


struct IconManager {
    private let application = UIApplication.shared
    
    public enum AppIcon: String, CaseIterable {
        case defaultIcon
        case whiteBackground
        case blackBackground
        case blackOnWhite
        
        var presentedName: String {
            switch self {
            case .whiteBackground:
                return "Light background"
            case .blackBackground:
                return "Dark background"
            case .blackOnWhite:
                return "Black on white"
            case .defaultIcon:
                return "Default"
            }
        }
        
        var imageName: String {
            switch self {
            case .whiteBackground:
                return "DefaultOnWhiteImage"
            case .blackBackground:
                return "DefaultOnBlackImage"
            case .blackOnWhite:
                return "BlackOnWhiteImage"
            case .defaultIcon:
                return "AppIconImage"
            }
        }
        
        var iconName: String? {
            switch self {
            case .whiteBackground:
                return "DefaultOnWhiteIcon"
            case .blackBackground:
                return "DefaultOnBlackIcon"
            case .blackOnWhite:
                return "BlackOnWhiteIcon"
            case .defaultIcon:
                return nil
            }
        }
    }
    
    public func changeIcon(to appIcon: AppIcon?) {
        // Setting to nil returns icon to default
        application.setAlternateIconName(appIcon?.iconName)
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
}
