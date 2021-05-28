//
//  Utils.swift
//  OnceUponAMeat
//
//  Created by Idan Israel on 06/11/2019.
//  Copyright © 2019 Idan Israel. All rights reserved.
//

import UIKit
import MapKit
import Foundation

/// MARK: - Utils
public class Utils {
    /// MARK: - Variables
    
    public static var inventory = [Category]()
    
    /// MARK: - Functions
    
    public static func createErrorMessage(title: String, message: String, buttonTitle: String, vc: UIViewController, segueIdentifier: String? = nil) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: UIAlertController.Style.alert)
        alert.addAction(UIAlertAction(title: buttonTitle, style: UIAlertAction.Style.default, handler: {
            _ in
            CATransaction.setCompletionBlock({  if let identifier = segueIdentifier { vc.performSegue(withIdentifier: identifier, sender: nil) }
            })
        }))
        
        vc.present(alert, animated: true, completion: nil)
    }
    
    public static func createQuestionMessage(title: String, message: String, vc: UIViewController) {
        let refreshAlert = UIAlertController(title: title, message: message, preferredStyle: UIAlertController.Style.alert)

        refreshAlert.addAction(UIAlertAction(title: "Ok", style: .default, handler: {
            (action: UIAlertAction!) in
            print("Handle Ok logic here")
        }))

        refreshAlert.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: {
            (action: UIAlertAction!) in
            print("Handle Cancel Logic here")
        }))

        vc.present(refreshAlert, animated: true, completion: nil)
    }
    
    public static func resizeImage(image: UIImage, targetSize: CGSize) -> UIImage {
        let size = image.size

        let widthRatio  = targetSize.width  / size.width
        let heightRatio = targetSize.height / size.height

        var newSize: CGSize
        
        if (widthRatio > heightRatio)
            { newSize = CGSize(width: size.width * heightRatio, height: size.height * heightRatio) }
        else
            { newSize = CGSize(width: size.width * widthRatio,  height: size.height * widthRatio) }
        let rect = CGRect(x: 0, y: 0, width: newSize.width, height: newSize.height)

        UIGraphicsBeginImageContextWithOptions(newSize, false, 1.0)
        image.draw(in: rect)
        
        let newImage = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()

        return newImage!
    }
    
    public static func makeControlRound(layer: CALayer, borderWidth: CGFloat, cornerRadius: CGFloat, borderColor: CGColor?) {
        layer.borderWidth = borderWidth
        layer.cornerRadius = cornerRadius
        layer.borderColor = borderColor
    }
    
    public static func presentSpecificVC (storyboardName: String, targetVcIdentifier: String, sourceVC: UIViewController) {
        let storyboard = UIStoryboard(name: storyboardName, bundle: nil)
        let controller = storyboard.instantiateViewController(withIdentifier: targetVcIdentifier)
        
        controller.modalTransitionStyle = .crossDissolve
        controller.modalPresentationStyle = .fullScreen
        sourceVC.present(controller, animated: true, completion: nil)
    }    
    
    public static func getTextWidth(text: String?) -> CGFloat {
        let tempLabel = UILabel()
        tempLabel.text = text
         
        return (floor(tempLabel.intrinsicContentSize.width) * 2.5)
    }
    
    public static func getVersionString() -> String {
        let appVersion = Bundle.main.infoDictionary?["CFBundleShortVersionString"] as? String
        return "מספר גרסא - \(appVersion ?? "0.0")"
    }
    
    public static func startCall(recipient: String) {
        let toDecoded = recipient.replacingOccurrences(of: "\\p{Cf}", with: "", options: .regularExpression)
        if let url = URL(string: "tel://\(toDecoded)"), UIApplication.shared.canOpenURL(url) {
            UIApplication.shared.open(url)
        }
    }
    
    public static func navigateToStore(address: String, completion: @escaping (CLLocationCoordinate2D?) -> Void) {
        let geocoder = CLGeocoder()
        geocoder.geocodeAddressString(address) {
            (placemarks, error) in
            guard error == nil else {
                print("Geocoding error: \(error!)")
                return
            }
            completion(placemarks?.first?.location?.coordinate)
        }
    }
    
    public static func openMapForPlace(lat: Double = 0, long: Double = 0, placeName: String = "") {
        let latitude: CLLocationDegrees = lat
        let longitude: CLLocationDegrees = long

        let regionDistance:CLLocationDistance = 100
        let coordinates = CLLocationCoordinate2DMake(latitude, longitude)
        let regionSpan = MKCoordinateRegion(center: coordinates, latitudinalMeters: regionDistance, longitudinalMeters: regionDistance)
        let options = [
            MKLaunchOptionsMapCenterKey: NSValue(mkCoordinate: regionSpan.center),
            MKLaunchOptionsMapSpanKey: NSValue(mkCoordinateSpan: regionSpan.span)
        ]
        let placemark = MKPlacemark(coordinate: coordinates, addressDictionary: nil)
        let mapItem = MKMapItem(placemark: placemark)
        mapItem.name = placeName
        mapItem.openInMaps(launchOptions: options)
    }
}

