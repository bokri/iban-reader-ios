//
//  GuidanceOverlayView.swift
//  IbanReader
//
//  Created by Aymen Bokri on 25/04/2024.
//

import Foundation
import UIKit

/// A custom UIView subclass representing a guidance overlay view with a cutout region.
class GuidanceOverlayView: UIView {
    /// The CGRect defining the cutout region of the view.
    var cutout: CGRect?
    
    /// The title label displayed on the view.
    var title: UILabel
    
    /// Initializes the guidance overlay view with a given cutout region.
    /// - Parameter cutout: The CGRect defining the cutout region. If `nil`, the view will have no cutout.
    init(cutout: CGRect?) {
        self.title = UILabel()
        self.cutout = cutout
        
        super.init(frame: .zero)
        
        // Configure title label
        self.title.text = String(localized: "iban_scanner_title")
        self.title.textAlignment = .center
        self.title.numberOfLines = 0
        self.title.font = UIFont.boldSystemFont(ofSize: 14)
        self.title.textColor = UIColor(.white)
        self.title.translatesAutoresizingMaskIntoConstraints = false
        self.addSubview(title)
        
        // Layout constraints for the title label
        NSLayoutConstraint.activate([
            title.leadingAnchor.constraint(
                equalTo: safeAreaLayoutGuide.leadingAnchor,
                constant: 40
            ),
            title.trailingAnchor.constraint(
                equalTo: safeAreaLayoutGuide.trailingAnchor,
                constant: -40
            ),
            title.topAnchor.constraint(
                equalTo: safeAreaLayoutGuide.topAnchor,
                constant: 40
            )
        ])
        
        // Configure background color and opacity
        backgroundColor = UIColor(.black).withAlphaComponent(0.5)
        isOpaque = false
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    /// Overrides the `draw(_:)` method to draw the view with the cutout region.
    override func draw(_ rect: CGRect) {
        backgroundColor?.setFill()
        UIRectFill(rect)
        guard let cutout = cutout else { return }
        
        let path = UIBezierPath(rect: cutout)
        let intersection = rect.intersection(cutout)
        UIRectFill(intersection)
        
        UIColor.clear.setFill()
        UIGraphicsGetCurrentContext()?.setBlendMode(.copy)
        path.fill()
    }
}
