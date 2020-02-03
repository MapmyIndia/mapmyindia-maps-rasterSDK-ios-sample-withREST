
![MapmyIndia APIs](https://www.mapmyindia.com/api/img/mapmyindia-api.png)

  

# MapmyIndia  Raster Maps  iOS SDK

  

## [Getting Started](#Getting-Started)

 MapmyIndia’s iOS Map SDK helps to embed MapmyIndia maps within your iOS application. Through customized raster tiles, you can add different map layers to your application and add bunch of controls and gestures to enhance map usability thus creating potent map based solutions for your customers.


## [API Usage](#API-Usage) 

Your MapmyIndia Maps SDK usage needs a set of license keys ([get them here](http://www.mapmyindia.com/api/signup) ) and is governed by the API [terms and conditions](https://www.mapmyindia.com/api/terms-&-conditions).

As part of the terms and conditions, you cannot remove or hide the MapmyIndia logo and copyright information in your project.

Please see [branding guidelines](https://www.mapmyindia.com/api/advanced-maps/API-Branding-Guidelines.pdf) on MapmyIndia [website](https://www.mapmyindia.com/api) for more details.

The allowed SDK hits are described on the [plans](https://www.mapmyindia.com/api/) page. Note that your usage is

shared between platforms, so the API hits you make from a web application, Android app or an iOS app all add up to your allowed daily limit.

  

## [Setup your Project](#Setup-your-Project)

  

#### Create a new project in Xcode.

  

- Drag and drop the MapmyIndia Map SDK Framework (Mapbox.framework) to your project. It must be added in embedded binaries.

- Drag and drop the `MapmyIndiaAPIKit` Framework to your project. It must be added in embedded binaries. It is a dependent framework.

- In the Build Phases tab of the project editor, click the + button at the top and select .New Run Script Phase.. Enter the following code into the script text field: bash `${BUILT_PRODUCTS_DIR}/${FRAMEWORKS_FOLDER_PATH}/Mapbox.framework/strip-frameworks.sh`

- For iOS9 or later, make this change to your

info.plist (Project target > info.plist > Add row and set key `NSLocationWhenInUseUsageDescription`, `NSLocationAlwaysUsageDescription`)

  

Add your MapmyIndia Map API keys to your `AppDelegate.m` as follows-
    1. Add the following import statement.
                 
```

    #import <MMIFramework/MMIFramework.h>
    
```

   2.Add the following to your application:didFinishLaunchingWithOptions: method, replacing restAPIKey and mapSDKKey with your own API keys:
   
```

[LicenceManager sharedInstance].restAPIKey=your_rest_api_key;
[LicenceManager sharedInstance].mapSDKKey=your_java_script_key;

```


1. Add the following import statement.

#### Objective-C

```objectivec

#import <MapmyIndiaAPIKit/MapmyIndiaAPIKit.h>

```

#### Swift

```swift

import MapmyIndiaAPIKit

```



To initialize SDK you have to set required keys. You can achieve this using

two ways:

****First Way (Preferred)****

By adding following keys in `Info.plist` file of your project `MapmyIndiaSDKKey`, `MapmyIndiaRestKey`, `MapmyIndiaAtlasClientId`, `MapmyIndiaAtlasClientSecret`, `MapmyIndiaAtlasGrantType`.

****Second Way****

You can also set these required keys programmatically.

Add the following to your `application:didFinishLaunchingWithOptions`: method, replacing `restAPIKey` and `mapSDKKey` with your own API keys:

  

#### Objective-C

```objectivec

[MapmyIndiaAccountManager setMapSDKKey:@"MAP SDK_KEY"];
[MapmyIndiaAccountManager setRestAPIKey:@"REST API_KEY"];
[MapmyIndiaAccountManager setAtlasClientId:@"ATLAS CLIENT_ID"];
[MapmyIndiaAccountManager setAtlasClientSecret:@"ATLAS CLIENT_SECRET"];
[MapmyIndiaAccountManager setAtlasGrantType:@"GRANT_TYPE"]; //always put client_credentials
[MapmyIndiaAccountManager setAtlasAPIVersion:@"1.3.11"]; // Optional; deprecated

```

#### Swift

```swift

MapmyIndiaAccountManager.setMapSDKKey("MAP SDK_KEY")
MapmyIndiaAccountManager.setRestAPIKey("REST API_KEY")
MapmyIndiaAccountManager.setAtlasClientId("ATLAS CLIENT_ID")
MapmyIndiaAccountManager.setAtlasClientSecret("ATLAS CLIENT_SECRET")
MapmyIndiaAccountManager.setAtlasGrantType("GRANT_TYPE") //always put client_credentials
MapmyIndiaAccountManager.setAtlasAPIVersion("1.3.11") // Optional; deprecated

```

For usage of SDK go to [here](https://github.com/MapmyIndia/mapmyindia-maps-rasterSDK-ios-sample-withREST/wiki)



For any queries and support, please contact:

  

![Email](https://www.google.com/a/cpanel/mapmyindia.co.in/images/logo.gif?service=google_gsuite)

Email us at [apisupport@mapmyindia.com](mailto:apisupport@mapmyindia.com)

  

![](https://www.mapmyindia.com/api/img/icons/stack-overflow.png)

[Stack Overflow](https://stackoverflow.com/questions/tagged/mapmyindia-api)

Ask a question under the mapmyindia-api

  

![](https://www.mapmyindia.com/api/img/icons/support.png)

[Support](https://www.mapmyindia.com/api/index.php#f_cont)

Need support? contact us!

  

![](https://www.mapmyindia.com/api/img/icons/blog.png)

[Blog](http://www.mapmyindia.com/blog/)

Read about the latest updates & customer stories

  

  

> _© Copyright 2019. CE Info Systems Pvt. Ltd. All Rights Reserved. |_ [_Terms & Conditions_](http://www.mapmyindia.com/api/terms-&-conditions)

> _mapbox-gl-native copyright (c) 2014-2019 Mapbox._
