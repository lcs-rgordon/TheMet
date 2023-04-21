import SwiftUI

// Example JSON response
//
// This illustrates how to handle an API that makes use of two endpoints.
//
// It also shows how to handle responses that include arrays, and data that is nested several levels deep.
//
// Recall that arrays are denoted by [ ] brackets.
//
// Objects are denoted by { }. Any time an object is provided,
// you must design a Swift structure to match it.
//
// Documentation: https://metmuseum.github.io/#search
//
// Initial endpoint (search by artist name for works of art with an image and in the public domain):
// https://collectionapi.metmuseum.org/public/collection/v1/search?hasImages=true&isPublicDomain=true&medium=Paintings&q=Vincent+Van+Gogh
//
// Sends back a list of object IDs that match the initial search
//
let initialResponse = """
 
{
    "total": 253,
    "objectIDs": [
        459123,
        436533,
        436532,
        436529,
        437984,
        436528,
        436535,
        436530,
        436527,
        436531,
        436524,
        436526,
        436536,
        438722,
        436525,
        437998,
        436534,
        437112,
        631809,
        631808,
        437980,
        441926,
        752393,
        436176,
        752392,
        437042,
        875741,
        749639,
        437432,
        486840,
        438144,
        438011,
        489124,
        436302,
        436952,
        437394,
        484537,
        853372,
        437393,
        435673,
        470306,
        437097,
        436085,
        437314,
        435870,
        437122,
        436882,
        437835,
        437526,
        437671,
        435604,
        842296,
        437099,
        435600,
        436516,
        436095,
        437131,
        437138,
        437670,
        486162,
        437300,
        437382,
        437150,
        436840,
        436121,
        436850,
        437391,
        437106,
        436001,
        437310,
        441924,
        436932,
        437436,
        436205,
        437107,
        435989,
        437378,
        435680,
        459005,
        435773,
        435990,
        437909,
        436089,
        438819,
        436448,
        437456,
        435882,
        435883,
        480987,
        437654,
        437040,
        437148,
        490146,
        437989,
        437513,
        437133,
        435879,
        436122,
        437127,
        437105,
        437437,
        437517,
        437346,
        437461,
        459107,
        437990,
        49734,
        437837,
        437349,
        437160,
        437656,
        436008,
        435875,
        816264,
        816263,
        436099,
        437427,
        435754,
        437303,
        437147,
        488496,
        853341,
        436961,
        436294,
        436144,
        437121,
        436021,
        436923,
        436076,
        435831,
        437993,
        438816,
        437655,
        490034,
        435868,
        435885,
        888924,
        435874,
        437838,
        437658,
        490002,
        435871,
        438669,
        436724,
        484829,
        436175,
        436012,
        493694,
        437251,
        435972,
        437381,
        436451,
        438821,
        436703,
        830723,
        437125,
        436725,
        437079,
        435991,
        435832,
        481763,
        437299,
        436149,
        435702,
        436138,
        435987,
        435888,
        436123,
        435774,
        436974,
        436632,
        438386,
        459110,
        435711,
        436177,
        435621,
        437896,
        437124,
        441104,
        490033,
        435691,
        488710,
        437847,
        483377,
        435876,
        437891,
        436180,
        438006,
        436449,
        435653,
        437916,
        482314,
        489974,
        437306,
        435988,
        436944,
        436964,
        437429,
        436946,
        500194,
        435983,
        437433,
        436090,
        436080,
        436114,
        435694,
        435968,
        435877,
        435884,
        436949,
        489634,
        459175,
        437115,
        436093,
        436139,
        437135,
        671456,
        488221,
        436061,
        489625,
        436869,
        438015,
        435878,
        437117,
        437672,
        438815,
        436954,
        481430,
        435851,
        437383,
        437986,
        489969,
        436917,
        436950,
        436965,
        436483,
        816522,
        436575,
        435802,
        436446,
        436106,
        490611,
        436105,
        437113,
        435869,
        437343,
        489544,
        437347,
        436537,
        435607,
        435640,
        437827,
        436948
    ]
}

"""

// Model (for initial response shown above)
//
//
struct SearchResult: Codable {
    
    let total: Int
    let objectIDs: [Int]
    
}

// Secondary endpoint (retrieve details for a specific work of art, we must pass in an ID to find the details for):
// https://collectionapi.metmuseum.org/public/collection/v1/objects/REPLACE_WITH_ID
//
// e.g.:
// https://collectionapi.metmuseum.org/public/collection/v1/objects/459123
//

