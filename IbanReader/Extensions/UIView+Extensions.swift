//
//  UIView+Extensions.swift
//  IbanReader
//
//  Created by Aymen Bokri on 25/04/2024.
//

import Foundation
import UIKit

extension UIView {
    /// Adds a child view to the receiver view and sets up auto-layout constraints to fill the parent view.
    /// - Parameter child: The view to be added as a child.
    func addChildView(_ child: UIView) {
        child.translatesAutoresizingMaskIntoConstraints = false
        
        addSubview(child)
        
        NSLayoutConstraint.activate([
            safeAreaLayoutGuide.leadingAnchor.constraint(
                equalTo: child.safeAreaLayoutGuide.leadingAnchor,
                constant: 0
            ),
            safeAreaLayoutGuide.trailingAnchor.constraint(
                equalTo: child.safeAreaLayoutGuide.trailingAnchor,
                constant: 0
            ),
            safeAreaLayoutGuide.topAnchor.constraint(
                equalTo: child.safeAreaLayoutGuide.topAnchor,
                constant: 0
            ),
            safeAreaLayoutGuide.bottomAnchor.constraint(
                equalTo: child.safeAreaLayoutGuide.bottomAnchor,
                constant: 0
            )
        ])
    }
}
