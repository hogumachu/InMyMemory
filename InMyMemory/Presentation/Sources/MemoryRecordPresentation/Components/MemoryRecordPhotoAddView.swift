//
//  MemoryRecordPhotoAddView.swift
//
//
//  Created by 홍성준 on 1/12/24.
//

import UIKit
import BasePresentation
import DesignKit
import Then
import SnapKit

final class MemoryRecordPhotoAddView: BaseView {
    
    private let imageView = UIImageView()
    
    override func tintColorDidChange() {
        super.tintColorDidChange()
        layer.borderColor = UIColor.orange1.cgColor
    }
    
    override func setupLayout() {
        addSubview(imageView)
        imageView.snp.makeConstraints { make in
            make.center.equalToSuperview()
            make.size.equalTo(30)
        }
    }
    
    override func setupAttributes() {
        self.do {
            $0.backgroundColor = .background
            $0.layer.cornerRadius = 16
            $0.layer.borderWidth = 1
            $0.layer.borderColor = UIColor.orange1.cgColor
        }
        
        imageView.do {
            $0.image = .plus.withRenderingMode(.alwaysTemplate)
            $0.tintColor = .orange1
            $0.clipsToBounds = true
            $0.backgroundColor = .background
        }
    }
    
}
