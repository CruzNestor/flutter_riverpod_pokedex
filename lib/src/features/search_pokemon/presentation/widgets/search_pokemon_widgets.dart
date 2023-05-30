part of '../pages/search_pokemon_page.dart';

Widget buildPokemonImage(BuildContext context, SearchedPokemon data, {void Function()? onTap}) {
  return SizedBox(
    height: MediaQuery.of(context).size.height - 100,
    width: MediaQuery.of(context).size.width,
    child: Column(children: [
      SizedBox(
        width: 220,
        child: Card(
          margin: const EdgeInsets.only(top: 20.0),
          elevation: 0,
          clipBehavior: Clip.hardEdge,
          color: Theme.of(context).colorScheme.surfaceVariant.withOpacity(0.5),
          child: InkWell(
            onTap: () async {
              await Future.delayed(const Duration(milliseconds: 200));
              onTap!.call();
            },
            child: Column(children: [
              Container(
                padding: const EdgeInsets.only(top: 10.0, right: 10.0),
                alignment: Alignment.topRight,
                child: Text('#${data.id}'.toUpperCase(), 
                  style: const TextStyle(fontSize: 18.0)
                )
              ),
              SizedBox(
                height: 200,
                child: FadeInImage.memoryNetwork(
                  image: '${HTTPClientConstants.POKEMON_ARTWORK}${data.id}.png',
                  placeholder: kTransparentImage,
                  imageErrorBuilder: (BuildContext context, Object exception, StackTrace? stackTrace) {
                    return Container(
                      alignment: Alignment.center,
                      child: const Text('Image Not Found', style: TextStyle(fontSize: 10))
                    );
                  }
                )
              ),
              Padding(
                padding: const EdgeInsets.only(top: 5.0, right: 10.0, bottom: 10.0, left: 10.0),
                child: Text(data.name.toUpperCase(), 
                  style: const TextStyle(fontSize: 16.0, fontWeight: FontWeight.bold)
                )
              )
            ])
          )
        )
      )
    ])
  );
}

Widget messageWidget({required Widget child}){
  return SizedBox(
    child: Center(
      child: child
    )
  );
}