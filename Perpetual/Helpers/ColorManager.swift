//
//  ColorManager.swift
//  Perpetual
//
//  Created by Caleb Elson on 12/30/21.
//

import SwiftUI

struct ColorManager {
    func scoreColor(_ score: Double) -> Color {
        return Color(.sRGB, red: (score/100)*1.25, green: 0.25*(100-score)/100, blue: (100-score)/100, opacity: 1)
    }
}
