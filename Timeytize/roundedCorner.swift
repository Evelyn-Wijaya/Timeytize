//
//  roundedCorner.swift
//  Timeytize
//
//  Created by Peter Lee on 10/04/21.
//

import UIKit
@IBDesignable

class roundedCorner: UIView {

    @IBInspectable var corderRadius: CGFloat = 0 {
            didSet {
                layer.cornerRadius = corderRadius
                layer.masksToBounds = corderRadius > 0
            }
        }
        @IBInspectable var borderWidth: CGFloat = 0 {
                didSet {
                    layer.borderWidth = borderWidth
                }
            }
            
        @IBInspectable var borderColor: UIColor? {
            didSet {
                layer.borderColor = borderColor?.cgColor
            }
        }

}
