# Full stack Assignment

# Frontend
<img src="images/seasons.png" width = "270" height = "600"/> <img src="./images/races.png" width = "270" height = "600"/>

The front end of the application is implemented in Flutter

## Implementation Details
The implementation is inspired from **[Clean Architecture](https://blog.cleancoder.com/uncle-bob/2012/08/13/the-clean-architecture.html)** and is divided into 3 layers i.e. presentation, domain, data. I have also tried to add proper separation of concerns using abstractions where ever I could, following dependency inversion, along with separate models and mappers between layers if there are any differences between models.

The following are the features implemented;
1. The UI consists of two screens i.e., Seasons with champions and races in a season
   - **Seasons with champions**: This is a simple list of clickable seasons starting from the year you set in the app build-time configuration to the current year. Clicking on the item takes you to the Races in that season
   - **Races in a season**: This screen consists of a list of all the races in the selected season. The race in which the champion of the season won has higher elevation and contains a small trophy against the race winner's name.
2. The profile data is persisted in **sqflite** in the cache package of data layer.
3. Api access through **OpenApi dart generator**
   - The data for the seasons and the races is fetched using ApiClient generated using OpenApi dart generator and included as a separate lib under frontend/packages/f1_api_client. The api client is then exposed to the application though a remote data-source in the data layer.
   - You will also find **the generate_api.sh** script in the frontend folder along with **frontend/packages/f1_api_client/openapi.json**. These can be used to generate the api client again in case the back end changes. 
4. All the project dependencies are injected using Providers
5. Extensive **Unit tests** are also implemented
6. CI/CD Pipeline
   - The pipeline has been implemented using the GitHub Actions with flow: install → lint → test → build → deploy
   - Both the android and iOS artifacts can be accessed from the GitHub release.
   - The Android apk can be installed in an emulator on a machine running the backend on localhost to run the application
   - For the iOS, unfortunately, to distribute the application, you need a paid developer's account. Only then you can configure signing and distribute on test flight. Which was not possible, hence I just created a runner and uploaded that as artifact. But you can run locally and test on iOs as well.  

## How to run?
Have the backend running on localhost. 
Download the apk from the GitHub releases and install it in an emulator.

### Run locally
To run locally, you have to create an **env.json** containing two parameters. 
You will find an **env-example.json** that explains what should be present in the file.
Please keep in mind that to access localhost, you can access it through http://localhost:8080 for iOS but for android you need to set the path to http://10.0.2.2:8080. 


