//
//  IconSelectView.swift
//  IconSelectView
//
//  Created by Caleb Elson on 9/15/21.
//

import SwiftUI

struct IconSelectView: View {
    //@State var iconManager = IconManager()
    @State private var iconManager: [AppIconStatus] = createAppIconStatuses()
    
    var body: some View {
        Form {
            ForEach(iconManager) { icon in
                Button(action: {
                    let iconName = icon.appIcon.rawValue == "AppIcon" ? nil : icon.appIcon.rawValue
                    
                    UIApplication.shared.setAlternateIconName(iconName)
                    
//                    let altIcon = icon.rawValue ? nil : icon.appIcon.rawValue
//                    AppIcon.changeIcon(to: icon)
                }) {
                    HStack {
                        Image(uiImage: icon.appIcon.thumbnail)
                            .resizable()
                            .frame(width: 68, height: 68)
                            .padding(.trailing, 5)
                       // VStack(alignment: .leading) {
                        Text(icon.appIcon.presentedName)
                                .font(.system(.callout, design: .rounded).weight(.medium))
                                .foregroundColor(.primary)
//                            Text(status.appIcon.subtitle)
//                                .font(.system(.caption2, design: .rounded))
//                                .foregroundColor(.secondary)
                       // }
                        Spacer()
                        
                        //let _ = print(IconManager().currentAppIcon, "current app icon")
//                        if icon.isCurrentAppIcon {
//                            Image(systemName: "checkmark")
//                                .font(.headline)
//                        }
                        
                        /*
                        HStack {
                            Image(uiImage: icon.thumbnail)
                                .clipShape(RoundedRectangle(cornerRadius: 12))
                                .overlay(
                                RoundedRectangle(cornerRadius: 12)
                                    .stroke(Color.gray, lineWidth: 0.25)
                                )
                            Text(icon.presentedName)
                                .foregroundColor(Color.primary)
                            Spacer()
                            let _ = print(UIApplication.shared.alternateIconName, "alt icon name", icon.rawValue, "raw value")
                            if UIApplication.shared.alternateIconName == icon.rawValue || (icon.rawValue == "AppIcon" && UIApplication.shared.alternateIconName == nil) {
                                Image(systemName: "checkmark")
                                    .font(.headline)
                            }
    //                        if iconManager.getIcon() == icon {
    //                            let _ = print(iconManager.getIcon(), icon, "founder")
    //                            Image(systemName: "checkmark")
    //                                .font(.headline)
    //                        } else {
    //                            let _ = print(iconManager.getIcon())
    //                            let _ = print(icon)
    //                            let _ = print("unfounder")
    //                        }
                         */
                    }
                }
            }
        }
    }
    
    private static func createAppIconStatuses() -> [AppIconStatus] {
        AppIcon.allCases.map { unlockedIcon in
            AppIconStatus(appIcon: unlockedIcon, isCurrentAppIcon: AppIcon.currentAppIcon == unlockedIcon)
        }
    }
}

struct AppIconStatus: Hashable {
    let appIcon: AppIcon
    let isCurrentAppIcon: Bool
}

extension AppIconStatus: Identifiable {
    var id: AppIcon {
        appIcon
    }
}

extension String: Identifiable {
    public var id: Self { self }
}

//class AppIconViewController: UIHostingController<IconSelectView> {
//    convenience init() {
//        self.init(rootView: AppIconView())
//        title = "App Icon"
//    }
//}

struct IconSelectView_Previews: PreviewProvider {
    static var previews: some View {
        IconSelectView()
    }
}
