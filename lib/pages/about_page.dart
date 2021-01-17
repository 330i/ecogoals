import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'counter.dart';

class About extends StatelessWidget {
  final Map<String, dynamic> params;

  const About({Key key, this.params}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          padding: EdgeInsets.all(20),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(20),
            color: Colors.white,
            boxShadow: [
              BoxShadow(
                offset: Offset(0, 4),
                blurRadius: 30,
                color: Color(0xFFB7B7B7).withOpacity(.16),
              ),
            ],
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: <Widget>[
              Counter(
                color: Colors.red,
                number: double.parse(params['weight']),
                title: "Grams of Waste",
              ),
              Counter(
                color: Color(0xFF36C12C),
                number: 70.0,
                title: "Lifespan",
              ),
            ],
          ),
        ),
        SizedBox(
          height: 20,
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(
                horizontal: 10,
              ),
              child: Text(
                " About your Item",
                style: TextStyle(
                    color: Colors.black,
                    fontWeight: FontWeight.bold,
                    fontSize: 18,
                    fontFamily: 'Google'),
              ),
            ),
          ],
        ),
        SizedBox(
          height: 20,
        ),
        Padding(
          padding: const EdgeInsets.symmetric(
            horizontal: 15,
          ),
          child: Text(
            "Your item has a waste value (grams) of " +
                params["weight"] +
                " and has a lifespan of " +
                70.toString() +
                " years. " +
                "Placeholder for more data",
            style: TextStyle(
              color: Colors.black,
              fontFamily: 'Google',
            ),
          ),
        )
      ],
    );
  }
}
