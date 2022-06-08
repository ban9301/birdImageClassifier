//
//  ToDoDetailTableViewController.swift
//  ToDoList
//
//  Created by Iulia Anisoi on 23.04.2021.
//

import UIKit
import MapKit
import CoreLocation
//table view detail function
class ToDoDetailTableViewController: UITableViewController, CLLocationManagerDelegate {
//create IBoutlet
    @IBOutlet weak var titleTextField: UITextField!
//    @IBOutlet weak var isCompleteButton: UIButton!
    @IBOutlet weak var notesTextView: UITextView!
    @IBOutlet weak var saveButton: UIBarButtonItem!
    //@IBOutlet weak var latField : UITextField!
    //@IBOutlet weak var lngField : UITextField!
   // @IBOutlet weak var accuracyField : UITextField!
    @IBOutlet weak var mapView : MKMapView!
    //define variable
    var annotation1 = [MKPointAnnotation]();
    var isDatePickerHidden = true
    let dateLabelIndexPath = IndexPath(row: 0, section: 1)
    let datePickerIndexPath = IndexPath(row: 1, section: 1)
    let notesIndexPath = IndexPath(row: 0, section: 2)
    var locationManager : CLLocationManager?
    var todo: ToDo?
    
    //when the view open will do
    override func viewDidLoad() {
        super.viewDidLoad()
        if let todo = todo {
            //setup title name
            navigationItem.title = "觀鳥地圖"
            titleTextField.text = todo.title
            notesTextView.text = todo.notes
            //enable map function
            if CLLocationManager.locationServicesEnabled() {
            self.locationManager = CLLocationManager();
            self.locationManager?.delegate = self;
            if CLLocationManager.authorizationStatus() != .authorizedAlways {
            self.locationManager?.requestAlwaysAuthorization();
            }
            else {
            self.setupAndStartLocationManager();
            }
            }
            let nycAnnotation1 = MKPointAnnotation();
            //data string to double
            let latitudedouble = Double(todo.latitude)
            let longitudedouble = Double(todo.longitude)
            //setup initial location
            let initialLocation =  CLLocation(latitude: latitudedouble!, longitude: longitudedouble!)
            mapView.centerToLocation(initialLocation)
            
            nycAnnotation1.coordinate = CLLocationCoordinate2D(latitude: latitudedouble!, longitude: longitudedouble!);
            nycAnnotation1.title = todo.title;
            //setup location point
            self.annotation1.append(nycAnnotation1);
            self.mapView?.addAnnotations(self.annotation1);
        }
        
        //updateDueDateLabel(date: dueDatePickerView.date)
       // updateSaveButton()
    }
    //map location manager
    func locationManager(_ manager: CLLocationManager,
     didUpdateLocations locations: [CLLocation]) {
     if let location = locations.last {
        let coord = CLLocationCoordinate2D(latitude: 22.390208, longitude: 114.198133);
        let span = MKCoordinateSpan(latitudeDelta: 0.005, longitudeDelta: 0.005);
     let region = MKCoordinateRegion(center: coord, span: span)
     self.mapView?.setRegion(region, animated: false);
     }
     }
    
    func setupAndStartLocationManager(){
    self.locationManager?.desiredAccuracy = kCLLocationAccuracyBest;
    self.locationManager?.distanceFilter = kCLDistanceFilterNone;
    self.locationManager?.startUpdatingLocation();
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        super.prepare(for: segue, sender: sender)
        
        guard segue.identifier == "saveUnwind" else { return }
        
        let title = titleTextField.text!
        let notes = notesTextView.text
        if todo != nil {
            todo?.title = title
            todo?.notes = notes
        } 
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        switch indexPath {
        case datePickerIndexPath where isDatePickerHidden == true:
            return 0
        case notesIndexPath:
            return 200
        default:
            return UITableView.automaticDimension
        }
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if indexPath == dateLabelIndexPath {
            isDatePickerHidden.toggle()
            tableView.deselectRow(at: indexPath, animated: true)
            tableView.beginUpdates()
            tableView.endUpdates()
        }
    }
    
   /* func updateSaveButton() {
        let shouldEnableSaveButton = titleTextField.text?.isEmpty == false
        saveButton.isEnabled = shouldEnableSaveButton
    }*/

//    func updateDueDateLabel(date: Date) {
//        dueDateLabel.text = ToDo.dueDateFormatter.string(from: date)
//    }
    
    /*@IBAction func textEditingChanged(_ sender: Any) {
        updateSaveButton()
    }*/
    
    @IBAction func returnPressed(_ sender: UITextField) {
       sender.resignFirstResponder()
      //  view.endEditing(true)
    }
    
//    @IBAction func isCompleteButtonTapped(_ sender: UIButton) {
//        isCompleteButton.isSelected.toggle()
//    }
    
//    @IBAction func datePickerChanged(_ sender: UIDatePicker) {
//        updateDueDateLabel(date: sender.date)
//    }
    
}

private extension MKMapView {
  func centerToLocation(
    _ location: CLLocation,
    //setup zoom in distance
    regionRadius: CLLocationDistance = 800
  ) {
    let coordinateRegion = MKCoordinateRegion(
      center: location.coordinate,
      latitudinalMeters: regionRadius,
      longitudinalMeters: regionRadius)
    setRegion(coordinateRegion, animated: true)
  }
}
