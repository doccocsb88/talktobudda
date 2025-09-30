//
//  SimpleWebView.swift
//  TalkToBudda
//
//  Created by mac on 11/5/25.
//

import UIKit
import WebKit

class SimpleWebView: UIViewController {
    let webView = WKWebView()
    private let url: URL
    private let webTitle: String?
    private lazy var navView: UIView = {
        let view = UIView()
        
        return view
    }()
    
    private lazy var backButton: UIButton = {
        let backButton = UIButton()
        backButton.setImage(Asset.Assets.icBack.image.withRenderingMode(.alwaysTemplate), for: .normal)
        backButton.imageView?.contentMode = .scaleAspectFit
        backButton.tintColor = .color4B3621
        backButton.addTarget(self, action: #selector(tappedBackButton(_:)), for: .touchUpInside)
        return backButton
    }()
    
    private lazy var titleLabel: UILabel = {
        let titleLabel = UILabel()
        titleLabel.text = webTitle
        titleLabel.font = FontFamily.PlayfairDisplay.bold.font(size: 24)
        titleLabel.textAlignment = .center
        titleLabel.textColor = UIColor(hexString: "#4B3621")
        
        titleLabel.textAlignment = .center
        
        return titleLabel
    }()
    
    init(url: URL, title: String? = nil) {
        self.url = url
        self.webTitle = title
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationController?.setNavigationBarHidden(true, animated: false)
        view.backgroundColor = .colorFDF6ED
        title = "Privacy Policy"
        view.addSubview(navView)
        view.addSubview(webView)
        navView.snp.makeConstraints { make in
            make.left.right.equalToSuperview()
            make.height.equalTo(44)
            make.top.equalTo(view.safeAreaLayoutGuide.snp.top)
        }
        
        navView.addSubview(backButton)
        navView.addSubview(titleLabel)
        navView.snp.makeConstraints { make in
            make.left.right.equalToSuperview()
            make.height.equalTo(44)
            make.top.equalTo(view.safeAreaLayoutGuide.snp.top)
        }
        
        titleLabel.snp.makeConstraints { make in
            make.center.equalToSuperview()
        }
        
        backButton.snp.makeConstraints { make in
            make.left.equalToSuperview().inset(8)
            make.width.height.equalTo(44)
        }
        
        webView.snp.makeConstraints { make in
            make.left.right.bottom.equalToSuperview()
            make.top.equalTo(navView.snp.bottom)
        }
        webView.loadFileURL(url, allowingReadAccessTo: url)
    }
    
    func load(url: URL) {
        webView.loadFileURL(url, allowingReadAccessTo: url)
    }
    
    @objc func tappedBackButton(_ sender: UIButton) {
        dismiss(animated: true)
    }
}
