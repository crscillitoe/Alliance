//
//  QRCode.swift
//  alliances
//
//  Created by Bradford Bonanno on 4/13/25.
//

import SwiftUI
import CoreImage.CIFilterBuiltins
import EFQRCode


struct QRCodeView: View {
    let allianceId: String
    let allianceName: String
    let size: CGFloat
    
    var body: some View {
        ZStack {
            Image(uiImage: generateBackground())
            Image(uiImage: generateQRCode(allianceId: allianceId, allianceName: allianceName))
                .interpolation(.none)
                .resizable()
                .scaledToFit()
                .frame(width: size, height: size)
                .background(Color.clear)
        }
    }
    
    func generateQRCodeURL(allianceId: String) -> String {
        return "alliances://open?id=\(allianceId)&name=\(allianceName)"
    }
    
    func generateQRCode(allianceId: String, allianceName: String) -> UIImage {
        let data = generateQRCodeURL(allianceId: allianceId)
        
        return QRCodeFactory.getGenerator(theme: .fancyTheme).generate(text: data)
    }
    
    func generateBackground() -> UIImage {
        return QRCodeFactory.getGenerator(theme: .fancyTheme).background()
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
