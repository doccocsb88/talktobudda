//
//  ListSoundVC .swift
//  TalkToBudda
//
//  Created by mac on 9/5/25.
//

import UIKit
import SnapKit
import RxSwift

struct SoundCodable: Codable, Equatable{
    let title: String
    let name: String
    
    static let `default` = SoundCodable(title: "meditation vocal pad", name: "meditation-vocal-pad-84-amin-171546.mp3")
}
class ListSoundView: UIViewController {
    private var soundOptions: [SoundCodable] = []
    
    private var tableView: UITableView!
    private let titleLabel = UILabel()
    private lazy var navView = UIView()
    private let backButton = UIButton()
    private let saveButton = UIButton()

    let soundPlayer = MeditationAudioPlayer()
    private var selectedSound: SoundCodable?
    private var state: MeditationAudioState = .stopped
    
    deinit {
        soundPlayer.stop()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        initDatas()
        setupRX()
        setupUI()
    }

    private func initDatas() {
        soundOptions.append(SoundCodable(title: "calm relaxing pad", name: "calm-relaxing-pad-258065.mp3"))
        soundOptions.append(SoundCodable(title: "fire sound", name: "fire-sound-310285.mp3"))
        soundOptions.append(SoundCodable(title: "meditation vocal pad", name: "meditation-vocal-pad-84-amin-171546.mp3"))
        soundOptions.append(SoundCodable(title: "peacefull drone", name: "peacefull-drone-132285.mp3"))
        soundOptions.append(SoundCodable(title: "rain-01", name: "rain-01.mp3"))
        soundOptions.append(SoundCodable(title: "singing bell hit", name: "singing-bell-hit-2-75258.mp3"))
        soundOptions.append(SoundCodable(title: "TunePocket Om Shanti Om", name: "TunePocket-Om-Shanti-Om-Preview.mp3"))
        soundOptions.append(SoundCodable(title: "TunePocket Reiki Healing", name: "TunePocket-Reiki-Healing-Preview.mp3"))
        soundOptions.append(SoundCodable(title: "water relaxing sound", name: "water-relaxing-sound-121599.mp3"))
    }
    
    private func setupRX() {
        let o1 = soundPlayer.stateSubject
        let o2 = soundPlayer.soundSubject
        
       let _ = Observable.combineLatest(o1, o2)
            .take(until: self.rx.deallocated)
            .observe(on: MainScheduler.asyncInstance)
            .subscribe(onNext: {[weak self] state, sound in
                self?.selectedSound = sound
                self?.state = state
                self?.tableView.reloadData()
            })
    }
    
    private func setupUI() {
        navigationController?.setNavigationBarHidden(true, animated: false)
        view.backgroundColor = UIColor(red: 0.96, green: 0.93, blue: 0.86, alpha: 1.0)
        view.addSubview(navView)
        // Tiêu đề
        titleLabel.text = "Choose Background Sound"
        titleLabel.font = FontFamily.PlayfairDisplay.medium.font(size: 16)
        titleLabel.textColor = .black
        navView.addSubview(titleLabel)
        navView.addSubview(backButton)
        navView.addSubview(saveButton)

        titleLabel.snp.makeConstraints { make in
            make.center.equalToSuperview()
        }

        navView.snp.makeConstraints { make in
            make.left.right.equalToSuperview()
            make.top.equalTo(view.safeAreaLayoutGuide).offset(0)
            make.height.equalTo(44)
        }
        
        // Nút quay lại
        
        backButton.setImage(Asset.Assets.icBack.image.withRenderingMode(.alwaysTemplate), for: .normal)
        backButton.imageView?.contentMode = .scaleAspectFit
        backButton.tintColor = .color4B3621
        backButton.addTarget(self, action: #selector(backTapped), for: .touchUpInside)
        
        saveButton.isEnabled = false
        saveButton.setTitle("Save", for: .normal)
        saveButton.setTitleColor(.color4B3621, for: .normal)
        saveButton.setTitleColor(.lightGray, for: .disabled)

        saveButton.titleLabel?.font = FontFamily.PlayfairDisplay.medium.font(size: 16)
        saveButton.addTarget(self, action: #selector(tappedSaveButton), for: .touchUpInside)
        backButton.snp.makeConstraints { make in
            make.centerY.equalToSuperview()
            make.leading.equalToSuperview().offset(8)
            make.width.height.equalTo(40)
        }
        
        saveButton.snp.makeConstraints { make in
            make.centerY.equalToSuperview()
            make.trailing.equalToSuperview().inset(8)
        }
        
        // TableView hiển thị danh sách âm thanh
        tableView = UITableView(frame: .zero, style: .plain)
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(ListSoundTVC.self, forCellReuseIdentifier: "ListSoundTVC")
        tableView.backgroundColor = .clear
        tableView.separatorStyle = .singleLine
        view.addSubview(tableView)

        tableView.snp.makeConstraints { make in
            make.top.equalTo(navView.snp.bottom).offset(20)
            make.leading.trailing.bottom.equalToSuperview()
        }
    }

    @objc private func backTapped() {
        dismiss(animated: true)
    }
    
    @objc private func tappedSaveButton() {
        guard let sound = selectedSound else { return }
        PreferenceService.shared.meditationSound = sound
        MeditationAudioPlayer.shared.playMeditationSound(sound: sound)
        dismiss(animated: true)
    }
}

extension ListSoundView: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return soundOptions.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "ListSoundTVC", for: indexPath) as? ListSoundTVC else {
            return UITableViewCell()
        }
        var playing: Bool = false
        let sound = soundOptions[indexPath.row]
        if sound.name == selectedSound?.name, state == .playing {
            playing = true
        }
        cell.updateContentView(sound, playing: playing)
        cell.playPauseHandler = {[weak self] in
            if sound == self?.selectedSound {
                self?.soundPlayer.togglePlayPause()
            } else {
                self?.soundPlayer.playMeditationSound(sound: sound)
            }
        }
        return cell
    }

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let selectedSound = soundOptions[indexPath.row]
        print("Selected sound: \(selectedSound)")
        // Logic để phát âm thanh hoặc chuyển về màn hình thiền với âm thanh đã chọn
        tableView.deselectRow(at: indexPath, animated: true)
        
//        PreferenceService.shared.meditationSound = selectedSound
        soundPlayer.playMeditationSound(sound: selectedSound)
        saveButton.isEnabled = true
    }

    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 50
    }
}
