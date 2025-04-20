//
//  FancyThemeGenerator.swift
//  alliances
//
//  Created by Bradford Bonanno on 4/20/25.
//

import EFQRCode
import UIKit
import SwiftUI
import Logging


class FancyThemeGenerator: QRCodeGenerator {
    let log = Logger(label: "FancyThemeLogger")
    func background() -> UIImage {
        return UIImage(named: "FancyThemeBackground") ?? UIImage()
    }
    
    func generate(text: String) -> UIImage {
        log.debug("Generating...")
        let electricCyan = CGColor.init(red: 34/255.0, green: 217/255.0, blue: 251/255.0, alpha: 1.0);
        
        guard let outputImage = EFQRCode.generate(
            for: text,
            backgroundColor: UIColor.clear.cgColor,
            foregroundColor: electricCyan,
            //watermark: UIImage(named: "FancyThemeBackground")?.cgImage
        ) else {
            log.debug("Returning blank UIImage")
            return UIImage()
        }
        return UIImage(cgImage: outputImage)
    }
}

#Preview {
    QRCodeView(
        allianceId: "e132d37b-609e-4420-aebe-77462f549fa2",
        allianceName: "Test Alliance",
               size: 200
    )
    .foregroundColor(.white)
    .containerRelativeFrame([.horizontal, .vertical])
    .background(.black)
}
