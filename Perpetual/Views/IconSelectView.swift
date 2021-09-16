//
//  IconSelectView.swift
//  IconSelectView
//
//  Created by Caleb Elson on 9/15/21.
//

import SwiftUI

struct IconSelectView: View {
    var iconManager = IconManager()
    
    var body: some View {
        Form {
            ForEach(IconManager.AppIcon.allCases, id: \.self) { icon in
                Button(action: {
                    iconManager.changeIcon(to: icon)
                }) {
                    HStack {
                        Image(uiImage: UIImage(named: icon.imageName) ?? UIImage())
                            .clipShape(RoundedRectangle(cornerRadius: 12))
                            .overlay(
                            RoundedRectangle(cornerRadius: 12)
                                .stroke(Color.gray, lineWidth: 0.25)
                            )
                        Text(icon.presentedName)
                            .foregroundColor(Color.primary)
                    }
                }
            }
        }
    }
}

struct IconSelectView_Previews: PreviewProvider {
    static var previews: some View {
        IconSelectView()
    }
}
