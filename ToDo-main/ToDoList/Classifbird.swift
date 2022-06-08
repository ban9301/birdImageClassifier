//
//  Classifbird.swift
//  ITP4206 Bird Identifier
//
//  Created by user on 17/12/2021.
//

import UIKit
import CoreML
import Vision
//bird classifier
class Classifbird: UIViewController,UIImagePickerControllerDelegate, UINavigationControllerDelegate{

    
    @IBOutlet weak var redoButton: UIButton!
    @IBOutlet weak var birdbigbutton: UIButton!
    @IBOutlet weak var ImageView: UIImageView!

    @IBOutlet weak var textfield01: UITextField!
    
    
    @IBOutlet weak var textfield02: UITextField!
    @IBOutlet weak var textfield03: UITextField!
    @IBOutlet weak var textfield05: UITextView!
    @IBOutlet weak var text1: UILabel!
    @IBOutlet weak var text2: UILabel!
    @IBOutlet weak var text3: UILabel!
    @IBOutlet weak var text4: UILabel!
    @IBOutlet weak var textfield04: UITextField!
 
    var imagePicker:UIImagePickerController!
    //when this view open will do
    override func viewDidLoad() {
        super.viewDidLoad()
        //isHidden is (not) hidden some textfield or buttion
        ImageView.isHidden = true
        textfield01.isHidden = true
        textfield02.isHidden = true
        textfield03.isHidden = true
        textfield04.isHidden = true
        text1.isHidden = true
        text2.isHidden = true
        text3.isHidden = true
        text4.isHidden = true
        redoButton.isHidden = true
        birdbigbutton.isHidden = false
        textfield05.isHidden = true
        imagePicker=UIImagePickerController()
        imagePicker.delegate=self
        imagePicker.sourceType = .camera
        
        //let attributeString = NSAttributedString(string: "store")
        
        //attributeString.addAttribute(.link, value:"https://www.google.com", range: NSRange(location:19, length:55))
        
        //textfield03.attributedText = attributeString
        

        // Do any additional setup after loading the view.
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        
    }
    //func textfield03(_ textfield03: UITextView, shouldInteractWith URL: URL, in characterRange: NSRange, interactionL UITextItemInteraction) -> Bool{
        //UIApplication.shared.open=(URL)
        //return false
    //}
  
    
//take photo function
    @IBAction func takephoto(_ sender: Any) {
        self.birdbigbutton.isHidden = true
        present(imagePicker, animated: true, completion: nil)
        /*let vc = storyboard?.instantiateViewController(withIdentifier: "other") as! otherViewController
        vc.modalPresentationStyle = .fullScreen
        present(vc,animated: true)
        NotificationCenter.default.post(name: Notification.Name("text"), object: textfield.text)*/
    
    }
    /*func imagePickerController(_ picker: UIImagePickerController, didFinishPickeringMediaWithInfo info:[String : Any]){
        
        ImageView.image=info[UIImagePickerController.InfoKey.originalImage] as? UIImage
        imagePicker.dismiss(animated: true, completion: nil)
        pictureIdentifyML(image: (info[UIImagePickerController.InfoKey.originalImage] as? UIImage)!)
    }*/
        func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
                picker.dismiss(animated: true, completion: nil)
                //show photo
                guard let image = info[UIImagePickerController.InfoKey.originalImage] as? UIImage else {return}
            
                ImageView.image = image
            
