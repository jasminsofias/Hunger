//
//  StarView.swift
//  Hunger
//
//  Created by Sofia Abd Alwaheb on 2022-12-21.
//

//
//  StarRateView.swift
//  Hunger
//
//  Created by Sofia Abd Alwaheb on 2022-12-19.
//

import SwiftUI

struct StarView: View {
    
    @StateObject var hungerVM = HungerVM()
    var rating: Int
    
    var label = ""
    var maxRating = 5
    
    var offImage: Image?
    var onImage = Image(systemName: "star.fill")
    
    var offColor = Color.gray
    var onColor = Color.yellow
    
    var body: some View {
        HStack{
            if label.isEmpty == false {
                Text(label)
            }
            ForEach(1..<maxRating + 1, id: \.self){ number in
                image(for: number)
                    .foregroundColor(number > rating ? offColor : onColor)
                    
            }
        }
        //Text("\(hungerVM.userName)")
    }
    
    func image(for number: Int) -> Image{
        if number > rating{
            return offImage ?? onImage
        }else{
            return onImage
        }
    }
    
}

struct StarView_Previews: PreviewProvider {
    static var previews: some View {
        StarRateView(rating: .constant(4))
    }
}

