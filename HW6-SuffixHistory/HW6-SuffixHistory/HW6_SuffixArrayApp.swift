import SwiftUI

@main
struct HW6_SuffixArrayApp: App {

    @StateObject var historyService = HistoryService()
    
    var body: some Scene {
        WindowGroup {
            NavigationStack {
                VStack(alignment: .leading) {
                    TitleView(title: "your history")
                    ScrollView {
                        if historyService.items.isEmpty {
                            Text("nothing")
                                .monospaced()
                                .foregroundStyle(.gray)
                                .padding(.bottom, Style.spacing)
                            
                        } else {
                            ForEach(historyService.items, id: \.text) { item in
                                NavigationLink(
                                    destination: {
                                        AnalizeView(viewModel: ViewModel(text: item.text) { text, suffixes in
                                            historyService.append(Searches(text: text, time: 0, results: suffixes))
                                        })
                                    },
                                    label: {
                                        ItemView(
                                            title: item.text,
                                            subtitle: "\(item.time)",
                                            color: Color.speed(for: item.time, minTime: historyService.minTime, maxTime: historyService.maxTime)
                                        )
                                    }
                                )
                            }
                        }
                        Spacer()
                    }.padding(.all, Style.spacing)
                    
                    NavigationLink(
                        destination: {
                            AnalizeView(viewModel: ViewModel(text: "your text") { text, suffixes in
                                historyService.append(Searches(text: text, time: 0, results: suffixes))
                            })
                        },
                        label: {
                            Text("analize new string")
                                .monospaced()
                                .frame(height: 40)
                                .frame(maxWidth: .infinity)
                                .foregroundStyle(.dark)
                                .background {
                                    RoundedRectangle(cornerRadius: Style.cornerRadius)
                                        .foregroundStyle(.white)
                                }
                                .padding(.all, Style.spacing)
                        }
                    )
                }.padding(.all, Style.spacing)
            }.preferredColorScheme(.dark)
        }
    }
}
