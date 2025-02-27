# MVVM Clearn Architecture 
iOS Clean Architecture app written in Swift using Combine, Used Coordinator for navigation, and used Container for Dependency Injection.

## Architecture
Uses concepts of the notorious Uncle Bob's architecture called [Clean Architecture](https://blog.cleancoder.com/uncle-bob/2012/08/13/the-clean-architecture.html).</br>

* Better separation of concerns. Each module has a clear API., Feature related classes life in different modules and can't be referenced without explicit module dependency.
* Features can be developed in parallel eg. by different teams
* Each feature can be developed in isolation, independently from other features
* faster compile time

## Modules:
* **data** - The data layer implements the repository interface that the domain layer defines. This layer provide a single source of truth for data. 
* **Application** - This layer implements Overall generic components needed for the pp
* **domain** - The domain layer contains the UseCases that encapsulate a single and very specific task that can be performed. This task is part of the business logic of the application. 
* **presentation** - MVVM with ViewModels exposing LiveData that the UI consume. The ViewModel does not know anything about it's consumers. 

## Tech Stack:
* [Swift][1]
* [Combine][2]
* [URLSession][3]
* [UI Kit][4]
* [XCTestCase][5]

## Testing
Currently written ViewModelType test case covered domain, data, presentation and Application module with moderate test coverage 

## Additonal feature in app
1. App Handle Internet Connectivity Error
2. Pull to refresh Data
3. Dark Mode Support


## TODO
1. Instrumentation test cases.
2. More unit test cases 
3. Improve UI

