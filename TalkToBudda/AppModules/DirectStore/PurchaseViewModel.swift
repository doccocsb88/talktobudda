//
//  PurchaseViewModel.swift
//  TalkToBudda
//
//  Created by mac on 14/5/25.
//


import StoreKit
import Foundation
import Combine

@MainActor
class PurchaseViewModel: ObservableObject {
    @Published var products: [Product] = []
    @Published var selectedIndex: Int = 1
    @Published var purchasedItems: Set<StoreItem> = []

    let itemOrder: [StoreItem] = [.weekly1, .weeklytrial1, .monthly2]

    private var cancellables = Set<AnyCancellable>()

    /// Callback gọi khi có item được mua mới
    var onItemPurchased: ((StoreItem) -> Void)?
    
    /// Callback gọi khi restore purchase bắt đầu
    var onRestoreStarted: (() -> Void)?
    
    /// Callback gọi khi restore purchase thành công
    var onRestoreSuccess: (() -> Void)?
    
    /// Callback gọi khi không có purchases để restore
    var onRestoreNoPurchases: (() -> Void)?
    
    /// Callback gọi khi restore purchase thất bại
    var onRestoreError: ((Error) -> Void)?

    init() {
        StoreKitManager.shared.purchasedItemsPublisher
            .receive(on: DispatchQueue.main)
            .sink { [weak self] newItems in
                guard let self = self else { return }
                let oldItems = self.purchasedItems
                let addedItems = newItems.subtracting(oldItems)
                self.purchasedItems = newItems
                if let newItem = addedItems.first {
                    print("[PurchaseViewModel] Item vừa được mua: \(newItem)")
                    self.onItemPurchased?(newItem)
                }
            }
            .store(in: &cancellables)
    }

    func load() async throws {
        try await StoreKitManager.shared.loadProducts()
        let available = StoreKitManager.shared.availableProducts
        
        // Check if we got any products
        if available.isEmpty {
            throw NSError(domain: "PurchaseViewModel", code: -1, userInfo: [NSLocalizedDescriptionKey: "No products available"])
        }
        
        products = itemOrder.compactMap { id in
            available.first(where: { $0.id == id.productId })
        }
        
        // Check if we got any products after filtering
        if products.isEmpty {
            throw NSError(domain: "PurchaseViewModel", code: -2, userInfo: [NSLocalizedDescriptionKey: "No matching products found"])
        }
    }

    func select(index: Int) {
        selectedIndex = index
    }

    func selectedItem() -> StoreItem? {
        guard selectedIndex < itemOrder.count else { return nil }
        return itemOrder[selectedIndex]
    }
    
    func getStoreItem(for productId: String) -> StoreItem? {
        return itemOrder.first(where: {$0.productId == productId})
    }

    func purchaseSelectedItem() async {
        guard let item = selectedItem() else { return }
        await StoreKitManager.shared.purchase(item: item)
    }

    func restore() {
        onRestoreStarted?()
        Task {
            do {
                let hasPurchases = try await StoreKitManager.shared.restorePurchases()
                await MainActor.run {
                    if hasPurchases {
                        onRestoreSuccess?()
                    } else {
                        onRestoreNoPurchases?()
                    }
                }
            } catch {
                await MainActor.run {
                    onRestoreError?(error)
                }
            }
        }
    }
    
    func isItemPurchased(_ item: StoreItem?) -> Bool {
        guard let _item = item else { return false }
        return purchasedItems.contains(_item)
    }
}
