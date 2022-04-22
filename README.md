#  CountriesApp

## Requirements ##


### Build an iOS app ###
The application is a list of countries and their detailed description.
The data is loaded page by page and located in JSON files pageN.json, where N is a page number.
Start with
[ page1.json ]( https://rawgit.com/NikitaAsabin/799e4502c9fc3e0ea7af439b2dfd88fa/raw/7f5c6c66358501f72fada21e04d75f64474a7888/page1.json ) . The URL to the next page is located in the JSON file in the "next" parameter. 

The detailed design with assets is in the sketch [file](https://drive.google.com/file/d/1DwzFVFKsgTbrduPskJuDuWkQ_kggk9jO/view?usp=sharing)

The list of loaded countries should be saved locally. In the absence of an Internet connection, cached data should be display.

#### Screens: ####

**List of countries**

 * The screen must match the attached [ design ]( https://invis.io/BKDKMH76Q#/254298088_Countries_List )
 * Automatic loading of countries (pagination)
 * Dynamic cell size
 * Ability to update the list of countries (pull to refresh)
 
**Detailed information about the country**

 * The screen must match the attached [ design ]( https://invis.io/BKDKMH76Q#/254298087_Country_Page ). 
 * If there is no photo - display the flag of the selected country

> *Photos in the JSON file are located by the key image or in countryInfo:{images: [] }*


## Workflow ##

* Use Swift
* Your choice of architecture (MVC, MVP, MVVM, Viper)
* Storyboard or XIBs
* Networking
* Store local data
* Follow Gitflow
* Store local data with Realm or Core Data
* Unit tests
* UI tests
* **Do not** use third party frameworks for image loading
