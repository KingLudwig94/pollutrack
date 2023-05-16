import 'package:flutter/material.dart';
import 'package:graphic/graphic.dart';

class CustomPlot extends StatelessWidget {
  const CustomPlot({
    Key? key,
    required this.data,
  }) : super(key: key);
  final List<Map<String, dynamic>> data;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 360,
      height: 250,
      child: Chart(
        rebuild: true,
        data: data,
        variables: {
          'date': Variable(
            accessor: (Map map) => map['date'] as String,
            scale: OrdinalScale(tickCount: 5),
          ),
          'points': Variable(
            accessor: (Map map) => map['points'] as num,
          ),
        },
        elements: <GeomElement<Shape>>[
          LineElement(
            position: Varset('date') * Varset('points'),
            shape: ShapeAttr(value: BasicLineShape(smooth: true)),
            size: SizeAttr(value: 2),
            color: ColorAttr(value: const Color(0xFF83AA99)),
          )
        ],
        axes: [
          Defaults.horizontalAxis,
          Defaults.verticalAxis,
        ],
        selections: {'tap': PointSelection(dim: Dim.x)},
        tooltip: TooltipGuide(),
        crosshair: CrosshairGuide(),
      ),
    );
  }
}
