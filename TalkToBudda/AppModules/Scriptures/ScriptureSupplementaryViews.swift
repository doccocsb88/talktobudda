//
//  ScriptureSupplementaryViews.swift
//  TalkToBudda
//
//  Created by Codex on 29/7/26.
//

import UIKit
import SnapKit

final class ContinueReadingCell: UITableViewCell {
    static let reuseIdentifier = "ContinueReadingCell"

    private let cardView = WarmCardView()
    private let iconWrapView = UIView()
    private let iconImageView = UIImageView()
    private let titleLabel = UILabel()
    private let subtitleLabel = UILabel()
    private let progressTrackView = UIView()
    private let progressFillView = UIView()
    private let progressValueLabel = UILabel()
    private var progressWidthConstraint: Constraint?
    private var progressFraction: Double = 0
    private let metaLabel = UILabel()

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupUI()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    private func setupUI() {
        selectionStyle = .none
        backgroundColor = .clear
        contentView.backgroundColor = .clear

        iconWrapView.backgroundColor = UIColor(hexString: "#334C2E")
        iconWrapView.layer.cornerRadius = 8
        iconImageView.image = Asset.Assets.icLotus.image.withRenderingMode(.alwaysTemplate)
        iconImageView.tintColor = UIColor(hexString: "#CFA45B")
        iconImageView.contentMode = .scaleAspectFit

        titleLabel.applyThemeTextStyle(font: ThemeFont.sectionTitle(17), color: ThemeColor.textPrimary)
        subtitleLabel.applyThemeTextStyle(font: ThemeFont.bodyMedium(13), color: ThemeColor.textSecondary)
        metaLabel.applyThemeTextStyle(font: ThemeFont.body(13), color: ThemeColor.textSecondary)
        progressValueLabel.applyThemeTextStyle(font: ThemeFont.bodyMedium(13), color: ThemeColor.textTertiary, alignment: .right)

        progressTrackView.backgroundColor = UIColor(hexString: "#EFE3CE")
        progressTrackView.layer.cornerRadius = 3
        progressFillView.backgroundColor = ThemeColor.accentWarm
        progressFillView.layer.cornerRadius = 3

        contentView.addSubview(cardView)
        [iconWrapView, titleLabel, subtitleLabel, metaLabel, progressTrackView, progressValueLabel].forEach(cardView.addSubview)
        iconWrapView.addSubview(iconImageView)
        progressTrackView.addSubview(progressFillView)

        cardView.snp.makeConstraints { make in
            make.edges.equalToSuperview().inset(UIEdgeInsets(top: 0, left: 16, bottom: 12, right: 16))
        }

        iconWrapView.snp.makeConstraints { make in
            make.left.equalToSuperview().inset(18)
            make.centerY.equalToSuperview()
            make.width.height.equalTo(72)
        }

        iconImageView.snp.makeConstraints { make in
            make.center.equalToSuperview()
            make.width.height.equalTo(24)
        }

        titleLabel.snp.makeConstraints { make in
            make.top.equalToSuperview().inset(18)
            make.left.equalTo(iconWrapView.snp.right).offset(16)
            make.right.equalToSuperview().inset(18)
        }

        subtitleLabel.snp.makeConstraints { make in
            make.top.equalTo(titleLabel.snp.bottom).offset(6)
            make.left.equalTo(titleLabel)
            make.right.equalToSuperview().inset(18)
        }

        metaLabel.snp.makeConstraints { make in
            make.top.equalTo(subtitleLabel.snp.bottom).offset(4)
            make.left.equalTo(titleLabel)
            make.right.equalToSuperview().inset(18)
        }

        progressTrackView.snp.makeConstraints { make in
            make.top.equalTo(metaLabel.snp.bottom).offset(12)
            make.left.equalTo(titleLabel)
            make.right.equalTo(progressValueLabel.snp.left).offset(-12)
            make.height.equalTo(6)
            make.bottom.equalToSuperview().inset(18)
        }

        progressFillView.snp.makeConstraints { make in
            make.left.top.bottom.equalToSuperview()
            progressWidthConstraint = make.width.equalTo(0).constraint
        }

        progressValueLabel.snp.makeConstraints { make in
            make.centerY.equalTo(progressTrackView)
            make.right.equalToSuperview().inset(18)
            make.width.equalTo(44)
        }
    }

