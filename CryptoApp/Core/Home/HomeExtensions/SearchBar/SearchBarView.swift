//
//  SearchBarView.swift
//  CryptoApp
//
//  Created by Benny Mushiya on 21/01/2023.
//

import SwiftUI

// creates a search bar
struct SearchBarView: View {
    
    //MARK: - PROPERTIES
    
    @Binding var searchText: String
    
    
    //MARK: - LIFECYCLE

    var body: some View {
        
        HStack {
            
            Image(systemName: "magnifyingglass")
                .foregroundColor(
                    searchText.isEmpty ? Color.theme.secondaryText : Color.theme.accent
                )
            
            TextField("search by name or symbol.....", text: $searchText )
                .foregroundColor(Color.theme.accent)
                .disableAutocorrection(true)
                .overlay(
                
                    Image(systemName: "xmark.circle.fill")
                        .foregroundColor(Color.theme.accent)
                        .offset(x: 10)
                        .foregroundColor(Color.theme.accent)
                        .opacity(searchText.isEmpty ? 0.0 : 1.0)
                        .onTapGesture {
                            
                            // an extension of UIAplication we created to end editing
                            UIApplication.shared.endEditing()
                            searchText = ""
                        }
                
                    ,alignment: .trailing
                )
        }
        .font(.headline)
        .padding()
        .background(
        
            RoundedRectangle(cornerRadius: 25)
                .fill(Color.theme.background)
                .shadow(color: Color.theme.accent.opacity(0.15), radius: 10, x: 0, y: 0)
        )
        .padding()
    }
}

struct SearchBarView_Previews: PreviewProvider {
    static var previews: some View {
        
        Group {
            
            SearchBarView(searchText: .constant(""))
                .previewLayout(.sizeThatFits)
                .preferredColorScheme(.light)

            
        }
    }
}
