import 'package:flutter/material.dart';
import 'package:superhero_beta/widgets/flipable_card.dart';
import 'package:superhero_beta/providers/providers.dart';
import 'package:provider/provider.dart';

class DetailsScreen extends StatelessWidget {
  const DetailsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    String? selectedItem =
        Provider.of<SelectedValueNotifier>(context).selectedValue;

    return Scaffold(
      appBar: AppBar(
        title: Text(selectedItem ??
            'Default Value'), // Aquí usamos el valor seleccionado como título.
      ),
      body: Center(
        child: CustomFlipCard(),
      ),
    );
  }
}
