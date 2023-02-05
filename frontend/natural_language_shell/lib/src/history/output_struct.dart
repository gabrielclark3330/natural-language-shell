import 'package:flutter/material.dart';

class Standard extends StatefulWidget {
  final int index;
  final String query;

  const Standard(this.index, this.query, {super.key});

  @override
  // ignore: no_logic_in_create_state
  State<Standard> createState() => _Standard(index, query);
}

class _Standard extends State<Standard> {
  late Future<String> _data;
  final int index;
  final String query;
  _Standard(this.index, this.query);

  @override
  void initState() {
    super.initState();
    _data = getResponse();
  }

  Future<String> getResponse() async {
    return Future.delayed(const Duration(seconds: 2), () {
      return "I am data";
      // throw Exception("Custom Error");
    });
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(
            horizontal: 0,
            vertical: 4,
          ),
          child: SizedBox(
            height: 20,
            child: Text("> $query"),
          ),
        ),
        Padding(
          padding: const EdgeInsets.symmetric(
            horizontal: 0,
            vertical: 4,
          ),
          child: SizedBox(
            height: 20,
            child: FutureBuilder(
              builder: (BuildContext context, AsyncSnapshot<String> snapshot) {
                if (snapshot.connectionState == ConnectionState.done) {
                  return Text("< ${snapshot.data} $index");
                } else {
                  return Row(
                    children: const [
                      Text("< "),
                      Icon(Icons.timer),
                    ],
                  );
                }
              },
              future: _data,
            ),
          ),
        ),
      ],
    );
  }
}