    override func layoutSubviews() {
        super.layoutSubviews()
        let width = progressTrackView.bounds.width * progressFraction
        progressWidthConstraint?.update(offset: progressFraction > 0 ? max(width, 8) : 0)
    }

    func configure(with progress: ScriptureReadingProgress) {
        titleLabel.text = progress.scriptureTitle
        subtitleLabel.text = chapterText(for: progress)
        metaLabel.text = progress.pageStatusText
        progressValueLabel.text = progress.progressPercentText
        progressFraction = progress.progressFraction
        progressWidthConstraint?.update(offset: 0)
        layoutIfNeeded()
    }

    private func chapterText(for progress: ScriptureReadingProgress) -> String {
        let pageStart = max(progress.currentPage, 0) + 1
        let pageEnd = min(progress.currentPage + 10, max(progress.totalPages, 1))
        return "Chapter 1 • Pages \(pageStart)-\(pageEnd)"
    }
}

final class ScriptureCollectionCell: UITableViewCell {
    static let reuseIdentifier = "ScriptureCollectionCell"

    private let cardView = WarmCardView()
    private let iconCircleView = UIView()
    private let iconImageView = UIImageView()
    private let titleLabel = UILabel()
    private let subtitleLabel = UILabel()
    private let chevronView = UIImageView(image: UIImage(systemName: "chevron.right"))
    private let separatorView = UIView()

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupUI()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    private func setupUI() {
        selectionStyle = .none
        backgroundColor = .clear
        contentView.backgroundColor = .clear

        cardView.layer.cornerRadius = 0
        cardView.layer.borderWidth = 0
        cardView.layer.shadowOpacity = 0

        iconCircleView.backgroundColor = ThemeColor.surfaceBadge
        iconCircleView.layer.cornerRadius = 20
        iconImageView.contentMode = .scaleAspectFit
        chevronView.tintColor = ThemeColor.textTertiary
        chevronView.contentMode = .scaleAspectFit
        
        separatorView.backgroundColor = UIColor(hexString: "#EFE5D7")

        titleLabel.applyThemeTextStyle(font: ThemeFont.sectionTitle(16), color: ThemeColor.textPrimary)
        subtitleLabel.applyThemeTextStyle(font: ThemeFont.body(13), color: ThemeColor.textSecondary)

        contentView.addSubview(cardView)
        [iconCircleView, titleLabel, subtitleLabel, chevronView, separatorView].forEach(cardView.addSubview)
        iconCircleView.addSubview(iconImageView)

        cardView.snp.makeConstraints { make in
            make.edges.equalToSuperview().inset(UIEdgeInsets(top: 0, left: 16, bottom: 0, right: 16))
        }

        iconCircleView.snp.makeConstraints { make in
            make.left.equalToSuperview().inset(18)
            make.centerY.equalToSuperview()
            make.width.height.equalTo(40)
        }

        iconImageView.snp.makeConstraints { make in
            make.center.equalToSuperview()
            make.width.height.equalTo(24)
        }

        titleLabel.snp.makeConstraints { make in
            make.top.equalToSuperview().inset(18)
            make.left.equalTo(iconCircleView.snp.right).offset(14)
            make.right.equalTo(chevronView.snp.left).offset(-12)
        }

        subtitleLabel.snp.makeConstraints { make in
            make.top.equalTo(titleLabel.snp.bottom).offset(4)
            make.left.equalTo(titleLabel)
            make.right.equalTo(chevronView.snp.left).offset(-12)
            make.bottom.equalToSuperview().inset(18)
        }

        chevronView.snp.makeConstraints { make in
            make.centerY.equalToSuperview()
            make.right.equalToSuperview().inset(18)
            make.width.height.equalTo(14)
        }

        separatorView.snp.makeConstraints { make in
            make.left.equalTo(titleLabel)
            make.right.equalToSuperview().inset(18)
            make.bottom.equalToSuperview()
            make.height.equalTo(1)
        }
    }

    func configure(with entity: ScriptureCollectionEntity) {
        titleLabel.text = entity.title
        subtitleLabel.text = entity.subtitle
        iconImageView.image = icon(for: entity.resourceTag)
    }

    func setShowsSeparator(_ showsSeparator: Bool) {
        separatorView.isHidden = !showsSeparator
    }

