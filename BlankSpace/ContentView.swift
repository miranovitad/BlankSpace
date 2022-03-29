import SwiftUI

struct ContentView: View {
    
//    @StateObject private var storyListVM = StoryListViewModel()

    var body: some View {
        VStack{
//            TextField("Enter id story", text: $storyListVM.idStory)
            Button("Save"){
            }
        }.padding()
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
