//
//  ViewController.swift
//  Meu Primeiro app
//
//  Created by Jonathan on 28/01/20.
//  Copyright © 2020 hbisis. All rights reserved.
//

import os.log
import UIKit

class ViewController: UIViewController, UITextFieldDelegate, UIImagePickerControllerDelegate,UINavigationControllerDelegate {
    
    @IBOutlet weak var ratingControll: RtingBar!
    @IBOutlet weak var saveButton: UIBarButtonItem!
    /*
     This value is either passed by `MealTableViewController` in `prepare(for:sender:)`
     or constructed as part of adding a new meal.
     */
    var meal: Bar?
    
    @IBOutlet weak var NomeBarTextField: UITextField!
    
    @IBOutlet weak var EnderecoTextField: UITextField!
    
    @IBOutlet weak var TelefoneTextFiled: UITextField!
    
    @IBOutlet weak var NotaBarTextField: UITextField!
    
    @IBOutlet weak var ImageView: UIImageView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Handle the text field’s user input through delegate callbacks.
        NomeBarTextField.delegate = self
        // Set up views if editing an existing Meal.
        if let meal = meal {
            navigationItem.title = meal.name
            NomeBarTextField.text  = meal.name
            ratingControll.rating = meal.rating
            EnderecoTextField.text = meal.Endereco
            TelefoneTextFiled.text = meal.Telefone
        }
        
        // Enable the Save button only if the text field has a valid Meal name.
        updateSaveButtonState()
    }
    
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        var nomeCampo : String!
        switch  textField {
        case NomeBarTextField:
            nomeCampo = "Bar: "
            break;
        case EnderecoTextField :
            nomeCampo = "Endereço: "
            break;
        case TelefoneTextFiled:
            nomeCampo = "Telefone"
            break;
        case NotaBarTextField:
            nomeCampo = "Nota do Bar"
            break;
        default:
            nomeCampo = "OutroCampo: "
        }
        let digitando =
            textField.text!
        let message = nomeCampo +
        digitando
        print (message)
        return true;
    }
    func textFieldDidBeginEditing(_ textField: UITextField) {
        updateSaveButtonState()
        navigationItem.title = textField.text
    }
    @IBAction func Cancel(_ sender: UIBarButtonItem) {
        // Depending on style of presentation (modal or push presentation), this view controller needs to be dismissed in two different ways.
        let isPresentingInAddMealMode = presentingViewController is UINavigationController
        if isPresentingInAddMealMode {
            dismiss(animated: true, completion: nil)
        }
        else if let owningNavigationController = navigationController{
            owningNavigationController.popViewController(animated: true)
        }else {
            fatalError("The MealViewController is not inside a navigation controller.")
        }
        dismiss(animated: true, completion: nil)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        super.prepare(for: segue, sender: sender)
        
        // Configure the destination view controller only when the save button is pressed.
        guard let button = sender as? UIBarButtonItem, button === saveButton else {
            os_log("The save button was not pressed, cancelling", log: OSLog.default, type: .debug)
            return
        }
        
        let name = NomeBarTextField.text ?? ""
        let photo = ImageView.image
        let rating = ratingControll.rating
        let Telefone = TelefoneTextFiled.text ?? ""
        let Endereco = EnderecoTextField.text ?? ""
        
        
        meal = Bar( name: name,photo:photo, rating:rating,Telefone: Telefone,Longitude:0.0,Latitude:0.0,Endereco:Endereco)
    }
    @IBAction func SaveButton(_ sender: Any) {
        print(NomeBarTextField.text!)
        print(EnderecoTextField.text!)
        print(TelefoneTextFiled.text!)
        print(NomeBarTextField.text!)
      }
   
    @IBAction func saveButton(_ sender: Any) {
    }
    
    @IBAction func changeImage(_ sender: Any) {
        print("OK")
        let imagePicker = UIImagePickerController()
        imagePicker.delegate = self;
        imagePicker.sourceType = .photoLibrary
        present(imagePicker, animated: true,completion: nil)
    }
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        let image = info[.originalImage] as?UIImage;
        ImageView.image = image;
        picker.dismiss(animated: true, completion: nil)
    }
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
     picker.dismiss(animated: true, completion: nil)
    }
    //MARK: Private Methods
    private func updateSaveButtonState() {
        // Disable the Save button if the text field is empty.
        let text = NomeBarTextField.text ?? ""
        saveButton.isEnabled = !text.isEmpty
    }
    
  
}
    

