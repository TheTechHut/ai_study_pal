# summarize_app

This app aims to solve the problem of reading through long articles

## Getting Started

##App Architecture 
The Architecture used is MVVM architecture with Serverless.

## Contribution Guide 

 - **Clone the repo (Do this by pasting this line on your terminal** `https://github.com/STARKthegreat/finlit_app` )
 - **Run `flutter pub get` in your terminal**
 - **Change your branch to the one you want to work with**
 - **Make your Changes**
 - **Commit your changes following** [Conventional Commits](https://www.conventionalcommits.org/en/v1.0.0/)
 - **Push your branch**
 - **Make your Pull Request to the dev branch and add a reviewer to merge your Pull Request**
### Style Guide 
  
  > Private classes was create to handle these styles and these classes have all their members and fields as static so they can be access.
  > You can find these classes in `lib/const/` for the styles


#### Textstyle

 -  Check the  `app_textstyle.dart` for more info.
 
 #### Color
 
 -  Check the  `app_color.dart` for more info.
 
 
  #### Dimension
 
 - This contains dimensions of numbers following a squence. This dimension class can be used for spacing, padding, margin, sizes or any place at all you want to use dimensions.Check the  `app_dimensions.dart` for more info.
 
 
  #### Spacing
 
 - This is a StatelessWidget that has property fields of height and width. It also has muiltple constructors which can be used for spacing when needed e.g `Spacing.smallHeight()` .Check the  `spacing.dart` for more info.
 
 # NB: 
## Never push your changes directly to the main or dev branch. 
## The pull request should be made to the dev branch
## The changes will then be merged with the dev branch after review
## The main brach contains production code.

