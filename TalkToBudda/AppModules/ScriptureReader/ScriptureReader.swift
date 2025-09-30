//
//  ScriptureReader.swift
//  TalkToBudda
//
//  Created by mac on 8/5/25.
//

import UIKit
import SnapKit
import PDFKit
import SVProgressHUD

class ScriptureReaderVC: UIViewController {
    private let userDefaultsKey = "LastReadPage"
    
    var pdfUrl: URL?
    private var pdfView: PDFView!
    private let scripture: ScriptureEntity
    
    private var lastPageKey: String {
        return "\(userDefaultsKey)_\(scripture.name)"
    }
    
    private lazy var closeButton: UIButton = {
        let button = UIButton()
        button.tintColor = .neutral950
        button.setImage(Asset.Assets.icClose.image.withRenderingMode(.alwaysTemplate), for: .normal)
        return button
    }()
    
    private let navOverlayView = UIView()
    private let navView = UIView()
    private let titleLabel = UILabel()

    
    init(scripture: ScriptureEntity) {
        self.scripture = scripture
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    deinit {
        NotificationCenter.default.removeObserver(self)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupPDFView()
        
        // Tải tài nguyên trước
        SVProgressHUD.show(withStatus: "Loading...")
        
        ResourceTagManager.shared.downloadResource(for: scripture.resourceTag) {[weak self] success in
            guard let self else { return }
            SVProgressHUD.dismiss()
            
            if success {
                // Nếu đã tải xong, load các file
                // Lấy URL từ ResourceTagManager
                if let url = ResourceTagManager.shared.urlForResource(fileName: self.scripture.name, in: self.scripture.resourceTag) {
                    self.pdfUrl = url
                    DispatchQueue.main.async {
                        self.loadPDF()
                    }
                } else {
                    print("❌ Không tìm thấy file \(self.scripture.name) trong \(self.scripture.resourceTag)")
                }
            } else {
                print("Không thể tải tài nguyên Long Discourses.")
            }
        }
    }
    
    private func setupPDFView() {
        view.backgroundColor = .colorE9D8C0
        pdfView = PDFView(frame: view.bounds)
        pdfView.autoScales = true
        pdfView.delegate = self

        [pdfView, navOverlayView, navView, closeButton].forEach({view.addSubview($0)})
        navView.addSubview(titleLabel)
        navView.backgroundColor = .white
        navOverlayView.backgroundColor = .white

        navView.snp.makeConstraints { make in
            make.left.right.equalToSuperview()
            make.height.equalTo(44)
            make.top.equalTo(view.safeAreaLayoutGuide.snp.top)
        }
        
        navOverlayView.snp.makeConstraints { make in
            make.left.right.equalToSuperview()
            make.top.equalToSuperview()
            make.bottom.equalTo(navView.snp.bottom)
        }
        navView.addSubview(titleLabel)
        titleLabel.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.left.equalTo(closeButton.snp.right).offset(8)
            make.top.equalToSuperview().offset(12)
        }
        
        titleLabel.numberOfLines = 2
        titleLabel.text = scripture.title.uppercased()
        titleLabel.font = FontFamily.FiraMono.bold.font(size: 12)
        titleLabel.textAlignment = .center
        
        closeButton.snp.makeConstraints { make in
            make.width.height.equalTo(40)
            make.top.equalTo(view.safeAreaLayoutGuide.snp.top).offset(8)
            make.left.equalToSuperview().offset(16)
        }
        
        closeButton.addTarget(self, action: #selector(tappedCloseButton(_:)), for: .touchUpInside)
    }
    
    private func loadPDF() {
        guard let url = pdfUrl else {
            print("❌ URL không hợp lệ.")
            return
        }
        if let document = PDFDocument(url: url) {
            pdfView.document = document
            
            
            let center = NotificationCenter.default
            center.addObserver(self,
                               selector: #selector(pdfViewWillChangePage),
                               name: .PDFViewPageChanged,
                               object: nil)
            
            // Đọc page đã lưu từ UserDefaults
            let lastPage = UserDefaults.standard.integer(forKey: lastPageKey)
            if let page = pdfView.document?.page(at: lastPage) {
                pdfView.go(to: page)
            }
            print("✅ Tải PDF thành công: \(url.lastPathComponent)")
        } else {
            print("❌ Không thể load PDF.")
        }
    }
    
    @objc func tappedCloseButton(_ sender: UIButton) {
        dismiss(animated: true)
    }
}


extension ScriptureReaderVC: PDFViewDelegate {
    // MARK: - PDFViewDelegate
    @objc func pdfViewWillChangePage() {
        
        guard let pdfDocument = pdfView.document else { return }
        guard let currentPage = pdfView.currentPage else { return }
        let currentIndex = pdfDocument.index(for: currentPage)
        
        // Lưu lại số trang khi người dùng scroll
        UserDefaults.standard.set(currentIndex, forKey: lastPageKey)
        print("Saved page: \(currentIndex)")
    }
}
