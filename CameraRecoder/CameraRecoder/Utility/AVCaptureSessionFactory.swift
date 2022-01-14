//
//  AVCaptureSessionFactory.swift
//  CameraRecoder
//
//  Created by Ppop on 2022/01/14.
//

import AVFoundation
import UIKit

protocol AVCaptureSessionFactoryProtocol {
    var avCaptureSession: AVCaptureSession { get }
    func startRecording()
    func stopRecording()
}

class AVCaptureSessionFactory: NSObject, AVCaptureSessionFactoryProtocol {
    let avCaptureSession: AVCaptureSession = AVCaptureSession()
    private var tempURL: URL?
    private var movieFileOutput: AVCaptureMovieFileOutput?
    
    override init() {
        super.init()
        prepareForCaptureSession()
    }
}

extension AVCaptureSessionFactory {
    
    func startRecording() {
        let tempURL = createTempDirectory()
        self.tempURL = tempURL
        movieFileOutput?.startRecording(to: tempURL,
                                        recordingDelegate: self)
        avCaptureSession.startRunning()
    }
    
    func stopRecording() {
        guard let movieFileOutput = movieFileOutput else { return }
        if movieFileOutput.isRecording {
            movieFileOutput.stopRecording()
        }
    }
    
    private func createTempDirectory() -> URL {
      let directory = NSTemporaryDirectory() as NSString
      
        let path = directory.appendingPathComponent(NSUUID().uuidString + ".mp4")
        return URL(fileURLWithPath: path)
    }
    
   private func prepareForCaptureSession() {
        avCaptureSession.beginConfiguration()
       avCaptureSession.sessionPreset = .hd1920x1080

        setupVideoInput()
        setupAudioInput()
        setupMovieFileOutput()
        
        avCaptureSession.commitConfiguration()
    }
    
    private func setupVideoInput() {
        guard let videoDevice = AVCaptureDevice.default(.builtInDualCamera, for: .video, position: .back) else { return }
        guard let deviceInput = try? AVCaptureDeviceInput.init(device: videoDevice) else { return }
        if avCaptureSession.canAddInput(deviceInput) {
            avCaptureSession.addInput(deviceInput)
        }
    }
    
    private func setupMovieFileOutput() {
        movieFileOutput = AVCaptureMovieFileOutput()
        if avCaptureSession.canAddOutput(movieFileOutput!) {
            avCaptureSession.addOutput(movieFileOutput!)
        }
    }
    
    private func setupAudioInput() {
        guard let audioDevice = AVCaptureDevice.default(for: AVMediaType.audio) else { return }
        guard let audioInput = try? AVCaptureDeviceInput(device: audioDevice) else { return }
        if avCaptureSession.canAddInput(audioInput) {
            avCaptureSession.addInput(audioInput)
        }
    }
}

extension AVCaptureSessionFactory: AVCaptureFileOutputRecordingDelegate {
    func fileOutput(_ output: AVCaptureFileOutput, didStartRecordingTo fileURL: URL, from connections: [AVCaptureConnection]) {
        print("didStartRecordingTo: ", output)
        print("didStartRecordingTo: ", fileURL)
        print("didStartRecordingTo: ", connections)
    }
    
    func fileOutput(_ output: AVCaptureFileOutput, didFinishRecordingTo outputFileURL: URL, from connections: [AVCaptureConnection], error: Error?) {
        print("didFinishRecordingTo: ", output)
        print("didFinishRecordingTo: ", outputFileURL)
        print("didFinishRecordingTo: ", connections)
        guard let videoRecorded = tempURL else { return }
        UISaveVideoAtPathToSavedPhotosAlbum(videoRecorded.path, nil, nil, nil)
    }
}
