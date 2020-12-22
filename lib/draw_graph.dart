library draw_graph;

import 'package:flutter/material.dart';

import 'package:draw_graph/models/feature.dart';
import 'package:draw_graph/widgets/lineGraph.dart';

class LineGraph extends StatefulWidget {
  final List<Feature> features;
  final Size size;
  final List<String> labelX;
  final List<String> labelY;
  final String fontFamily;
  final Color graphColor;
  final bool showDescription;
  final double graphOpacity;

  LineGraph({
    @required this.features,
    @required this.size,
    this.labelX,
    this.labelY,
    this.fontFamily,
    this.graphColor = Colors.grey,
    this.showDescription = false,
    this.graphOpacity,
  });

  @override
  _LineGraphState createState() => _LineGraphState();
}

class _LineGraphState extends State<LineGraph> {
  List<Feature> features;
  bool tapped = false;

  @override
  Widget build(BuildContext context) {
    setState(() {
      if (!tapped) {
        features = widget.features;
      }
    });
    return Container(
      height: widget.size.height,
      width: widget.size.width,
      child: widget.showDescription
          ? Column(
              children: <Widget>[
                getGraph(Size(widget.size.width, widget.size.height - 70)),
                SizedBox(
                  height: 40,
                ),
                Container(
                  height: 28,
                  child: getFeautures(),
                ),
              ],
            )
          : getGraph(widget.size),
    );
  }

  Widget getGraph(Size size) {
    return CustomPaint(
      size: size,
      painter: LineGraphPainter(
        features: features,
        labelX: widget.labelX,
        labelY: widget.labelY,
        fontFamily: widget.fontFamily,
        graphColor: widget.graphColor,
        graphOpacity: widget.graphOpacity,
      ),
    );
  }

  Widget getFeautures() {
    List<Widget> featureDescriptions = [];
    for (int i = 0; i < features.length; i++) {
      featureDescriptions.add(getDescription(features[i]));
    }

    return ListView(
      scrollDirection: Axis.horizontal,
      children: featureDescriptions,
    );
  }

  Widget getDescription(Feature feature) {
    return Padding(
      padding: EdgeInsets.only(left: 20, right: 40, bottom: 0, top: 0),
      child: GestureDetector(
        child: Row(
          mainAxisSize: MainAxisSize.max,
          children: [
            Container(
              height: 24,
              width: 24,
              decoration: BoxDecoration(
                border: Border.all(color: feature.color, width: 1.5),
                color: feature.color.withOpacity(0.3),
              ),
            ),
            SizedBox(width: 20),
            Text(
              feature.title,
              style: TextStyle(
                fontFamily: widget.fontFamily,
              ),
            ),
          ],
        ),
        onTap: () {
          setState(() {
            if (!tapped) {
              features = [feature];
              tapped = true;
            } else {
              tapped = false;
            }
          });
        },
      ),
    );
  }
}
