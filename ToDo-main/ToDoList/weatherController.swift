//
//  weatherController.swift
//  ITP4206 Bird Identifier
//
//  Created by user210091 on 12/20/21.
//

import UIKit

class weatherController: UIViewController{
    //insert image
    let HKimage = "https://www.hko.gov.hk/wxinfo/aws/hko_mica/vpa/latest_HD_VPA.jpg"
    @IBOutlet var textField: UITextField!
    @IBOutlet var citiNameLabel: UILabel!
    @IBOutlet var weatherLabel: UILabel!
    @IBOutlet var temperatureLabel: UILabel!
    @IBOutlet var maxLabel: UILabel!
    @IBOutlet var minLabel: UILabel!
    @IBOutlet var weatherImage: UIImageView!
    @IBOutlet weak var HKweatherImg: UIImageView!
    let reachability = Reachability()
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        if reachability.isConnectedToNetwork() == true {
            //when internet connection
            print("Connected to the internet")
            let citiName : String = "HongKong"
            getCurrentWeather(citiName: citiName)
          fetchImage()
            view.endEditing(true)
        } else {
            //when no internet connection
            print("No internet connection")
            showAlert(message: "無網絡連接")
        }
        let citiName : String = "HongKong"
        getCurrentWeather(citiName: citiName)
        view.endEditing(true)
    }
    //refrest weather function
    @IBAction func refreshWeather(){
        if reachability.isConnectedToNetwork() == true {
            print("Connected to the internet")
            let citiName : String = "HongKong"
            getCurrentWeather(citiName: citiName)
            view.endEditing(true)
        } else {
            //when no internet connection
            print("No internet connection")
           showAlert(message: "無網絡連接")
        }
        
    }

    
    func getCurrentWeather(citiName: String) {
        guard let url = URL(string: "https://api.openweathermap.org/data/2.5/weather?q=\(citiName)&appid=0de57519925dcbac571ee1c1b5f7ee4a") else { return }
        
        let session = URLSession(configuration: .default)
        session.dataTask(with: url) { [weak self] data, response, error in
            let successRange = 200...299
            guard let data = data, error == nil else { return }
            let decoder = JSONDecoder()
            
            if let response = response as? HTTPURLResponse, successRange.contains(response.statusCode) {
                guard let weatherInformation = try? decoder.decode(WeatherInformation.self, from: data) else { return }
    //            debugPrint(weatherInformation)
                
                DispatchQueue.main.async {
                  //  self?.stackView.isHidden = false
                    self?.configureView(weatherInformation: weatherInformation)
                }
            } else {
                guard let errorMessage = try? decoder.decode(ErrorMessage.self, from: data) else { return }
                //debugPrint(errorMessage)
                
                DispatchQueue.main.async {
                    self?.showAlert(message: errorMessage.message)
                }
            }
        }.resume()
    }
    
    func configureView(weatherInformation: WeatherInformation) {
       // citiNameLabel.text = weatherInformation.name
        if let weather = weatherInformation.weather.first {
            //set up weather description and image
            switch(weather.description){
            case "overcast clouds":
                weatherLabel.text = "陰雲密布"
                weatherImage.image = UIImage(named:"04d")
            case "broken clouds":
                weatherLabel.text = "陰雲密布"
                weatherImage.image = UIImage(named:"04d")
            case "scattered clouds":
                weatherLabel.text = "零星雲霧"
                weatherImage.image = UIImage(named:"03d")
            case "few clouds":
                weatherLabel.text = "少許雲霧"
                weatherImage.image = UIImage(named:"02d")
            case "clear sky":
                weatherLabel.text = "晴空萬里"
                weatherImage.image = UIImage(named:"01d")
            case "tornado":
                weatherLabel.text = "龍捲風"
                weatherImage.image = UIImage(named:"50d")
            case "squalls":
                weatherLabel.text = "狂風"
                weatherImage.image = UIImage(named:"50d")
            case "dust":
                weatherLabel.text = "沙塵天氣"
                weatherImage.image = UIImage(named:"50d")
            case "sand":
                weatherLabel.text = "沙塵暴"
                weatherImage.image = UIImage(named:"50d")
            case "fog":
                weatherLabel.text = "多霧"
                weatherImage.image = UIImage(named:"50d")
            case "Haze":
                weatherLabel.text = "陰霾"
                weatherImage.image = UIImage(named:"50d")
            case "Smoke":
                weatherLabel.text = "陰霾"
                weatherImage.image = UIImage(named:"50d")
            case "mist":
                weatherLabel.text = "霧霾"
                weatherImage.image = UIImage(named:"50d")
            case "ragged shower rain":
                weatherLabel.text = "襤褸陣雨"
                weatherImage.image = UIImage(named:"09d")
            case "heavy intensity shower rain":
                weatherLabel.text = "大雨"
                weatherImage.image = UIImage(named:"09d")
            case "shower rain":
                weatherLabel.text = "陣雨"
                weatherImage.image = UIImage(named:"09d")
            case "light intensity shower rain":
                weatherLabel.text = "小陣雨"
                weatherImage.image = UIImage(named:"09d")
            case "extreme rain":
                weatherLabel.text = "暴雨"
                weatherImage.image = UIImage(named:"10d")
            case "very heavy rain":
                weatherLabel.text = "大暴雨"
                weatherImage.image = UIImage(named:"10d")
            case "heavy intensity rain":
                weatherLabel.text = "暴雨"
                weatherImage.image = UIImage(named:"10d")
            case "moderate rain":
                weatherLabel.text = "中等雨量"
                weatherImage.image = UIImage(named:"10d")
            case "light rain":
                weatherLabel.text = "小雨"
                weatherImage.image = UIImage(named:"10d")
            case "shower drizzle":
                weatherLabel.text = "毛毛雨"
                weatherImage.image = UIImage(named:"09d")
            case "heavy shower rain and drizzle":
                weatherLabel.text = "大雨和毛毛雨"
                weatherImage.image = UIImage(named:"09d")
            case "shower rain and drizzle":
                weatherLabel.text = "陣雨和毛毛雨"
                weatherImage.image = UIImage(named:"09d")
            case "heavy intensity drizzle rain":
                weatherLabel.text = "細雨"
                weatherImage.image = UIImage(named:"09d")
            case "drizzle rain":
                weatherLabel.text = "毛毛雨"
                weatherImage.image = UIImage(named:"09d")
            case "light intensity drizzle rain":
                weatherLabel.text = "毛毛雨"
                weatherImage.image = UIImage(named:"09d")
            case "heavy intensity drizzle":
                weatherLabel.text = "大雨"
                weatherImage.image = UIImage(named:"09d")
            case "drizzle":
                weatherLabel.text = "細雨"
                weatherImage.image = UIImage(named:"09d")
            case "light intensity drizzle":
                weatherLabel.text = "細雨"
                weatherImage.image = UIImage(named:"09d")
            case "thunderstorm with heavy drizzle":
                weatherLabel.text = "雷雨"
                weatherImage.image = UIImage(named:"11d")
            case "thunderstorm with drizzle":
                weatherLabel.text = "雷雨"
                weatherImage.image = UIImage(named:"11d")
            case "thunderstorm with light drizzle":
                weatherLabel.text = "雷雨"
                weatherImage.image = UIImage(named:"11d")
            case "ragged thunderstorm":
                weatherLabel.text = "雷暴"
                weatherImage.image = UIImage(named:"11d")
            case "heavy thunderstorm":
                weatherLabel.text = "大雷暴"
                weatherImage.image = UIImage(named:"11d")
            case "thunderstorm":
                weatherLabel.text = "雷雨"
                weatherImage.image = UIImage(named:"11d")
            case "light thunderstorm":
                weatherLabel.text = "小雷暴"
                weatherImage.image = UIImage(named:"11d")
            case "thunderstorm with heavy rain":
                weatherLabel.text = "大雷雨"
                weatherImage.image = UIImage(named:"11d")
            case "thunderstorm with rain":
                weatherLabel.text = "雷雨"
                weatherImage.image = UIImage(named:"11d")
            case "thunderstorm with light rain":
                weatherLabel.text = "小雷雨"
                weatherImage.image = UIImage(named:"11d")
            
            default:
                weatherLabel.text = weather.description
            }
           // weatherLabel.text = weather.description
        }
        temperatureLabel.text = "\(Int(weatherInformation.temp.temp - 273.15))℃"
        //highest temperature
        maxLabel.text = "最高溫度: \(Int(weatherInformation.temp.tempMax - 273.15))℃"
        //lowest temperature
        minLabel.text = "最低溫度: \(Int(weatherInformation.temp.tempMin - 273.15))℃"
    }
    //show error
    func showAlert(message: String) {
        let alert = UIAlertController(title: "系統錯誤", message: message, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "確認", style: .default, handler: nil))
        present(alert, animated: true, completion: nil)
    }
    
    private func fetchImage(){
        guard let url = URL(string: HKimage) else{
            return
        }
        let getDataTask = URLSession.shared.dataTask(with: url){
            data,_, error in
            guard let data = data, error == nil else{
                return
            }
            DispatchQueue.main.async {
                let image = UIImage(data: data)
                self.HKweatherImg.image = image
            }
                
            
        }
        getDataTask.resume()
    }
  
}

