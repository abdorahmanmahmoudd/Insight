//
//  Extensions.swift
//  DHCR_Community_iOS
//
//  Created by MIS on 12/4/17.
//  Copyright © 2017 linkdev. All rights reserved.
//

import UIKit

extension String {
    
    func base64Encoded() -> String {
        let plainData = data(using: String.Encoding.utf8)
        let base64String = plainData?.base64EncodedString(options: NSData.Base64EncodingOptions.init(rawValue: 0))
        return base64String!
    }
    
    func base64Decoded() -> String {
        let decodedData = NSData(base64Encoded: self, options:NSData.Base64DecodingOptions.init(rawValue: 0))
        let decodedString = NSString(data: decodedData! as Data, encoding: String.Encoding.utf8.rawValue)
        return decodedString! as String
    }
    
    var html2AttributedString: NSAttributedString? {
        guard
            let data = data(using: String.Encoding.utf8, allowLossyConversion: true)
            else { return nil }
        do {
            
            let str = try NSAttributedString(data: data, options: [.documentType: NSAttributedString.DocumentType.html, .characterEncoding: String.Encoding.utf8.rawValue], documentAttributes: nil)
            return str
        } catch let error as NSError {
            print(error.localizedDescription)
            return  nil
        }
    }
    var html2String: String {
        return html2AttributedString?.string.trimmedText() ?? self
    }
    
    func trimmedText()->String
    {
        return trimmingCharacters(in: CharacterSet.whitespacesAndNewlines)
    }
    
    func hasNoCharchters() -> Bool
    {
        return trimmedText().count == 0
    }
    
    func isValidEmail() -> Bool
    {
        let emailRegEx = "(?:[\\p{L}0-9!#$%\\&'*+/=?\\^_`{|}~-]+(?:\\.[\\p{L}0-9!#$%\\&'*+/=?\\^_`{|}" +
            "~-]+)*|\"(?:[\\x01-\\x08\\x0b\\x0c\\x0e-\\x1f\\x21\\x23-\\x5b\\x5d-\\" +
            "x7f]|\\\\[\\x01-\\x09\\x0b\\x0c\\x0e-\\x7f])*\")@(?:(?:[\\p{L}0-9](?:[a-" +
            "z0-9-]*[\\p{L}0-9])?\\.)+[\\p{L}0-9](?:[\\p{L}0-9-]*[\\p{L}0-9])?|\\[(?:(?:25[0-5" +
            "]|2[0-4][0-9]|[01]?[0-9][0-9]?)\\.){3}(?:25[0-5]|2[0-4][0-9]|[01]?[0-" +
            "9][0-9]?|[\\p{L}0-9-]*[\\p{L}0-9]:(?:[\\x01-\\x08\\x0b\\x0c\\x0e-\\x1f\\x21" +
        "-\\x5a\\x53-\\x7f]|\\\\[\\x01-\\x09\\x0b\\x0c\\x0e-\\x7f])+)\\])"
        
        let emailTest = NSPredicate(format:"SELF MATCHES %@", emailRegEx)
        return emailTest.evaluate(with: self)
    }
    
    func isValidPassword() -> Bool
    {
        //"^(?=.*\\d)(?=.*\\D)([a-zA-Z0-9@#$%&;:'^{}<>,!\"'*=+]{8,})$"
         // "^(?=.*[A-Za-z])(?=.*\\d)[A-Za-z\\d@#$%&;:'^{}<>,!\"'*=+-_|/\\]{8,}$"
        let passRegex = "^(?=.*[A-Za-z])(?=.*\\d)[A-Za-z\\d@#$%&;:'^{}<>,!\"'*=+-_|\\/\\\\]{8,}$"
        let emailTest = NSPredicate(format:"SELF MATCHES %@", passRegex)
        let isValid = emailTest.evaluate(with: self)
        return isValid
    }
    
    func isValidPhone() -> Bool
    {
        
        let passRegex = "^[0-9]{11}$"
        let phoneTest = NSPredicate(format:"SELF MATCHES %@", passRegex)
        let isValid = phoneTest.evaluate(with: self)
        return isValid
    }
    func containsWhiteSpace() -> Bool {
        
        // check if there's a range for a whitespace
        
        let range =  self.rangeOfCharacter(from: .whitespaces)
        
        // returns false when there's no range for whitespace
        if let _ = range {
            return true
        } else {
            return false
        }
    }
    
    var isAlphanumeric: Bool {
        
       return rangeOfCharacter(from: CharacterSet(charactersIn: "abcdefghijklmnopqrstuvwxyz1234567890ABCDEFGHIJKLMNOPQRSTUVWXYZ.").inverted) != nil//(charactersInString:"abcdefghijklmnopqrstuvwxyz1234567890ABCDEFGHIJKLMNOPQRSTUVWXYZ").invertedSet) == nil
    }
    
