//
//  QRCodeGenerator.swift
//  alliances
//
//  Created by Bradford Bonanno on 4/20/25.
//

import Foundation
import UIKit
import SwiftUI


protocol QRCodeGenerator {
    func generate(text: String) -> UIImage
    func background() -> UIImage
}