            pictureIdentifyML(image: (info[UIImagePickerController.InfoKey.originalImage] as? UIImage)!)
            }

    
            func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
                picker.dismiss(animated: true, completion: nil)
            }
    
    func pictureIdentifyML(image:UIImage){
        
        guard let model = try? VNCoreMLModel(for:birdImageClassifier_1().model)
        else{
            //when not find ml model
            fatalError(" cannot load ML model")
        }
        let request = VNCoreMLRequest(model: model){
            [weak self] request, error in
            
            guard let results = request.results as? [VNClassificationObservation],
            let firstResult = results.first
            else{
                //when not get ml model request
                fatalError("cannot get result from VNCoreMLRequest")
                    }
            DispatchQueue.main.async{
                self?.ImageView.isHidden = false
                self?.birdbigbutton.isHidden = true
                self?.textfield01.isHidden = false
                self?.textfield02.isHidden = false
                self?.textfield03.isHidden = false
                self?.textfield04.isHidden = false
                self?.text1.isHidden = false
                self?.text2.isHidden = false
                self?.text3.isHidden = false
                self?.text4.isHidden = false
                self?.redoButton.isHidden = false
                self?.textfield05.isHidden = false
                let con_result = (Int(firstResult.confidence * 100))
                let bird_name = firstResult.identifier
                if(con_result <= 95){
                    //when accuracy lower when 95%
                    print("error")
                    //textfield will show
                    self?.textfield05.text = "請重新拍攝!"
                    self?.textfield01.text = "錯誤!!"
                    self?.textfield02.text = "錯誤!!"
                    self?.textfield03.text = "錯誤!!"
                    self?.textfield04.text = "錯誤!!"
                    //self?.textfield01.text = "error \(Int(firstResult.confidence * 100))"
                }else if (bird_name == "lovebird"){
                    //when identified this image is lovebird label
                    //bird description in textfield
                    self?.textfield01.text = "情侶鸚鵡"
                    self?.textfield02.text = "10年至15年"
                    self?.textfield03.text = "13厘米—17厘米"
                    self?.textfield04.text = "40克—60克"
                    self?.textfield05.text = "牡丹鸚鵡又稱為情侶鸚鵡、愛情鸚鵡、愛情鳥，是一種非常喜歡群居及深情親切的鸚鵡，身型矮胖及有一條短尾，喙部相對為大，大部份牡丹鸚鵡鳥體都是綠色的，額頭、鳥喙和眼睛之間、臉頰、喉嚨為橘紅色，而人工配種及變種使很多的顏色出現。牡丹鸚鵡會與伴侶形影不離，相依相偎，而且多是會廝守終生，因此一般是成對或者是成群飼養，牡丹鸚鵡像其他的鸚鵡一樣，只要得到足夠的關心及照顧，牡丹鸚鵡可以與人建立一個友伴關係。"
                }else if (bird_name == "Leiothrix_lutea"){
                    //when identified this image is Leiothrix_lutealabel
                    //bird description in textfield
                    self?.textfield01.text = "紅嘴相思鳥"
                    self?.textfield02.text = "10年"
                    self?.textfield03.text = "15厘米"
                    self?.textfield04.text = "21.4克"
                    self?.textfield05.text = "紅嘴相思鳥是鶲科畫眉亞科中最嬌小可愛的一種。它嘴鮮紅，體態玲瓏，顯得眉清目秀，嫵媚動人。繁殖期間，雌雄形影不離。雌雄偎依枝頭互理羽毛，有時比翼藍天互追互逐夜間雙棲雙宿，就像一對情意纏綿、永不分離的情侶。故被稱為愛情鳥，是吉祥如意、堅貞純潔的象徵。國外多在至愛親朋結婚時，贈送一對相思鳥，祝賀新婚夫婦相親相愛，白頭偕老。相思鳥也為畫家詩人描述，入詩入畫，謝承舉有一首《題相思鳥圖》的題畫詩：“俱飛並逐倚園春，互語相思字字真。啼到苦心聲莫放，綠窗驚起病春人。”這首詩以擬人手法，賦予相思鳥以人的思想和感情，以相思鳥雙飛雙啼，互吐衷腸，與“病春人”的形影相弔苦苦思戀形成鮮明的對比，顯得特別真切動人 。"
                }
              /*  self?.textfield01.text = "confidence= \(Int(firstResult.confidence * 100))%, 情侶鸚鵡 \((firstResult.identifier))"*/
                                //"confidence= \(Int(firstResult.confidence * 100))%,
            }
        }
        guard let ciImage = CIImage(image: image)else{
            fatalError("cannot convert to CIImage")
        }
        let imageHandler = VNImageRequestHandler(ciImage:ciImage)
        DispatchQueue.global(qos: .userInteractive).async{
            do{
                try imageHandler.perform([request])
            }catch{
                //print error message
                print("Error \(error)")
            }
        }
    }
    //isHidden is (not) hidden some textfield or buttion
    @IBAction func redonfun2(_ sender: UIButton) {
        self.ImageView.isHidden = true
        self.textfield01.isHidden = true
        self.textfield02.isHidden = true
        self.textfield03.isHidden = true
        self.textfield04.isHidden = true
        self.text1.isHidden = true
        self.text2.isHidden = true
        self.text3.isHidden = true
        self.text4.isHidden = true
        self.birdbigbutton.isHidden = false
        self.redoButton.isHidden = true
        self.textfield05.isHidden = true
    }
    /*func showAlert(message: String) {
        let alert = UIAlertController(title: "系統錯誤", message: message, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "確認", style: .default, handler: nil))
        present(alert, animated: true, completion: nil)
    }*/
    
}
