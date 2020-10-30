//
//  MemeEditorViewController.swift
//  MemeMeApp
//
//  Created by Giovanni Luidi Bruno on 28/10/20.
//  Copyright © 2020 Giovanni Luigi Bruno. All rights reserved.
//

import UIKit

class MemeEditorViewController: UIViewController, UIImagePickerControllerDelegate,
UINavigationControllerDelegate, UITextFieldDelegate, FontSelectionDelegate {
    
    
    @IBOutlet weak var memeImageView: UIImageView!
    @IBOutlet weak var cameraButton: UIBarButtonItem!
    @IBOutlet weak var memeContainer: UIView!
    
    @IBOutlet weak var bottomToolBar: UIToolbar!
    @IBOutlet weak var topTextField: UITextField!
    @IBOutlet weak var bottomTextField: UITextField!
    
    var memeTextAttributes: [NSAttributedString.Key: Any] = [
        NSAttributedString.Key.strokeColor: UIColor.black,
        NSAttributedString.Key.foregroundColor: UIColor.white,
        NSAttributedString.Key.font: UIFont(name: "impact", size: 40)!,
        NSAttributedString.Key.strokeWidth:  -2,
    ]
    
    var savedMemes: [Meme] = []
    
    override var preferredStatusBarStyle: UIStatusBarStyle {
        .lightContent
    }
    
    // MARK:- Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        memeImageView.contentMode = .scaleAspectFit
        cameraButton.isEnabled = UIImagePickerController.isSourceTypeAvailable(.camera)
        let tap: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(dismissKeyboard))
        view.addGestureRecognizer(tap)
        setupTextFields(textFields: [topTextField, bottomTextField])
        bottomToolBar.layer.cornerRadius = 20;
        bottomToolBar.clipsToBounds  =  true
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        subscribeToKeyboardNotifications()
        setNeedsStatusBarAppearanceUpdate()
    }

    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        unsubscribeFromKeyboardNotifications()
    }
    
    
    // MARK:- Actions
    @IBAction func didTapCameraButton(_ sender: Any) {
        pickImage(source: .camera)
    }
    
    @IBAction func didTapLibraryButton(_ sender: Any) {
        pickImage(source: .photoLibrary)
    }
    
    @IBAction func didTapEditButton(_ sender: Any) {
    }
    
    @IBAction func didTapCancelButton(_ sender: Any) {
        topTextField.text = "TOP"
        bottomTextField.text = "BOTTOM"
        memeImageView.image = nil
    }
    
    @IBAction func didTapShareButton(_ sender: Any) {
        let topText = topTextField.text ?? String()
        let bottomText = bottomTextField.text ?? String()
        
        let meme = Meme(topText:  topText, bottomText: bottomText, originalImage: memeImageView.image, memedImage: generateMemedImage())
        
        
        let activityController = UIActivityViewController(activityItems: [meme.memedImage], applicationActivities: nil)
        activityController.completionWithItemsHandler = {
            [weak self] (activityType: UIActivity.ActivityType?, completed: Bool, returnedItems: [Any]?, error: Error?) -> Void  in
            if completed && error == nil {
                self?.savedMemes.append(meme)
            }
        }
        present(activityController, animated: true, completion: nil)
    }
    
    // MARK: - Private funcs
    private func generateMemedImage() -> UIImage {
        UIGraphicsBeginImageContext(self.memeContainer.frame.size)
        memeContainer.drawHierarchy(in: self.memeContainer.bounds, afterScreenUpdates: false)
        let memedImage: UIImage = UIGraphicsGetImageFromCurrentImageContext()!
        UIGraphicsEndImageContext()

        return memedImage
    }
    
    private func pickImage(source: UIImagePickerController.SourceType) {
        let imagePicker = UIImagePickerController()
        imagePicker.sourceType = source
        imagePicker.delegate = self
        imagePicker.allowsEditing = true
        present(imagePicker, animated: true, completion: nil)
    }
    
    private func dismiss() {
        dismiss(animated: true, completion: nil)
    }
    
    private func setupTextFields(textFields: [UITextField]) {
        for tf in textFields {
            tf.defaultTextAttributes = memeTextAttributes
            tf.borderStyle = .none
            tf.textAlignment = .center
            tf.delegate = self
        }
    }
    
    private func subscribeToKeyboardNotifications() {
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillShow(_:)), name: UIResponder.keyboardWillShowNotification, object: nil)
        
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillHide(_:)), name: UIResponder.keyboardWillHideNotification, object: nil)
    }

    private func unsubscribeFromKeyboardNotifications() {
        NotificationCenter.default.removeObserver(self, name: UIResponder.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.removeObserver(self, name: UIResponder.keyboardWillHideNotification, object: nil)
    }
    
    @objc private func keyboardWillShow(_ notification: Notification) {
        if bottomTextField.isEditing {
            view.frame.origin.y -= getKeyboardHeight(notification)
        }
    }
    
    @objc private func keyboardWillHide(_ notification: Notification) {
        if bottomTextField.isEditing {
            view.frame.origin.y += getKeyboardHeight(notification)
        }
    }

    private func getKeyboardHeight(_ notification:Notification) -> CGFloat {

        let userInfo = notification.userInfo
        let keyboardSize = userInfo![UIResponder.keyboardFrameEndUserInfoKey] as! NSValue // of CGRect
        return keyboardSize.cgRectValue.height
    }
    
    @objc private func dismissKeyboard() {
        view.endEditing(true)
    }
    
    
    // MARK: - ImagePickerDelegate
    
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        self.dismiss()
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        if let image = info[UIImagePickerController.InfoKey.originalImage] as? UIImage {
            memeImageView.image = image
        }
        self.dismiss()
    }
    
    // MARK: - TextFieldDelegate
    
    func textFieldDidBeginEditing(_ textField: UITextField) {
        textField.text = String()
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
    
    // MARK: - Navigation
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let controller = segue.destination as? FontSelectionViewController {
            controller.delegate = self
        }
    }
    
    // MARK: - FontSectionDelegate
    
    func didSelectFont(font: String) {
        memeTextAttributes[NSAttributedString.Key.font] = UIFont(name: font, size: 40)!
        setupTextFields(textFields: [topTextField, bottomTextField])
    }

}
