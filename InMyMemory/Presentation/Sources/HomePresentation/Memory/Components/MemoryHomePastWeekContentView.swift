//
//  MemoryHomePastWeekContentView.swift
//
//
//  Created by 홍성준 on 12/30/23.
//

import UIKit
import BasePresentation
import DesignKit
import SnapKit
import Then

struct MemoryHomePastWeekContentViewModel {
    let title: String
    let imageData: Data?
}

final class MemoryHomePastWeekContentView: BaseView {
    
    private let imageView = UIImageView()
    private let dateLabel = UILabel()
    
    func setup(model: MemoryHomePastWeekContentViewModel) {
        print(model.title)
        dateLabel.text = model.title
        
        if let imageData = model.imageData {
            imageView.image = UIImage(data: imageData)
        } else {
            imageView.image = nil
        }
    }
    
    override func tintColorDidChange() {
        super.tintColorDidChange()
        imageView.layer.borderColor = UIColor.orange1.cgColor
    }
    
    override func setupLayout() {
        addSubview(imageView)
        imageView.snp.makeConstraints { make in
            make.top.leading.trailing.equalToSuperview()
            make.size.equalTo(100)
        }
        
        addSubview(dateLabel)
        dateLabel.snp.makeConstraints { make in
            make.top.equalTo(imageView.snp.bottom).offset(5)
            make.leading.trailing.bottom.equalToSuperview()
        }
    }
    
    override func setupAttributes() {
        imageView.do {
            $0.backgroundColor = .background
            $0.contentMode = .scaleAspectFill
            $0.clipsToBounds = true
            $0.layer.cornerRadius = 16
            $0.layer.borderColor = UIColor.orange1.cgColor
            $0.layer.borderWidth = 1
        }
        
        dateLabel.do {
            $0.textColor = .orange1
            $0.font = .gmarketSans(type: .light, size: 11)
            $0.textAlignment = .center
        }
    }
    
}
