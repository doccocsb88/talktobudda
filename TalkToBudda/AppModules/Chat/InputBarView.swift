//
//  InputBarView.swift
//  TalkToBudda
//
//  Created by mac on 6/5/25.
//

import UIKit
import SnapKit

class InputBarView: UIView {

    private lazy var textField: UITextField = {
        let textField = UITextField()
        textField.leftView = UIView(frame: CGRect(origin: .zero, size: CGSize(width: 18, height: 56)))
        textField.leftViewMode = .always
        let placeholderText = "Ask your question and seek wisdom..."
        let attributes: [NSAttributedString.Key: Any] = [
            .foregroundColor: UIColor(hexString: "#B8A28C"),
            .font: FontFamily.Inter28pt.regular.font(size: 17)
        ]

        textField.attributedPlaceholder = NSAttributedString(string: placeholderText, attributes: attributes)
        textField.font = FontFamily.Inter28pt.regular.font(size: 17)
        textField.backgroundColor = UIColor(hexString: "#FBF6F0")
        textField.textColor = .color4B3621
        textField.layer.cornerRadius = 22
        textField.layer.borderWidth = 1
        textField.layer.borderColor = UIColor(hexString: "#E9D8C5").cgColor
        textField.clipsToBounds = true
        return textField
    }()
    
    let sendButton = UIButton(type: .system)
    var onSend: ((String)->())?
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupUI()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    private func setupUI() {
        backgroundColor = UIColor.clear

        addSubview(textField)
        addSubview(sendButton)

        let config = UIImage.SymbolConfiguration(pointSize: 24, weight: .medium)
        sendButton.setImage(UIImage(systemName: "arrow.right", withConfiguration: config)?.withRenderingMode(.alwaysTemplate), for: .normal)
        sendButton.tintColor = .color4B3621
        sendButton.rounded(radius: 28)
        sendButton.backgroundColor = UIColor(hexString: "#F1DFC2")
        sendButton.layer.borderWidth = 1
        sendButton.layer.borderColor = UIColor(hexString: "#E0C7A6").cgColor
        
        textField.snp.makeConstraints { make in
            make.left.equalToSuperview()
            make.centerY.equalToSuperview()
            make.right.equalTo(sendButton.snp.left).offset(-8)
            make.height.equalTo(56)
        }

        sendButton.snp.makeConstraints { make in
            make.right.equalToSuperview()
            make.centerY.equalToSuperview()
            make.width.height.equalTo(56)
        }
        
        sendButton.addTarget(self, action: #selector(tappedSend(_:)), for: .touchUpInside)
        
        // Add tap gesture to make textField first responder
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(handleTap))
        addGestureRecognizer(tapGesture)
    }
    
    @objc private func handleTap() {
        textField.becomeFirstResponder()
    }
    
    func uploadLoadingState(_ loading: Bool) {
        sendButton.isEnabled = !loading
        sendButton.alpha = loading ? 0.65 : 1
    }
    
    @objc func tappedSend(_ sender: UIButton) {
        guard let text = textField.text, !text.isEmpty else { return }
        guard ConditionServices.shared.canChat() else {
            if let topVC = UIViewController.topMostViewController() {
                DSRouter.showDS(from: topVC)
            }
            return }
        onSend?(text)
        textField.text = nil
    }
}
