//
//  ScannerViewModel.swift
//  IbanReader
//
//  Created by Aymen Bokri on 25/04/2024.
//

import Foundation
import VisionKit

class ScannerViewModel {
    
    /// Weak reference to the scanner view protocol delegate.
    weak var delegate: ScannerViewProtocol?
    
    /// Sets up the delegate for handling scanner results.
    /// - Parameter delegate: Scanner view protocol delegate.
    func setupDelegate(delegate: ScannerViewProtocol?) {
        self.delegate = delegate
    }
    
    /// Updates the scanner result asynchronously via the provided async stream.
    /// - Parameter stream: Async stream containing recognized items.
    func updateViaAsyncStream(stream: AsyncStream<[RecognizedItem]>) async {
        for await newItems: [RecognizedItem] in stream {
            for textualItem in newItems.compactMap({ item in
                switch item {
                case .text(let text):
                    if !text.transcript.isEmpty {
                        return text.transcript
                    } else {
                        return nil
                    }
                default:
                    return nil
                }
            }) {
                await delegate?.onScannerResult(result: textualItem)
            }
        }
    }
}
