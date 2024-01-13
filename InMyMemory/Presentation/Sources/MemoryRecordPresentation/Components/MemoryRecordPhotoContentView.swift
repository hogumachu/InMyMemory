//
//  MemoryRecordPhotoContentView.swift
//
//
//  Created by 홍성준 on 1/12/24.
//

import UIKit
import BasePresentation
import DesignKit
import RxSwift
import RxCocoa
import Then
import SnapKit

final class MemoryRecordPhotoContentView: BaseView {
    
    private let imageView = UIImageView()
    fileprivate let removeButton = ActionButton()
    
    func setup(imageData data: Data) {
        imageView.image = UIImage(data: data)
    }
    
    override func tintColorDidChange() {
        super.tintColorDidChange()
        layer.borderColor = UIColor.orange1.cgColor
    }
    
    override func setupLayout() {
        addSubview(imageView)
        imageView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
            make.size.equalTo(200)
        }
        
        addSubview(removeButton)
        removeButton.snp.makeConstraints { make in
            make.top.trailing.equalToSuperview().inset(10)
            make.size.equalTo(CGSize(width: 50, height: 25))
        }
    }
    
    override func setupAttributes() {
        self.do {
            $0.backgroundColor = .background
            $0.layer.cornerRadius = 16
            $0.layer.borderWidth = 1
            $0.layer.borderColor = UIColor.orange1.cgColor
            $0.clipsToBounds = true
        }
        
        imageView.do {
            $0.contentMode = .scaleAspectFill
            $0.backgroundColor = .background
        }
        
        removeButton.do {
            $0.style = .normalSmall
            $0.setTitle("제거", for: .normal)
            $0.layer.cornerRadius = 25 / 2
        }
    }
    
}

extension Reactive where Base: MemoryRecordPhotoContentView {
    
    var removeTap: ControlEvent<Void> {
        let source = base.removeButton.rx.tap
        return ControlEvent(events: source)
    }
    
}
