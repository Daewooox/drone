//
//  DronAccountTableViewCell.swift
//  Dron
//
//  Created by Dmtech on 18.05.18.
//  Copyright © 2018 DMTech. All rights reserved.
//

import UIKit

class DronAccountTableViewCell: UITableViewCell {

    var titleLabel : UILabel = UILabel()
    var textView : UITextField = UITextField()
    
    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        self.setupUI()
    }
    
    
    required init?(coder aDecoder: NSCoder) {
     super.init(coder: aDecoder)
    }
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }

    internal func setupUI() {
        
        self.contentView.backgroundColor = UIColor.clear
        self.backgroundColor = UIColor.clear
        
        self.titleLabel.translatesAutoresizingMaskIntoConstraints = false
        self.titleLabel.textColor = UIColor.black
        self.titleLabel.font = UIFont.systemFont(ofSize: 16)
        self.titleLabel.numberOfLines = 0
        self.titleLabel.lineBreakMode = NSLineBreakMode.byWordWrapping
        self.contentView.addSubview(self.titleLabel)
        
        self.titleLabel.leadingAnchor.constraint(equalTo: self.contentView.leadingAnchor, constant: 15).isActive = true
        self.titleLabel.topAnchor.constraint(equalTo: self.contentView.topAnchor, constant: 5).isActive = true
        self.titleLabel.trailingAnchor.constraint(lessThanOrEqualTo: self.contentView.trailingAnchor, constant: -15).isActive = true
        
        textView.translatesAutoresizingMaskIntoConstraints = false
        textView.font = UIFont.systemFont(ofSize: 16)
        let indentView = UIView(frame: CGRect(x: 0, y: 0, width: 5, height: 5))
        indentView.backgroundColor = UIColor.clear
        textView.leftView = indentView
        textView.leftViewMode = UITextFieldViewMode.always
        textView.spellCheckingType = UITextSpellCheckingType.no
        textView.autocapitalizationType = UITextAutocapitalizationType.sentences
        textView.backgroundColor = UIColor.AccountViewController.textFieldBackgroundColor
        textView.textColor = UIColor.AccountViewController.textFieldTextColor
        textView.tintColor = UIColor.AccountViewController.textFieldTextColor
        
        
        textView.layer.borderWidth = 1
        textView.layer.borderColor = UIColor.AccountViewController.textFieldBorderColor.cgColor
        textView.layer.cornerRadius = 5

        self.contentView.addSubview(self.textView)
        
        self.textView.heightAnchor.constraint(equalToConstant: 44).isActive = true
        self.textView.leadingAnchor.constraint(equalTo: self.titleLabel.leadingAnchor, constant: 0).isActive = true
        self.textView.trailingAnchor.constraint(equalTo: self.contentView.trailingAnchor, constant: -15).isActive = true
        self.textView.topAnchor.constraint(equalTo: self.titleLabel.bottomAnchor, constant: 10).isActive = true
        self.textView.bottomAnchor.constraint(equalTo: self.contentView.bottomAnchor, constant: -10).isActive = true
    }
    
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

    }

}
