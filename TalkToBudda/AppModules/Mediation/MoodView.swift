//
//  MoodView.swift
//  TalkToBudda
//
//  Created by mac on 7/5/25.
//

import UIKit
import SnapKit


class MoodView: UIView {
    let imageView = UIImageView()
    let textLabel = UILabel()
    private let selectionRing = UIView()
    let button = UIButton()
    
    var onSelectMood: ((Mood)->())?
    private let mood: Mood
    
    init(mood: Mood) {
        self.mood = mood
        super.init(frame: .zero)
        setupUIs()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setupUIs() {
        [selectionRing, imageView, textLabel, button].forEach{addSubview($0)}
        imageView.contentMode = .scaleAspectFit
        textLabel.text = mood.text
        textLabel.font = FontFamily.PlayfairDisplay.regular.font(size: 12)
        textLabel.textColor = .color7D5A4F
        textLabel.textAlignment = .center
        
        imageView.image = mood.icon
        
        selectionRing.backgroundColor = UIColor(hexString: "#F7E9CE")
        selectionRing.layer.borderWidth = 1.5
        selectionRing.layer.borderColor = UIColor(hexString: "#D8B17A").cgColor
        selectionRing.layer.cornerRadius = 34
        selectionRing.alpha = 0

        button.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
        
        selectionRing.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(2)
            make.centerX.equalToSuperview()
            make.width.height.equalTo(68)
        }
        
        imageView.snp.makeConstraints{
            $0.left.right.top.equalToSuperview()
            $0.height.equalTo(imageView.snp.width)
        }
        
        textLabel.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.top.equalTo(imageView.snp.bottom).offset(4)
        }
        
        button.addTarget(self, action: #selector(tappedButton(_:)), for: .touchUpInside)
    }
    
    func updateSelection(isSelected: Bool) {
        selectionRing.alpha = isSelected ? 1 : 0
        imageView.alpha = isSelected ? 1 : 0.8
        textLabel.alpha = isSelected ? 1 : 0.72
        textLabel.font = isSelected ? FontFamily.PlayfairDisplay.bold.font(size: 12) : FontFamily.PlayfairDisplay.regular.font(size: 12)
    }
    
    
    @objc func tappedButton(_ sender: UIButton) {
        onSelectMood?(mood)
    }
}
