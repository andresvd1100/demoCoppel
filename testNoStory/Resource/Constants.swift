//
//  Constants.swift
//  testNoStory
//
//  Created by Andres Valerio on 11/02/23.
//

import Foundation
struct Constants{
    struct ValidatorMessages {
        static let email = "Por favor ingrese un correo valido"
        static let name = "@ es requerido"
        static let password = "La contraseña es muy corta"
        static let loginInvalidEmpty = "Ingrese un usuario y contraseña correctos"
    }
    
    struct FieldsNameForms {
        // MARK: LOGIN
        static let name = "Username"
        static let password = "Password"
    }
    
    struct ButtonTitles {
        // MARK: LOGIN
        static let login = "Login"
        static let closeSession = "Cerrar sesion"
        static let addFavorites = "Agregar a favoritos"
        static let deleteFavorites = "Eliminar de favoritos"
    }
    
    struct Titles {
        static let movies = "Movies"
    }
    
    struct Labels{
        static let duration = "Duración: "
        static let status = "Estado: "
        static let budget = "Presupuesto"
        static let ingresos = "Ingresos"
        static let cast = "Reparto"
        static let crew = "Equipo"
    }
    
    struct Messages{
        static let addFavorites = "Has agregado esta pelicula a tus favoritos"
    }
    
    struct SegmentedTitles{
        static let moviesOption = ["Popular","Top Rated","Now playing","Upcoming"]
    }
    
    struct TMDB{
        static let apiKey = "d31677dad13da4f7bb465d890d2ae61d"
    }
    
    
}
