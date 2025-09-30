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
        textField.leftView = UIView(frame: CGRect(origin: .zero, size: CGSize(width: 20, height: 44)))
        textField.leftViewMode = .always
        let placeholderText = "Ask your question and seek wisdom..."
        let attributes: [NSAttributedString.Key: Any] = [
            .foregroundColor:  UIColor.color7D5A4F,
            .font: FontFamily.PlayfairDisplay.regular.font(size: 13)
        ]

        textField.attributedPlaceholder = NSAttributedString(string: placeholderText, attributes: attributes)

        textField.font = FontFamily.PlayfairDisplay.regular.font(size: 14)
        textField.backgroundColor = UIColor(hexString: "D7CBB7")
        textField.textColor = .color4B3621
        textField.rounded(radius: 22)
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

        
        sendButton.setImage(UIImage(systemName: "arrow.right")?.withRenderingMode(.alwaysTemplate), for: .normal)
        sendButton.tintColor = .color4B3621
        sendButton.rounded(radius: 12)
        sendButton.backgroundColor = UIColor(hexString: "D7CBB7")
        
        textField.snp.makeConstraints { make in
            make.left.equalToSuperview().offset(16)
            make.centerY.equalToSuperview()
            make.right.equalTo(sendButton.snp.left).offset(-8)
            make.height.equalTo(44)
        }

        sendButton.snp.makeConstraints { make in
            make.right.equalToSuperview().offset(-16)
            make.centerY.equalToSuperview()
            make.width.height.equalTo(44)
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
