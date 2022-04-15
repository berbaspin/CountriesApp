#  CountriesApp

## Требования ##


### Сделать iOS приложение ###
Приложение представляет из себя список стран и их детальное описание.
Данные подгружаются постранично и находятся в JSON файлах pageN.json,  где N-номер страницы.
Начать нужно с 
[ page1.json ]( https://rawgit.com/NikitaAsabin/799e4502c9fc3e0ea7af439b2dfd88fa/raw/7f5c6c66358501f72fada21e04d75f64474a7888/page1.json ) . URL к следующей странице хранится в JSON файле в параметре "next".  

Детальный дизайн с ассетами находится в скетч файле тут [Тестовое задание для iOS](https://drive.google.com/file/d/1DwzFVFKsgTbrduPskJuDuWkQ_kggk9jO/view?usp=sharing)

Список подгруженных стран должен сохранятся локально.  В случае отсутствия интернета отображать закешированые данные.

#### Экраны: ####

**Список стран**

 * Необходимо отобразить список стран
 * Экран должен соответствовать прикрепленному [ дизайну ]( https://invis.io/BKDKMH76Q#/254298088_Countries_List )
 * Реализовать автоматическую подгрузку стран (пагинация)
 * Предусмотреть динамический размер ячеек
 * Добавить возможность обновления списка ( pull to refresh )
 
**Детальная информации о стране**

 * Необходимо отобразить детальную информацию о стране
 * Экран должен соответствовать прикрепленному [ дизайну ]( https://invis.io/BKDKMH76Q#/254298087_Country_Page ). Дополнительно можно сделать в соотвествии с данным [дизайном](https://invis.io/BKDKMH76Q#/254309438_Country_Page_2)
 * В случае если фото отсутствует - отобразить флаг выбранной страны

> *Фото в JSON файле находится в image или в countryInfo:{images: [] }*


## Workflow ##

* Use Swift
* Your choice for architecture (MVC, MVP, MVVM, Viper)
* Storyboard or XIBs
* Networking
* Store local data
* Follow Gitflow
* **Do not** use third party frameworks for image loading
* Store local data with Realm or Core Data
* Unit tests
* UI tests
