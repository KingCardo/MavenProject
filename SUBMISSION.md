# Submission

**[Instructions](./INSTRUCTIONS.md) Summary**:
* Apply any number of the suggested Maven practices to the prototype 
* Add new functionality
* Elaborate on your approach in SUBMISSION.md

## Your Response

### Which aspects of the codebase did you choose to work on and why?

// First thing I did was review codebase to make sure I understood everything
//Then started refactoring code base to be programmatic instead of storyboards natively with UIKit
//Got rid of magic numbers and string and placed in extension for readability and maintainability
//Then focused on refactoring each scene to use MVVM

//I started with this route because I think having a good architecture and clean code base is top priority and will improve velocity for future stories while minimizing complexities.
//In Swift 5 JSON parsing is super easy with Codable protocol and will natively do so to avoid adding extra dependencies to project instead of SwiftJson
//Adding basic unit test for view models to make sure behave as expected
//adding local persistence to save posts and prevent expensive network calls for the same data
//adding some extensions to UIKit for easy config of labels and textfields and reduce setup in viewcontrollers
//adding UIActivityIndicator for login screen so user is aware something is happening in case of bad network

### Additional thoughts

//This was fun! Enjoyed every second!
//Major priorities was making code modular so each object could be more testable, and reusable


