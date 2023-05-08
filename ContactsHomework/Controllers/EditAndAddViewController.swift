//
//  EditViewController.swift
//  ContactsHomework
//
//  Created by tamzimun on 05.06.2022.
//

import UIKit

protocol AddContactDelegate: AnyObject {
    func addContact(contact: Contact)
}

protocol EditContactDelegate: AnyObject {
    func editContact(contact: Contact, index: Int)
}

class EditAndAddViewController: UIViewController {
    
    weak var addDelegate: AddContactDelegate?
    weak var editDelegate: EditContactDelegate?
    
    private var name: String = ""
    private var phoneNumber: String = ""
    private var gender: String = ""
    
    private let genderPickerView = UIPickerView()
    private var chooseGender: String = ""
    private let genders: [String] = ["male", "female"]
    
    var cellIndex2: Int?
    
    init(name: String, phoneNumber: String) {
        self.name = name
        self.phoneNumber = phoneNumber
        super.init(nibName: nil, bundle: nil)
    }
    
    convenience init() {
        self.init(name:"", phoneNumber: "")
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - UITextField
    
    let fullNameField: UITextField = {
        let textField = UITextField()
        textField.textAlignment = .center
        textField.translatesAutoresizingMaskIntoConstraints = false
        textField.placeholder = "Enter full name"
        return textField
    }()
    
    let phoneNumberField: UITextField = {
        let textField = UITextField()
        textField.textAlignment = .center
        textField.placeholder = "Enter phone number"
        textField.translatesAutoresizingMaskIntoConstraints = false
        return textField
    }()
    
    
    // MARK: - Save UIButton
    let saveButton: UIButton = {
        let button = UIButton()
        button.backgroundColor = .systemBlue
        button.setTitle("Save", for: .normal)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.addTarget(self, action: #selector(saveButtonTapped), for: .touchUpInside)
        return button
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.addSubview(fullNameField)
        view.addSubview(phoneNumberField)
        view.addSubview(saveButton)
        view.addSubview(genderPickerView)
        view.backgroundColor = .white
        
        fullNameField.text = name
        phoneNumberField.text = phoneNumber
        
        genderPickerView.delegate = self
        genderPickerView.dataSource = self
        chooseGender = genders[0]
        
        setUpConstraints()
    }
    
    @objc private func saveButtonTapped() {
        guard let fullname = fullNameField.text, fullNameField.hasText else {
            return
        }
        guard let phoneNumber = phoneNumberField.text, phoneNumberField.hasText else {
            return
        }
        let contact = Contact(fullname: fullname, phoneNumber: phoneNumber, image: chooseGender + ".jpeg", gender: chooseGender)
        addDelegate?.addContact(contact: contact)
        if let cellIndex2 = cellIndex2 {
            editDelegate?.editContact(contact: contact, index: cellIndex2)
        }
//        self.navigationController?.popToViewController(DetailViewController(), animated: true)
        self.navigationController?.popToRootViewController(animated: true)
    }

    // MARK: - Setup Constraints
    
    func setUpConstraints() {
        fullNameField.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 25).isActive = true
        fullNameField.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20).isActive = true
        fullNameField.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20).isActive = true
        fullNameField.heightAnchor.constraint(equalToConstant: view.frame.height * 0.05).isActive = true
        fullNameField.layer.borderWidth = 2
        fullNameField.layer.cornerRadius = 5
        fullNameField.layer.borderColor = UIColor.systemGray5.cgColor
        
        phoneNumberField.topAnchor.constraint(equalTo: fullNameField.bottomAnchor, constant: 10).isActive = true
        phoneNumberField.leadingAnchor.constraint(equalTo: fullNameField.leadingAnchor).isActive = true
        phoneNumberField.trailingAnchor.constraint(equalTo: fullNameField.trailingAnchor).isActive = true
        phoneNumberField.heightAnchor.constraint(equalToConstant: view.frame.height * 0.05).isActive = true
        phoneNumberField.layer.borderWidth = 2
        phoneNumberField.layer.cornerRadius = 5
        phoneNumberField.layer.borderColor = UIColor.systemGray5.cgColor
        
        genderPickerView.translatesAutoresizingMaskIntoConstraints = false
        genderPickerView.topAnchor.constraint(equalTo: phoneNumberField.bottomAnchor, constant: 50).isActive = true
        genderPickerView.leadingAnchor.constraint(equalTo: fullNameField.leadingAnchor).isActive = true
        genderPickerView.trailingAnchor.constraint(equalTo: fullNameField.trailingAnchor).isActive = true
        genderPickerView.heightAnchor.constraint(equalToConstant: 100).isActive = true
        
        
        saveButton.leadingAnchor.constraint(equalTo: fullNameField.leadingAnchor).isActive = true
        saveButton.trailingAnchor.constraint(equalTo: fullNameField.trailingAnchor).isActive = true
        saveButton.heightAnchor.constraint(equalToConstant: view.frame.height * 0.05).isActive = true
        saveButton.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -10).isActive = true
        
    }
}

extension EditAndAddViewController: UIPickerViewDelegate, UIPickerViewDataSource {
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        genders.count
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        let row = genders[row]
        return row
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        chooseGender = genders[row]
    }
}




//we
