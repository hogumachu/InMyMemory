//
//  ActionButton.swift
//
//
//  Created by 홍성준 on 12/30/23.
//

import UIKit
import SnapKit
import Then

open class ActionButton: UIButton {
    
    public var style: ActionButtonStyle = .normal {
        didSet { updateStyle() }
    }
    
    public override var isHighlighted: Bool {
        didSet { pressedView.isHidden = !isHighlighted }
    }
    
    public override var isEnabled: Bool {
        didSet { updateStyle() }
    }
    
    private let pressedView = UIView()
    
    public override init(frame: CGRect) {
        super.init(frame: frame)
        setupAttributes()
        setupLayout()
    }
    
    public required init?(coder: NSCoder) {
        super.init(coder: coder)
        setupAttributes()
        setupLayout()
    }
    
    private func setupLayout() {
        addSubview(pressedView)
        
        pressedView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
    }
    
    private func setupAttributes() {
        clipsToBounds = true
        updateStyle()
        
        pressedView.do {
            $0.isUserInteractionEnabled = false
            $0.isHidden = true
        }
    }
    
    private func updateStyle() {
        updateFont()
        updateTextColor()
        updateBackgroundColor()
        updateBorder()
    }
    
    private func updateFont() {
        titleLabel?.font = isEnabled ? style.font : style.disabledFont
    }
    
    private func updateTextColor() {
        setTitleColor(style.textColor, for: .normal)
        setTitleColor(style.disabledTextColor, for: .disabled)
    }
    
    private func updateBackgroundColor() {
        backgroundColor = isEnabled ? style.backgroundColor : style.disabledBackgroundColor
        pressedView.backgroundColor = style.pressedBackgroundColor
    }
    
    private func updateBorder() {
        layer.borderWidth = style.borderWidth
        layer.borderColor = isEnabled ? style.borderColor.cgColor : style.disabledBorderColor.cgColor
    }
    
}
