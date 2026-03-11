//
//  ContactManager.swift
//  CairYuk
//
//  Created by hekang on 2026/3/11.
//

import UIKit
import Contacts
import ContactsUI

class ContactManager: NSObject {
    
    static let shared = ContactManager()
    
    private let store = CNContactStore()
    
    func checkPermission(from vc: UIViewController,
                         allowLimitedPicker: Bool = true,
                         completion: @escaping (Bool, CNAuthorizationStatus) -> Void) {
        
        let status = CNContactStore.authorizationStatus(for: .contacts)
        
        switch status {
            
        case .notDetermined:
            store.requestAccess(for: .contacts) { granted, _ in
                DispatchQueue.main.async {
                    completion(granted, CNContactStore.authorizationStatus(for: .contacts))
                }
            }
            
        case .authorized:
            completion(true, status)
            
        case .limited:
            completion(allowLimitedPicker, status)
            
        case .denied, .restricted:
            showSettingAlert(from: vc)
            completion(false, status)
            
        @unknown default:
            completion(false, status)
        }
    }
    
    func fetchAllContacts() -> [[String: String]] {
        
        var result: [[String: String]] = []
        
        let keys: [CNKeyDescriptor] = [
            CNContactGivenNameKey as CNKeyDescriptor,
            CNContactFamilyNameKey as CNKeyDescriptor,
            CNContactPhoneNumbersKey as CNKeyDescriptor
        ]
        
        let request = CNContactFetchRequest(keysToFetch: keys)
        
        do {
            
            try store.enumerateContacts(with: request) { contact, _ in
                
                let phones = contact.phoneNumbers.map {
                    $0.value.stringValue
                }
                
                guard phones.count > 0 else { return }
                
                let phoneStr = phones.joined(separator: ",")
                
                let name = "\(contact.familyName) \(contact.givenName)"
                
                let item: [String: String] = [
                    "ratherine": phoneStr,
                    "traveleous": name
                ]
                
                result.append(item)
            }
            
        } catch {
            print("error===contact====", error)
        }
        
        return result
    }
    
    func presentContactPicker(from vc: UIViewController,
                              completion: @escaping ([String: String]?) -> Void) {
        
        let picker = CNContactPickerViewController()
        
        picker.delegate = self
        
        self.singleCompletion = completion
        
        vc.present(picker, animated: true)
    }
    
    private var singleCompletion: (([String: String]?) -> Void)?
}

extension ContactManager: CNContactPickerDelegate {
    
    func contactPicker(_ picker: CNContactPickerViewController, didSelect contact: CNContact) {
        
        guard let phone = contact.phoneNumbers.first?.value.stringValue else {
            singleCompletion?(nil)
            return
        }
        
        let name = "\(contact.familyName) \(contact.givenName)"
        
        let data: [String: String] = [
            "ratherine": phone,
            "traveleous": name
        ]
        
        singleCompletion?(data)
    }
    
    func contactPickerDidCancel(_ picker: CNContactPickerViewController) {
        singleCompletion?(nil)
    }
}

extension ContactManager {
    
    func showSettingAlert(from vc: UIViewController) {
        
        let alert = UIAlertController(
            title: "通讯录权限未开启",
            message: "请前往设置开启通讯录权限",
            preferredStyle: .alert
        )
        
        alert.addAction(UIAlertAction(title: "取消", style: .cancel))
        
        alert.addAction(UIAlertAction(title: "去设置", style: .default) { _ in
            
            if let url = URL(string: UIApplication.openSettingsURLString) {
                UIApplication.shared.open(url)
            }
            
        })
        
        vc.present(alert, animated: true)
    }
}
