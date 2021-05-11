import 'package:flutter/material.dart';
import 'package:draw_graph/models/feature.dart';

class LineGraphPainter extends CustomPainter {
  final List<Feature>? features;
  final List<String>? labelX;
  final List<String>? labelY;
  final String? fontFamily;
  final Color graphColor;
  final double graphOpacity;

  LineGraphPainter({
    required this.features,
    required this.labelX,
    required this.labelY,
    required this.fontFamily,
    required this.graphColor,
    required this.graphOpacity,
  });

  @override
  void paint(Canvas canvas, Size size) {
    double _offsetX = 1;
    for (int i = 0; i < labelY!.length; i++) {
      if (labelY![i].length > _offsetX) {
        _offsetX = labelY![i].length.toDouble();
      }
    }

    _offsetX *= 7;
    _offsetX += 2 * size.width / 20;
    Size margin = Size(_offsetX, size.height / 8);
    Size graph = Size(
      size.width - 2 * margin.width,
      size.height - 2 * margin.height,
    );
    Size cell = Size(
      graph.width / (labelX!.length - 1),
      graph.height / labelY!.length,
    );

    drawAxis(canvas, graph, margin);
    drawLabelsY(canvas, size, margin, graph, cell);
    drawLabelsX(canvas, margin, graph, cell);

    for (int i = 0; i < features!.length; i++) {
      drawGraph(
        features![i],
        canvas,
        graph,
        cell,
        margin,
      );
    }
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) {
    return true;
  }

  void drawAxis(Canvas canvas, Size graph, Size margin) {
    Paint linePaint = Paint()
      ..color = graphColor
      ..strokeWidth = 1;

    Offset xEnd =
        Offset(graph.width + 2 * margin.width, graph.height + margin.height);
    Offset yStart = Offset(margin.width, 0);

    //X-Axis & Y-Axis
    canvas.drawLine(
        Offset(margin.width, graph.height + margin.height), xEnd, linePaint);
    canvas.drawLine(
        yStart, Offset(margin.width, graph.height + margin.height), linePaint);

    //Arrow heads
    canvas.drawLine(xEnd, Offset(xEnd.dx - 5, xEnd.dy - 5), linePaint);
    canvas.drawLine(xEnd, Offset(xEnd.dx - 5, xEnd.dy + 5), linePaint);
    canvas.drawLine(yStart, Offset(yStart.dx - 5, yStart.dy + 5), linePaint);
    canvas.drawLine(yStart, Offset(yStart.dx + 5, yStart.dy + 5), linePaint);
  }

  void drawLabelsY(
      Canvas canvas, Size size, Size margin, Size graph, Size cell) {
    for (int i = 0; i < labelY!.length; i++) {
      TextSpan span = new TextSpan(
        style: new TextStyle(
          color: graphColor,
          fontFamily: fontFamily,
        ),
        text: labelY![i],
      );
      TextPainter tp = new TextPainter(
        text: span,
        textAlign: TextAlign.left,
        textDirection: TextDirection.ltr,
      );
      tp.layout();
      tp.paint(
        canvas,
        new Offset(
          size.width / 20,
          margin.height + graph.height - 8 - (i + 1) * cell.height,
        ),
      );
    }
  }

  void drawLabelsX(Canvas canvas, Size margin, Size graph, Size cell) {
    for (int i = 0; i < labelX!.length; i++) {
      TextSpan span = new TextSpan(
        style: new TextStyle(
          color: graphColor,
          fontFamily: fontFamily,
        ),
        text: labelX![i],
      );
      TextPainter tp = new TextPainter(
          text: span,
          textAlign: TextAlign.left,
          textDirection: TextDirection.ltr);
      tp.layout();
      tp.paint(
        canvas,
        new Offset(
          margin.width + cell.width * i - 16,
          margin.height + graph.height + 10,
        ),
      );
    }
  }

  void drawGraph(
      Feature feature, Canvas canvas, Size graph, Size cell, Size margin) {
    Paint fillPaint = Paint()
      ..color = feature.color.withOpacity(graphOpacity)
      ..style = PaintingStyle.fill;
    Paint strokePaint = Paint()
      ..color = feature.color
      ..strokeWidth = 2
      ..style = PaintingStyle.stroke;

    Path path = Path();
    Path linePath = Path();
    path.moveTo(margin.width, graph.height + margin.height);
    path.lineTo(
      margin.width,
      margin.height + graph.height - feature.data[0] * graph.height,
    );
    linePath.moveTo(
      margin.width,
      margin.height + graph.height - feature.data[0] * graph.height,
    );
    int i = 0;
    for (i = 1; i < labelX!.length && i < feature.data.length; i++) {
      if (feature.data[i] > 1) {
        feature.data[i] = 1;
      }
      if (feature.data[i] < 0) {
        feature.data[i] = 0;
      }
      path.lineTo(
        margin.width + i * cell.width,
        margin.height + graph.height - feature.data[i] * graph.height,
      );
      linePath.lineTo(
        margin.width + i * cell.width,
        margin.height + graph.height - feature.data[i] * graph.height,
      );
    }
    // path.lineTo(
    //     margin.width + (feature.data.length - 1) * cell.width, margin.height);
    path.lineTo(
      margin.width + cell.width * (i - 1),
      margin.height + graph.height,
    );
    canvas.drawPath(path, fillPaint);
    canvas.drawPath(linePath, strokePaint);
  }
}