    private func icon(for resourceTag: ResourceTag) -> UIImage {
        switch resourceTag {
        case .middleDiscourses, .longDiscourses:
            return Asset.Assets.icScriptureTree.image
        case .numberedDiscourses, .linkedDiscourses:
            return Asset.Assets.icScriptureLotus.image
        case .abhidhammaPitaka:
            return Asset.Assets.icScriptureBudda.image
        case .vinayaPitaka:
            return Asset.Assets.icScriptureVinaya.image
        case .minorCollection:
            return Asset.Assets.icLotus.image
        }
    }
}

final class ScriptureHistoryCell: UITableViewCell {
    static let reuseIdentifier = "ScriptureHistoryCell"

    private let cardView = WarmCardView()
    private let titleLabel = UILabel()
    private let subtitleLabel = UILabel()
    private let dateLabel = UILabel()
    private let progressLabel = UILabel()
    private let progressTrackView = UIView()
    private let progressFillView = UIView()
    private var progressWidthConstraint: Constraint?
    private var progressFraction: Double = 0

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupUI()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    private func setupUI() {
        selectionStyle = .none
        backgroundColor = .clear
        contentView.backgroundColor = .clear

        titleLabel.applyThemeTextStyle(font: ThemeFont.sectionTitle(17), color: ThemeColor.textPrimary, numberOfLines: 2)
        subtitleLabel.applyThemeTextStyle(font: ThemeFont.body(14), color: ThemeColor.textSecondary)
        dateLabel.applyThemeTextStyle(font: ThemeFont.eyebrowMono(12), color: ThemeColor.textTertiary)
        progressLabel.applyThemeTextStyle(font: ThemeFont.bodyMedium(13), color: ThemeColor.textTertiary, alignment: .right)

        progressTrackView.backgroundColor = UIColor(hexString: "#EFE3CE")
        progressTrackView.layer.cornerRadius = 3
        progressFillView.backgroundColor = ThemeColor.accentWarm
        progressFillView.layer.cornerRadius = 3

        contentView.addSubview(cardView)
        [titleLabel, subtitleLabel, dateLabel, progressTrackView, progressLabel].forEach(cardView.addSubview)
        progressTrackView.addSubview(progressFillView)

        cardView.snp.makeConstraints { make in
            make.edges.equalToSuperview().inset(UIEdgeInsets(top: 0, left: 16, bottom: 12, right: 16))
        }

        titleLabel.snp.makeConstraints { make in
            make.top.left.right.equalToSuperview().inset(18)
        }

        subtitleLabel.snp.makeConstraints { make in
            make.top.equalTo(titleLabel.snp.bottom).offset(6)
            make.left.right.equalToSuperview().inset(18)
        }

        dateLabel.snp.makeConstraints { make in
            make.top.equalTo(subtitleLabel.snp.bottom).offset(8)
            make.left.equalToSuperview().inset(18)
            make.right.lessThanOrEqualTo(progressLabel.snp.left).offset(-12)
        }

        progressTrackView.snp.makeConstraints { make in
            make.top.equalTo(dateLabel.snp.bottom).offset(12)
            make.left.equalToSuperview().inset(18)
            make.right.equalTo(progressLabel.snp.left).offset(-12)
            make.height.equalTo(6)
            make.bottom.equalToSuperview().inset(18)
        }

        progressFillView.snp.makeConstraints { make in
            make.left.top.bottom.equalToSuperview()
            progressWidthConstraint = make.width.equalTo(0).constraint
        }

        progressLabel.snp.makeConstraints { make in
            make.centerY.equalTo(progressTrackView)
            make.right.equalToSuperview().inset(18)
            make.width.equalTo(44)
        }
    }

    func configure(with record: ScriptureReadingProgress) {
        titleLabel.text = record.scriptureTitle
        subtitleLabel.text = record.pageStatusText
        dateLabel.text = DateFormatter.scriptureHistory.string(from: record.lastOpenedAt)
        progressLabel.text = record.progressPercentText
        progressFraction = record.progressFraction
        progressWidthConstraint?.update(offset: 0)
        layoutIfNeeded()
    }

    override func layoutSubviews() {
        super.layoutSubviews()
        let width = progressTrackView.bounds.width * progressFraction
        progressWidthConstraint?.update(offset: progressFraction > 0 ? max(width, 8) : 0)
    }
}

private extension DateFormatter {
    static let scriptureHistory: DateFormatter = {
        let formatter = DateFormatter()
        formatter.dateStyle = .medium
        formatter.timeStyle = .short
        return formatter
    }()
}
