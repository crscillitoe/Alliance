//
//  QRCodeFactory.swift
//  alliances
//
//  Created by Bradford Bonanno on 4/20/25.
//

enum QRCodeTheme {
    case defaultTheme
    case fancyTheme
}

class QRCodeFactory {
    static func getGenerator(theme: QRCodeTheme) -> QRCodeGenerator {
        switch (theme) {
            case .fancyTheme:
                return FancyThemeGenerator()
            default:
                return DefaultThemeGenerator()
        }
    }
}
