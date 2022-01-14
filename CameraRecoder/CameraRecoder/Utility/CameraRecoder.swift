//
//  CameraRecoder.swift
//  CameraRecoder
//
//  Created by Ppop on 2022/01/14.
//

import AVFoundation

protocol CameraRecoderProtocol {
    var previewLayer: AVCaptureVideoPreviewLayer { get }
    func startRecording()
    func stopRecording()
}

struct CameraRecoder: CameraRecoderProtocol {
    let previewLayer: AVCaptureVideoPreviewLayer
    private let avCaptureSession: AVCaptureSessionFactoryProtocol
 
    init(avCaptureSession: AVCaptureSessionFactoryProtocol) {
        self.avCaptureSession = avCaptureSession
        previewLayer = AVCaptureVideoPreviewLayer(session: avCaptureSession.avCaptureSession)
    }
}

extension CameraRecoder {
    func startRecording() {
        avCaptureSession.startRecording()
    }
    
    func stopRecording() {
        avCaptureSession.stopRecording()
    }
}
