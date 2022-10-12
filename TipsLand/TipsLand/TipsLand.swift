//
//  TipsLand.swift
//  TipsLand
//
//  Created by Cjh on 2022/10/9.
//

import UIKit

enum TipsLandState {
    case success
    case failure
    case loading
    
    var tintColor: UIColor {
        get {
            switch self {
            case .success:
                return .systemGreen
            case .failure:
                return .systemRed
            case .loading:
                return .systemBlue
            }
        }
    }
    
    var image: UIImage? {
        get {
            switch self {
            case .success:
                return UIImage(systemName: "checkmark.circle")
            case .failure:
                return UIImage(systemName: "xmark.circle")
            case .loading:
                return UIImage(systemName: "clock.arrow.circlepath")
            }
        }
    }
    
    var notificationType: UINotificationFeedbackGenerator.FeedbackType {
        get {
            switch self {
            case .success:
                return .success
            case .failure:
                return .error
            case .loading:
                return .warning
            }
        }
    }
}

class TipsLand {
    
    // MARK: - Public
    
    static let `shared` = tipsLand
    
    public func show(_ state: TipsLandState, title: String, message: String) {
        self.tipsLandView.configState(state, title: title, message: message)
        self.showTipsLand(state == .loading ? false : true)
    }
    
    // MARK: - Private
    
    private var timer = Timer()
    private var tipsLandView = TipsLandView()
    private var isDisplayed = false
    
    private func showTipsLand(_ isNeedAutoHide: Bool = false) {
        guard let rootView = UIApplication.rootView,
              self.isDisplayed == false
        else {
            self.closeTimer()
            if isNeedAutoHide {
                self.startTimer()
            }
            return
        }
        self.isDisplayed = true
        rootView.addSubview(self.tipsLandView)
        self.tipsLandView.snp.remakeConstraints { make in
            make.bottom.equalTo(rootView.snp.top)
            make.centerX.equalTo(rootView)
            make.width.equalTo(190)
            make.height.equalTo(50)
        }
        rootView.setNeedsLayout()
        rootView.layoutIfNeeded()
        var topPadding = UIApplication.safeAreaInsets?.top ?? 0
        if topPadding == 0 {
            topPadding = 10
        }
        UIView.animate(withDuration: 0.35, delay: 0, options: .curveEaseOut) {
            self.tipsLandView.snp.remakeConstraints { make in
                make.top.equalTo(topPadding)
                make.centerX.equalTo(rootView)
                make.width.equalTo(190)
                make.height.equalTo(50)
            }
            rootView.setNeedsLayout()
            rootView.layoutIfNeeded()
        } completion: { finished in
            if isNeedAutoHide {
                self.startTimer()
            }
        }
    }
    
    private func hideTipsLand() {
        self.closeTimer()
        self.isDisplayed = false
        guard let superview = self.tipsLandView.superview else {
            return
        }
        UIView.animate(withDuration: 0.35, delay: 0, options: .curveEaseOut) {
            self.tipsLandView.snp.remakeConstraints { make in
                make.bottom.equalTo(superview.snp.top)
                make.centerX.equalTo(superview)
                make.width.equalTo(190)
                make.height.equalTo(50)
            }
            superview.setNeedsLayout()
            superview.layoutIfNeeded()
        }
    }
    
    private func startTimer() {
        self.closeTimer()
        self.timer = Timer.scheduledTimer(withTimeInterval: 2, repeats: false, block: { timer in
            self.hideTipsLand()
        })
    }
    
    private func closeTimer() {
        self.timer.invalidate()
    }
}

private let tipsLand = TipsLand()
