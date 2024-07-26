//
//  SignUpRepository.swift
//  ChatApp
//
//  Created by Jamerson Macedo on 26/07/24.
//

import Foundation
import FirebaseAuth
import FirebaseFirestore
import FirebaseStorage
class SignUpRepository {
    
    func signUp(withEmail: String, password: String, image : UIImage,name :String,completion : @escaping (String?) -> Void){
    
        Auth.auth().createUser(withEmail: withEmail, password: password){ result, error in
            guard let user = result?.user, error == nil else {
                completion(error?.localizedDescription)
                return
            }
            self.uploadPhoto(image: image,name: name){err in
                if let err = err{
                    completion(err)
                }
                
            }
        }
    }
    private func uploadPhoto(image:UIImage,name:String,completion : @escaping (String?) ->Void){
        let filename = UUID().uuidString
        
        guard let data = image.jpegData(compressionQuality: 0.2) else {return }
        let newMetadata = StorageMetadata()
        newMetadata.contentType = "image/jpeg"
        
        let ref = Storage.storage().reference(withPath: "/images/\(filename).jpg")
        
        ref.putData(data,metadata: newMetadata){ metadata, error in
            ref.downloadURL{ url,error in
                guard let imageUrl = url else {return}
                self.createUser(photoUrl: imageUrl,name: name,completion: completion)
                
            }
        }
    }
    private func createUser(photoUrl : URL,name:String,completion : @escaping (String?) ->Void) {
        // docuement() cria um documento com id aleatorio
        let id = Auth.auth().currentUser!.uid
        Firestore.firestore().collection("users").document(id).setData([
            "name": name,
            "uuid" : id,
            "profileUrl": photoUrl.absoluteString,
            
        ]){ err in
            if let err = err {
                
                print("error\(err.localizedDescription)")
                completion(err.localizedDescription)
                return
            }
            
        }
        
    }
}
