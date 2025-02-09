import Foundation
import Combine
import SwiftUI

final class ViewModel: ObservableObject {
    
    @Published var text: String = Settings.defaultText
    @Published var items: [ResultItem] = []

    @Published var summary = ""
    
    private var subscriptions = Array<AnyCancellable>()
    let scheduler: JobScheduler
    
    init() {
        self.scheduler = JobScheduler()
        setup()
    }
    
    private func setup() {
        $text
            .debounce(for: .milliseconds(500), scheduler: RunLoop.main)
            .sink { [weak self] newText in
                guard let self = self else {
                    return
                }
                update(using: newText)
            }
            .store(in: &subscriptions)
        
        Task {
            await scheduler.$isRunning
                .receive(on: DispatchQueue.main)
                .sink { [weak self] _ in
                    guard let self = self else {
                        return
                    }
                    updateSummary()
                }
                .store(in: &subscriptions)
        }
    }
    
    private func update(using string: String) {
        items.removeAll()
        summary = ""
        
        string.components(separatedBy: " ").forEach { addJobToQueue(for: $0) }
    }
    
    private func addJobToQueue(for word: String) {
        guard
            items.firstIndex(where: { $0.string == word } ) == nil,
            word.replacingOccurrences(of: " ", with: "") != ""
        else {
            return
        }
            
        let job = Job(word: word) { [weak self] result in
            DispatchQueue.main.async {
                guard let self else {
                    return
                }
                self.items.append(result)
                self.items.sort { $0.duration < $1.duration }
                self.updateColors()
            }
        }
        
        Task {
            await scheduler.add(job)
        }
    }
    
    private func updateSummary() {
        let count = items.count
        let avarageTime = items.map { $0.duration }.reduce(0, +) / Double(items.count)
        
        summary = "count: \(count) | avarage time: " + String(format: "%.6f sec", avarageTime)
    }
    
    private func updateColors() {
        guard
            let bestTimeResult = items.first,
            let worstTimeResult = items.last
        else {
            return
        }
        
        for i in (0..<items.count) {
            items[i].color = Color.speed(
                for: items[i].duration,
                minTime: bestTimeResult.duration,
                maxTime: worstTimeResult.duration
            )
        }
    }
}
