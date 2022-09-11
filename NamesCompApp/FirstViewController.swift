//
//  ViewController.swift
//  NamesCompApp
//
//  Created by Yuriy on 10.09.2022.
//

import UIKit

class FirstViewController: UIViewController {
    
    @IBOutlet weak var yourNameTF: UITextField!
    @IBOutlet weak var partnerNameTF: UITextField!
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        guard let destinationVC = segue.destination as? ResultViewController else { return }
        destinationVC.firstName = yourNameTF.text
        destinationVC.secondName = partnerNameTF.text
    }
    
    @IBAction func resultButtonTapped() {
        guard let firstName = yourNameTF.text, let secondName = partnerNameTF.text else { return }
        if firstName.isEmpty || secondName.isEmpty {
            showAlert(
                title: "Names are missing",
                message: "Please enter both names"
            )
            return
        }
        
        let deniedSymbols = ["1", "2", "3", "4", "5", "6", "7",
                             "8", "9", "0", "!", "@", "#", "$",
                             "%", "^", "&", "*", "(", ")", "_",
                             "-", "+", "=", ",", ".", ":", "'",
                             "\"", "§", "±", " "]
        
        for symbol in firstName {
            if deniedSymbols.contains(String(symbol)) {
                showAlert(
                    title: "Your name contains incorrect symbols",
                    message: "Please enter correct name only from letters"
                )
                return
            }
        }
        
        for symbol in secondName {
            if deniedSymbols.contains(String(symbol)) {
                showAlert(
                    title: "Partner's name contains incorrect symbols",
                    message: "Please enter correct name only from letters"
                )
                return
            }
        }
        
        performSegue(withIdentifier: "goToResult", sender: nil)
    }
    
    @IBAction func unwindSegueToFirstVC(segue: UIStoryboardSegue) {
        yourNameTF.text = ""
        partnerNameTF.text = ""
    }
    
}

extension FirstViewController {
    private func showAlert(title: String, message: String) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        let okAction = UIAlertAction(title: "OK", style: .default)
        alert.addAction(okAction)
        present(alert, animated: true)
    }
}

extension FirstViewController: UITextFieldDelegate {
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        super.touchesBegan(touches, with: event)
        view.endEditing(true)
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        if textField == yourNameTF {
            partnerNameTF.becomeFirstResponder()
        } else {
            resultButtonTapped()
        }
        return true
    }
}
