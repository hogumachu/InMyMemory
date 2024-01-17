//
//  PhotoProvider.swift
//
//
//  Created by 홍성준 on 1/12/24.
//

import UIKit
import PhotosUI

public protocol PhotoProviderDelegate: AnyObject {
    func photoProviderDidFinishPicking(_ provider: PhotoProviderInterface, image: Data?)
}

public protocol PhotoProviderInterface: AnyObject {
    var delegate: PhotoProviderDelegate? { get set }
    func present(from controller: UIViewController, animated: Bool)
    func dismiss(animated: Bool)
}

public final class PhotoProvider: PhotoProviderInterface {
    
    public weak var delegate: PhotoProviderDelegate?
    private var picker: PHPickerViewController?
    
    public init() {}
    
    public func present(from controller: UIViewController, animated: Bool) {
        let picker: PHPickerViewController = {
            var configuration = PHPickerConfiguration(photoLibrary: .shared())
            configuration.selectionLimit = 1
            return PHPickerViewController(configuration: configuration)
        }()
        picker.delegate = self
        controller.present(picker, animated: animated)
        self.picker = picker
    }
    
    public func dismiss(animated: Bool) {
        self.picker?.dismiss(animated: true)
        self.picker = nil
    }
    
}

extension PhotoProvider: PHPickerViewControllerDelegate {
    
    public func picker(_ picker: PHPickerViewController, didFinishPicking results: [PHPickerResult]) {
        guard let itemProvider = results.first?.itemProvider else {
            delegate?.photoProviderDidFinishPicking(self, image: nil)
            return
        }
        
        itemProvider.loadObject(ofClass: UIImage.self) { [weak self] image, _ in
            guard let self else { return }
            let imageData = (image as? UIImage)?.pngData()
            delegate?.photoProviderDidFinishPicking(self, image: imageData)
        }
    }
    
}