let artworkDetail = """
{
    "objectID": 459123,
    "isHighlight": true,
    "accessionNumber": "1975.1.231",
    "accessionYear": "1975",
    "isPublicDomain": true,
    "primaryImage": "https://images.metmuseum.org/CRDImages/rl/original/DT3154.jpg",
    "primaryImageSmall": "https://images.metmuseum.org/CRDImages/rl/web-large/DT3154.jpg",
    "additionalImages": [
        "https://images.metmuseum.org/CRDImages/rl/original/ep1975.1.231.bw.R.jpg",
        "https://images.metmuseum.org/CRDImages/rl/original/RLC1.jpg",
        "https://images.metmuseum.org/CRDImages/rl/original/2489.jpg"
    ],
    "constituents": [
        {
            "constituentID": 161947,
            "role": "Artist",
            "name": "Vincent van Gogh",
            "constituentULAN_URL": "http://vocab.getty.edu/page/ulan/500115588",
            "constituentWikidata_URL": "https://www.wikidata.org/wiki/Q5582",
            "gender": ""
        }
    ],
    "department": "Robert Lehman Collection",
    "objectName": "Painting",
    "title": "Madame Roulin and Her Baby",
    "culture": "",
    "period": "",
    "dynasty": "",
    "reign": "",
    "portfolio": "",
    "artistRole": "Artist",
    "artistPrefix": "",
    "artistDisplayName": "Vincent van Gogh",
    "artistDisplayBio": "Dutch, Zundert 1853–1890 Auvers-sur-Oise",
    "artistSuffix": "",
    "artistAlphaSort": "Gogh, Vincent van",
    "artistNationality": "Dutch",
    "artistBeginDate": "1853",
    "artistEndDate": "1890",
    "artistGender": "",
    "artistWikidata_URL": "https://www.wikidata.org/wiki/Q5582",
    "artistULAN_URL": "http://vocab.getty.edu/page/ulan/500115588",
    "objectDate": "1888",
    "objectBeginDate": 1888,
    "objectEndDate": 1888,
    "medium": "Oil on canvas",
    "dimensions": "25 x 20 1/8 in.",
    "measurements": [
        {
            "elementName": "Overall",
            "elementDescription": null,
            "elementMeasurements": {
                "Height": 63.5,
                "Width": 50.8
            }
        }
    ],
    "creditLine": "Robert Lehman Collection, 1975",
    "geographyType": "",
    "city": "",
    "state": "",
    "county": "",
    "country": "",
    "region": "",
    "subregion": "",
    "locale": "",
    "locus": "",
    "excavation": "",
    "river": "",
    "classification": "Paintings",
    "rightsAndReproduction": "",
    "linkResource": "",
    "metadataDate": "2023-04-21T04:46:32.55Z",
    "repository": "Metropolitan Museum of Art, New York, NY",
    "objectURL": "https://www.metmuseum.org/art/collection/search/459123",
    "tags": [
        {
            "term": "Infants",
            "AAT_URL": "http://vocab.getty.edu/page/aat/300189561",
            "Wikidata_URL": "https://www.wikidata.org/wiki/Q998"
        },
        {
            "term": "Portraits",
            "AAT_URL": "http://vocab.getty.edu/page/aat/300015637",
            "Wikidata_URL": "https://www.wikidata.org/wiki/Q134307"
        },
        {
            "term": "Mothers",
            "AAT_URL": "http://vocab.getty.edu/page/aat/300025932",
            "Wikidata_URL": "https://www.wikidata.org/wiki/Q7560"
        },
        {
            "term": "Women",
            "AAT_URL": "http://vocab.getty.edu/page/aat/300025943",
            "Wikidata_URL": "https://www.wikidata.org/wiki/Q467"
        }
    ],
    "objectWikidata_URL": "https://www.wikidata.org/wiki/Q17024776",
    "isTimelineWork": false,
    "GalleryNumber": "825"
}
"""

// Model (for retrieving details for a specific work of art)
//
//

struct ArtworkDetail: Codable {
    
    let primaryImage: String
    let department: String
    let title: String
    let artistDisplayName: String
    let medium: String
    let dimensions: String
    // Measurement is a data type (structure) we define to
    // match format of object the endpoint sends us
    let measurements: [Measurement]
    let creditLine: String
    let objectURL: String
    
}

