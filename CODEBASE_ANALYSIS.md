# TalkToBudda Codebase Analysis

## 1. Tổng quan

`TalkToBudda` là một ứng dụng iOS native viết bằng Swift, dùng UIKit làm UI framework chính, có thêm một widget target `BuddaWidget`.

Mục tiêu sản phẩm hiện tại:

- Chat với AI theo vai trò hướng dẫn tâm linh.
- Hỗ trợ thiền: chọn mood, thiền có timer, phát âm thanh nền.
- Đọc scriptures/PDF theo từng bộ tài liệu.
- Lưu lịch sử hội thoại.
- Monetization qua In-App Purchase và direct store screen.
- Widget hiển thị trích dẫn Phật giáo.

## 2. Stack kỹ thuật

### Core

- Ngôn ngữ: Swift
- UI: UIKit
- Widget: SwiftUI + WidgetKit + AppIntents
- Layout: SnapKit
- Persistence: RealmSwift
- Reactive/event stream: RxSwift, RxCocoa, Combine
- Store/IAP: StoreKit 2
- PDF reader: PDFKit
- HUD/loading: SVProgressHUD

### Build/resources

- SwiftGen được dùng để generate accessors cho:
  - strings
  - assets
  - fonts
- Cấu hình nằm ở `swiftgen.yml`.

## 3. Cấu trúc codebase

### Main app

- `TalkToBudda/AppDelegate.swift`
  - Entry point của app.
  - Khởi tạo StoreKit observer, load products, cập nhật entitlement.
  - Set root controller về `LoadingVC`.

- `TalkToBudda/AppModules`
  - Chứa toàn bộ feature modules.

- `TalkToBudda/Common`
  - Extension, helper UI, color, text, web view đơn giản.

- `TalkToBudda/Networks`
  - OpenAI request/response model, prompt builder, network service.

- `TalkToBudda/Resources`
  - Assets, strings, sounds, scriptures JSON/PDF, HTML policy/terms.

### Widget

- `BuddaWidget`
  - Widget quotes độc lập, dùng `AppIntentTimelineProvider`.
  - Cho phép cấu hình refresh frequency và background style.

## 4. Kiến trúc ứng dụng

Codebase đang dùng kiến trúc pha trộn:

- Nhiều màn hình dùng style VIPER/MVP:
  - ví dụ `Chat`, `Scriptures`, `History`, `Meditation`
  - có `Viewable`, `Presentable`, `Interactable`, `Router/Wireframe`
- Một số màn đơn giản hơn dùng trực tiếp `UIViewController`.
- `Settings` đang gần với MVVM nhẹ.

Điều này cho thấy codebase chưa hoàn toàn đồng nhất kiến trúc, nhưng đã có xu hướng tách feature theo module.

## 5. Luồng khởi động

### Startup flow

1. `AppDelegate.didFinishLaunchingWithOptions`
2. `StoreKitManager` bắt đầu observe transaction
3. Load sản phẩm IAP
4. Root set về `LoadingVC`
5. `LoadingVC` hiển thị splash khoảng 3 giây
6. Request ATT/IDFA
7. Điều hướng:
   - nếu đã xem onboarding: vào `CustomTabBarController`, sau đó show direct store
   - nếu chưa: vào `OnboardingViewController`

### Nhận xét

- Flow launch khá rõ ràng.
- `LoadingVC.goToNextScreen()` đang auto gọi `DSRouter.showDS(from: self)` khi user đã onboarding xong, nghĩa là paywall/direct store có thể bật ngay sau khi vào app.

## 6. Các tính năng hiện có

### 6.1 Onboarding

File chính:

- `TalkToBudda/AppModules/Onboarding/OnboardingViewController.swift`
- `TalkToBudda/AppModules/Onboarding/OnboardingPageView.swift`

Chức năng:

- 3 trang onboarding dạng horizontal paging.
- CTA cuối là `Start the Journey`.
- Trạng thái đã xem được lưu qua `PreferenceService.shared.isShowedOnboarding`.

