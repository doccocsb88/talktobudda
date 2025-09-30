//
//  MeditationAudioControlBar.swift
//  TalkToBudda
//
//  Created by mac on 7/5/25.
//

import UIKit

final class MeditationAudioControlBar: UIView {

    let titleLabel: UIButton = {
        let label = UIButton()
        label.setImage(Asset.Assets.icSearch.image, for: .normal)
        label.setTitle("Sound: Bamboo Flute", for: .normal)
        label.setTitleColor(.color4B3621, for: .normal)
        label.titleLabel?.font = FontFamily.FiraMono.medium.font(size: 14)
        label.imageView?.contentMode = .scaleAspectFit
        label.imageEdgeInsets = UIEdgeInsets(top: 0, left: -8, bottom: 0, right: 8)
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
        addSubview(titleLabel)
        addSubview(volumeSlider)
        addSubview(muteButton)
        titleLabel.snp.makeConstraints {
            $0.top.equalToSuperview().offset(8)
            $0.centerX.equalToSuperview()
            $0.height.equalTo(30)
        }

        muteButton.snp.makeConstraints {
            $0.top.equalTo(titleLabel.snp.bottom).offset(8)
            $0.right.equalToSuperview().inset(8)
            $0.width.height.equalTo(40)
        }
        
        volumeSlider.snp.makeConstraints {
            $0.centerY.equalTo(muteButton.snp.centerY)
            $0.left.equalToSuperview().inset(8)
            $0.right.equalTo(muteButton.snp.left).offset(-8)
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
