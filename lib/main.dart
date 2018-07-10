import 'package:flutter/material.dart';
import 'package:english_words/english_words.dart';
int main(){
  runApp(new MyApp());
}
class RandomELWords extends StatefulWidget{
  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return new RandomELWordsState();
  }
}
class RandomELWordsState extends State<RandomELWords>{
  final words = <WordPair>[];
  final checkedWords = new Set<WordPair>();
  @override
  Widget build(BuildContext context) {
    // TODO: implement build

    return new Scaffold(
      appBar: AppBar(
        title: new Text("List of English words"),
        actions: <Widget>[
          new IconButton(icon:new Icon(Icons.list), onPressed: pushToSaveWordsScreen)
        ],
      ),
      body: ListView.builder(itemBuilder: (context,index){
        if(index>=words.length)
          words.addAll(generateWordPairs().take(10));
        return buildRow(words[index], index);
      }),
    );
  }
  pushToSaveWordsScreen(){
    final pageRoute =new MaterialPageRoute(builder: (context) {
      final listTile = checkedWords.map((wordsPair) {
        return new ListTile(
          title: new Text(
            wordsPair.asPascalCase,
            style: new TextStyle(fontSize: 20.0),
          ),
        );
      });
      return new Scaffold(
          appBar: AppBar(
            title: new Text("Checked Words"),
          ),
          body: new ListView(children: listTile.toList(),)

      );
    });
      Navigator.of(context).push(pageRoute);
    }
  Widget buildRow(WordPair wordPair, int index){
    final color = index%2 == 0 ? Colors.red:Colors.blue;
    final ischecked = checkedWords.contains(wordPair);
    return new ListTile(
      leading: Icon(ischecked ? Icons.check_box :Icons.check_box_outline_blank ),
      title: new Text(
        wordPair.asUpperCase,
        style: new TextStyle(fontSize: 20.0,color: color),
      ),
      onTap: (){
        setState(() {
          !ischecked ? checkedWords.add(wordPair):checkedWords.remove(wordPair);
        });
      },
    );
  }

}
class MyApp extends StatelessWidget{
  @override
  Widget build(BuildContext context) {
    final wordpair = new WordPair.random();
    // TODO: implement build
    return new MaterialApp(
      title: "This is my first Flutter App",
      home: RandomELWords()
    );
  }
}