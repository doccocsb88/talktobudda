//
//  UIView+Exts.swift
//  TalkToBudda
//
//  Created by mac on 30/4/25.
//

import SnapKit
import UIKit

//MARK: init

extension UIView {
    /// general UIView with background
    /// - Parameter background: color
    /// - Returns: view with backgroud color
    static func generalView(background: UIColor? = nil) -> UIView {
        let view = UIView()
        let background = background == nil ? .clear : background
        view.backgroundColor = background
        return view
    }

    var hasTopNorth: Bool {
        if #available(iOS 11.0, tvOS 11.0, *) {
            return UIApplication.shared.delegate?.window??.safeAreaInsets.top ?? 0 > 20
        }
        return false
    }

    var safeTopAnchor: NSLayoutYAxisAnchor {
        if #available(iOS 11.0, *) {
            return safeAreaLayoutGuide.topAnchor
        }
        return topAnchor
    }

    var safeLeftAnchor: NSLayoutXAxisAnchor {
        if #available(iOS 11.0, *) {
            return safeAreaLayoutGuide.leftAnchor
        }
        return leftAnchor
    }

    var safeBottomAnchor: NSLayoutYAxisAnchor {
        if #available(iOS 11.0, *) {
            return safeAreaLayoutGuide.bottomAnchor
        }
        return bottomAnchor
    }

    var safeRightAnchor: NSLayoutXAxisAnchor {
        if #available(iOS 11.0, *) {
            return safeAreaLayoutGuide.rightAnchor
        }
        return rightAnchor
    }

    var safeTop: ConstraintItem {
        return self.safeAreaLayoutGuide.snp.top
    }

    var safeLeft: ConstraintItem {
        return self.safeAreaLayoutGuide.snp.left
    }

    var safeBottom: ConstraintItem {
        return self.safeAreaLayoutGuide.snp.bottom
    }

    var safeRight: ConstraintItem {
        return self.safeAreaLayoutGuide.snp.right
    }

    func setGradientBackgroundColor(colorOne: UIColor, colorTwo: UIColor) {
        let gradientLayer = CAGradientLayer()
        gradientLayer.frame = bounds
        gradientLayer.colors = [colorOne.cgColor, colorTwo.cgColor]
        gradientLayer.locations = [0.0, 1.0]
        gradientLayer.endPoint = CGPoint(x: 1.0, y: 1.0)
        gradientLayer.startPoint = CGPoint(x: 0.0, y: 0.0)

        layer.insertSublayer(gradientLayer, at: 0)
    }

    func rounded(radius: CGFloat = 0, borderWidth: CGFloat = 0, borderColor: UIColor = .clear) {
        layer.cornerRadius = radius
        layer.borderWidth = borderWidth
        layer.borderColor = borderColor.cgColor
        clipsToBounds = true
    }

    func roundedTop(radius: CGFloat = 10) {
        clipsToBounds = true
        layer.cornerRadius = radius
        layer.maskedCorners = [.layerMaxXMinYCorner, .layerMinXMinYCorner]
    }

    func roundedBot(radius: CGFloat = 10) {
        clipsToBounds = true
        layer.cornerRadius = radius
        layer.maskedCorners = [.layerMinXMaxYCorner, .layerMaxXMaxYCorner]
    }

    func roundedAll(radius: CGFloat = 10) {
        clipsToBounds = true
        layer.cornerRadius = radius
        layer.maskedCorners = [.layerMaxXMinYCorner, .layerMinXMinYCorner, .layerMinXMaxYCorner, .layerMaxXMaxYCorner]
    }

    enum ViewSide {
        case Left, Right, Top, Bottom
    }

    func addBorder(toSide side: ViewSide, withColor color: CGColor, andThickness thickness: CGFloat) {
        let border = CALayer()
        border.backgroundColor = color

        switch side {
        case .Left: border.frame = CGRect(x: frame.minX, y: frame.minY, width: thickness, height: frame.height); break
        case .Right: border.frame = CGRect(x: frame.maxX, y: frame.minY, width: thickness, height: frame.height); break
        case .Top: border.frame = CGRect(x: frame.minX, y: frame.minY, width: frame.width, height: thickness); break
        case .Bottom: border.frame = CGRect(x: frame.minX, y: frame.maxY, width: frame.width, height: thickness); break
        }

        layer.addSublayer(border)
    }

    func addBorder(sides: [ViewSide], withColor color: CGColor, andThickness thickness: CGFloat) {
        sides.forEach { side in
            let border = CALayer()
            border.backgroundColor = color

            switch side {
            case .Left: border.frame = CGRect(x: frame.minX, y: frame.minY, width: thickness, height: frame.height); break
            case .Right: border.frame = CGRect(x: frame.maxX, y: frame.minY, width: thickness, height: frame.height); break
            case .Top: border.frame = CGRect(x: frame.minX, y: frame.minY, width: frame.width, height: thickness); break
            case .Bottom: border.frame = CGRect(x: frame.minX, y: frame.maxY, width: frame.width, height: thickness); break
            }

            layer.addSublayer(border)
        }
    }
}

//MARK: rotate

extension UIView {
    /**
     Rotate a view by specified degrees
     parameter angle: angle in degrees
     */

    func rotate(angle: CGFloat) {
        let radians = angle / 180.0 * CGFloat.pi
        let rotation = CGAffineTransformRotate(self.transform, radians)
        self.transform = rotation
    }
}


extension UILabel {
    
    /// Highlight specific text within the label with custom font and color.
    /// - Parameters:
    ///   - textToHighlight: The text you want to highlight.
    ///   - font: The font to apply to the highlighted text.
    ///   - color: The color to apply to the highlighted text.
    func highlight(text textToHighlight: String, with font: UIFont? = nil, color: UIColor? = nil) {
        guard let labelText = self.text else { return }
        
        // Create a mutable attributed string
        let attributedText = NSMutableAttributedString(string: labelText)
        
        // Search for the range of the text to highlight
        let range = (labelText as NSString).range(of: textToHighlight)
        
        if range.location != NSNotFound {
            // Apply attributes if the range is valid
            if let _font = font {
                attributedText.addAttribute(.font, value: _font, range: range)
            }
            
            if let _color = color {
                attributedText.addAttribute(.foregroundColor, value: _color, range: range)
            }
        }
        
        // Set the attributed text back to the label
        self.attributedText = attributedText
    }
}

extension UIImage {
    func resized(to size: CGSize) -> UIImage? {
        UIGraphicsBeginImageContextWithOptions(size, false, 0.0)
        self.draw(in: CGRect(origin: .zero, size: size))
        let resized = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        return resized
    }
}
