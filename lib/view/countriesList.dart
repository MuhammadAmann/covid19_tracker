import 'package:covid19_tracker/Models/WorldstateModel.dart';
import 'package:covid19_tracker/Services/statesservices.dart';
import 'package:covid19_tracker/view/countrydetail.dart';
import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';

class CountriesList extends StatefulWidget {
  const CountriesList({super.key});

  @override
  State<CountriesList> createState() => _CountriesListState();
}

class _CountriesListState extends State<CountriesList> {
  TextEditingController searchcontroller = TextEditingController();
  @override
  StatesServices statesServices = StatesServices();
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(title: Text("Countries"), centerTitle: true),
        body: Padding(
          padding: const EdgeInsets.all(10),
          child: Column(
            children: [
              TextFormField(
                controller: searchcontroller,
                onChanged: (value) {
                  setState(() {});
                },
                decoration: InputDecoration(
                  suffixIcon: IconButton(
                      onPressed: () {
                        searchcontroller.clear();
                      },
                      icon: Icon(Icons.clear)),
                  contentPadding: EdgeInsets.all(20),
                  hintText: "Search countries here",
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(50),
                  ),
                  prefixIcon: Padding(
                    padding: const EdgeInsets.only(left: 6),
                    child: Icon(Icons.search),
                  ),
                  focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(50),
                      borderSide: BorderSide(color: Colors.grey)),
                  prefixIconColor: Colors.grey,
                ),
              ),
              Expanded(
                child: FutureBuilder(
                  future: statesServices.getworldList(),
                  builder: (context, AsyncSnapshot<List<dynamic>> snapshot) {
                    if (!snapshot.hasData) {
                      return ListView.builder(
                        itemCount: 7,
                        itemBuilder: (context, index) {
                          return Shimmer.fromColors(
                            baseColor: Colors.grey,
                            highlightColor: Colors.white,
                            child: ListTile(
                              leading: Container(
                                height: 50,
                                width: 50,
                                color: Colors.white,
                              ),
                              title: Container(
                                height: 20,
                                width: 90,
                                color: Colors.white,
                              ),
                              subtitle: Container(
                                height: 10,
                                width: 90,
                                color: Colors.white,
                              ),
                            ),
                          );
                        },
                      );
                    } else {
                      return ListView.builder(
                        itemCount: snapshot.data!.length,
                        itemBuilder: (context, index) {
                          String name = snapshot.data![index]['country'];
                          if (searchcontroller.text.isEmpty) {
                            return InkWell(
                              onTap: () {
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) => CountryDetails(
                                              name: snapshot.data![index]
                                                  ['country'],
                                              image: snapshot.data![index]
                                                  ['countryInfo']['flag'],
                                              totalcases: snapshot.data![index]
                                                  ['cases'],
                                              totaldeaths: snapshot.data![index]
                                                  ['deaths'],
                                              totalRecovered: snapshot
                                                  .data![index]['recovered'],
                                              active: snapshot.data![index]
                                                  ['active'],
                                              critical: snapshot.data![index]
                                                  ['critical'],
                                              todayRecovered:
                                                  snapshot.data![index]
                                                      ['todayRecovered'],
                                              test: snapshot.data![index]
                                                  ['tests'],
                                            )));
                              },
                              child: ListTile(
                                leading: Image(
                                    height: 50,
                                    width: 50,
                                    image: NetworkImage(snapshot.data![index]
                                        ['countryInfo']['flag'])),
                                title: Text(snapshot.data![index]['country']),
                                subtitle: Text("Active Cases : " +
                                    snapshot.data![index]['active'].toString()),
                              ),
                            );
                          } else if (name
                              .toLowerCase()
                              .contains(searchcontroller.text.toString())) {
                            return InkWell(
                              onTap: () {
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) => CountryDetails(
                                        name: snapshot.data![index]['country'],
                                        image: snapshot.data![index]
                                            ['countryInfo']['flag'],
                                        totalcases: snapshot.data![index]
                                            ['cases'],
                                        totaldeaths: snapshot.data![index]
                                            ['deaths'],
                                        totalRecovered: snapshot.data![index]
                                            ['recovered'],
                                        active: snapshot.data![index]['active'],
                                        critical: snapshot.data![index]
                                            ['critical'],
                                        todayRecovered: snapshot.data![index]
                                            ['todayRecovered'],
                                        test: snapshot.data![index]['tests'],
                                      ),
                                    ));
                              },
                              child: ListTile(
                                leading: Image(
                                    height: 50,
                                    width: 50,
                                    image: NetworkImage(snapshot.data![index]
                                        ['countryInfo']['flag'])),
                                title: Text(snapshot.data![index]['country']),
                                subtitle: Text("Active Cases : " +
                                    snapshot.data![index]['active'].toString()),
                              ),
                            );
                          } else {
                            return Container();
                          }
                        },
                      );
                    }
                  },
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
