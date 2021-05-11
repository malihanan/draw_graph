# Draw Graph

A dart package to draw line graphs in your flutter app.

<p align="center">
  <img src="https://user-images.githubusercontent.com/50942732/117781784-9caa2b80-b25e-11eb-9ede-de11542bd017.jpg" width="200" title="Graph">
  <img src="https://user-images.githubusercontent.com/50942732/117782154-fa3e7800-b25e-11eb-96da-4f6d53f1a08f.jpg" width="200" title="On Tapped">
</p>

## Usage

* Getting graph widget:
  ### LineGraph Widget
  #### Properties
  * features: [List](https://api.flutter.dev/flutter/dart-core/List-class.html)<feature>
    
    A list of features to be shown in the graph. Detailed description of Feature class below.
    (required)
  * size: [Size](https://api.flutter.dev/flutter/dart-ui/Size-class.html)
    
    This will determine the size of your graph. Height will be size.height - 50 in case when description is showed.
    (required)
  * labelX: [List](https://api.flutter.dev/flutter/dart-core/List-class.html)<[String](https://api.flutter.dev/flutter/dart-core/String-class.html)>
  
    A list of X-Axis Labels. This will determine and number of cells to distribute your data in and the width of your cells.
  * labelY: [List](https://api.flutter.dev/flutter/dart-core/List-class.html)<[String](https://api.flutter.dev/flutter/dart-core/String-class.html)>
  
    A list of Y-Axis Labels. The labels will be distributed on Y-Axis and determine height on cells.
  * fontFamily: [String](https://api.flutter.dev/flutter/dart-core/String-class.html)
  
    The fontFamily to use for labels and description of features.
  * graphColor: [Color](https://api.flutter.dev/flutter/dart-ui/Color-class.html)
  
    The color of your axis and labels.
  * showDescription: [bool](https://api.flutter.dev/flutter/dart-core/bool-class.html)
    
    Whether to show description at the end of graph.
  * graphOpacity: [double](https://api.flutter.dev/flutter/dart-core/double-class.html)
    
    The opacity of the area under graph.
  * verticalFeatureDirection: [bool](https://api.flutter.dev/flutter/dart-core/bool-class.html)
    
    Whether to scroll description vertically or not.
  * descriptionHeight: [double](https://api.flutter.dev/flutter/dart-core/double-class.html)
    
    If scrolling the description vertically, what should be the height of the description box.
  
  #### Constructor
  ```
  LineGraph({
    @required List<feature> features, 
    @required Size size,
    List<String> labelX: [],
    List<String> labelY: [],
    String fontFamily: 'sans serif',
    Color graphColor: Colors.grey,
    bool showDescription: false,
    double graphOpacity = 0.3,
    bool verticalFeatureDirection = false,
    double descriptionHeight = 80,
  });
  ```

  #### Example
  ```
  LineGraph({
    features: features,
    size: Size(320, 400),
    labelX: ['Day 1', 'Day 2', 'Day 3', 'Day 4', 'Day 5'],
    labelY: ['20%', '40%', '60%', '80%', '100%'],
    showDescription: true,
    graphColor: Colors.white30,
    graphOpacity: 0.2,
    verticalFeatureDirection: true,
    descriptionHeight: 130,
  })
  ```

* Creating a list of Features
  - import the Feature model
  ```import 'package:draw_graph/models/feature.dart';```
  
  ### Feature Model
  #### Properties
  * data: [List](https://api.flutter.dev/flutter/dart-core/List-class.html)<[double](https://api.flutter.dev/flutter/dart-core/double-class.html)>
  
    The Y-Axis values to be plotted. Should be in the range [0-1]. The length of the list should be equal to X-Axis labels.
    (required)
  * title: [String](https://api.flutter.dev/flutter/dart-core/String-class.html)
  
    The title displayed in Feature Description below the graph
  * color: [Color](https://api.flutter.dev/flutter/dart-ui/Color-class.html)
  
    The color of graph for this feature
    
  #### Constructor
  ```
  Feature({
    @required List<double> data,
    String title: '',
    Color color: Colors.black,
  });
  ```
  
  #### Example
  ```
  List<Feature> features = [
    Feature(
      title: "Drink Water",
      color: Colors.blue,
      data: [0.2, 0.8, 1, 0.7, 0.6],
    ),
    Feature(
      title: "Exercise",
      color: Colors.pink,
      data: [1, 0.8, 6, 0.7, 0.3, 8],
    ),
  ];
  ```

## Getting Started

See the `example` directory for a sample app using draw_graph.