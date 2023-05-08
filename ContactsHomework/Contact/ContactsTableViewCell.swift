//
//  ContactsTableViewCell.swift
//  ContactsHomework
//
//  Created by tamzimun on 03.06.2022.
//

import UIKit

class ContactsTableViewCell: UITableViewCell {

    // MARK: - UIImageView, UIView, UILabel
    
    let contactImageView: UIImageView = {
        let image = UIImageView()
        image.contentMode = .scaleToFill
        image.translatesAutoresizingMaskIntoConstraints = false
        return image
    }()
    
    
    let fullNameLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.boldSystemFont(ofSize: 22)
        label.textColor = .black
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    let phoneNumberLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 16, weight: .medium)
        label.textColor = .systemGray
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        self.contentView.addSubview(contactImageView)
        contentView.addSubview(fullNameLabel)
        contentView.addSubview(phoneNumberLabel)
        setUpConstraints()
     }
    
    required init?(coder aDecoder: NSCoder) {
       super.init(coder: aDecoder)
    }
    
    var contact: Contact? {
        didSet{
            guard let contactItem = contact else {return}
            if let fullname = contactItem.fullname {
                contactImageView.image = UIImage(named: contactItem.image ?? "")
                fullNameLabel.text = fullname
                phoneNumberLabel.text = contactItem.phoneNumber
            }
        }
    }
    
    // MARK: - Setup Constraints
    
    func setUpConstraints() {
        contactImageView.centerYAnchor.constraint(equalTo: contentView.centerYAnchor).isActive = true
        contactImageView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 10).isActive = true
        contactImageView.widthAnchor.constraint(equalToConstant: 70).isActive = true
        contactImageView.heightAnchor.constraint(equalToConstant: 70).isActive = true
        
        
        fullNameLabel.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 20).isActive = true
        fullNameLabel.leadingAnchor.constraint(equalTo: contactImageView.trailingAnchor, constant: 20).isActive = true
        fullNameLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -10).isActive = true
    
        
        phoneNumberLabel.topAnchor.constraint(equalTo: fullNameLabel.bottomAnchor, constant: 10).isActive = true
        phoneNumberLabel.leadingAnchor.constraint(equalTo: fullNameLabel.leadingAnchor).isActive = true
        phoneNumberLabel.trailingAnchor.constraint(equalTo: fullNameLabel.trailingAnchor).isActive = true
    }

}