### 6.2 Tab navigation

File chính:

- `TalkToBudda/AppModules/Tabbar/CustomTabBarController.swift`

4 tab hiện tại:

- Quotes
- Meditation
- History
- Scriptures

Nhận xét:

- Tab 1 tên là `Quotes` nhưng controller khởi tạo là `QuotesListViewController`.
- Không thấy `Chat` là một tab chính; khả năng chat được mở từ màn khác.

### 6.3 AI Chat

File chính:

- `TalkToBudda/AppModules/Chat/*`
- `TalkToBudda/Networks/PromptBuilder.swift`
- `TalkToBudda/Networks/NetworkService.swift`

Khả năng hiện có:

- Hiển thị conversation dạng table view.
- Gửi message từ input bar.
- Có trạng thái loading.
- Cho phép chọn character/guide.
- Có gating số lượt chat miễn phí và nút `Get More`.
- Lưu hội thoại vào Realm.

Chi tiết kỹ thuật:

- `ChatInteractor` tạo conversation mới nếu không truyền conversation cũ.
- Nếu là chat mới, app nạp sample Q&A từ `TalkToBuddha_Questions.json`.
- Network gọi trực tiếp OpenAI Chat Completions API qua `https://api.openai.com/v1/chat/completions`.
- Model đang dùng là `gpt-4o`.
- Prompt được build theo từng `CharacterType`.
- Response ưu tiên parse JSON `{ question, answer }`, fallback sang raw text nếu model không trả JSON hợp lệ.

Character system:

- Có nhiều persona hơn riêng Buddhist:
  - Buddha
  - Monk
  - Zen Master
  - Meditation Guide
  - Spiritual Teacher
  - Jesus
  - Mary
  - Wise Philosopher
  - Marcus Aurelius
  - Socrates

Nhận xét:

- Product naming là “TalkToBudda”, nhưng thực tế feature chat đang mở rộng thành multi-spiritual-character app.
- API key được đọc từ `OpenAI.plist` trong bundle, không phải remote config hay secure backend proxy.

### 6.4 Chat history

File chính:

- `TalkToBudda/AppModules/History/*`
- `TalkToBudda/AppModules/Services/ChatDataManager.swift`
- `TalkToBudda/AppModules/Services/Realm/*`

Chức năng:

- Lưu conversation và messages bằng Realm.
- Hiển thị danh sách lịch sử hội thoại.
- Có khả năng mở lại conversation cũ.
- Có empty state cell riêng.

Nhận xét:

- `HistoryInteractor.swift` hiện gần như trống, logic chủ yếu có thể đang dồn sang presenter/data manager.

### 6.5 Meditation mood + guide

File chính:

- `TalkToBudda/AppModules/Mediation/*`
- `TalkToBudda/AppModules/MeditationGuide/MeditationGuideVC.swift`

Chức năng:

- Chọn mood hiện tại.
- Hiển thị danh sách meditation phù hợp.
- Bấm vào item để mở guide chi tiết.

Nguồn dữ liệu:

- Có `buddhist_meditation_types.json`
- Có `Quote` entity, `MeditationCodable`

Nhận xét:

- Tên thư mục là `Mediation` nhưng nội dung là `Meditation`; đây là naming inconsistency trong codebase.

### 6.6 Meditation timer + ambient sound

File chính:

- `TalkToBudda/AppModules/MeditationTimer/*`
- `TalkToBudda/AppModules/ListSound/*`
- `TalkToBudda/AppModules/Services/MeditationAudioPlayer.swift`
- `TalkToBudda/AppModules/Services/PreferenceService.swift`

Chức năng:

- Đồng hồ thiền countdown.
- Pause/finish session.
- Phát nhạc nền/ambient sound.
- Mute, volume control, chọn sound.
- Hiển thị quote ngẫu nhiên khi thiền.
- Có donate CTA để mua thêm chats.

Nhận xét:

- Meditation feature được tách tương đối đầy đủ và có trải nghiệm độc lập.

### 6.7 Scriptures browser + reader

File chính:

