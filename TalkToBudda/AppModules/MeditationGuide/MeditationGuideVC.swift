//
//  MeditationGuideVC.swift
//  TalkToBudda
//
//  Created by mac on 11/5/25.
//


import UIKit
import SnapKit

class MeditationGuideVC: UIViewController {
    
    // MARK: - UI Components
    private let scrollView = UIScrollView()
    private let contentView = UIStackView()
    
    private let titleLabel = UILabel()
    private let purposeLabel = UILabel()
    private let methodLabel = UILabel()
    private let benefitsLabel = UILabel()
    private let practiceTitleLabel = UILabel()
    private let practiceStackView = UIStackView()
    private let backButton = UIButton()
    private let navView = UIView()
    
    var meditation: MeditationCodable?
    init(meditation: MeditationCodable? = nil) {
        self.meditation = meditation
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        setupLayout()
        visualizer()
        populateData()
    }
    
    private func setupUI() {
        view.backgroundColor = .colorFDF6ED
        view.addSubview(navView)
        
        navView.addSubview(backButton)
        navView.addSubview(titleLabel)

        
        backButton.setImage(Asset.Assets.icBack.image.withRenderingMode(.alwaysTemplate), for: .normal)
        backButton.imageView?.contentMode = .scaleAspectFit
        backButton.tintColor = .color4B3621
        backButton.addTarget(self, action: #selector(tappedBackButton(_:)), for: .touchUpInside)
        
        // ScrollView and ContentView setup
        scrollView.alwaysBounceVertical = true
        view.addSubview(scrollView)
        
        contentView.axis = .vertical
        contentView.spacing = 16
        contentView.layoutMargins = UIEdgeInsets(top: 16, left: 16, bottom: 16, right: 16)
        contentView.isLayoutMarginsRelativeArrangement = true
        scrollView.addSubview(contentView)
        
        // Title Label
        titleLabel.font = FontFamily.PlayfairDisplay.bold.font(size: 20)
        titleLabel.numberOfLines = 0
        titleLabel.textAlignment = .center
        titleLabel.textColor =  UIColor(hexString: "#4B3621")
        // Section Labels
        [purposeLabel, methodLabel, benefitsLabel, practiceTitleLabel].forEach {
            $0.font = .systemFont(ofSize: 18, weight: .medium)
            $0.numberOfLines = 0
        }
        
        practiceStackView.axis = .vertical
        practiceStackView.spacing = 8
        
        // Add views to StackView
        contentView.addArrangedSubview(purposeLabel)
        contentView.addArrangedSubview(methodLabel)
        contentView.addArrangedSubview(benefitsLabel)
        contentView.addArrangedSubview(practiceTitleLabel)
        contentView.addArrangedSubview(practiceStackView)
    }
    
    private func setupLayout() {
        navView.snp.makeConstraints { make in
            make.left.right.equalToSuperview()
            make.top.equalTo(view.safeAreaLayoutGuide.snp.top)
            make.height.equalTo(44)
        }
        
        backButton.snp.makeConstraints { make in
            make.left.equalToSuperview().offset(8)
            make.centerY.equalToSuperview()
            make.width.height.equalTo(44)
        }
        
        titleLabel.snp.makeConstraints { make in
            make.center.equalToSuperview()
            make.left.equalTo(backButton.snp.right).offset(8)
        }
        
        scrollView.snp.makeConstraints { make in
            make.left.bottom.right.equalToSuperview()
            make.top.equalTo(navView.snp.bottom)
        }
        
        contentView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
            make.width.equalToSuperview()
        }
    }
    
    func visualizer() {
        titleLabel.font = FontFamily.PlayfairDisplay.semiBold.font(size: 16)
        purposeLabel.font = FontFamily.PlayfairDisplay.regular.font(size: 16)
        methodLabel.font = FontFamily.PlayfairDisplay.regular.font(size: 16)
        benefitsLabel.font = FontFamily.PlayfairDisplay.regular.font(size: 16)
        practiceTitleLabel.font = FontFamily.PlayfairDisplay.bold.font(size: 16)
    }
    
    func populateData() {
        guard let meditation = meditation else { return }
        
        titleLabel.text = meditation.name
        purposeLabel.text = "Purpose: \(meditation.purpose)"
        methodLabel.text = "Method: \(meditation.method)"
        benefitsLabel.text = "Benefits: \(meditation.benefits)"
        practiceTitleLabel.text = "How to Practice:"
        
        purposeLabel.highlight(text: "Purpose:", with: FontFamily.PlayfairDisplay.semiBold.font(size: 16), color: .black)
        methodLabel.highlight(text: "Method:", with: FontFamily.PlayfairDisplay.semiBold.font(size: 16), color: .black)
        benefitsLabel.highlight(text: "Benefits:", with: FontFamily.PlayfairDisplay.semiBold.font(size: 16), color: .black)

        meditation.how_to_practice.enumerated().forEach { index, step in
            let stepLabel = UILabel()
            stepLabel.font = .systemFont(ofSize: 16)
            stepLabel.text = "\(index + 1). \(step)"
            stepLabel.numberOfLines = 0
            stepLabel.font = FontFamily.PlayfairDisplay.regular.font(size: 16)
            practiceStackView.addArrangedSubview(stepLabel)
        }
    }
    
    @objc func tappedBackButton(_ sender: UIButton) {
        dismiss(animated: true)
    }
}
