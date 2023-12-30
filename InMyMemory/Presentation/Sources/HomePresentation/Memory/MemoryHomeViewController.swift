//
//  MemoryHomeViewController.swift
//
//
//  Created by 홍성준 on 12/30/23.
//

import UIKit
import BasePresentation
import DesignKit
import RxSwift
import RxCocoa
import SnapKit
import Then

final class MemoryHomeViewController: UIViewController {
    
    private let scrollView = UIScrollView()
    private let stackView = UIStackView()
    
    private let recordView = MemoryHomeRecordView()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupLayout()
        setupAttributes()
    }
    
    private func setupLayout() {
        view.addSubview(scrollView)
        scrollView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
        
        scrollView.addSubview(stackView)
        stackView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
        
        stackView.addArrangedSubview(recordView)
    }
    
    private func setupAttributes() {
        view.backgroundColor = .background
        
        scrollView.do {
            $0.showsHorizontalScrollIndicator = false
            $0.showsVerticalScrollIndicator = false
        }
        
        stackView.do {
            $0.axis = .horizontal
            $0.alignment = .fill
            $0.distribution = .equalSpacing
            $0.spacing = 40
        }
    }
    
}
