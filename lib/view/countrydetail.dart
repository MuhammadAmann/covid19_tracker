import 'package:covid19_tracker/view/worldstates.dart';
import 'package:flutter/material.dart';

class CountryDetails extends StatefulWidget {
  String name, image;

  int totalcases,
      totaldeaths,
      totalRecovered,
      active,
      critical,
      todayRecovered,
      test;
  CountryDetails(
      {required this.name,
      required this.image,
      required this.totalcases,
      required this.totaldeaths,
      required this.totalRecovered,
      required this.active,
      required this.critical,
      required this.todayRecovered,
      required this.test});

  @override
  State<CountryDetails> createState() => _CountryDetailsState();
}

class _CountryDetailsState extends State<CountryDetails> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.name),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Stack(
              alignment: Alignment.topCenter,
              children: [
                Padding(
                  padding: EdgeInsets.only(
                      top: MediaQuery.of(context).size.height * .09),
                  child: Card(
                    child: Column(
                      children: [
                        SizedBox(
                            height: MediaQuery.of(context).size.height * .06),
                        Reuseablerow(
                            title: 'Cases',
                            value: widget.totalcases.toString()),
                        Reuseablerow(
                            title: 'Total Recovered',
                            value: widget.totalRecovered.toString()),
                        Reuseablerow(
                            title: 'Total Deaths',
                            value: widget.totaldeaths.toString()),
                        Reuseablerow(
                            title: 'Critical',
                            value: widget.critical.toString()),
                        Reuseablerow(
                            title: 'Today Recovered',
                            value: widget.todayRecovered.toString()),
                      ],
                    ),
                  ),
                ),
                CircleAvatar(
                  radius: 50,
                  backgroundImage: NetworkImage(widget.image),
                )
              ],
            )
          ],
        ),
      ),
    );
  }
}
