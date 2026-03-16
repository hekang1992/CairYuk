//
//  CameraManager.swift
//  CairYuk
//
//  Created by David Jones on 2026/3/10.
//

import UIKit
import AVFoundation

class CameraManager: NSObject, UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    
    var photoCaptureComplete: ((UIImage?) -> Void)?
    
    private let maxImageSize: CGFloat = 700
    
    private weak var presentingViewController: UIViewController?
    
    private var cameraDevice: UIImagePickerController.CameraDevice = .rear
    
    init(presentingViewController: UIViewController, initialCameraPosition: UIImagePickerController.CameraDevice = .rear) {
        self.presentingViewController = presentingViewController
        self.cameraDevice = initialCameraPosition
        super.init()
    }
    
    func checkCameraPermission(completion: @escaping (Bool) -> Void) {
        switch AVCaptureDevice.authorizationStatus(for: .video) {
        case .authorized:
            completion(true)
        case .notDetermined:
            AVCaptureDevice.requestAccess(for: .video) { granted in
                DispatchQueue.main.async {
                    if granted {
                        completion(true)
                    } else {
                        completion(false)
                        self.showPermissionDeniedAlert()
                    }
                }
            }
        case .denied, .restricted:
            DispatchQueue.main.async {
                completion(false)
                self.showPermissionDeniedAlert()
            }
        @unknown default:
            DispatchQueue.main.async {
                completion(false)
            }
        }
    }
    
    private func showPermissionDeniedAlert() {
        guard let viewController = presentingViewController else { return }
        
        let alert = UIAlertController(
            title: "Camera Permission".localized,
            message: "Camera permission is needed to capture your ID card and securely collect your identity information. Please grant access in Settings.".localized,
            preferredStyle: .alert
        )
        
        alert.addAction(UIAlertAction(title: "Cancel".localized, style: .cancel))
        
        alert.addAction(UIAlertAction(title: "Go to Settings".localized, style: .default) { _ in
            
            if let url = URL(string: UIApplication.openSettingsURLString) {
                UIApplication.shared.open(url)
            }
            
        })
        
        viewController.present(alert, animated: true)
    }
    
    func openCamera() {
        checkCameraPermission { [weak self] granted in
            guard let self = self, granted else { return }
            
            DispatchQueue.main.async {
                self.presentCamera()
            }
        }
    }
    
    private func presentCamera() {
        guard let viewController = presentingViewController,
              UIImagePickerController.isSourceTypeAvailable(.camera) else {
            return
        }
        
        let imagePicker = UIImagePickerController()
        imagePicker.sourceType = .camera
        imagePicker.delegate = self
        imagePicker.allowsEditing = false
        imagePicker.cameraDevice = cameraDevice
        
        viewController.present(imagePicker, animated: true)
    }
    
    func switchCamera() {
        cameraDevice = cameraDevice == .rear ? .front : .rear
    }
    
    private func compressImage(_ image: UIImage) -> UIImage? {
        let maxSize = maxImageSize
        let originalSize = image.size
        
        var newSize: CGSize
        if originalSize.width > originalSize.height {
            let ratio = maxSize / originalSize.width
            newSize = CGSize(width: maxSize, height: originalSize.height * ratio)
        } else {
            let ratio = maxSize / originalSize.height
            newSize = CGSize(width: originalSize.width * ratio, height: maxSize)
        }
        
        if newSize.width > originalSize.width || newSize.height > originalSize.height {
            return image
        }
        
        UIGraphicsBeginImageContextWithOptions(newSize, false, 1.0)
        image.draw(in: CGRect(origin: .zero, size: newSize))
        let compressedImage = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        
        return compressedImage
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        picker.dismiss(animated: true) { [weak self] in
            guard let self = self else { return }
            if let originalImage = info[.originalImage] as? UIImage {
                if let compressedImage = self.compressImage(originalImage) {
                    self.photoCaptureComplete?(compressedImage)
                } else {
                    self.photoCaptureComplete?(originalImage)
                }
            } else {
                self.photoCaptureComplete?(nil)
            }
        }
    }
    
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        picker.dismiss(animated: true) { [weak self] in
            self?.photoCaptureComplete?(nil)
        }
    }
}
