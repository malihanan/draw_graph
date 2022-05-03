library draw_graph;

import 'package:flutter/material.dart';
import 'package:draw_graph/models/feature.dart';
import 'package:draw_graph/widgets/linegraph.dart';

class LineGraph extends StatefulWidget {
  final bool isShowGraphLine;
  final Size size;
  final List<String>? labelX;
  final List<String>? labelY;
  final List<int> list;

  final int labelYGap;
  final String? fontFamily;
  final Color graphColor;
  final Color backgroundColor;
  final bool showDescription;
  final double graphOpacity;
  final bool verticalFeatureDirection;
  final double descriptionHeight;

  const LineGraph({
    required Key key,
    required this.isShowGraphLine,
    required this.size,
    this.labelX,
    required this.list,
    this.labelY,
    required this.labelYGap,
    this.fontFamily,
    this.backgroundColor = Colors.grey,
    this.graphColor = Colors.grey,
    this.showDescription = false,
    this.graphOpacity = 0.3,
    this.verticalFeatureDirection = false,
    this.descriptionHeight = 80,
  }) : super(key: key);

  @override
  _LineGraphState createState() => _LineGraphState();
}

class _LineGraphState extends State<LineGraph> {
  bool tapped = false;

  @override
  Widget build(BuildContext context) {
    setState(() {
      if (!tapped) {}
    });
    return Container(
      color: widget.backgroundColor,
      height: widget.size.height,
      width: widget.size.width,
      child: widget.showDescription
          ? widget.verticalFeatureDirection
              ? Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    getGraph(Size(widget.size.width,
                        widget.size.height - widget.descriptionHeight - 40)),
                    const SizedBox(height: 40),
                    SizedBox(
                      height: widget.descriptionHeight,
                      child: getFeatures(),
                    )
                  ],
                )
              : Column(
                  children: <Widget>[
                    getGraph(Size(widget.size.width, widget.size.height - 70)),
                    const SizedBox(height: 40),
                    SizedBox(
                      height: 28,
                      child: getFeatures(),
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
        isShowGraphLine: widget.isShowGraphLine,
        labelX: widget.labelX ?? [],
        labelY: widget.labelY ?? [],
        labelYGab: widget.labelYGap,
        fontFamily: widget.fontFamily ?? '',
        graphColor: widget.graphColor,
        graphOpacity: widget.graphOpacity,
        list: widget.list,
      ),
    );
  }

  Widget getFeatures() {
    List<Widget> featureDescriptions = [];

    return ListView(
      scrollDirection:
          widget.verticalFeatureDirection ? Axis.vertical : Axis.horizontal,
      children: featureDescriptions,
    );
  }

  Widget getDescription(Feature feature) {
    return Padding(
      padding: widget.verticalFeatureDirection
          ? const EdgeInsets.only(left: 0, right: 0, bottom: 10, top: 10)
          : const EdgeInsets.only(left: 20, right: 40, bottom: 0, top: 0),
      child: GestureDetector(
        child: Row(
          mainAxisSize: MainAxisSize.max,
          children: [
            Container(
              height: 24,
              width: 24,
              decoration: BoxDecoration(
                border: Border.all(color: feature.color, width: 1.5),
                color: feature.color.withOpacity(widget.graphOpacity),
              ),
            ),
            const SizedBox(width: 20),
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
