import Speech
import AVFoundation

final class LiveTranscriber {
    
    // Speech recognizer that converts audio into Thai text
    private let recognizer = SFSpeechRecognizer(
        locale: Locale(identifier: "th-TH")
    )!
    
    // Audio engine that gets live audio from the microphone
    private let engine = AVAudioEngine()
    
    // Stores the current speech recognition request
    private var request: SFSpeechAudioBufferRecognitionRequest?
    
    // Stores the active speech recognition task
    private var task: SFSpeechRecognitionTask?

    
    // Starts listening to the microphone
    // onText is a function that gets called whenever new text is recognized
    func start(onText: @escaping (String) -> Void) throws {
        
        #if os(iOS)
        
        // Get the app's shared audio session
        let session = AVAudioSession.sharedInstance()
        
        // Tell the audio session that we're using it for recording
        // .measurement reduces extra audio processing
        try session.setCategory(.playAndRecord, mode: .measurement)
        
        // Turn the audio session on
        try session.setActive(true)
        
        #endif

        
        // Create a request that accepts live audio buffers
        let request = SFSpeechAudioBufferRecognitionRequest()
        
        // Gives us text updates while the user is still speaking
        // instead of waiting until they're completely finished
        request.shouldReportPartialResults = true
        
        // Check whether this device/language supports
        // speech recognition directly on the device
        if recognizer.supportsOnDeviceRecognition {
            
            // Require recognition to happen locally instead of using a server
            request.requiresOnDeviceRecognition = true
        }
        
        // Save this request in the class
        // so we can access and stop it later
        self.request = request

        
        // Get the microphone input from the audio engine
        let input = engine.inputNode
        
        // Add a "tap" to the microphone
        // A tap lets us receive chunks of audio while the user speaks
        input.installTap(
            onBus: 0,
            bufferSize: 1024,
            format: input.outputFormat(forBus: 0)
        ) { buffer, _ in
            
            // Every time we receive another chunk of microphone audio,
            // send that audio to the speech recognition request
            request.append(buffer)
        }
        
        
        // Prepare the audio engine to start recording
        engine.prepare()
        
        // Actually begin listening to the microphone
        try engine.start()

        
        // Start the actual speech recognition task
        // The recognizer continuously processes the audio
        // that we're appending to the request
        task = recognizer.recognitionTask(
            with: request
        ) { [weak self] result, error in
            
            // If the recognizer has produced a result...
            if let result {
                
                // Get its current best guess of what the user said
                // and send that String back through onText
                onText(
                    result.bestTranscription.formattedString
                )
            }
            
            
            // If something went wrong...
            // OR the recognizer says this result is finished...
            if error != nil || result?.isFinal == true {
                
                // Stop listening and clean everything up
                self?.stop()
            }
        }
    }

    
    // Stops live speech recognition
    func stop() {
        
        engine.stop()
        
        engine.inputNode.removeTap(onBus: 0)
        
        request?.endAudio()
        
        task?.cancel()
        
        request = nil
        task = nil
        
        #if os(iOS)
        try? AVAudioSession.sharedInstance().setActive(
            false,
            options: .notifyOthersOnDeactivation
        )
        #endif
    }
}

func requestPermissions() {
    
    // ask for speech recognition permission
    SFSpeechRecognizer.requestAuthorization { status in
        
        switch status {
            
        case .authorized:
            print("Speech recognition authorized")
            
        case .denied:
            print("Speech recognition denied")
            
        case .restricted:
            print("Speech recognition restricted")
            
        case .notDetermined:
            print("Speech recognition not determined")
            
        @unknown default:
            break
        }
    }
    
    
    // ask for microphone permission
    AVAudioApplication.requestRecordPermission { granted in
        
        if granted {
            print("Microphone authorized")
        } else {
            print("Microphone denied")
        }
    }
}
