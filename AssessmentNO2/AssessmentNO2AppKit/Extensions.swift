//
//  Extensions.swift
//  AssessmentNO2
//
//  Created by Muhammad  Farhan Akram on 22/10/2024.
//

import Foundation
import UIKit

extension CAShapeLayer {
    static func rectangle(roundedRect: CGRect, cornorRadius: CGFloat, color: UIColor) -> CAShapeLayer {
        let path = UIBezierPath(roundedRect: roundedRect, cornerRadius: cornorRadius)
        let shape = CAShapeLayer()
        shape.path = path.cgPath
        shape.fillColor = color.cgColor
        return shape
    }
}

extension UIView {
    func draw(_ shapes: CAShapeLayer...) {
        for shape in shapes {
            layer.addSublayer(shape)
        }
    }
}
extension CAShapeLayer {
    
    static func oval(in rect: CGRect, color: UIColor) -> CAShapeLayer {
        let path = UIBezierPath(ovalIn: rect)
        let shape = CAShapeLayer()
        shape.path = path.cgPath
        shape.fillColor = color.cgColor
        return shape
    }
    
    static func triangle(_ point1: CGPoint, _ point2: CGPoint, _ point3: CGPoint, color: UIColor) -> CAShapeLayer {
        let path = UIBezierPath()
        path.move(to: point1)
        path.addLine(to: point2)
        path.addLine(to: point3)
        path.close()
        let shape = CAShapeLayer()
        shape.path = path.cgPath
        shape.fillColor = color.cgColor
        return shape
    }
    
    static func line(start: CGPoint, end: CGPoint, width: CGFloat, color: UIColor) -> CAShapeLayer {
        let path = UIBezierPath()
        path.move(to: start)
        path.addLine(to: end)
        let shape = CAShapeLayer()
        shape.path = path.cgPath
        shape.lineWidth = width
        shape.strokeColor = color.cgColor
        return shape
    }
}




extension UIApplication {
    static func topViewController(base: UIViewController? = UIApplication.shared.connectedScenes
                                    .filter({ $0.activationState == .foregroundActive })
                                    .compactMap({ $0 as? UIWindowScene })
                                    .first?.windows
                                    .filter({ $0.isKeyWindow }).first?.rootViewController) -> UIViewController? {
        if let nav = base as? UINavigationController {
            return topViewController(base: nav.visibleViewController)
        }
        
        if let tab = base as? UITabBarController, let selected = tab.selectedViewController {
            return topViewController(base: selected)
        }
        
        if let presented = base?.presentedViewController {
            return topViewController(base: presented)
        }
        
        return base
    }
}
