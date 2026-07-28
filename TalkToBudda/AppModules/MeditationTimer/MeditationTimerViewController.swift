//
//  MeditationTimerViewController.swift
//  TalkToBudda
//
//  Created by mac on 6/5/25.
//

import UIKit
import SnapKit

final class MeditationTimerViewController: UIViewController, MeditationTimerViewable {
    var presenter: MeditationTimerPresentable?
    
    private let navView = UIView()
    private let titleLabel = UILabel()
    private let backgroundImageView = UIImageView(image: Asset.Assets.bgMeditationTimer.image)
    private let quoteLabel = UILabel()
    private let timerLabel = UILabel()
    private let pauseButton = UIButton()
    private let stopButton = UIButton()
    private lazy var audioView: MeditationAudioControlBar = {
        let audioView  = MeditationAudioControlBar()
        audioView.onMuteChanged = {
            MeditationAudioPlayer.shared.toggleMute()
        }
        
        audioView.onVolumeChanged = { value in
            MeditationAudioPlayer.shared.setVolume(value)
        }
        
        audioView.onTappedSound = { [weak self] in
            self?.showListSoundVC()
        }
        return audioView
    }()
    
    private let donateButton = UIButton()
    private let donateLabel = UILabel()
    private let backButton = UIButton()
    private let timerCardView = UIView()
    private let donateCardView = UIView()
    private let controlsStackView = UIStackView()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = UIColor(hexString: "#FDF6ED")
        setupRX()
        setupUI()
        presenter?.viewDidLoad()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.tabBarController?.tabBar.isHidden = true
        MeditationAudioPlayer.shared.play()
        quoteLabel.text = presenter?.quotes.randomElement()?.quote ?? "Let your soul be still..."

    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        MeditationAudioPlayer.shared.pause()
        if self.isMovingFromParent {
            self.tabBarController?.tabBar.isHidden = false
        }
    }
    
    private func setupRX() {
        let _ = MeditationAudioPlayer.shared
            .muteSubject
            .take(until: self.rx.deallocated)
            .subscribe(onNext: {[weak self] isMuted in
                self?.audioView.updateMuteState(isMute: isMuted)
            })
        
        let _ = MeditationAudioPlayer.shared
            .stateSubject
            .take(until: self.rx.deallocated)
            .subscribe(onNext: {[weak self] state in
                self?.pauseButton.isSelected = state == .playing
            })
        
        let _ = MeditationAudioPlayer.shared
            .soundSubject
            .take(until: self.rx.deallocated)
            .subscribe(onNext: {[weak self] sound in
                self?.audioView.updateSoundName(sound.title)
            })
        
        Task {
            try? await StoreKitManager.shared.loadProducts()
            if let karmarProduct = StoreKitManager.shared.hasItem(item: .karma) {
                donateButton.isHidden = false
                donateButton.setTitle("Plant a seed of wisdom for just \(karmarProduct.displayPrice)", for: .normal)
            } else {
                donateButton.isHidden = true
            }
            
            donateLabel.isHidden = StoreKitManager.shared.isPremium
            donateButton.isHidden = StoreKitManager.shared.isPremium
        }
    }
    
    private func setupUI() {
        [backgroundImageView, navView, quoteLabel, timerCardView, audioView, controlsStackView, donateCardView].forEach({view.addSubview($0)})
        [titleLabel, backButton].forEach({navView.addSubview($0)})
        timerCardView.addSubview(timerLabel)
        donateCardView.addSubview(donateButton)
        donateCardView.addSubview(donateLabel)
        backgroundImageView.alpha = 0.18
        backgroundImageView.contentMode = .scaleAspectFill
        backgroundImageView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
        
        titleLabel.font = FontFamily.PlayfairDisplay.bold.font(size: 24)
        titleLabel.textAlignment = .center
        titleLabel.textColor = UIColor(hexString: "#4B3621")

        backButton.setImage(Asset.Assets.icBack.image.withRenderingMode(.alwaysTemplate), for: .normal)
        backButton.imageView?.contentMode = .scaleAspectFit
        backButton.tintColor = .color4B3621
                
        donateButton.setImage(Asset.Assets.icDonate2.image, for: .normal)
        donateButton.setTitle("Plant a seed of wisdom for just $0.99", for: .normal)
        donateButton.setTitleColor(.color4B3621, for: .normal)
        donateButton.imageView?.contentMode = .scaleAspectFit
        donateButton.titleLabel?.font = FontFamily.PlayfairDisplay.medium.font(size: 12)
        donateButton.titleEdgeInsets = UIEdgeInsets(top: 0, left: 5, bottom: 0, right: -5)
        donateButton.imageEdgeInsets = UIEdgeInsets(top: 0, left: -5, bottom: 0, right: 5)

        donateLabel.text = "Get 10 bonus chats to deepen your practice."
        donateLabel.textColor = .gray100
        donateLabel.font = FontFamily.PlayfairDisplay.regular.font(size: 12)
        donateLabel.textAlignment = .center

        navView.snp.makeConstraints { make in
            make.left.right.equalToSuperview()
            make.top.equalTo(view.safeAreaLayoutGuide.snp.top)
            make.height.equalTo(44)
        }
        
        titleLabel.snp.makeConstraints {
            $0.center.equalToSuperview()
        }
        
        backButton.snp.makeConstraints { make in
            make.centerY.equalToSuperview()
            make.left.equalToSuperview().inset(8)
            make.width.height.equalTo(44)
        }
        
     
        quoteLabel.text = "Let your soul be still..."
        quoteLabel.textAlignment = .center
        quoteLabel.numberOfLines = 0
        quoteLabel.font = FontFamily.PlayfairDisplay.italic.font(size: 13)
        quoteLabel.textColor = UIColor(hexString: "#8A6B57").withAlphaComponent(0.7)
        quoteLabel.snp.makeConstraints {
            $0.top.equalTo(navView.snp.bottom).offset(18)
            $0.centerX.equalToSuperview()
            $0.left.right.equalToSuperview().inset(40)
        }
        
        timerLabel.text = "00:10:00"
        timerLabel.font = FontFamily.Inter28pt.semiBold.font(size: 68)
        timerLabel.textAlignment = .center
        timerLabel.textColor = UIColor(hexString: "C09A5B")

        timerCardView.backgroundColor = UIColor.white.withAlphaComponent(0.34)
        timerCardView.layer.cornerRadius = 30
        timerCardView.layer.borderWidth = 1
        timerCardView.layer.borderColor = UIColor.white.withAlphaComponent(0.55).cgColor
        timerCardView.layer.shadowColor = UIColor(hexString: "#E4D2BA").cgColor
        timerCardView.layer.shadowOpacity = 0.32
        timerCardView.layer.shadowRadius = 22
        timerCardView.layer.shadowOffset = CGSize(width: 0, height: 12)
        timerCardView.snp.makeConstraints {
            $0.top.equalTo(quoteLabel.snp.bottom).offset(18)
            $0.left.right.equalToSuperview().inset(24)
            $0.height.equalTo(190)
        }

        timerLabel.snp.makeConstraints {
            $0.center.equalToSuperview()
        }
        
        controlsStackView.axis = .horizontal
        controlsStackView.spacing = 16
        controlsStackView.distribution = .fillEqually
        controlsStackView.addArrangedSubview(pauseButton)
        controlsStackView.addArrangedSubview(stopButton)
        
        pauseButton.setTitle("Pause", for: .normal)
        pauseButton.setImage(Asset.Assets.icPlay.image.withRenderingMode(.alwaysTemplate), for: .normal)
        pauseButton.setImage(Asset.Assets.icPause.image.withRenderingMode(.alwaysTemplate), for: .selected)
        
        
        stopButton.setTitle("Finish", for: .normal)
        stopButton.setImage(Asset.Assets.icStop.image.withRenderingMode(.alwaysTemplate), for: .normal)
        
        [pauseButton, stopButton].forEach{
            $0.titleLabel?.font = FontFamily.Inter28pt.medium.font(size: 18)
            $0.setTitleColor(.color7D5A4F, for: .normal)
            $0.tintColor = .color7D5A4F
            $0.imageEdgeInsets = UIEdgeInsets(top: 0, left: -3, bottom: 0, right: 3)
            $0.titleEdgeInsets = UIEdgeInsets(top: 0, left: 3, bottom: 0, right: -3)
            $0.backgroundColor = UIColor.white.withAlphaComponent(0.88)
            $0.rounded(radius: 14, borderWidth: 1, borderColor: .color7D5A4F)
        }
                
        audioView.snp.makeConstraints { make in
            make.top.equalTo(timerCardView.snp.bottom).offset(18)
            make.left.right.equalToSuperview().inset(24)
            make.height.equalTo(110)
        }

        controlsStackView.snp.makeConstraints {
            $0.top.equalTo(audioView.snp.bottom).offset(16)
            $0.left.right.equalToSuperview().inset(48)
            $0.height.equalTo(54)
        }

        donateCardView.backgroundColor = UIColor.white.withAlphaComponent(0.34)
        donateCardView.layer.cornerRadius = 22
        donateCardView.layer.borderWidth = 1
        donateCardView.layer.borderColor = UIColor(hexString: "E5D8C4").withAlphaComponent(0.72).cgColor
        donateCardView.snp.makeConstraints { make in
            make.top.equalTo(controlsStackView.snp.bottom).offset(28)
            make.left.right.equalToSuperview().inset(24)
            make.bottom.equalTo(view.safeAreaLayoutGuide.snp.bottom).inset(14)
        }
        
        donateButton.contentHorizontalAlignment = .center
        donateButton.alpha = 0.88
        donateButton.snp.makeConstraints { make in
            make.height.equalTo(36)
            make.top.equalToSuperview().offset(14)
            make.left.right.equalToSuperview().inset(14)
        }
      
        donateLabel.snp.makeConstraints { make in
            make.top.equalTo(donateButton.snp.bottom).offset(6)
            make.left.right.equalToSuperview().inset(18)
            make.bottom.equalToSuperview().inset(14)
        }
        
        pauseButton.addTarget(self, action: #selector(pauseTapped), for: .touchUpInside)
        stopButton.addTarget(self, action: #selector(stopTapped), for: .touchUpInside)
        donateButton.addTarget(self, action: #selector(tappedDonateButton), for: .touchUpInside)
        backButton.addTarget(self, action: #selector(tappedBackButton(_:)), for: .touchUpInside)
    }
    
    func updateTimerDisplay(timeString: String) {
        timerLabel.text = timeString
    }
    
    func showMeditationTitle(_ title: String) {
        titleLabel.text = title.capitalized
    }
    
    func showListSoundVC() {
        let vc = ListSoundView()
        vc.modalPresentationStyle = .fullScreen
        present(vc, animated: true)
    }
    
    @objc private func pauseTapped() {
        presenter?.didTapPause()
    }
    
    @objc private func stopTapped() {
        presenter?.didTapStop()
    }
    
    @objc func tappedBackButton(_ sender: UIButton) {
        presenter?.didTapBack()
        navigationController?.popViewController(animated: true)
    }
    
    @objc func tappedDonateButton(_ sender: UIButton) {
        Task {
            await StoreKitManager.shared.purchase(item: .karma)
        }
    }
}
