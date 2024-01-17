//
//  MemoryDetailImageListView.swift
//
//
//  Created by 홍성준 on 1/13/24.
//

import UIKit
import BasePresentation
import RxSwift
import RxCocoa
import SnapKit
import Then

final class MemoryDetailImageListView: BaseView {
    
    fileprivate var imageBinder: Binder<[Data]> {
        return Binder(self) { this, images in
            this.setup(images: images)
        }
    }
    
    private let scrollView = UIScrollView()
    private let stackView = UIStackView()
    private let emptyLabel = UILabel()
    private let topLayer = CALayer()
    private let bottomLayer = CALayer()
    
    func setup(images: [Data]) {
        emptyLabel.isHidden = !images.isEmpty
        stackView.subviews.forEach { $0.removeFromSuperview() }
        
        images.forEach { imageData in
            let imageView = UIImageView()
            imageView.image = UIImage(data: imageData)
            imageView.contentMode = .scaleAspectFill
            imageView.clipsToBounds = true
            stackView.addArrangedSubview(imageView)
            imageView.snp.makeConstraints { make in
                make.size.equalTo(self)
            }
        }
    }
    
    override func tintColorDidChange() {
        super.tintColorDidChange()
        topLayer.backgroundColor = UIColor.orange1.cgColor
        bottomLayer.backgroundColor = UIColor.orange1.cgColor
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        topLayer.frame = .init(x: 0, y: 0, width: frame.width, height: 1)
        bottomLayer.frame = .init(x: 0, y: frame.maxY - 1, width: frame.width, height: 1)
    }
    
    override func setupLayout() {
        addSubview(scrollView)
        scrollView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
        
        scrollView.addSubview(stackView)
        stackView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
        
        addSubview(emptyLabel)
        emptyLabel.snp.makeConstraints { make in
            make.center.equalToSuperview()
        }
        
        layer.addSublayer(topLayer)
        layer.addSublayer(bottomLayer)
    }
    
    override func setupAttributes() {
        scrollView.do {
            $0.isPagingEnabled = true
            $0.showsHorizontalScrollIndicator = false
        }
        
        stackView.do {
            $0.axis = .horizontal
            $0.spacing = 0
            $0.alignment = .fill
            $0.distribution = .fill
        }
        
        emptyLabel.do {
            $0.text = "사진이 없어요"
            $0.textColor = .orange1
            $0.font = .gmarketSans(type: .light, size: 17)
        }
        
        topLayer.backgroundColor = UIColor.orange1.cgColor
        bottomLayer.backgroundColor = UIColor.orange1.cgColor
    }
    
}

extension Reactive where Base: MemoryDetailImageListView {
    
    var images: Binder<[Data]> {
        return base.imageBinder
    }
    
}
