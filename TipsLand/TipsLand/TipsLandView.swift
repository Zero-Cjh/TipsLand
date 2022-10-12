//
//  TipsLandView.swift
//  TipsLand
//
//  Created by Cjh on 2022/10/9.
//

import UIKit
import SnapKit

class TipsLandView: UIView {
    
    func configState(_ state: TipsLandState, title: String, message: String? = nil) {
        UINotificationFeedbackGenerator().notificationOccurred(state.notificationType)
        UIView.animate(withDuration: 0.5) {
            self.state = state
            self.title = title
            self.message = message
            self.layer.shadowColor = state.tintColor.cgColor
            self.layer.shadowOpacity = 0.5
        } completion: { finished in
            UIView.animate(withDuration: 0.5) {
                self.layer.shadowColor = UIColor.bundleColor("TipsLand_Shadow_Color")?.cgColor
                self.layer.shadowOpacity = 0.1
            }
        }
    }
    
    private var state: TipsLandState {
        get {
            return .success
        }
        set {
            self.leftImageView.image = newValue.image
            self.leftImageView.tintColor = newValue.tintColor
        }
    }
    
    private var title: String? {
        get {
            return self.titleLabel.text
        }
        set {
            self.titleLabel.text = newValue
        }
    }
    
    private var message: String? {
        get {
            return self.messageLabel.text
        }
        set {
            self.messageLabel.text = newValue
        }
    }
    
    private func configUI() {
        self.backgroundColor = .bundleColor("TipsLand_Background_Color")
        self.layer.shadowColor = UIColor.bundleColor("TipsLand_Shadow_Color")?.cgColor
        self.layer.shadowRadius = 15
        self.layer.shadowOffset = CGSize(width: 0, height: 1)
        self.layer.shadowOpacity = 0.1
        self.layer.cornerRadius = 25
        self.addSubview(self.leftImageView)
        self.addSubview(self.titleLabel)
        self.addSubview(self.messageLabel)
        
        self.leftImageView.snp.makeConstraints { make in
            make.left.equalTo(self).offset(15)
            make.centerY.equalTo(self)
            make.size.equalTo(CGSize(width: 25, height: 25))
        }
        self.titleLabel.snp.makeConstraints { make in
            make.centerX.equalTo(self)
            make.width.equalTo(90)
            make.bottom.equalTo(self.snp.centerY)
        }
        self.messageLabel.snp.makeConstraints { make in
            make.top.equalTo(self.titleLabel.snp.bottom)
            make.centerX.equalTo(self.titleLabel)
            make.width.equalTo(self.titleLabel)
        }
    }
    
    lazy var leftImageView: UIImageView = {
        leftImageView = UIImageView()
        return leftImageView
    }()
    
    lazy var titleLabel: UILabel = {
        titleLabel = UILabel()
        titleLabel.textAlignment = .center
        titleLabel.font = .systemFont(ofSize: 14, weight: .semibold)
        titleLabel.textColor = .gray
        return titleLabel
    }()
    
    lazy var messageLabel: UILabel = {
        messageLabel = UILabel()
        messageLabel.textAlignment = .center
        messageLabel.font = .systemFont(ofSize: 14)
        messageLabel.adjustsFontSizeToFitWidth = true
        return messageLabel
    }()
    
    init() {
        super.init(frame: CGRect())
        self.configUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
