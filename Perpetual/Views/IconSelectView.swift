//
//  IconSelectView.swift
//  IconSelectView
//
//  Created by Caleb Elson on 9/15/21.
//

import SwiftUI

struct IconSelectView: View {
    @State private var iconManager: [AppIconStatus] = createAppIconStatuses()
    
    var body: some View {
        Form {
            ForEach($iconManager) { $icon in
                Button(action: {
                    let iconName = icon.appIcon.rawValue == "AppIcon" ? nil : icon.appIcon.rawValue
                    
                    UIApplication.shared.setAlternateIconName(iconName)
                    
                    // Update every .isCurrentAppIcon after change so checkmark is on correct line
                    for i in iconManager.indices {
                                            iconManager[i].isCurrentAppIcon = iconManager[i].appIcon == icon.appIcon
                                        }
                    
                }) {
                    HStack {
                        Image(uiImage: icon.appIcon.thumbnail)
                            .clipShape(RoundedRectangle(cornerRadius: 18, style: .continuous))
                        
                        Text(icon.appIcon.presentedName)
                            .font(.system(.callout, design: .rounded).weight(.medium))
                            .foregroundColor(.primary)
                        
                        Spacer()
                        
                        // Show checkmark only for the currently chosen icon
                        Image(systemName: icon.isCurrentAppIcon ? "checkmark" : "")
                    }
                }
            }
        }
        .navigationTitle("Choose an icon")
    }
    
    private static func createAppIconStatuses() -> [AppIconStatus] {
        AppIcon.allCases.map { unlockedIcon in
            AppIconStatus(appIcon: unlockedIcon, isCurrentAppIcon: AppIcon.currentAppIcon == unlockedIcon)
        }
    }
}

struct AppIconStatus: Hashable {
    let appIcon: AppIcon
    var isCurrentAppIcon: Bool
}

extension AppIconStatus: Identifiable {
    var id: AppIcon {
        appIcon
    }
}

extension String: Identifiable {
    public var id: Self { self }
}

struct IconSelectView_Previews: PreviewProvider {
    static var previews: some View {
        IconSelectView()
    }
}
