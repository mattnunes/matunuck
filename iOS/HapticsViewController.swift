//
// HapticsViewController.swift
// Copyright © 2020 Matt Nunes-Spraggs
//


import UIKit
import AudioToolbox

class HapticsViewController: UIViewController {

    // MARK: - Types
    
    private typealias FeedbackStyle = UIImpactFeedbackGenerator.FeedbackStyle
    
    private struct Constants {
        private static let rootKey = "haptics-vc"
        static let feedbackStyleKey = "\(rootKey).feedback-style"
        static let feedbackIntensityKey = "\(rootKey).feedback-intensity"
    }
    
    // MARK: - IBOutlets
    
    @IBOutlet weak var feedbackStyleControl: UISegmentedControl!
    @IBOutlet weak var feedbackIntensitySlider: UISlider!
    @IBOutlet weak var feedbackIntensityLabel: UILabel!

    // MARK: - Private Properties
    
    private let feedbackStyles: [FeedbackStyle] = [.light, .medium, .heavy, .soft, .rigid]
    
    @UserDefault(Constants.feedbackStyleKey, default: .heavy)
    private var selectedFeedbackStyle: UIImpactFeedbackGenerator.FeedbackStyle

    @UserDefault(Constants.feedbackIntensityKey, default: 1.0)
    private var selectedFeedbackIntensity: Float
    
    // MARK: - UIViewController
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupFeedbackStyleControl(feedbackStyles,
                                  selected: selectedFeedbackStyle)
        updateIntensityLabel(for: selectedFeedbackIntensity)
        updateIntensitySlider(for: selectedFeedbackIntensity)
    }
    
    // MARK: - Private API
    
    private func setupFeedbackStyleControl(_ feedbackStyles: [FeedbackStyle], selected: FeedbackStyle) {
        feedbackStyleControl.setTitles(feedbackStyles.map({ $0.localizedTitle }))
        if let index = index(forFeedbackStyle: selected, in: feedbackStyles) {
            feedbackStyleControl.selectedSegmentIndex = index
        }
    }
    
    private func index(forFeedbackStyle style: FeedbackStyle, in styles: [FeedbackStyle]) -> Int? {
        return styles.firstIndex(of: style)
    }
    
    private func feedbackStyle(forIndex index: Int, in styles: [FeedbackStyle]) -> FeedbackStyle? {
        guard styles.indices.contains(index) else {
            return nil
        }
        return styles[index]
    }
    
    private func updateIntensityLabel(for intensity: Float) {
        let percentage = Int(round(intensity * 100.0))
        feedbackIntensityLabel.text = "\(percentage)%"
    }
    
    private func updateIntensitySlider(for intensity: Float) {
        feedbackIntensitySlider.value = intensity
    }
    
    // MARK: - IBActions
    
    @IBAction func intensitySliderDidChange(_ sender: UISlider) {
        self.selectedFeedbackIntensity = max(0.0, min(1.0, sender.value))
        updateIntensityLabel(for: sender.value)
    }
    
    @IBAction func feedbackStyleSegmentDidChange(_ sender: UISegmentedControl) {
        guard let selectedStyle = feedbackStyle(forIndex: sender.selectedSegmentIndex,
                                                in: feedbackStyles) else {
            return
        }
        self.selectedFeedbackStyle = selectedStyle
    }
    
    @IBAction func generateFeedback(_ sender: Any) {
        let generator = UIImpactFeedbackGenerator(style: selectedFeedbackStyle)
        generator.impactOccurred(intensity: CGFloat(selectedFeedbackIntensity))
    }
    
    @IBAction func selectionFeedbackSelectionChanged(_ sender: Any) {
        UISelectionFeedbackGenerator().selectionChanged()
    }
    
    @IBAction func notificationFeedbackSuccess(_ sender: Any) {
        UINotificationFeedbackGenerator().notificationOccurred(.success)
    }
    
    @IBAction func notificationFeedbackError(_ sender: Any) {
        UINotificationFeedbackGenerator().notificationOccurred(.error)
    }
    
    @IBAction func notificationFeedbackWarning(_ sender: Any) {
        UINotificationFeedbackGenerator().notificationOccurred(.warning)
    }
    
    @IBAction func audioServicesVibrate(_ sender: Any) {
        AudioServicesPlaySystemSound(kSystemSoundID_Vibrate)
    }
    
}
