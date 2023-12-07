import 'package:flip_card/flip_card.dart';
import 'package:flutter/material.dart' as Flutter;
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:superhero_beta/providers/providers.dart';

import '../models/models.dart';

class CustomFlipCard extends StatefulWidget {
  final String name;
  

  const CustomFlipCard(this.name, {Key? key}) : super(key: key);

  @override
  State<CustomFlipCard> createState() => _CustomFlipCardState();
}

class _CustomFlipCardState extends State<CustomFlipCard> {
  List<Result>? superheros;
  String? imageUrl;

  @override
  void initState() {
    super.initState();
    final superherosProvider = Provider.of<SuperherosProvider>(context, listen: false);
    superherosProvider.getOnCharacters(widget.name).then((_) {
      setState(() {
        superheros = superherosProvider.character;
        print(superheros);
        imageUrl= superheros![0].image.url;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
   
    
    return Card(
      elevation: 0.0,
      margin: EdgeInsets.all(32.0),
      color: Color(0x00000000),
      child: FlipCard(
        direction: FlipDirection.HORIZONTAL,
        side: CardSide.FRONT,
        speed: 1000,
        onFlipDone: (status) {
          print(status);
        },
        front: Container(
          decoration: BoxDecoration(
            color: Colors.transparent,
            borderRadius: BorderRadius.all(Radius.circular(8.0)),
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              if (imageUrl != null)
                Flutter.Image.network(
                  imageUrl!, // Use the updated variable
                   // Adjust the width as needed
                  fit: BoxFit.fill,
                ),
              Text('Para Ver infromacion detallada tocar la card',
                  style: Theme.of(context).textTheme.bodyText1),
            ],
          ),
        ),
       back: Container(
  decoration: BoxDecoration(
    color: Colors.blueGrey,
    borderRadius: BorderRadius.all(Radius.circular(8.0)),
  ),
  child: Column(
    mainAxisAlignment: MainAxisAlignment.center,
    children: <Widget>[
    
      if (superheros != null) ...[
        Text('Biography',
          style: Theme.of(context).textTheme.titleMedium),
        Text('Fullname : ${superheros![0].biography.fullName}',
          style: Theme.of(context).textTheme.bodyLarge),
          Text('Alignament: ${superheros![0].biography.alignment}',
          style: Theme.of(context).textTheme.bodyLarge),
          Text('alterEgos : ${superheros![0].biography.alterEgos}',
          style: Theme.of(context).textTheme.bodyLarge),
          Text('firstAppearance : ${superheros![0].biography.firstAppearance}',
          style: Theme.of(context).textTheme.bodyLarge),
          Text('placeOfBirth: ${superheros![0].biography.placeOfBirth}',
          style: Theme.of(context).textTheme.bodyLarge),
          Text('publisher: ${superheros![0].biography.publisher}',
          style: Theme.of(context).textTheme.bodyLarge),
          Container(height: 10,),
          Text('PowerStats',
          style: Theme.of(context).textTheme.titleMedium),
        Text('Combat : ${superheros![0].powerstats.combat}',
          style: Theme.of(context).textTheme.bodyLarge),
        Text('Durability : ${superheros![0].powerstats.durability}',
          style: Theme.of(context).textTheme.bodyLarge),
          Text('Intelligence : ${superheros![0].powerstats.intelligence}',
          style: Theme.of(context).textTheme.bodyLarge),
          Text('Power : ${superheros![0].powerstats.power}',
          style: Theme.of(context).textTheme.bodyLarge),
          Text('Speed : ${superheros![0].powerstats.speed}',
          style: Theme.of(context).textTheme.bodyLarge),
          Text('Strenght : ${superheros![0].powerstats.strength}',
          style: Theme.of(context).textTheme.bodyLarge),
          Container(height: 10,),
          Text('Work',
          style: Theme.of(context).textTheme.titleMedium),
        Text('Base: ${superheros![0].work.base}',
          style: Theme.of(context).textTheme.bodyLarge),
          Text('Occupation: ${superheros![0].work.occupation}',
          style: Theme.of(context).textTheme.bodyLarge),
          Container(height: 10,),
          Text('Connections',
          style: Theme.of(context).textTheme.titleMedium),
        Text('groupAffiliation: ${superheros![0].connections.groupAffiliation}',
          style: Theme.of(context).textTheme.bodyLarge),
          Container(height: 10,),
          Text('relatives: ${superheros![0].connections.relatives}',
          style: Theme.of(context).textTheme.bodyLarge),
      ],
      Container(height: 10,),
        Text('Tocar Para Volver a la imagen',
        style: Theme.of(context).textTheme.bodyLarge),
    ],
  ),
),

      ),
    );
  }

  
}



