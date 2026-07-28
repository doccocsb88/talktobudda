//
//  OnboardingViewController.swift
//  ResumeBuilder
//
//  Created by mac on 22/4/25.
//

import SnapKit
import UIKit

class OnboardingViewController: UIViewController {
    private let scrollView = UIScrollView()
    private let ambientView = UIView()
    private lazy var nextButton: UIButton = {
        let button = UIButton()
        button.isHidden = true
        button.isUserInteractionEnabled = true
        button.setTitle("Start the Journey", for: .normal)
        button.setTitleColor(.white, for: .normal)
        button.titleLabel?.font = FontFamily.PlayfairDisplay.bold.font(size: 18)
        button.backgroundColor = UIColor(hexString: "#B77945")
        button.rounded(radius: 16, borderWidth: 0, borderColor: .clear)
        button.layer.shadowColor = UIColor(hexString: "#9E6A40").cgColor
        button.layer.shadowOpacity = 0.24
        button.layer.shadowOffset = CGSize(width: 0, height: 12)
        button.layer.shadowRadius = 20
        button.addTarget(self, action: #selector(tappedNextButton(_:)), for: .touchUpInside)
        return button
    }()

    private lazy var pageControl: UIPageControl = {
        let control = UIPageControl()
        control.numberOfPages = 3
        control.currentPageIndicatorTintColor = .color7D5A4F
        control.pageIndicatorTintColor = .colorE9D8C0
        return control
    }()
    
    private var pages: [(image: UIImage?, title: String, subtitle: String)] = []

    private var currentPageIndex: Int = 0 {
        didSet {
            nextButton.isHidden = currentPageIndex < 2
            pageControl.currentPage = currentPageIndex
        }
    }
    
    init() {
        super.init(nibName: nil, bundle: nil)
        viewDidLoad()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .colorE9D8C0
//        let gradientLayer = CAGradientLayer()
//        gradientLayer.frame = view.bounds
//        gradientLayer.colors = [
//            UIColor(hexString: "#CCE5FF").cgColor,
//            //            UIColor(hexString: "#FFFFFF").cgColor,
//            UIColor.white.cgColor
//        ]
//        gradientLayer.startPoint = CGPoint(x: 0.5, y: 0)
//        gradientLayer.endPoint = CGPoint(x: 0.5, y: 1)
//
//        view.layer.insertSublayer(gradientLayer, at: 0)
        pages = [(Asset.Assets.ob1Bg1.image, "Listen to Your Inner Self", "This AI-powered app helps you connect with the wisdom of Buddhism anytime, anywhere."),
            (Asset.Assets.ob1Bg2.image , "The Path to Enlightenment", "Ask questions, share your thoughts, and meditate with AI inspired by Buddhist wisdom."),
            (Asset.Assets.ob1Bg3.image, "Dwell in Mindfulness", "Begin your journey of inner peace today.")
        ]

        setupScrollView()
        setupPages()
        setupNextButton()
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.setNavigationBarHidden(true, animated: false)
    }

    private func setupScrollView() {
        view.addSubview(ambientView)
        view.addSubview(scrollView)
        ambientView.backgroundColor = .clear
        scrollView.contentInsetAdjustmentBehavior = .never
        scrollView.isPagingEnabled = true
        scrollView.showsHorizontalScrollIndicator = false
        scrollView.isScrollEnabled = true
        scrollView.isUserInteractionEnabled = true
        scrollView.delegate = self
        
        ambientView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }

        scrollView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }

        scrollView.contentSize = CGSize(width: Int(UIScreen.main.bounds.width) * pages.count, height: Int(UIScreen.main.bounds.height))
    }

    private func setupPages() {
        var previousPage: UIView?

        for page in pages {
            let pageView = OnboardingPageView(image: page.image, title: page.title, subtitle: page.subtitle)
            scrollView.addSubview(pageView)

            pageView.snp.makeConstraints { make in
                make.top.bottom.equalToSuperview()
                make.width.equalTo(view)
                make.height.equalToSuperview()

                if let prev = previousPage {
                    make.left.equalTo(prev.snp.right)
                } else {
                    make.left.equalToSuperview()
                }
            }

            previousPage = pageView
        }

        if let lastPage = previousPage {
            lastPage.snp.makeConstraints { make in
                make.right.equalToSuperview()
            }
        }
    }

    private func setupNextButton() {
        view.addSubview(pageControl)
        view.addSubview(nextButton)
        nextButton.snp.makeConstraints { make in
            make.bottom.equalTo(view.safeAreaLayoutGuide.snp.bottom).offset(-18)
            make.centerX.equalToSuperview()
            make.left.equalToSuperview().offset(24)
            make.height.equalTo(58.scaleHeight(max: 58, min: 50))
        }
        
        pageControl.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.centerY.equalTo(nextButton.snp.centerY)
        }
    }

    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        if ambientView.layer.sublayers?.isEmpty != false {
            let topGlow = CAGradientLayer()
            topGlow.colors = [
                UIColor(hexString: "#F3E0BF").withAlphaComponent(0.85).cgColor,
                UIColor.clear.cgColor
            ]
            topGlow.startPoint = CGPoint(x: 0.5, y: 0)
            topGlow.endPoint = CGPoint(x: 0.5, y: 1)
            topGlow.frame = ambientView.bounds
            ambientView.layer.insertSublayer(topGlow, at: 0)
        } else {
            ambientView.layer.sublayers?.first?.frame = ambientView.bounds
        }
    }

    func scrollTo(index: Int) {
        scrollView.setContentOffset(CGPoint(x: Int(UIScreen.main.bounds.width) * index, y: 0), animated: true)
    }

    func setHomeAsRoot() {
        guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else { return }

        guard
            let navigationController = appDelegate.window?.rootViewController as? UINavigationController,
            !navigationController.viewControllers.isEmpty
        else {
            return
        }

        PreferenceService.shared.isShowedOnboarding = true
        navigationController.setViewControllers([CustomTabBarController()], animated: true)
    }

    @objc func tappedNextButton(_ sender: UIButton) {
        currentPageIndex += 1
        if currentPageIndex < pages.count {
            scrollTo(index: currentPageIndex)
        } else {
            setHomeAsRoot()
        }
    }
}

extension OnboardingViewController: UIScrollViewDelegate {
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        currentPageIndex = Int((scrollView.contentOffset.x / UIScreen.main.bounds.width))
    }
}
