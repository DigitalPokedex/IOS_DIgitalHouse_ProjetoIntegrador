//
//  PokemonDetailViewController.swift
//  DigitlaPokedex
//
//  Created by Cesar A. Tavares on 09/11/20.
//

import UIKit

class PokemonDetailViewController: UIViewController {

    @IBOutlet weak var labelName: UILabel!
    @IBOutlet weak var labelDescription: UILabel!
    @IBOutlet weak var imageViewPokemon: UIImageView!
    @IBOutlet weak var labelHp: UILabel!
    @IBOutlet weak var labelAtk: UILabel!
    @IBOutlet weak var labelDef: UILabel!
    @IBOutlet weak var labelStak: UILabel!
    @IBOutlet weak var labelSdef: UILabel!
    @IBOutlet weak var labelSpd: UILabel!

    @IBOutlet weak var progressViewHp: UIProgressView!
    @IBOutlet weak var progressViewAtk: UIProgressView!
    
    var name: String?
    var pokemonDescription: String?
    var image: String?
    var hp: String?
    var atk: String?
    var def: String?
    var stak: String?
    var sdef: String?
    var spd: String?
    
    var maxProgress: Float = 0
    var currentProgress: Float = 0
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        loadDetails()

    }
    
    @objc func updateProgress(sender:UIProgressView) {
        currentProgress = currentProgress + 1.0
        progressViewHp.progress = currentProgress/100
        
        if currentProgress < maxProgress {
            perform(#selector(updateProgress), with: nil, afterDelay: 0.025)
        }
    }
    
    func loadDetails() {
        if let name = name {
            labelName.text = name
        }
        
        if let image = image {
            imageViewPokemon.image = UIImage(named: image)
        }
        
        if let description = pokemonDescription {
            labelDescription.text = description
        }
        
        if let hp = hp {
            labelHp.text = hp
            
            maxProgress = Float(hp) ?? 0
            
            progressViewHp.setProgress(currentProgress, animated: true)
            progressViewHp.updateProgress(currentProgress: currentProgress, maxProgress: maxProgress)
        }
        
        if let atk = atk {
            labelAtk.text = atk
            
            maxProgress = Float(atk) ?? 0

            progressViewAtk.updateProgress(currentProgress: currentProgress, maxProgress: maxProgress)
        }
        
        if let def = def {
            labelDef.text = def
            
//            maxProgress = Float(def) ?? 0
//
//            progressViewHP.setProgress(currentProgress, animated: true)
//            perform(#selector(updateProgress), with: nil, afterDelay: 0.025)
        }
        
        if let stak = stak {
            labelStak.text = stak
            
//            maxProgress = Float(stak) ?? 0
//
//            progressViewHP.setProgress(currentProgress, animated: true)
//            perform(#selector(updateProgress), with: nil, afterDelay: 0.025)
        }
        
        if let sdef = sdef {
            labelSdef.text = sdef
            
//            maxProgress = Float(sdef) ?? 0
//
//            progressViewHP.setProgress(currentProgress, animated: true)
//            perform(#selector(updateProgress), with: nil, afterDelay: 0.025)
        }
        
        if let spd = spd {
            labelSpd.text = spd
            
//            maxProgress = Float(spd) ?? 0
//
//            progressViewHP.setProgress(currentProgress, animated: true)
//            perform(#selector(updateProgress), with: nil, afterDelay: 0.025)
        }
    }
    
    
    @IBAction func actionButtonInfo(_ sender: Any) {
    }
    
    @IBAction func actionButtonEvolution(_ sender: Any) {
    }
    
    @IBAction func actionButtonClose(_ sender: Any) {
        dismiss(animated: true, completion: nil)
    }
    
    @IBAction func actionButtonShare(_ sender: Any) {
        // Setting description
            let firstActivityItem = "Compartilhar Pokémon"
            
            // If you want to use an image
            let activityViewController : UIActivityViewController = UIActivityViewController(
                activityItems: [firstActivityItem], applicationActivities: nil)
            
            // This lines is for the popover you need to show in iPad
            activityViewController.popoverPresentationController?.sourceView = (sender as! UIButton)
            
            // This line remove the arrow of the popover to show in iPad
            activityViewController.popoverPresentationController?.permittedArrowDirections = UIPopoverArrowDirection.down
            activityViewController.popoverPresentationController?.sourceRect = CGRect(x: 150, y: 150, width: 0, height: 0)
            
            // Pre-configuring activity items
            activityViewController.activityItemsConfiguration = [
                UIActivity.ActivityType.postToFacebook,
                UIActivity.ActivityType.postToTwitter,
                UIActivity.ActivityType.message,
                UIActivity.ActivityType.saveToCameraRoll
            ] as? UIActivityItemsConfigurationReading
            
            // Anything you want to exclude
            activityViewController.excludedActivityTypes = [
                UIActivity.ActivityType.postToWeibo,
                UIActivity.ActivityType.print,
                UIActivity.ActivityType.assignToContact,
                UIActivity.ActivityType.addToReadingList,
                UIActivity.ActivityType.postToFlickr,
                UIActivity.ActivityType.postToVimeo,
                UIActivity.ActivityType.postToTencentWeibo,
            ]
            
            activityViewController.isModalInPresentation = true
            self.present(activityViewController, animated: true, completion: nil)
    }
    
    
    static func getPokemonDetails() -> PokemonDetailViewController? {
        if let detailsView = UIStoryboard(name: "PokemonDetail", bundle: nil).instantiateInitialViewController() as? PokemonDetailViewController {
            return detailsView
        }
        return nil
    }


}

