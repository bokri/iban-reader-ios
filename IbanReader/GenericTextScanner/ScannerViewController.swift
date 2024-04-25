//
//  ScannerViewController.swift
//  IbanReader
//
//  Created by Aymen Bokri on 25/04/2024.
//

import Foundation
import UIKit
import VisionKit

class ScannerViewController: UIViewController {
    
    // MARK: - Properties
    
    /// Data scanner view controller for scanning operations.
    var dataScanner = DataScannerViewController.factory()
    
    /// Guidance overlay view for masking the background during scanning.
    var partialTransparentView: GuidanceOverlayView?
    
    /// ViewModel for managing scanner-related data and operations.
    var viewModel: ScannerViewModel
    
    // MARK: - Constructors
    
    /// Initializes the ScannerViewController with a view model.
    /// - Parameter viewModel: Scanner view model to be used.
    init(viewModel: ScannerViewModel) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
        installDataScanner()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Life Cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        startScanning()
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        if dataScanner.parent == nil {
            installDataScanner()
            startScanning()
        }
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        uninstallDatascanner()
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        if partialTransparentView != nil { return }
        let width: CGFloat = view.bounds.width - 32
        let height: CGFloat = 64
        let viewXPosition: CGFloat = 16
        let viewYPosition: CGFloat = (dataScanner.view.bounds.height / 2) - (height / 2)
        let cutout = CGRect(x: viewXPosition, y: viewYPosition, width: width, height: height)
        let partialTransparentView = GuidanceOverlayView(cutout: cutout)
        
        dataScanner.view.addChildView(partialTransparentView)
        
        self.partialTransparentView = partialTransparentView
        
        dataScanner.regionOfInterest = cutout
    }
    
    deinit {
        uninstallDatascanner()
    }
    
    // MARK: - Setup Delegate
    
    /// Sets up the delegate for handling scanner results.
    /// - Parameter delegate: Scanner view protocol delegate.
    func setupDelegate(delegate: ScannerViewProtocol?) {
        self.viewModel.setupDelegate(delegate: delegate)
    }
    
    // MARK: - Scanning Functions
    
    /// Installs the data scanner view.
    func installDataScanner() {
        view.addChildView(dataScanner.view)
        addChild(dataScanner)
    }
    
    /// Uninstalls the data scanner view.
    func uninstallDatascanner() {
        stopScanning()
        dataScanner.view.removeFromSuperview()
        dataScanner.removeFromParent()
    }
    
    /// Starts the scanning process.
    func startScanning() {
        do {
            try dataScanner.startScanning()
            
            Task {
                await viewModel.updateViaAsyncStream(stream: dataScanner.recognizedItems)
            }
            
        } catch {
            print("** Error: Unable to start scan - \(error)")
        }
    }
    
    /// Stops the scanning process.
    func stopScanning() {
        dataScanner.stopScanning()
    }
}
