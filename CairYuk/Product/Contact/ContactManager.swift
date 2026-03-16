//
//  ContactManager.swift
//  CairYuk
//
//  Created by David Jones on 2026/3/11.
//

import UIKit
import Contacts
import ContactsUI

class ContactManager: NSObject {
    
    static let shared = ContactManager()
    
    private let store = CNContactStore()
    
    private var singleCompletion: (([String: String]?) -> Void)?
    
    func checkPermission(from vc: UIViewController,
                         allowLimitedPicker: Bool = true,
                         completion: @escaping (Bool, CNAuthorizationStatus) -> Void) {
        
        let status = CNContactStore.authorizationStatus(for: .contacts)
        
        switch status {
            
        case .notDetermined:
            
            store.requestAccess(for: .contacts) { granted, _ in
                
                DispatchQueue.main.async {
                    
                    let newStatus = CNContactStore.authorizationStatus(for: .contacts)
                    
                    if granted {
                        completion(true, newStatus)
                    } else {
                        DispatchQueue.main.asyncAfter(deadline: .now() + 0.2) {
                            self.showSettingAlert(from: vc)
                        }
                        completion(false, newStatus)
                    }
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
    
    // MARK: - 获取所有联系人
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
                
                let phones = contact.phoneNumbers.compactMap {
                    self.cleanPhoneNumber($0.value.stringValue)
                }
                
                guard phones.count > 0 else { return }
                
                let phoneStr = phones.joined(separator: ",")
                
                let name = "\(contact.familyName) \(contact.givenName)".trimmingCharacters(in: .whitespaces)
                
                let item: [String: String] = [
                    "ratherine": phoneStr,
                    "traveleous": name
                ]
                
                result.append(item)
            }
            
        } catch {
            print("contact fetch error:", error)
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
}

extension ContactManager: CNContactPickerDelegate {
    
    func contactPicker(_ picker: CNContactPickerViewController, didSelect contact: CNContact) {
        
        guard let phone = contact.phoneNumbers.first?.value.stringValue else {
            singleCompletion?(nil)
            return
        }
        
        let cleanPhone = cleanPhoneNumber(phone)
        
        let name = "\(contact.familyName) \(contact.givenName)".trimmingCharacters(in: .whitespaces)
        
        let data: [String: String] = [
            "ratherine": cleanPhone,
            "traveleous": name
        ]
        
        singleCompletion?(data)
    }
    
    func contactPickerDidCancel(_ picker: CNContactPickerViewController) {
        singleCompletion?(nil)
    }
}

extension ContactManager {
    
    private func cleanPhoneNumber(_ phone: String) -> String {
        
        var number = phone
        
        number = number.replacingOccurrences(of: " ", with: "")
        number = number.replacingOccurrences(of: "-", with: "")
        number = number.replacingOccurrences(of: "(", with: "")
        number = number.replacingOccurrences(of: ")", with: "")
        
        return number
    }
    
    func showSettingAlert(from vc: UIViewController) {
        
        let alert = UIAlertController(
            title: "Contacts Permission".localized,
            message: "To verify your identity information, we need to access your contact list. This security measure helps prevent fraud and speeds up your loan application process. Please grant access in Settings.".localized,
            preferredStyle: .alert
        )
        
        alert.addAction(UIAlertAction(title: "Cancel".localized, style: .cancel))
        
        alert.addAction(UIAlertAction(title: "Go to Settings".localized, style: .default) { _ in
            
            if let url = URL(string: UIApplication.openSettingsURLString) {
                UIApplication.shared.open(url)
            }
            
        })
        
        vc.present(alert, animated: true)
    }
}
