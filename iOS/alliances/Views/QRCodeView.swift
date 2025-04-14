//
//  QRCode.swift
//  alliances
//
//  Created by Bradford Bonanno on 4/13/25.
//

import SwiftUI
import CoreImage.CIFilterBuiltins

struct QRCodeView: View {
    let allianceId: String
    let allianceName: String
    let size: CGFloat
    
    var body: some View {
        Image(uiImage: generateQRCode(allianceId: allianceId, allianceName: allianceName))
            .interpolation(.none)
            .resizable()
            .scaledToFit()
            .frame(width: size, height: size)
    }
    
    func generateQRCodeURL(allianceId: String) -> String {
        return "alliances://open?id=\(allianceId)&name=\(allianceName)"
    }
    
    func generateQRCode(allianceId: String, allianceName: String) -> UIImage {
        let data = generateQRCodeURL(allianceId: allianceId)
        
        let context = CIContext()
        let filter = CIFilter.qrCodeGenerator()
        
        filter.message = Data(data.utf8)
        filter.correctionLevel = "M"
        
        guard let outputImage = filter.outputImage else {
            return UIImage()
        }
        
        let invertFilter = CIFilter.colorInvert()
        invertFilter.inputImage = outputImage
        guard let invertedImage = invertFilter.outputImage else {
            return UIImage()
        }
        
        let scale = size / invertedImage.extent.width
        let scaledImage = invertedImage.transformed(by: CGAffineTransform(scaleX: scale, y: scale))
        
        guard let cgImage = context.createCGImage(scaledImage, from: scaledImage.extent) else {
            return UIImage()
        }
        
        return UIImage(cgImage: cgImage)
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
