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
        [imageView, textLabel, button].forEach{addSubview($0)}
        imageView.contentMode = .scaleAspectFit
        textLabel.text = mood.text
        textLabel.font = FontFamily.PlayfairDisplay.regular.font(size: 12)
        textLabel.textColor = .color7D5A4F
        
        imageView.image = mood.icon
        
        button.snp.makeConstraints { make in
            make.edges.equalToSuperview()
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
    
    
    @objc func tappedButton(_ sender: UIButton) {
        onSelectMood?(mood)
    }
}
