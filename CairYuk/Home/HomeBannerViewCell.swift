//
//  HomeBannerViewCell.swift
//  CairYuk
//
//  Created by David Jones on 2026/3/11.
//

import UIKit
import SnapKit
import FSPagerView

class HomeBannerViewCell: UITableViewCell {
    
    // MARK: - Properties
    var tapBlock: ((foldfishessModel) -> Void)?
    
    var modelArray: [foldfishessModel]? {
        didSet { pagerView.reloadData() }
    }
    
    // MARK: - UI Components
    private let bgView: UIView = {
        let view = UIView()
        view.layer.cornerRadius = 4
        view.layer.masksToBounds = true
        view.backgroundColor = UIColor(hexString: "#FFEDED")
        return view
    }()
    
    private let pagerView: FSPagerView = {
        let view = FSPagerView()
        view.register(CustomPagerCell.self, forCellWithReuseIdentifier: CustomPagerCell.identifier)
        view.interitemSpacing = 5
        view.transformer = FSPagerViewTransformer(type: .linear)
        view.isInfinite = true
        view.automaticSlidingInterval = 3.0
        view.backgroundColor = .clear
        return view
    }()
    
    // MARK: - Initialization
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupView()
        setupConstraints()
        setupDelegates()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Setup
    private func setupView() {
        backgroundColor = .clear
        selectionStyle = .none
        contentView.addSubview(bgView)
        bgView.addSubview(pagerView)
    }
    
    private func setupConstraints() {
        bgView.snp.makeConstraints { make in
            make.top.bottom.equalToSuperview()
            make.centerX.equalToSuperview()
            make.size.equalTo(CGSize(width: 343.pix(), height: 56.pix()))
        }
        
        pagerView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
    }
    
    private func setupDelegates() {
        pagerView.dataSource = self
        pagerView.delegate = self
    }
    
    // MARK: - Helper Methods
    private func configurePagerCell(_ cell: CustomPagerCell) {
        cell.contentView.layer.shadowColor = UIColor.clear.cgColor
        cell.contentView.layer.shadowRadius = 0
        cell.contentView.layer.shadowOpacity = 0
        cell.contentView.layer.shadowOffset = .zero
        cell.contentView.transform = .identity
        cell.contentView.backgroundColor = .clear
        cell.backgroundColor = .clear
    }
}

// MARK: - FSPagerView DataSource & Delegate
extension HomeBannerViewCell: FSPagerViewDataSource, FSPagerViewDelegate {
    
    func numberOfItems(in pagerView: FSPagerView) -> Int {
        return modelArray?.count ?? 0
    }
    
    func pagerView(_ pagerView: FSPagerView, cellForItemAt index: Int) -> FSPagerViewCell {
        let cell = pagerView.dequeueReusableCell(withReuseIdentifier: CustomPagerCell.identifier, at: index) as! CustomPagerCell
        
        if let model = modelArray?[index] {
            cell.configure(with: model.northature ?? "")
        }
        
        configurePagerCell(cell)
        return cell
    }
    
    func pagerView(_ pagerView: FSPagerView, didSelectItemAt index: Int) {
        guard let model = modelArray?[index] else { return }
        tapBlock?(model)
    }
}

// MARK: - Custom Pager Cell
class CustomPagerCell: FSPagerViewCell {
    
    // MARK: - Properties
    static let identifier = "CustomPagerCell"
    
    // MARK: - UI Components
    private let containerView: UIView = {
        let view = UIView()
        view.backgroundColor = .clear
        return view
    }()
    
    private let oneImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(named: "rct_a_image")
        return imageView
    }()
    
    private let twoImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(named: "aow_black_image")
        return imageView
    }()
    
    private let titleLabel: UILabel = {
        let label = UILabel()
        label.textColor = .black
        label.font = UIFont.systemFont(ofSize: 12, weight: .medium)
        label.numberOfLines = 0
        label.textAlignment = .left
        return label
    }()
    
    // MARK: - Initialization
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupView()
        setupConstraints()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Setup
    private func setupView() {
        contentView.addSubview(containerView)
        containerView.addSubview(oneImageView)
        containerView.addSubview(twoImageView)
        containerView.addSubview(titleLabel)
    }
    
    private func setupConstraints() {
        containerView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
        
        oneImageView.snp.makeConstraints { make in
            make.centerY.equalToSuperview()
            make.left.equalToSuperview().offset(10)
            make.width.height.equalTo(24)
        }
        
        twoImageView.snp.makeConstraints { make in
            make.centerY.equalToSuperview()
            make.right.equalToSuperview().offset(-15.pix())
            make.width.height.equalTo(20)
        }
        
        titleLabel.snp.makeConstraints { make in
            make.left.equalTo(oneImageView.snp.right).offset(8)
            make.right.equalTo(twoImageView.snp.left).offset(-13)
            make.top.bottom.equalToSuperview()
        }
    }
    
    // MARK: - Configuration
    func configure(with title: String) {
        titleLabel.text = title
    }
}