- `TalkToBudda/AppModules/Scriptures/*`
- `TalkToBudda/AppModules/ScriptureReader/ScriptureReader.swift`
- `TalkToBudda/AppModules/Services/ResourceTagManager.swift`

Chức năng:

- Hiển thị danh sách scriptures.
- Search theo từ khóa.
- Empty state khi không có kết quả.
- Mở PDF reader.
- Lưu trang đọc cuối theo từng scripture bằng `UserDefaults`.

On-demand resources:

- `ResourceTagManager` dùng `NSBundleResourceRequest` theo tag:
  - ABHIDHAMMA PITAKA
  - Linked Discourses
  - Long Discourses
  - Middle Discourses
  - Minor Collection
  - Numbered Discourses
  - VINAYA PITAKA

Nhận xét:

- Đây là feature khá rõ ràng và có đầu tư hơn mức “viewer đơn giản”.
- Việc tải tài nguyên theo tag giúp giảm bundle size ban đầu.

### 6.8 Quotes

File chính:

- `TalkToBudda/AppModules/QuotesList/QuotesListViewController.swift`
- `TalkToBudda/Resources/buddha_quotes_100.json`

Chức năng suy ra:

- Hiển thị danh sách quotes Phật giáo.
- Reuse dữ liệu quotes cho widget.

### 6.9 Settings

File chính:

- `TalkToBudda/AppModules/Settings/SettingVC.swift`

Tính năng:

- Store
- Manage Subscription
- Review App
- Contact us
- Share app
- Privacy policy

Nhận xét:

- `showPrivacyPolicy()` đang tìm file `"Privacy Policy.html"` nhưng resources hiện có là `privacy-policy.html`. Đây là điểm cần kiểm tra vì rất dễ fail do khác tên file/chữ hoa.

### 6.10 In-App Purchase / Store

File chính:

- `TalkToBudda/AppModules/DirectStore/*`
- `TalkToBudda/AppModules/IAP/*`
- `TalkToBudda/AppModules/Services/StoreKitService.swift`
- `TalkToBudda/Configs/StoreKitConfigs.storekit`

Sản phẩm hiện có:

- `1karma`
- `weekly1`
- `weeklytrial1`
- `monthly2`

Mô hình monetization:

- Premium entitlement mở khóa non-consumable/subscription logic.
- Consumable `karma` được dùng để cộng thêm chat count.
- Direct store / paywall có:
  - benefit list
  - restore purchase
  - privacy / terms
  - CTA mua subscription
  - CTA mua bonus chats

Gating logic:

- `ConditionServices` cấp 5 lượt chat miễn phí cho user mới.
- Premium bỏ giới hạn.
- Purchase consumable cộng thêm lượt chat.

## 7. Dữ liệu và persistence

### Realm

Entities chính:

- `ConversationObject`
- `ChatMessageObject`

Data manager:

- `ChatDataManager.shared`

Capability:

- Tạo conversation
- Thêm tin nhắn
- Đổi character của conversation
- Fetch tất cả conversations
- Xóa conversation

### UserDefaults

Dùng cho:

- Đã xem onboarding hay chưa
- Sound thiền được chọn
- Số lượt chat đã dùng / miễn phí
- Trạng thái on-demand resource
- Last-read page của scripture

## 8. Networking và AI integration

### Cách gọi API

- Gọi trực tiếp từ app client tới OpenAI Chat Completions API.
- Authorization dùng Bearer API key lấy từ file plist trong app bundle.

### Prompting

- Có `system prompt` theo persona.
- Gửi full conversation history vào request.
- Yêu cầu model trả JSON chuẩn.

### Rủi ro kỹ thuật

- API key ở client bundle là rủi ro bảo mật lớn.
- Không thấy retry/backoff/rate limit handling.
- Không thấy streaming response.
- Không thấy moderation/safety layer riêng ngoài prompt instruction.

## 9. Widget

File chính:

- `BuddaWidget/BuddaWidget.swift`
- `BuddaWidget/AppIntent.swift`
- `BuddaWidget/BuddhaQuote.swift`

