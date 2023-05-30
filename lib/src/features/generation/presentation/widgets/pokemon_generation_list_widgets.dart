part of '../pages/pokemon_generation_list_page.dart';


Widget buildPokemonList(BuildContext context, Generation data) {
  var size = MediaQuery.of(context).size;
  final double itemHeight = (size.height - kToolbarHeight - 24) / 3;
  final double itemWidth = size.width / 2;
  return Expanded(
    child: GridView.count(
      crossAxisCount: 3,
      childAspectRatio: (itemWidth / itemHeight),
      padding: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 8.0),
      children: List.generate(data.pokemonSpecies.length, (index) {
        File file = File(data.pokemonSpecies[index]['url']); 
        String pokeId = basename(file.path);
        return itemPokemonList(
          context,
          int.parse(pokeId), 
          data.pokemonSpecies[index]['name'],
          itemHeight,
          itemWidth
        );
      })
    )
  );
}

Widget itemPokemonList(BuildContext context, int id, String name, double height, double width){
  return Card(
    elevation: 0,
    clipBehavior: Clip.hardEdge,
    color: Theme.of(context).colorScheme.surfaceVariant.withOpacity(0.5),
    child: InkWell(
      onTap: () async {
        await Future.delayed(const Duration(milliseconds: 200));
        if(context.mounted) context.push('/pokemon/$id');
      },
      child: AspectRatio(
        aspectRatio: width / height,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: [
            Container(
              alignment: Alignment.topRight,
              height: 30,
              padding: const EdgeInsets.symmetric(horizontal: 5.0, vertical: 4.0),
              child: Text('#$id', style: const TextStyle(fontSize: 12))
            ),
            Expanded(
              child: FadeInImage.memoryNetwork(
                image: '${HTTPClientConstants.POKEMON_ARTWORK}$id.png',
                placeholder: kTransparentImage,
                fit: BoxFit.fill,
                imageErrorBuilder: (BuildContext context, Object exception, StackTrace? stackTrace) {
                  return Container(
                    alignment: Alignment.center,
                    child: const Text('Image Not Found', style: TextStyle(fontSize: 10))
                  );
                }
              )
            ),
            SizedBox(
              height: 30,
              child: Container(
                alignment: Alignment.center,
                child: Text(name.toUpperCase(), 
                  textAlign: TextAlign.start, style: const TextStyle(fontSize: 10, fontWeight: FontWeight.bold)
                )
              )
            )
          ]
        )
      )
    )
  );
}

Widget buildLabelName(String text) {
  TextStyle style = const TextStyle(fontSize: 10, fontWeight: FontWeight.bold);
  return SizedBox(
    width: 88,
    child: Container(
      alignment: Alignment.center,
      child: Text(text.toUpperCase(), textAlign: TextAlign.start, style: style)
    )
  );
}