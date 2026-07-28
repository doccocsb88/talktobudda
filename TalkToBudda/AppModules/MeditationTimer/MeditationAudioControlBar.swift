//
//  MeditationAudioControlBar.swift
//  TalkToBudda
//
//  Created by mac on 7/5/25.
//

import UIKit

final class MeditationAudioControlBar: UIView {
    private let contentCard = UIView()
    private let sectionLabel = UILabel()

    let titleLabel: UIButton = {
        let label = UIButton()
        label.setImage(Asset.Assets.icVolumeOn.image.withRenderingMode(.alwaysTemplate), for: .normal)
        label.setTitle("Meditation vocal pad", for: .normal)
        label.setTitleColor(.color4B3621, for: .normal)
        label.titleLabel?.font = FontFamily.PlayfairDisplay.medium.font(size: 16)
        label.imageView?.contentMode = .scaleAspectFit
        label.tintColor = UIColor(hexString: "99713A")
        label.contentHorizontalAlignment = .left
        label.contentEdgeInsets = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
        label.imageEdgeInsets = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 10)
        label.titleEdgeInsets = UIEdgeInsets(top: 0, left: 10, bottom: 0, right: 0)
        return label
    }()

    let volumeSlider: UISlider = {
        let slider = UISlider()
        slider.value = 0.7
        slider.thumbTintColor = UIColor(hexString: "99713A")
        slider.tintColor = UIColor(hexString: "99713A")
        return slider
    }()

    let muteButton: UIButton = {
        let button = UIButton()
        button.setImage(Asset.Assets.icVolumeOn.image.withRenderingMode(.alwaysTemplate), for: .normal)
        button.setImage(Asset.Assets.icVolumeOff.image.withRenderingMode(.alwaysTemplate), for: .selected)

        button.tintColor = UIColor(hexString: "99713A")
        button.imageView?.contentMode = .scaleAspectFit
        button.imageEdgeInsets = UIEdgeInsets(top: 5, left: 5, bottom: 5, right: 5)
        return button
    }()
    
    var onVolumeChanged: ((Float)->())?
    var onMuteChanged: (()->())?
    var onTappedSound: (()->())?

    override init(frame: CGRect) {
        super.init(frame: frame)
        setupUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    
    private func setupUI() {
        contentCard.backgroundColor = UIColor.white.withAlphaComponent(0.52)
        contentCard.layer.cornerRadius = 22
        contentCard.layer.borderWidth = 1
        contentCard.layer.borderColor = UIColor(hexString: "E7D8C2").cgColor

        sectionLabel.text = "Background sound"
        sectionLabel.textColor = UIColor(hexString: "#8D6E4C")
        sectionLabel.font = FontFamily.Inter28pt.medium.font(size: 12)

        addSubview(contentCard)
        [sectionLabel, titleLabel, volumeSlider, muteButton].forEach(contentCard.addSubview)

        contentCard.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }

        sectionLabel.snp.makeConstraints {
            $0.top.equalToSuperview().offset(14)
            $0.left.right.equalToSuperview().inset(16)
        }

        titleLabel.snp.makeConstraints {
            $0.top.equalTo(sectionLabel.snp.bottom).offset(6)
            $0.left.right.equalToSuperview().inset(16)
            $0.height.equalTo(30)
        }

        muteButton.snp.makeConstraints {
            $0.top.equalTo(titleLabel.snp.bottom).offset(12)
            $0.right.equalToSuperview().inset(14)
            $0.width.height.equalTo(40)
        }
        
        volumeSlider.snp.makeConstraints {
            $0.centerY.equalTo(muteButton.snp.centerY)
            $0.left.equalToSuperview().inset(16)
            $0.right.equalTo(muteButton.snp.left).offset(-8)
            $0.bottom.equalToSuperview().inset(16)
        }
        
        muteButton.addTarget(self, action: #selector(tappedMuteButton(_:)), for: .touchUpInside)
        volumeSlider.addTarget(self, action: #selector(sliderValueChanged(_:)), for: .valueChanged)
        titleLabel.addTarget(self, action: #selector(tappedSoundButton(_:)), for: .touchUpInside)
    }

    func updateMuteState(isMute: Bool) {
        muteButton.isSelected = isMute
    }
    
    func updateSoundName(_ name: String) {
        titleLabel.setTitle(name, for: .normal)
    }
    
    @objc func tappedMuteButton(_ sender: UIButton) {
        onMuteChanged?()
    }
    
    @objc func tappedSoundButton(_ sender: UIButton) {
        onTappedSound?()
    }
    
    @objc func sliderValueChanged(_ slider: UISlider) {
        onVolumeChanged?(slider.value)
    }
}
