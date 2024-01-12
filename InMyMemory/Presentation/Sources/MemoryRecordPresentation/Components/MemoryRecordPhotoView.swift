//
//  MemoryRecordPhotoView.swift
//
//
//  Created by 홍성준 on 1/12/24.
//

import UIKit
import BasePresentation
import DesignKit
import RxSwift
import RxCocoa
import RxRelay
import Then
import SnapKit

final class MemoryRecordPhotoView: BaseView {
    
    fileprivate let contentLabel = UILabel()
    private let scrollView = UIScrollView()
    private let stackView = UIStackView()
    fileprivate let addView = MemoryRecordPhotoAddView()
    fileprivate let removeTapRelay = PublishRelay<Int>()
    fileprivate var imageBinder: Binder<[Data]> {
        return Binder(self) { this, images in
            this.stackView.subviews.forEach { $0.removeFromSuperview() }
            this.stackView.addArrangedSubview(this.addView)
            images.enumerated().forEach { offset, imageData in
                let view = MemoryRecordPhotoContentView()
                view.setup(imageData: imageData)
                this.stackView.addArrangedSubview(view)
                view.rx.removeTap
                    .map { _ in offset }
                    .bind(to: this.removeTapRelay)
                    .disposed(by: this.disposeBag)
            }
        }
    }
    
    override func setupLayout() {
        addSubview(contentLabel)
        contentLabel.snp.makeConstraints { make in
            make.top.leading.trailing.equalToSuperview()
        }
        
        addSubview(scrollView)
        scrollView.snp.makeConstraints { make in
            make.top.equalTo(contentLabel.snp.bottom).offset(20)
            make.leading.trailing.bottom.equalToSuperview()
            make.height.equalTo(200)
        }
        
        scrollView.addSubview(stackView)
        stackView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
        
        stackView.addArrangedSubview(addView)
        addView.snp.makeConstraints { make in
            make.size.equalTo(200)
        }
    }
    
    override func setupAttributes() {
        contentLabel.do {
            $0.font = .gmarketSans(type: .light, size: 17)
            $0.textColor = .orange1
            $0.textAlignment = .center
        }
        
        scrollView.do {
            $0.showsHorizontalScrollIndicator = false
            $0.contentInset = .init(
                top: 0,
                left: UIScreen.main.bounds.width / 2 - 100,
                bottom: 0,
                right: 20
            )
        }
        
        stackView.do {
            $0.axis = .horizontal
            $0.distribution = .fillEqually
            $0.alignment = .fill
            $0.spacing = 20
        }
    }
    
}

extension Reactive where Base: MemoryRecordPhotoView {
    
    var title: Binder<String?> {
        return base.contentLabel.rx.text
    }
    
    var addTap: ControlEvent<Void> {
        let source = base.addView.rx.recognizedTap
        return ControlEvent(events: source)
    }
    
    var images: Binder<[Data]> {
        return base.imageBinder
    }
    
    var removeImageTap: ControlEvent<Int> {
        let source = base.removeTapRelay
        return ControlEvent(events: source)
    }
    
}
