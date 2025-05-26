# f1_api_client.api.F1ControllerApi

## Load the API package
```dart
import 'package:f1_api_client/api.dart';
```

All URIs are relative to *http://localhost:8080*

Method | HTTP request | Description
------------- | ------------- | -------------
[**getSeasonRaces**](F1ControllerApi.md#getseasonraces) | **GET** /api/v1/seasons/{year}/races | 
[**getSeasonsWithChampions**](F1ControllerApi.md#getseasonswithchampions) | **GET** /api/v1/seasons | 


# **getSeasonRaces**
> List<RaceDTO> getSeasonRaces(year)



### Example
```dart
import 'package:f1_api_client/api.dart';

final api_instance = F1ControllerApi();
final year = 56; // int | 

try {
    final result = api_instance.getSeasonRaces(year);
    print(result);
} catch (e) {
    print('Exception when calling F1ControllerApi->getSeasonRaces: $e\n');
}
```

### Parameters

Name | Type | Description  | Notes
------------- | ------------- | ------------- | -------------
 **year** | **int**|  | 

### Return type

[**List<RaceDTO>**](RaceDTO.md)

### Authorization

No authorization required

### HTTP request headers

 - **Content-Type**: Not defined
 - **Accept**: */*

[[Back to top]](#) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to Model list]](../README.md#documentation-for-models) [[Back to README]](../README.md)

# **getSeasonsWithChampions**
> List<SeasonDTO> getSeasonsWithChampions(from, to)



### Example
```dart
import 'package:f1_api_client/api.dart';

final api_instance = F1ControllerApi();
final from = 56; // int | 
final to = 56; // int | 

try {
    final result = api_instance.getSeasonsWithChampions(from, to);
    print(result);
} catch (e) {
    print('Exception when calling F1ControllerApi->getSeasonsWithChampions: $e\n');
}
```

### Parameters

Name | Type | Description  | Notes
------------- | ------------- | ------------- | -------------
 **from** | **int**|  | [optional] [default to 2005]
 **to** | **int**|  | [optional] 

### Return type

[**List<SeasonDTO>**](SeasonDTO.md)

### Authorization

No authorization required

### HTTP request headers

 - **Content-Type**: Not defined
 - **Accept**: */*

[[Back to top]](#) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to Model list]](../README.md#documentation-for-models) [[Back to README]](../README.md)

