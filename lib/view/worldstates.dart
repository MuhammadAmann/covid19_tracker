import 'package:covid19_tracker/Models/WorldstateModel.dart';
import 'package:covid19_tracker/Services/statesservices.dart';
import 'package:covid19_tracker/view/countriesList.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:pie_chart/pie_chart.dart';

class World_States extends StatefulWidget {
  const World_States({super.key});

  @override
  State<World_States> createState() => _World_StatesState();
}

class _World_StatesState extends State<World_States>
    with TickerProviderStateMixin {
  late final AnimationController _controller =
      AnimationController(duration: Duration(seconds: 3), vsync: this)
        ..repeat();
  @override
  final colorlist = <Color>[
    const Color(0xff4285f4),
    const Color(0xff1aa260),
    const Color(0xffde5246),
  ];
  Widget build(BuildContext context) {
    StatesServices statesServices = StatesServices();
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.only(top: 14, left: 10, right: 10),
          child: SingleChildScrollView(
            child: Column(children: [
              SizedBox(height: MediaQuery.of(context).size.height * .01),
              FutureBuilder(
                future: statesServices.getworldstates(),
                builder: (context, AsyncSnapshot<WorldStates> snapshot) {
                  if (!snapshot.hasData) {
                    return Center(
                        child: SpinKitFadingCircle(
                      controller: _controller,
                      color: Colors.white,
                      size: 50,
                    ));
                  } else {
                    return Column(
                      children: [
                        PieChart(
                          dataMap: {
                            "Total":
                                double.parse(snapshot.data!.cases.toString()),
                            "Recovered": double.parse(
                                snapshot.data!.recovered.toString()),
                            "Deaths":
                                double.parse(snapshot.data!.deaths.toString()),
                          },
                          chartRadius: MediaQuery.of(context).size.width / 3.2,
                          colorList: colorlist,
                          chartType: ChartType.ring,
                          chartValuesOptions: ChartValuesOptions(
                              showChartValuesInPercentage: true),
                          legendOptions: LegendOptions(
                              legendPosition: LegendPosition.left),
                        ),
                        SizedBox(
                            height: MediaQuery.of(context).size.height * .04),
                        // //Card
                        Card(
                          child: Padding(
                            padding: const EdgeInsets.all(10),
                            child: Column(
                              children: [
                                Reuseablerow(
                                    title: 'Cases',
                                    value: snapshot.data!.cases.toString()),
                                Reuseablerow(
                                    title: 'Recovered',
                                    value: snapshot.data!.recovered.toString()),
                                Reuseablerow(
                                    title: 'Deaths',
                                    value: snapshot.data!.deaths.toString()),
                                Reuseablerow(
                                    title: 'Active',
                                    value: snapshot.data!.active.toString()),
                                Reuseablerow(
                                    title: 'Tests',
                                    value: snapshot.data!.tests.toString()),
                              ],
                            ),
                          ),
                        ),
                        SizedBox(
                            height: MediaQuery.of(context).size.height * .04),
                        GestureDetector(
                          onTap: () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => CountriesList(),
                                ));
                          },
                          child: Container(
                            height: 50,
                            decoration: BoxDecoration(
                                color: Color(0xff1aa260),
                                borderRadius: BorderRadius.circular(10)),
                            child: Center(child: Text("Track Countries")),
                          ),
                        )
                      ],
                    );
                  }
                },
              )
            ]),
          ),
        ),
      ),
    );
  }
}

class Reuseablerow extends StatelessWidget {
  String title, value;
  Reuseablerow({required this.title, required this.value});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.all(12),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [Text(title), Text(value)],
          ),
        ),
        Divider(),
      ],
    );
  }
}
