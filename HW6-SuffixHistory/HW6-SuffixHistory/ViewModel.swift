import Foundation
import Combine
import SwiftUI

final class ViewModel: ObservableObject {
    
    @Published var text: String = Settings.defaultText
    @Published var items: [ResultItem] = []

    private var subscriptions = Array<AnyCancellable>()
    let scheduler: JobScheduler
    
    init() {
        self.scheduler = JobScheduler()
        setup()
    }
    
    private func setup() {
        $text
            .sink { [weak self] newText in
                guard let self = self else {
                    return
                }
                update(using: newText)
            }
            .store(in: &subscriptions)
    }
    
    private func update(using string: String) {
        items.removeAll()
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
