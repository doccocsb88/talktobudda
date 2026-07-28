//
//  ListSoundTVC.swift
//  TalkToBudda
//
//  Created by mac on 12/5/25.
//

import UIKit
import SnapKit

class ListSoundTVC: UITableViewCell {
    private let cardView = UIView()
    private let accentBar = UIView()
    private let selectionBadge = UILabel()
    private lazy var nameLabel: UILabel = {
        let label = UILabel()
        label.textColor = .color4B3621
        label.font = FontFamily.PlayfairDisplay.medium.font(size: 16)
        label.numberOfLines = 2
        return label
    }()

    private lazy var subtitleLabel: UILabel = {
        let label = UILabel()
        label.textColor = UIColor(hexString: "#8E6B45")
        label.font = FontFamily.FiraMono.regular.font(size: 11)
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
        selectionStyle = .none

        cardView.backgroundColor = UIColor.white.withAlphaComponent(0.5)
        cardView.layer.cornerRadius = 18
        cardView.layer.borderWidth = 1
        cardView.layer.borderColor = UIColor(hexString: "#E6D7C1").cgColor

        accentBar.backgroundColor = UIColor(hexString: "#D1A35B")
        accentBar.layer.cornerRadius = 2
        
        selectionBadge.text = "Selected"
        selectionBadge.textAlignment = .center
        selectionBadge.textColor = UIColor(hexString: "#8B6438")
        selectionBadge.backgroundColor = UIColor(hexString: "#F8E8C8")
        selectionBadge.font = FontFamily.Inter28pt.medium.font(size: 10)
        selectionBadge.layer.cornerRadius = 9
        selectionBadge.clipsToBounds = true
        selectionBadge.isHidden = true

        contentView.addSubview(cardView)
        [accentBar, nameLabel, subtitleLabel, pausePlayButton, selectionBadge].forEach(cardView.addSubview)

        cardView.snp.makeConstraints { make in
            make.edges.equalToSuperview().inset(UIEdgeInsets(top: 6, left: 16, bottom: 6, right: 16))
        }

        accentBar.snp.makeConstraints { make in
            make.left.equalToSuperview().offset(12)
            make.centerY.equalToSuperview()
            make.width.equalTo(4)
            make.height.equalTo(34)
        }

        nameLabel.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(14)
            make.left.equalTo(accentBar.snp.right).offset(12)
            make.right.equalTo(pausePlayButton.snp.left).offset(-12)
        }
        
        selectionBadge.snp.makeConstraints { make in
            make.left.equalTo(nameLabel)
            make.top.equalTo(nameLabel.snp.bottom).offset(6)
            make.height.equalTo(18)
            make.width.greaterThanOrEqualTo(62)
        }

        subtitleLabel.snp.makeConstraints { make in
            make.top.equalTo(selectionBadge.snp.bottom).offset(6)
            make.left.equalTo(nameLabel)
            make.right.equalTo(nameLabel)
            make.bottom.equalToSuperview().inset(14)
        }
        
        pausePlayButton.snp.makeConstraints { make in
            make.width.height.equalTo(36)
            make.centerY.equalToSuperview()
            make.right.equalToSuperview().inset(14)
        }
        
        pausePlayButton.addTarget(self, action: #selector(tappedPlayPauseButton(_:)), for: .touchUpInside)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func updateContentView(_ sound: SoundCodable, playing: Bool, selected: Bool) {
        nameLabel.text = sound.title.capitalized
        subtitleLabel.text = playing ? "Previewing now" : (selected ? "Ready to save" : "Tap to preview")
        pausePlayButton.isSelected = playing
        selectionBadge.isHidden = !selected
        cardView.backgroundColor = playing ? UIColor(hexString: "#FFF2D5") : (selected ? UIColor(hexString: "#FFF8EB") : UIColor.white.withAlphaComponent(0.5))
        cardView.layer.borderColor = (playing ? UIColor(hexString: "#D6A85D") : (selected ? UIColor(hexString: "#E1BC7E") : UIColor(hexString: "#E6D7C1"))).cgColor
        accentBar.backgroundColor = playing ? UIColor(hexString: "#B8822E") : (selected ? UIColor(hexString: "#C99A4A") : UIColor(hexString: "#D1A35B"))
    }
    
    @objc func tappedPlayPauseButton(_ sender: UIButton) {
        playPauseHandler?()
    }
}
