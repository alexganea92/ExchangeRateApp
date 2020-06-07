# ExchangeRateApp


## Version

1.0

## Build and Runtime Requirements
+ Xcode 11.3 or later
+ iOS 13.2 or later

## Configuring the Project
1. Run "pod install" in terminal
2. Build & Run from Xcode


## Project Overview
  1. List Screen: shows the latest currencies rates based on a certain currency
  2. Setting Screen: can change the refresh time interval for the currency and also toggle the currency shown
  3. History Screen: shows a charts representing data sets of certain currencies of a period of time
  

    
 ### Architecture description
   The application is composed of 3 screens, which are grouped in 3 modules, 1 for each screen with additional helpers files.
   #### Components of a module:
    1. ViewController: the component visible to the user
    2. Controller: manages the communication between the ViewController and DataSource
    3. DataSource: can be an API or local data
    4. Model: used to represent useful, clear, properly formatted information for the user
    5. ViewModel: contains all the observable properties from which a ViewController binds and listens
   #### Components communication:
    1. ViewController which is initialized requests data from the Controller
    2. Controller requests the data from the DataSouce and assigns the useful ViewModel properties
    3. ViewModel events are triggered and data is shown to the user in a meaningful way using existing functions in the proper module and from the helpers.
    
 
### Technical description
    - Observable: manages the data binding
    - Protocols: helpers for MVVM components
    - Color extension: used to draw data sets line in history chart
    - Helper: functions for date, string, number formatters
    - Config: holds default values for different parameters
    
 ## Unit Tests
  1. List:
      - Cell view model: how it is represented in the cell
      - Data: if the number of currencies match the ones from the data source
      - Loading: if flag updates accordingly
      
  2. Setting:
      - Currency model: the name matches
      - Currencies options: if options presented for the user match the data source
      
  3. History:
      - Error: if message matches the one from the data source
      - Max Y value: if matches the one provided by the data source
      - Data: if pre-processed data matches the one provided by the data source
      
   ## Pods
- [Charts](https://github.com/danielgindi/Charts)
- [Alamofire](https://github.com/Alamofire/Alamofire)
