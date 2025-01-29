import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';

class LineChartGraph extends StatelessWidget {
  const LineChartGraph({super.key});

  @override
  Widget build(BuildContext context) {
    //I change it into a SizedBox to make it fit the screen and give it just a normal display
    return SizedBox(
      height: 200,
      child: Padding(
        padding: const EdgeInsets.all(12),
        child: LineChart(mainData()),
      ),
    );
  }

  LineChartData mainData() {
    return LineChartData(
      gridData: FlGridData(
        show: false,
      ),
      titlesData: FlTitlesData(
        show: true,
        bottomTitles: AxisTitles(
          sideTitles: SideTitles(
            showTitles: true,
            reservedSize: 22,
            getTitlesWidget: bottomTitleWidgets,
            interval: 1,
          ),
        ),
        leftTitles: const AxisTitles(
          sideTitles: SideTitles(showTitles: false),
        ),
        topTitles: const AxisTitles(
          sideTitles: SideTitles(showTitles: false),
        ),
        rightTitles: const AxisTitles(
          sideTitles: SideTitles(showTitles: false),
        ),
      ),
      borderData: FlBorderData(
        show: true,
        border: Border.all(color: Colors.grey.shade300),
      ),
      minX: 0,
      maxX: 6,
      minY: 0,
      maxY: 10,
      lineBarsData: [
        LineChartBarData(
          spots: const [
            FlSpot(0, 2),
            FlSpot(1, 3),
            FlSpot(2, 5),
            FlSpot(3, 6),
            FlSpot(4, 7),
            FlSpot(5, 9),
            FlSpot(6, 10),
          ],
          isCurved: true,
          color: Colors.lightBlue.shade300,
          barWidth: 3,
          isStrokeCapRound: true,
          dotData: const FlDotData(show: false),
          belowBarData: BarAreaData(
            show: true,
            color: Colors.lightBlue.shade100.withAlpha(128),
          ),
        ),
      ],
    );
  }

  Widget bottomTitleWidgets(double value, TitleMeta meta) {
    const style = TextStyle(
      fontSize: 12,
      fontWeight: FontWeight.w500,
      color: Colors.grey,
    );
    Widget text;
    switch (value.toInt()) {
      //Added everything
      case 0:
        text = const Text('Jan', style: style);
        break;
      case 1:
        text = const Text('Feb', style: style);
        break;
      case 2:
        text = const Text('Mar', style: style);
        break;
      case 3:
        text = const Text('Apr', style: style);
        break;
      case 4:
        text = const Text('May', style: style);
        break;
      case 5:
        text = const Text('Jun', style: style);
        break;
      case 6:
        text = const Text('Jul', style: style);
        break;
      case 7:
      default:
        text = const Text('', style: style);
        break;
    }

    return SideTitleWidget(
      space: 8.0,
      child: text,
      meta: meta,
    );
  }
}
