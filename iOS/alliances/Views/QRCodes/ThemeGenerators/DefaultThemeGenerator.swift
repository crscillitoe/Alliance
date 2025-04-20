//
//  DefaultThemeGenerator.swift
//  alliances
//
//  Created by Bradford Bonanno on 4/20/25.
//
import EFQRCode
import UIKit

class DefaultThemeGenerator: QRCodeGenerator {
    func background() -> UIImage {
            // Get the main screen bounds
            let screenBounds = UIScreen.main.bounds
            let screenSize = screenBounds.size
            
            // Create the black image with screen dimensions
            let renderer = UIGraphicsImageRenderer(size: screenSize)
            let image = renderer.image { context in
                UIColor.black.setFill()
                context.fill(CGRect(origin: .zero, size: screenSize))
            }
            
            return image
    }
    
    func generate(text: String) -> UIImage {
        guard let outputImage = EFQRCode.generate(
            for: text,
            backgroundColor: .black(1.0)!,
            foregroundColor: .white(1.0)!
        ) else {
            return UIImage()
        }
        return UIImage(cgImage: outputImage)
    }
}
