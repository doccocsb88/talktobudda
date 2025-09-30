//
//  StoreKitService.swift
//  TalkToBudda
//
//  Created by mac on 13/5/25.
//


import Foundation
import StoreKit
import Combine

class StoreKitManager {
    static let shared = StoreKitManager()
    
    private init() {
        observeTransactions()
        bindPurchasedItems()
    }
    
    var availableProducts: [Product] = []
    let items: [StoreItem] = StoreItem.allCases
    
    
    @Published var purchasedItems: Set<StoreItem> = []
    @Published var isPremium: Bool = false

    var purchasedItemsPublisher: AnyPublisher<Set<StoreItem>, Never> {
        $purchasedItems.eraseToAnyPublisher()
    }
    
    private func bindPurchasedItems() {
        $purchasedItems
            .sink {[weak self] items in
                print("StoreKitManager: [TransactionManager] Purchased updated: \(items)")
                self?.isPremium = !items.isEmpty
            }
            .store(in: &cancellables)
    }
    
    private func observeTransactions() {
        Task.detached(priority: .background) {
            for await result in Transaction.updates {
                do {
                    let transaction = try result.payloadValue
                    if transaction.revocationDate == nil && transaction.ownershipType == .purchased {
                        await transaction.finish()
                        print("StoreKitManager: Giao dịch hoàn tất qua Transaction.updates: \(transaction.id)")
                        // Handle unlock logic here if needed
                    }
                } catch {
                    print("StoreKitManager: Transaction update failed: \(error)")
                }
            }
        }
    }
    
    // Load sản phẩm từ App Store
    func loadProducts() async throws {
        do {
            let products = try await Product.products(for: items.compactMap({$0.productId}))
            self.availableProducts = products
            debugPrint("StoreKitManager: availableProducts \(products.count)")
            
            for product in products {
                debugPrint("StoreKitManager: product id \(product.id)")
            }
        } catch {
            debugPrint("StoreKitManager: Lỗi khi tải sản phẩm \(error)")
            throw error // Re-throw the error so it can be handled by the caller
        }
    }
    
    // Mua sản phẩm consumable
    func purchase(item: StoreItem) async {
        guard let product = availableProducts.first(where: { $0.id == item.productId }) else {
            debugPrint("StoreKitManager: Không tìm thấy sản phẩm")
            return
        }
        
        do {
            let result = try await product.purchase()
            
            switch result {
            case .success(let verificationResult):
                switch verificationResult {
                case .verified(let transaction):
                    debugPrint("StoreKitManager: Giao dịch thành công: \(transaction.id)")
                    await transaction.finish()
                    //                    addCoins(amount: 100) // Ví dụ: nạp thêm 100 coin
                    await handle(transaction: transaction)
                case .unverified(_, let error):
                    debugPrint("StoreKitManager: Giao dịch không xác thực: \(error)")
                }
            case .userCancelled:
                debugPrint("StoreKitManager: Người dùng đã huỷ giao dịch.")
            case .pending:
                debugPrint("StoreKitManager: Giao dịch đang chờ xử lý.")
            @unknown default:
                debugPrint("StoreKitManager: Trạng thái giao dịch không xác định.")
            }
        } catch {
            debugPrint("StoreKitManager: Lỗi khi mua sản phẩm: \(error)")
        }
    }
    
    private var cancellables = Set<AnyCancellable>()
    
    func startObservingTransactions() {
        Task.detached(priority: .background) {
            for await result in Transaction.updates {
                switch result {
                case .verified(let transaction):
                    await transaction.finish()
                    debugPrint("StoreKitManager: [TransactionManager] Giao dịch hoàn tất: \(transaction.id)")
                    await self.handle(transaction: transaction)
                case .unverified(_, let error):
                    debugPrint("StoreKitManager: [TransactionManager] Giao dịch không xác thực: \(error.localizedDescription)")
                }
            }
        }
    }
    
    func updateCurrentEntitlements() async {
        var activeItems: Set<StoreItem> = []
        for await result in Transaction.currentEntitlements {
            switch result {
            case .verified(let transaction):
                if let item = StoreItem.allCases.first(where: { $0.productId == transaction.productID }) {
                    activeItems.insert(item)
                }
            case .unverified(_, let error):
                debugPrint("StoreKitManager: [TransactionManager] Entitlement không xác thực: \(error.localizedDescription)")
            }
        }
        purchasedItems = activeItems
        debugPrint("StoreKitManager: [TransactionManager] Cập nhật purchasedItems: \(activeItems)")
    }
    
    private func handle(transaction: Transaction) async {
        if let item = StoreItem.allCases.first(where: { $0.productId == transaction.productID }) {
            purchasedItems.insert(item)
            debugPrint("StoreKitManager: [TransactionManager] Unlocking content for: \(item)")
        }
    }
    
    func isPurchased(_ item: StoreItem) -> Bool {
        return purchasedItems.contains(item)
    }
  
    func restorePurchases() async throws -> Bool {
        do {
            var restoredItems: [Product] = []

            for await result in Transaction.currentEntitlements {
                guard case .verified(let transaction) = result else { continue }

                // Lấy thông tin sản phẩm
                if let product = try? await Product.products(for: [transaction.productID]).first {
                    restoredItems.append(product)
                    debugPrint("StoreKitManager: ✅ Restored: \(product.id)")
                    
                    // Xử lý logic tùy theo loại sản phẩm
                    // Ví dụ: gán isPremium = true nếu là sản phẩm mở khóa
                    handleRestoredProduct(product)
                }
            }

            if restoredItems.isEmpty {
                debugPrint("StoreKitManager: ⚠️ No purchases to restore.")
                return false // Trả về false để báo không có gì để restore
            }
            
            return true // Trả về true để báo có purchases được restore

        } catch {
            debugPrint("StoreKitManager: ❌ Restore failed with error: \(error)")
            throw error // Re-throw để caller có thể handle
        }
    }

    func handleRestoredProduct(_ product: Product) {
        if let item = items.first(where: {$0.productId == product.id}) {
            purchasedItems.insert(item)
        }
    }

}