/// MARK: - Utils Extension
extension Utils {
    /// MARK: - Variables
    public static var KEYBOARD_ANIMATION_DURATION: CGFloat = 0.3
    public static var MINIMUM_SCROLL_FRACTION: CGFloat = 0.2
    public static var MAXIMUM_SCROLL_FRACTION: CGFloat = 0.8
    public static var PORTRAIT_KEYBOARD_HEIGHT: CGFloat = 216
    public static var LANDSCAPE_KEYBOARD_HEIGHT: CGFloat = 162
    public static var animatedDistance: CGFloat = 0
    
    /// MARK: - Public Functions
    
    @available(iOS 13.0, *)
    public static func textFieldDidBeginEditing (view: UIView, textField: UITextField) {
        let textFieldRect = view.window?.convert(textField.bounds, from: textField)
        let viewRect = view.window?.convert(view.bounds, from: view)
        
        if let textFieldOriginY = textFieldRect?.origin.y, let textFieldRectHeight = textFieldRect?.size.height, let viewOriginY = viewRect?.origin.y, let viewRectHeight = viewRect?.size.height {
            let midline = textFieldOriginY + 0.5 * textFieldRectHeight
            let numerator = midline - viewOriginY - Utils.MINIMUM_SCROLL_FRACTION * viewRectHeight
            let denominator = (Utils.MAXIMUM_SCROLL_FRACTION - Utils.MINIMUM_SCROLL_FRACTION) * viewRectHeight
            
            var heightFraction = numerator / denominator
            
            if (heightFraction < 0.0) {
                heightFraction = 0.0
            }
            else if (heightFraction > 1.0) {
                heightFraction = 1.0
            }
            
            let orientation = UIApplication.shared.windows.first?.windowScene?.interfaceOrientation
            if (orientation == UIInterfaceOrientation.portrait ||
                orientation == UIInterfaceOrientation.portraitUpsideDown)
            {
                animatedDistance = floor(Utils.PORTRAIT_KEYBOARD_HEIGHT * heightFraction)
            }
            else
            {
                animatedDistance = floor(Utils.LANDSCAPE_KEYBOARD_HEIGHT * heightFraction)
            }
            
            var viewFrame = view.frame
            viewFrame.origin.y -= animatedDistance
            
            UIView.animate(withDuration: TimeInterval(Utils.KEYBOARD_ANIMATION_DURATION)) {
                view.frame = viewFrame
            }
        }
    }
    
    public static func textFieldDidEndEditing (view: UIView, textField: UITextField) {
        var viewFrame = view.frame
        viewFrame.origin.y += Utils.animatedDistance
        
        UIView.animate(withDuration: TimeInterval(Utils.KEYBOARD_ANIMATION_DURATION)) {
            view.frame = viewFrame
        }
    }
    
    public static func textFieldShouldReturn (textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
}
