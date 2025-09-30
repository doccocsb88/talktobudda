//
//  String+Exts.swift
//  TalkToBudda
//
//  Created by mac on 6/5/25.
//

import UIKit

extension String {
    func size(usingFont font: UIFont, constrainedTo size: CGSize = .zero) -> CGSize {
        let attributes: [NSAttributedString.Key: Any] = [.font: font]
        let boundingSize = size == .zero ? CGSize(width: CGFloat.greatestFiniteMagnitude, height: CGFloat.greatestFiniteMagnitude) : size
        let rect = (self as NSString).boundingRect(
            with: boundingSize,
            options: [.usesLineFragmentOrigin, .usesFontLeading],
            attributes: attributes,
            context: nil
        )
        return rect.size
    }
}
