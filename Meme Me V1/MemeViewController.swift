//
//  MemeViewController.swift
//  Meme Me V1
//
//  Created by Zabe Rauf on 10/18/17.
//  Copyright © 2017 Zaben. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UINavigationControllerDelegate, UIImagePickerControllerDelegate, UITextFieldDelegate {

    // Outlets
    
    @IBOutlet weak var photoLibrary: UIBarButtonItem!
    @IBOutlet weak var cameraButton: UIBarButtonItem!
    @IBOutlet weak var shareButton: UIBarButtonItem!
    @IBOutlet weak var imagePicker: UIImageView!
    @IBOutlet weak var topToolbar: UIToolbar!
    @IBOutlet weak var bottomToolbar: UIToolbar!
    @IBOutlet weak var topText: UITextField!
    @IBOutlet weak var bottomText: UITextField!
    
    // textField Delegates
    let memeTextAttributes: [String:Any] = [
        NSAttributedStringKey.strokeColor.rawValue: UIColor.black,
        NSAttributedStringKey.foregroundColor.rawValue: UIColor.white,
        NSAttributedStringKey.font.rawValue: UIFont(name: "HelveticaNeue-CondensedBlack", size: 38)!,
        NSAttributedStringKey.strokeWidth.rawValue: -3.5]
    
    struct Meme {
        var topMemeText: String
        var bottomMemeText: String
        var originalImage: UIImage
        var memedImage : UIImage
    }
    
    func prepareTextField(textField: UITextField, defaultText: String) {
        textField.defaultTextAttributes = memeTextAttributes
        textField.textAlignment = .center
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        shareButton.isEnabled = false
        // Do any additional setup after loading the view, typically from a nib.
        
        self.topText.delegate = self
        self.bottomText.delegate = self
        
        prepareTextField(textField: topText, defaultText: "TOP")
        prepareTextField(textField: bottomText, defaultText: "BOTTOM")
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        subscribeToKeyboardNotifications()
        
        cameraButton.isEnabled = UIImagePickerController.isSourceTypeAvailable(.camera)
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        unsubscribeFromKeyboardNotifications()
    }
    
    // keyboardWillShow shifts the view up by the height
    // of the keyboard if the user selects the bottom text field.
    
    @objc func keyboardWillShow(_ notification:Notification) {
        if bottomText.isEditing {
            view.frame.origin.y = -getKeyboardHeight(notification)
        }
    }
    
    // keyboardWillHide(Notfication) hides keyboard
    // when user is done typing.
    
    @objc func keyboardWillHide(_ notification:Notification) {
        view.frame.origin.y = 0
    }
    
    // getKeyboardHeight(Notification) gets keyboard height.
    
    func getKeyboardHeight(_ notification:Notification) -> CGFloat {
        let userInfo = notification.userInfo
        let keyboardSize = userInfo![UIKeyboardFrameEndUserInfoKey] as! NSValue // of CGRect
        return keyboardSize.cgRectValue.height
    }
    
    // notifies when a function can shift the keyboard or not.
    
    func subscribeToKeyboardNotifications() {
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillShow(_:)), name: .UIKeyboardWillShow, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillHide(_:)), name: .UIKeyboardWillHide, object: nil)
    }
    
    func unsubscribeFromKeyboardNotifications() {
        NotificationCenter.default.removeObserver(self, name: .UIKeyboardWillShow, object: nil)
       NotificationCenter.default.removeObserver(self, name: .UIKeyboardWillHide, object: nil)
    }
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        if textField.tag == 0 {
            unsubscribeFromKeyboardNotifications()
        }
        subscribeToKeyboardNotifications()
    }
    
    // textfieldShouldReturn closes keyboard when user presses 'return'
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
    
    // functions opens photo library and shows
    // the selected image on the imagePicker View.
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any]) {
        if let image = info[UIImagePickerControllerOriginalImage] as? UIImage {
            imagePicker.image = image
            shareButton.isEnabled = true
        }
        dismiss(animated: true, completion: nil)
    }
    
    // if user cancels image picker, dismisses the picker.
    
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        dismiss(animated: true, completion: nil)
    }
    
    // generateMemedImage() generates memed image with
    // top and bottom text and hides top and bottom toolbars.
    
    func generateMemedImage() -> UIImage {
        
        // Hide Toolbar/Navbar
        topToolbar.isHidden = true
        bottomToolbar.isHidden = true
        
        UIGraphicsBeginImageContext(self.view.frame.size)
        view.drawHierarchy(in: self.view.frame, afterScreenUpdates: true)
        let memedImage: UIImage = UIGraphicsGetImageFromCurrentImageContext()!
        UIGraphicsEndImageContext()
        
        // Show Toolbar/Navbar
        topToolbar.isHidden = false
        bottomToolbar.isHidden = false
        
        return memedImage
    }
    
    func save(memedImage: UIImage) {
        // Create the meme
        let meme = Meme(topMemeText: topText.text!, bottomMemeText: bottomText.text!, originalImage: imagePicker.image!, memedImage: memedImage)
    }
    
    // sourceType picker is fed a sourcetype and performs actions for the type.
    
    func pick(sourceType: UIImagePickerControllerSourceType) {
        let sourcePicker = UIImagePickerController()
        sourcePicker.delegate = self
        sourcePicker.sourceType = sourceType
        present(sourcePicker, animated: true, completion: nil)
    }
    
    // IBActions
    
    @IBAction func imageLibrary(_ sender: Any) {
        pick(sourceType: .savedPhotosAlbum)
    }
    
    @IBAction func shareMeme(_ sender: Any) {
        let memedImage = generateMemedImage()
        let activityController = UIActivityViewController(activityItems: [memedImage], applicationActivities: nil)
        activityController.completionWithItemsHandler = {(activity, completed, items, error) in
            if completed {
                self.save(memedImage: memedImage)
                self.dismiss(animated: true, completion: nil)
            }
        }
        self.present(activityController, animated: true, completion: nil)
    }
    
    @IBAction func cameraButton(_ sender: Any) {
        pick(sourceType: .camera)
    }
    


}