Chức năng:

- Widget quotes với timeline refresh theo:
  - 3 giờ
  - 6 giờ
  - 12 giờ
  - hàng ngày
- Cho phép đổi background style:
  - gradient
  - lotus
  - zen
  - temple
  - nature
  - 5 background image preset

Nhận xét:

- Widget được viết mới hơn phần main app, style code hiện đại hơn và đã dùng AppIntent configuration.

## 10. Điểm mạnh của codebase

- Tính năng khá đầy: chat, thiền, scriptures, history, store, widget.
- Phân tách module theo feature tương đối rõ.
- Dùng SwiftGen để giảm hardcode assets/fonts/strings.
- Có Realm để persistence hội thoại thay vì chỉ lưu ephemeral state.
- Scriptures có on-demand resource + PDF reader + resume page.
- Monetization đã đi khá xa: subscription, consumable, restore, direct store.

## 11. Điểm cần lưu ý / debt kỹ thuật

### Kiến trúc

- Pha trộn nhiều pattern: VIPER/MVP/MVVM/direct UIViewController.
- Một số interactor/router tồn tại nhưng logic còn mỏng hoặc rỗng.

### Naming / consistency

- `TalkToBudda` vs `TalkToBuddha`
- `BuddaWidget` vs `Buddha`
- `Mediation` vs `Meditation`
- Tên file `ListSoundVC .swift` có dấu cách trước `.swift`

### Bảo mật

- OpenAI API key nằm trong app bundle là vấn đề lớn nhất.

### Chất lượng code

- Có force unwrap / `try!` khá nhiều trong Realm flow.
- Có một số string hardcode trong UI.
- Một số comment/debug log còn lẫn tiếng Việt và log tạm.
- `TransactionManager.swift` hiện gần như chưa có nội dung thực tế.

### Product logic

- App branding thiên về Phật giáo nhưng character set bao phủ nhiều tôn giáo/triết gia.
- Nếu đây là chủ đích sản phẩm thì nên phản ánh nhất quán trong naming và UX.
- Nếu không, đây là dấu hiệu scope đã drift.

### Flow logic

- Sau splash, user đã onboarding xong sẽ bị show direct store ngay.
- Cần xác nhận đây là chủ đích growth/paywall hay side effect của luồng hiện tại.

## 12. Feature map ngắn gọn

| Feature | Trạng thái | Ghi chú |
|---|---|---|
| Onboarding | Có | 3 bước, lưu flag local |
| AI chat | Có | Gọi OpenAI trực tiếp |
| Character personas | Có | 10 persona |
| Chat history | Có | Realm persistence |
| Free chat gating | Có | 5 lượt free + premium unlock |
| Meditation mood | Có | Chọn mood, gợi ý nội dung |
| Meditation timer | Có | Timer + sound + donate CTA |
| Sound picker | Có | Ambient audio |
| Scriptures search | Có | Search + empty state |
| PDF reader | Có | Resume last page |
| On-demand scripture resources | Có | NSBundleResourceRequest |
| Direct store / paywall | Có | Restore + IAP flows |
| Widget quotes | Có | Timeline + configurable background |

## 13. Kết luận

Đây là một codebase iOS sản phẩm hóa ở mức khá đầy đủ, không còn là prototype đơn giản. Trục giá trị chính là wellness/spiritual guidance, xoay quanh 3 mảng lớn:

- AI spiritual chat
- Meditation experience
- Scripture consumption

Phần mạnh nhất về mặt product breadth là hệ feature khá đa dạng. Phần yếu nhất về mặt kỹ thuật là tính nhất quán kiến trúc và bảo mật API client-side.

Nếu cần ưu tiên phân tích tiếp, nên đi theo thứ tự:

1. Sơ đồ navigation giữa các màn.
2. Luồng chat end-to-end và giới hạn free/premium.
3. Rà soát bug/risk hiện hữu trong settings/store/scripture loading.
4. Đề xuất refactor kiến trúc theo từng module.