// Required to get metric measurements
struct Measurement: Codable {
    let elementName: String
    // ElementMeasurement is a data type (structure) we define to
    // match format of object the endpoint sends us
    let elementMeasurements: ElementMeasurement
}

// Required to get actual measure values
struct ElementMeasurement: Codable {
    let Height: Double
    let Width: Double
}


// Network service #1
//
// This gets the initial list of object IDs that match search term
//
// Right now, this example always searches for "Vincent Van Gogh"
//
// See part of the tutorial previously provided for details on
// how to modify function to accept a search term given within your
// app's user interface:
//
// https://teaching.russellgordon.ca/current-courses/grade-11-introduction-to-computer-science/topics/json/retrieving-a-list-of-data-from-a-remote-endpoint/#making-the-search-functional
//
func fetch() async -> SearchResult? {

    // 1. Attempt to create a URL from the address provided
    let endpoint = "https://collectionapi.metmuseum.org/public/collection/v1/search?hasImages=true&isPublicDomain=true&medium=Paintings&q=Vincent+Van+Gogh"
    guard let url = URL(string: endpoint) else {
        print("Invalid address")
        return nil
    }

    // 2. Fetch the raw data from the URL
    //
    // Network requests can potentially fail (throw errors) so
    // we complete them within a do-catch block to report errors if they
    // occur.
    //
    do {
        
        // Fetch the data
        let (data, _) = try await URLSession.shared.data(from: url)
        
        // Create a decoder object to do most of the work for us
        let decoder = JSONDecoder()
        
        // Use the decoder object to convert the raw data into a instance of the SearchResult type
        let decodedData = try decoder.decode(SearchResult.self, from: data)

        // If we got here, we have received an array of artwork IDs that match our search
        if decodedData.total > 0 {
            return decodedData
        } else {
            return nil
        }
        
    } catch {
        
        // Show an error that we wrote and understand
        print("Count not retrieve data from endpoint, or could not decode data.")
        print("----")
        
        // No results, return an empty array
        print(error.localizedDescription)
        return nil
        
    }
    
}

// Network service #2
//
// This gets the details for a specific painting
//
func fetch(detailsFor artworkID: Int) async -> ArtworkDetail? {

    // 1. Attempt to create a URL from the address provided
    let endpoint = "https://collectionapi.metmuseum.org/public/collection/v1/objects/\(artworkID)"
    guard let url = URL(string: endpoint) else {
        print("Invalid address")
        return nil
    }

    // 2. Fetch the raw data from the URL
    //
    // Network requests can potentially fail (throw errors) so
    // we complete them within a do-catch block to report errors if they
    // occur.
    //
    do {
        
        // Fetch the data
        let (data, _) = try await URLSession.shared.data(from: url)
        
        // Create a decoder object to do most of the work for us
        let decoder = JSONDecoder()
        
        // Use the decoder object to convert the raw data into a instance of the ArtworkDetail type
        let decodedData = try decoder.decode(ArtworkDetail.self, from: data)

        // If we got here, we must have an instance of the ArtworkDetail type, so return it
        return decodedData
        
    } catch {
        
        // Show an error that we wrote and understand
        print("Count not retrieve data from endpoint, or could not decode data.")
        print("----")
        
        // No results, return an empty array
        print(error.localizedDescription)
        return nil
        
    }
    
}


// "View"
//
// A text-based presentation of results is provided, since
// the purpose of this playground is only to illustate how to
// build a model to match the data returned by an endpoint
//
Task {
    // Get search results
    if let result = await fetch() {
        
        print("\(result.objectIDs.count) results found.")
        print("Now fetching details for the first object ID retreived.")
        
        // Get details for first object ID
        if let details = await fetch(detailsFor: result.objectIDs.first!) {
            
            // Print the entire contents of the instance of ArtworkDetail
            print("----")
            print("Title: \(details.title)")
            print("")
            print("By: \(details.artistDisplayName)")
            print("")
            print("Imperial (US) measurements:")
            print(details.dimensions)
            print("")
            print("Metric measurements:")
            print("Height (cm): \(details.measurements.first!.elementMeasurements.Height)")
            print("Width (cm): \(details.measurements.first!.elementMeasurements.Width)")
            print("")
            print("View artwork at this address:")
            print(details.primaryImage)
                        
        } else {
            print("Could not retrieve artwork details for first search result returned.")
        }
        
    } else {
        print("No results found.")
    }
}
