//
//  ListSoundTVC.swift
//  TalkToBudda
//
//  Created by mac on 12/5/25.
//

import UIKit
import SnapKit

class ListSoundTVC: UITableViewCell {
    private lazy var nameLabel: UILabel = {
        let label = UILabel()
        label.textColor = .color4B3621
        label.font = FontFamily.PlayfairDisplay.medium.font(size: 16)
        return label
    }()
    
    private lazy var pausePlayButton: UIButton = {
        let button = UIButton()
        button.setImage(Asset.Assets.icPlay.image.withRenderingMode(.alwaysTemplate), for: .normal)
        button.setImage(Asset.Assets.icPause.image.withRenderingMode(.alwaysTemplate), for: .selected)
        button.tintColor = .color7D5A4F
        return button
    }()
    
    var playPauseHandler: (()->())?
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        backgroundColor = .clear
        contentView.backgroundColor = .clear
        contentView.addSubview(nameLabel)
        contentView.addSubview(pausePlayButton)
        nameLabel.snp.makeConstraints { make in
            make.centerY.equalToSuperview()
            make.left.equalToSuperview().offset(16)
        }
        
        pausePlayButton.snp.makeConstraints { make in
            make.width.height.equalTo(30)
            make.centerY.equalToSuperview()
            make.right.equalToSuperview().inset(16)
        }
        
        pausePlayButton.addTarget(self, action: #selector(tappedPlayPauseButton(_:)), for: .touchUpInside)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func updateContentView(_ sound: SoundCodable, playing: Bool) {
        nameLabel.text = sound.title.capitalized
        pausePlayButton.isSelected = playing
    }
    
    @objc func tappedPlayPauseButton(_ sender: UIButton) {
        playPauseHandler?()
    }
}
