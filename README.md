Github URL :  
https://github.com/sowmyasantoshi4/cpa-assign.git

**SetUp - Installation - Run : **
1.	Download and installation of Flutter in windows by following steps : 
  -	Goto : https://docs.flutter.dev/get-started/install/windows and download the .zip
  -	Extract into a folder
  -	Set path in environment variables like : D:flutter_path
  -	Goto command prompt and give the following commands : 
    o	where flutter dart  		// shows where the flutter path
    o	flutter doctor  		// check everything is OK or not
    o	flutter doctor --android-licenses
2.	After successful installation, create flutter project by using the following command in command prompt :
      flutter create app_name
3.	In command prompt, move to the newly created app folder. 
4.	Now, open the pubspec.yaml (inside the new folder created) using any editor and add the required dependencies : 
      dependencies:
        flutter:
          sdk: flutter
          parse_server_sdk: any
5.	In the command prompt, run the following command to get the dependencies into the project : 
      flutter pub get
6.	After the dependencies, add the code to your main.dart file (this is the entry point); present inside the lib folder.
7.	After done adding the code, goto command prompt and run the following command to check the output : 
      flutter devices  			// gives all the possible ways to check output like browsers, mobile if connected with developer options enabled
 
8.	Run the application to check the output using the following command : 
      flutter run 			// when you type this and enter, you are provided with the list of options asking to choose the device to run.. I chose edge browser once, and mobile once.. when you choose mobile, it   generates .apk file and installs in your mobile. You can run and check it. If you install emulator, it is also listed in the devices and you can check the output in it as well.
 
9.	Enter the option you wish to. 
10.	Check the mobile for app installed and view it.

11.	Check the browser opened automatically showing the output.
 
**Brief overview of bonus features implemented: **
-	Added Clear button to clear the data
-	Added validation before submitting the empty data.
-	Added multiline for description
-	Added icons for the Add and Clear buttons
-	Added CSS for the task list items and details of the task
-	Showed limited text for the description in the task list items when exceeded more than 30 chars and displayed whole text in details
-	Dynamic text change on button from Add to Update and Update to Add, according to the mode of operation along with background colour.
-	Made containers scrollable if the height is exceeding.
