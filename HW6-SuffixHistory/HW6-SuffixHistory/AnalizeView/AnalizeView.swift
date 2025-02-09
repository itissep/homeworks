import SwiftUI

enum Style {
    static let spacing: CGFloat = 10
    static let cornerRadius: CGFloat = 10
    
    static let textEditorHeight: CGFloat = 200
}

struct AnalizeView: View {
    
    @StateObject var viewModel: ViewModel
    
    var body: some View {
        ScrollView {
            VStack(alignment: .leading) {
                TitleView(title: "your text")
                
                TextEditor(text: $viewModel.text)
                    .foregroundStyle(.white)
                    .monospaced()
                    .padding(.horizontal, Style.spacing)
                    .scrollContentBackground(.hidden)
                    .background {
                        RoundedRectangle(cornerRadius: Style.cornerRadius)
                            .foregroundStyle(Color.accent.opacity(0.3))
                    }
                    .padding(.all, Style.spacing)
                    .frame(height: Style.textEditorHeight)
                
                Button("add to history") {
                    viewModel.addToHistory()
                }
                .monospaced()
                .buttonStyle(.plain)
                .frame(height: 40)
                .frame(maxWidth: .infinity)
                .foregroundStyle(.dark)
                .background {
                    RoundedRectangle(cornerRadius: Style.cornerRadius)
                        .foregroundStyle(.white)
                }
                .padding(.all, Style.spacing)
                
                TitleView(title: "suffixes")
                
                Picker("", selection: $viewModel.listType) {
                    ForEach(ListType.allCases, id: \.rawValue) {
                        Text($0.rawValue).tag($0)
                    }
                }
                .pickerStyle(.segmented)
                .padding(.all, Style.spacing)
                
                switch viewModel.listType {
                case .top:
                    Group {
                        ForEach(viewModel.topItems ?? [], id: \.suffix) {
                            ItemView(
                                title: $0.suffix,
                                subtitle: "\($0.count)",
                                color: Color.rarity(for: $0.count)
                            )
                        }
                    }
                    .padding(.all, Style.spacing)
                case .all:
                    HStack {
                        Picker("", selection: $viewModel.sortingType) {
                            ForEach(SortingType.allCases, id: \.rawValue) {
                                Text($0.rawValue).tag($0)
                            }
                        }
                        Picker("", selection: $viewModel.filteringType) {
                            ForEach(FilteringType.allCases, id: \.rawValue) {
                                Text("\($0.rawValue) \(Settings.suffixRange) letters").tag($0)
                            }
                        }
                    }
                    .padding(.all, Style.spacing)
                    
                    TextField("suffix search", text: $viewModel.searchText)
                        .autocapitalization(.none)
                        .disableAutocorrection(true)
                        .foregroundStyle(.gray)
                        .monospaced()
                        .padding(.all, Style.spacing)
                        .background {
                            RoundedRectangle(cornerRadius: Style.cornerRadius)
                                .foregroundStyle(Color.accent.opacity(0.3))
                        }
                        .padding(.all, Style.spacing)
                    
                    Group {
                        ForEach(viewModel.items ?? [], id: \.suffix) {
                            ItemView(
                                title: $0.suffix,
                                subtitle: "\($0.count)",
                                color: Color.rarity(for: $0.count)
                            )
                        }
                    }
                    .padding(.all, Style.spacing)
                }
            }
        }
        .backgroundStyle(.dark)
        .onAppear {
            UISegmentedControl.appearance().selectedSegmentTintColor = UIColor.white
            UISegmentedControl.appearance().setTitleTextAttributes([.foregroundColor: UIColor.accent], for: .selected)
            UISegmentedControl.appearance().setTitleTextAttributes([.foregroundColor: UIColor.white], for: .normal)
        }
        .onOpenURL { _ in viewModel.sortingType = viewModel.sortingType == .asc ? .desc : .asc }
    }
}
