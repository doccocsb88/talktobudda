//
//  ResourceTagManager.swift
//  TalkToBudda
//
//  Created by mac on 7/5/25.
//

import Foundation

enum ResourceTag: String, Codable {
    case abhidhammaPitaka = "ABHIDHAMMA PITAKA"
    case linkedDiscourses = "Linked Discourses"
    case longDiscourses = "Long Discourses"
    case middleDiscourses = "Middle Discourses"
    case minorCollection = "Minor Collection"
    case numberedDiscourses = "Numbered Discourses"
    case vinayaPitaka = "VINAYA PITAKA"
}

class ResourceTagManager {
    
    // MARK: - Singleton
    static let shared = ResourceTagManager()
    
    // MARK: - Properties
    private var resourceRequests: [ResourceTag: NSBundleResourceRequest] = [:]
    private let userDefaultsKey = "ResourceTagsStatus"
    private var currentRequest: NSBundleResourceRequest?
    
    private init() {}

    // MARK: - Public Methods
    func downloadResource(for tag: ResourceTag, completion: @escaping (Bool) -> Void) {
        let resourceRequest = NSBundleResourceRequest(tags: [tag.rawValue])
        resourceRequest.loadingPriority = 1.0
        
        resourceRequests[tag] = resourceRequest
        currentRequest = resourceRequest
        
        resourceRequest.beginAccessingResources { error in
            if let error = error {
                print("❌ Error downloading resource \(tag.rawValue): \(error.localizedDescription)")
                completion(false)
            } else {
                print("✅ Successfully downloaded resource: \(tag.rawValue)")
                self.updateDownloadStatus(for: tag, status: true)
                completion(true)
            }
        }
    }
    
    func isResourceDownloaded(for tag: ResourceTag) -> Bool {
        return UserDefaults.standard.bool(forKey: "\(userDefaultsKey)_\(tag.rawValue)")
    }
    
    func removeResource(for tag: ResourceTag, completion: @escaping (Bool) -> Void) {
        resourceRequests[tag]?.endAccessingResources()
        updateDownloadStatus(for: tag, status: false)
        print("🗑️ Resource \(tag.rawValue) removed from local storage.")
        completion(true)
    }
    
    func cancelDownload(for tag: ResourceTag) {
        resourceRequests[tag]?.endAccessingResources()
        print("🚫 Download for \(tag.rawValue) cancelled.")
    }

    // MARK: - Load Resources
    func loadResources(for tag: ResourceTag) -> [String] {
        
        guard let bundle = currentRequest?.bundle else { return []}
        guard let resourcePath = bundle.resourcePath else {
            print("❌ Không tìm thấy đường dẫn Bundle chính")
            return []
        }
        
        let folderPath = "\(resourcePath)/\(tag.rawValue)"
        
        do {
            let fileList = try FileManager.default.contentsOfDirectory(atPath: folderPath)
            let filteredFiles = fileList.filter { $0.hasSuffix(".png") || $0.hasSuffix(".jpg") || $0.hasSuffix(".pdf") }
            print("📂 Tìm thấy \(filteredFiles.count) file trong \(folderPath): \(filteredFiles)")
            return filteredFiles
        } catch {
            print("❌ Lỗi khi load resource từ \(folderPath): \(error.localizedDescription)")
            return []
        }
    }

    // MARK: - Private Methods
    private func updateDownloadStatus(for tag: ResourceTag, status: Bool) {
        UserDefaults.standard.set(status, forKey: "\(userDefaultsKey)_\(tag.rawValue)")
        UserDefaults.standard.synchronize()
    }
    
    func listAllResources() -> [String: Bool] {
        return [
            ResourceTag.abhidhammaPitaka.rawValue: isResourceDownloaded(for: .abhidhammaPitaka),
            ResourceTag.linkedDiscourses.rawValue: isResourceDownloaded(for: .linkedDiscourses),
            ResourceTag.longDiscourses.rawValue: isResourceDownloaded(for: .longDiscourses),
            ResourceTag.middleDiscourses.rawValue: isResourceDownloaded(for: .middleDiscourses),
            ResourceTag.minorCollection.rawValue: isResourceDownloaded(for: .minorCollection),
            ResourceTag.numberedDiscourses.rawValue: isResourceDownloaded(for: .numberedDiscourses),
            ResourceTag.vinayaPitaka.rawValue: isResourceDownloaded(for: .vinayaPitaka)
        ]
    }
}

extension ResourceTagManager {
    
    // MARK: - Get URL of Resource
    func urlForResource(fileName: String, in tag: ResourceTag) -> URL? {
        guard let bundle = currentRequest?.bundle else { return nil }

        guard let resourcePath = bundle.resourcePath else {
            print("❌ Không tìm thấy đường dẫn Bundle chính")
            return nil
        }
        
//        let folderPath = "\(resourcePath)/\(tag.rawValue)"
//        let filePath = "\(folderPath)/\(fileName)"
//        
//        if FileManager.default.fileExists(atPath: filePath) {
//            print("📄 File path found: \(filePath)")
//            return URL(fileURLWithPath: filePath)
//        } else {
//            print("❌ Không tìm thấy file: \(fileName) trong \(folderPath)")
//            return nil
//        }
//        
        return bundle.url(forResource: fileName, withExtension: "")
    }
}


//// Tải tài nguyên
//ResourceTagManager.shared.downloadResource(for: .longDiscourses) { success in
//    if success {
//        print("Long Discourses đã tải xong.")
//    } else {
//        print("Lỗi khi tải Long Discourses.")
//    }
//}
//
//// Kiểm tra trạng thái
//if ResourceTagManager.shared.isResourceDownloaded(for: .middleDiscourses) {
//    print("Middle Discourses đã được tải.")
//} else {
//    print("Middle Discourses chưa được tải.")
//}
//
//// Xóa tài nguyên
//ResourceTagManager.shared.removeResource(for: .longDiscourses) { success in
//    if success {
//        print("Long Discourses đã bị xóa khỏi bộ nhớ.")
//    }
//}
//
//// Liệt kê tất cả trạng thái tải xuống
//let allResources = ResourceTagManager.shared.listAllResources()
//print(allResources)
