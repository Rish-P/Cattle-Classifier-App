# Rishabh_Cattle-Classifier_FrontiersMarket

## About app
This is a Flutter app, implemented with User authentication using Firebase Auth. A user can sign-in and see for themselves what kind of cattle is there in the image they upload. Based on the dataset I have used, there are 5 cattle classes, namely:
#### Arynshire Cattle, Jersey Cattle, Red Dane Cattle, Holstein Friesian Cattle, Brown Swiss Cattle

The user can upload an image from the gallery, which then the pre-loaded TFLite MobileNet model will predict based on the cattle data it's been trained on. 

### How to run app
Run the shell command below to start off
```
./install.sh
```

I would recommend just running the doctor command to see if everything is okay with the flutter environment (optional)
```
flutter doctor -v
```

Then go ahead and clean all previous builds, and download all the flutter dependencies with:-
```
flutter clean
flutter pub get
```

Now you can run the app!
```
flutter run
```