    func width(withConstraintedHeight height: CGFloat, font: UIFont?) -> CGFloat {
        let constraintRect = CGSize(width: .greatestFiniteMagnitude, height: height)
        let boundingBox = self.boundingRect(with: constraintRect, options: .usesLineFragmentOrigin, attributes: [.font: font ?? .systemFont(ofSize: 14)], context: nil)
        return ceil(boundingBox.width)
    }
    
    func height(withConstraintedWidth width: CGFloat, font: UIFont?) -> CGFloat {
        let constraintRect = CGSize(width: width, height: .greatestFiniteMagnitude)
        let boundingBox = self.boundingRect(with: constraintRect, options: .usesLineFragmentOrigin, attributes: [.font: font ?? .systemFont(ofSize: 14)], context: nil)
        return ceil(boundingBox.height)
    }
    
    
}

extension UIImage {
    
    
    func resizedImage(newSize : CGSize, quality : CGInterpolationQuality) -> UIImage {
        var drawTransposed : Bool
        
        switch self.imageOrientation {
        case .left,.leftMirrored:
            drawTransposed = true
        case .right,.rightMirrored:
            drawTransposed = true
        default:
            drawTransposed = false
        }
        
        
        return self.resizedImage(newSize: newSize, transform: self.transformForOrientation(newSize: newSize), transpose: drawTransposed, quality: quality)
    }
    
    func resizedImage(newSize : CGSize, transform : CGAffineTransform, transpose : Bool, quality : CGInterpolationQuality ) -> UIImage {
        
        let newRect = CGRect(x: 0, y:0, width: newSize.width, height: newSize.height).integral
        let transposedRect = CGRect(x: 0, y:0, width: newSize.width, height: newSize.height)
        let imageRef = self.cgImage
        
        // Build a context that's the same dimensions as the new size
        let bitmap = CGContext.init(data: nil, width: Int(newRect.size.width), height: Int(newRect.size.height), bitsPerComponent: imageRef!.bitsPerComponent, bytesPerRow: 0, space: imageRef!.colorSpace!, bitmapInfo: imageRef!.bitmapInfo.rawValue)
        
        // Rotate and/or flip the image if required by its orientation
        bitmap!.concatenate(transform)
        
        // Set the quality level to use when rescaling
        bitmap!.interpolationQuality = quality
        
        // Draw into the context; this scales the image
        bitmap?.draw(imageRef!, in: transpose ? transposedRect : newRect)
        
        let newImageRef = bitmap!.makeImage()
        let newImage = UIImage(cgImage: newImageRef!)
        
        return newImage
    }
    
    func transformForOrientation(newSize : CGSize) -> CGAffineTransform {
        
        var transform = CGAffineTransform.identity
        
        switch self.imageOrientation {
        case .down, .downMirrored:
            transform = transform.translatedBy(x: newSize.width, y: newSize.height)
            transform = transform.rotated(by: .pi)
            
        case .left, .leftMirrored:
            transform = transform.translatedBy(x: newSize.width, y: 0)
            transform = transform.rotated(by: .pi/2)
            
        case .right, .rightMirrored:
            transform = transform.translatedBy(x: 0, y: newSize.height)
            transform = transform.rotated(by: -.pi/2)
            
        default:
            break
        }
        
        switch self.imageOrientation {
        case .upMirrored,.downMirrored:
            transform = transform.translatedBy(x: newSize.width, y: 0)
            transform = transform.scaledBy(x: -1, y: 1)
            
        case .leftMirrored,.rightMirrored:
            transform = transform.translatedBy(x: newSize.height, y: 0)
            transform = transform.scaledBy(x: -1, y: 1)
            
        default:
            break
        }
        
        return transform
    }
    
    static func from(red: CGFloat, green: CGFloat, blue: CGFloat, alpha : CGFloat) -> UIImage {
        let rect = CGRect(x: 0, y: 0, width: 1, height: 1)
        UIGraphicsBeginImageContext(rect.size)
        let context = UIGraphicsGetCurrentContext()
        context!.setFillColor(red: red, green: green, blue: blue, alpha: alpha)
        context!.fill(rect)
        let img = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        return img!
    }
        
}

extension UIFont {
    func sizeOfString (string: String, constrainedToWidth width: Double) -> CGSize {
        return NSString(string: string).boundingRect(with: CGSize(width: width, height: Double.greatestFiniteMagnitude),options: NSStringDrawingOptions.usesLineFragmentOrigin,
                                                     attributes: [NSAttributedStringKey.font: self],
                                                             context: nil).size
    }
}

extension MutableCollection {
    /// Shuffles the contents of this collection.
    mutating func shuffle() {
        let c = count
        guard c > 1 else { return }
        
        for (firstUnshuffled, unshuffledCount) in zip(indices, stride(from: c, to: 1, by: -1)) {
            let d: IndexDistance = numericCast(arc4random_uniform(numericCast(unshuffledCount)))
            let i = index(firstUnshuffled, offsetBy: d)
            swapAt(firstUnshuffled, i)
        }
    }
}


