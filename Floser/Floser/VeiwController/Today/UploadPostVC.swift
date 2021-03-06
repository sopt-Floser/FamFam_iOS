//
//  UploadPostVC.swift
//  flower
//
//  Created by 성다연 on 2019. 1. 7..
//  Copyright © 2019년 성다연. All rights reserved.
//

import UIKit

class UploadPostVC: UIViewController {
    
    @IBOutlet var contentImage: UIImageView!
    @IBOutlet var contentTextView: UITextView!
    
    @IBAction func backBtn(_ sender: Any) {
        navigationController?.popViewController(animated: true)
    }
    
    @IBAction func completeBtn(_ sender: Any) {
        guard contentTextView.text?.isEmpty != true else {return}
        
        // 작성된 api를 사용하여 게시글을 작성하고 만약 완료되었다면
        TodayService.shared.writeContent(content: contentTextView.text, photos: [contentImage.image!]) { status in
            switch status {
            case 201 :
                self.simpleAlert("글 작성", "게시글이 작성되었습니다.", completion: { (action) in
                    self.navigationController?.popViewController(animated: true)
                })
                print("게시글 업로드 성공")
            case 400 :
                print("null 에러")
            case 500 :
                print("서버 내부 에러")
            case 600 :
                print("db 에러")
            default :
                print("게시글 업로드 디폴트")
            }
            
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupTap()
    }
    

    
    // 텍스트필드나 텍스트 뷰의 edit 모드를 해제하기 위한, 즉, 키보드를 내리기 위한 탭 제스처와
    // 이미지 뷰를 탭하면 이미지를 추가할 수 있는 탭 제스처 설정
    
    
    func setupTap() {
        let viewTap = UITapGestureRecognizer(target: self, action: #selector(viewTapped))
        let imageTap = UITapGestureRecognizer(target: self, action: #selector(imageTapped))
        self.view.addGestureRecognizer(viewTap)
        self.contentImage.addGestureRecognizer(imageTap)
    }
    
    //뷰를 탭하면 edit 상태를 끝낸다
    @objc func viewTapped() {
        self.view.endEditing(true)
    }
    
    //이미지를 탭하면 이미지피커를 띄우는 메소드
    //코드를 천천히 읽어보시고 한번 이해해보세요!
    //영어 단어 뜻대로 의미를 담고 있으니 어렵지않게 이해하실겁니다.
    @objc func imageTapped() {
        let picker = UIImagePickerController()
        picker.delegate = self
        let actionSheet = UIAlertController(title: "Photo source", message: "Choose a source", preferredStyle: .actionSheet)
        actionSheet.addAction(UIAlertAction(title: "Camera", style: .default, handler: { (action) in
            if UIImagePickerController.isSourceTypeAvailable(.camera) {
                picker.sourceType = .camera
                picker.allowsEditing = true
                picker.showsCameraControls = true
                self.present(picker, animated: true)
            } else {
                print("not available")
            }
        }))
        actionSheet.addAction(UIAlertAction(title: "Photo Library", style: .default, handler: { (action) in
            picker.sourceType = .photoLibrary
            picker.allowsEditing = true
            self.present(picker, animated: true)
        }))
        actionSheet.addAction(UIAlertAction(title: "Cancel", style: .cancel))
        self.present(actionSheet, animated: true)
    }
}

//이미지 피커에 대한 여러 동작을 처리하는 delegate
extension UploadPostVC: UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    
    //이미지를 선택하지 않고 피커 종료시에 실행되는 delegate 메소드
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        dismiss(animated: true, completion: nil)
    }
    
    //이미지 피커에서 이미지를 선택하였을 때 일어나는 이벤트를 작성하는 메소드
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        var newImg = UIImage()
        
        if let possibleImg = info[.editedImage] as? UIImage {
            newImg = possibleImg
        }
        else if let possibleImg = info[.originalImage] as? UIImage {
            newImg = possibleImg
        }
        else {
            return
        }
        contentImage.image = newImg
        dismiss(animated: true, completion: nil)
    }
    
}
