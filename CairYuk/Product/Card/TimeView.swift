//
//  TimeView.swift
//  CairYuk
//
//  Created by hekang on 2026/3/10.
//

import UIKit
import SnapKit

class TimeView: UIView {
    
    private let dayPicker = UIPickerView()
    private let monthPicker = UIPickerView()
    private let yearPicker = UIPickerView()
    
    private let dayLabel = UILabel()
    private let monthLabel = UILabel()
    private let yearLabel = UILabel()
    
    private let confirmButton = UIButton(type: .custom)
    private let titleLabel = UILabel()
    
    private var days: [Int] = Array(1...31)
    private var months: [Int] = Array(1...12)
    private var years: [Int] = Array(1900...2100)
    
    private var selectedDay: Int = 1
    private var selectedMonth: Int = 1
    private var selectedYear: Int = 1990
    
    private let dateFormatter: DateFormatter = {
        let formatter = DateFormatter()
        formatter.dateFormat = "dd/MM/yyyy"
        return formatter
    }()
    
    var onConfirm: ((String) -> Void)?
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupUI()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setupUI()
    }
    
    func setDate(from dateString: String, format: String = "dd/MM/yyyy") {
        dateFormatter.dateFormat = format
        
        if let date = dateFormatter.date(from: dateString) {
            let calendar = Calendar.current
            let components = calendar.dateComponents([.day, .month, .year], from: date)
            
            selectedDay = components.day ?? 1
            selectedMonth = components.month ?? 1
            selectedYear = components.year ?? 1990
            
            dayPicker.selectRow(selectedDay - 1, inComponent: 0, animated: false)
            monthPicker.selectRow(selectedMonth - 1, inComponent: 0, animated: false)
            if let yearIndex = years.firstIndex(of: selectedYear) {
                yearPicker.selectRow(yearIndex, inComponent: 0, animated: false)
            }
        }
        
        dateFormatter.dateFormat = "dd/MM/yyyy"
    }
    
    private func setupUI() {
        backgroundColor = .white
        layer.cornerRadius = 12
        layer.shadowColor = UIColor.black.cgColor
        layer.shadowOpacity = 0.1
        layer.shadowRadius = 10
        layer.shadowOffset = CGSize(width: 0, height: 5)
        
        titleLabel.text = "Select date".localized
        titleLabel.font = UIFont.boldSystemFont(ofSize: 18)
        titleLabel.textAlignment = .center
        addSubview(titleLabel)
        
        setupLabel(dayLabel, text: "Day".localized)
        setupLabel(monthLabel, text: "Month".localized)
        setupLabel(yearLabel, text: "Year".localized)
        
        setupPicker(dayPicker, tag: 1)
        setupPicker(monthPicker, tag: 2)
        setupPicker(yearPicker, tag: 3)
        
        confirmButton.setTitle("Confirm".localized, for: .normal)
        confirmButton.setTitleColor(.white, for: .normal)
        confirmButton.layer.cornerRadius = 8
        confirmButton.titleEdgeInsets = UIEdgeInsets(top: 0, left: 0, bottom: 10, right: 0)
        confirmButton.addTarget(self, action: #selector(confirmTapped), for: .touchUpInside)
        
        confirmButton.setBackgroundImage(UIImage(named: "con_a_bt_image"), for: .normal)
        
        addSubview(confirmButton)
        
        setupConstraints()
        
        setDate(from: "01/01/1990")
    }
    
    private func setupLabel(_ label: UILabel, text: String) {
        label.text = text
        label.font = UIFont.systemFont(ofSize: 14)
        label.textColor = .gray
        label.textAlignment = .center
        addSubview(label)
    }
    
    private func setupPicker(_ picker: UIPickerView, tag: Int) {
        picker.tag = tag
        picker.delegate = self
        picker.dataSource = self
        addSubview(picker)
    }
    
    private func setupConstraints() {
        titleLabel.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(20)
            make.left.right.equalToSuperview().inset(20)
        }
        
        dayLabel.snp.makeConstraints { make in
            make.top.equalTo(titleLabel.snp.bottom).offset(20)
            make.left.equalToSuperview().offset(20)
            make.width.equalTo((UIScreen.main.bounds.width - 80) / 3)
        }
        
        monthLabel.snp.makeConstraints { make in
            make.top.equalTo(titleLabel.snp.bottom).offset(20)
            make.centerX.equalToSuperview()
            make.width.equalTo((UIScreen.main.bounds.width - 80) / 3)
        }
        
        yearLabel.snp.makeConstraints { make in
            make.top.equalTo(titleLabel.snp.bottom).offset(20)
            make.right.equalToSuperview().offset(-20)
            make.width.equalTo((UIScreen.main.bounds.width - 80) / 3)
        }
        
        dayPicker.snp.makeConstraints { make in
            make.top.equalTo(dayLabel.snp.bottom).offset(10)
            make.left.equalToSuperview().offset(20)
            make.width.equalTo((UIScreen.main.bounds.width - 80) / 3)
            make.height.equalTo(150)
        }
        
        monthPicker.snp.makeConstraints { make in
            make.top.equalTo(monthLabel.snp.bottom).offset(10)
            make.centerX.equalToSuperview()
            make.width.equalTo((UIScreen.main.bounds.width - 80) / 3)
            make.height.equalTo(150)
        }
        
        yearPicker.snp.makeConstraints { make in
            make.top.equalTo(yearLabel.snp.bottom).offset(10)
            make.right.equalToSuperview().offset(-20)
            make.width.equalTo((UIScreen.main.bounds.width - 80) / 3)
            make.height.equalTo(150)
        }
        
        confirmButton.snp.makeConstraints { make in
            make.top.equalTo(dayPicker.snp.bottom).offset(20)
            make.centerX.equalToSuperview()
            make.width.equalTo(261)
            make.height.equalTo(65)
            make.bottom.equalToSuperview().offset(-20)
        }
    }
    
    @objc private func confirmTapped() {
        let dayString = String(format: "%02d", selectedDay)
        let monthString = String(format: "%02d", selectedMonth)
        let yearString = String(selectedYear)
        
        let dateString = "\(dayString)/\(monthString)/\(yearString)"
        
        onConfirm?(dateString)
        
        removeFromSuperview()
    }
}

// MARK: - UIPickerView Delegate & DataSource
extension TimeView: UIPickerViewDelegate, UIPickerViewDataSource {
    
    func pickerView(_ pickerView: UIPickerView, rowHeightForComponent component: Int) -> CGFloat {
        return 40
    }
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        switch pickerView.tag {
        case 1:
            return days.count
        case 2:
            return months.count
        case 3:
            return years.count
        default:
            return 0
        }
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        switch pickerView.tag {
        case 1:
            return String(format: "%02d", days[row])
        case 2:
            return String(format: "%02d", months[row])
        case 3:
            return "\(years[row])"
        default:
            return nil
        }
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        switch pickerView.tag {
        case 1:
            selectedDay = days[row]
        case 2:
            selectedMonth = months[row]
        case 3:
            selectedYear = years[row]
        default:
            break
        }
    }
}
