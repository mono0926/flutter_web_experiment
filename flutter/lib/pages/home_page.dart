import 'dart:math';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../model/model.dart';

class HomePage extends StatelessWidget {
  const HomePage({Key key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    final notifier = Provider.of<StampsNotifier>(context);
    final docs = notifier.docs;
    return Scaffold(
      appBar: AppBar(
        title: const Text('ラヴさんスタンプ'),
        leading: IconButton(
//          icon: const AssetsIcon(AssetsIcons.menu),
          icon: Icon(Icons.menu),
          onPressed: () async {},
        ),
      ),
      body: LayoutBuilder(
        builder: (context, constraints) => GridView.builder(
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: min(5, constraints.maxWidth ~/ 150),
          ),
          itemBuilder: (context, index) => _GridCell(doc: docs[index]),
          itemCount: docs.length,
        ),
      ),
    );
  }
}

class _GridCell extends StatelessWidget {
  const _GridCell({
    Key key,
    @required this.doc,
  }) : super(key: key);

  final StampDoc doc;
  Stamp get stamp => doc.entity;

  @override
  Widget build(BuildContext context) {
    return Hero(
      tag: doc.id,
      child: Card(
        child: Ink.image(
          fit: BoxFit.cover,
          image: Image.network(
            stamp.imageUrl,
          ).image,
          child: InkWell(
            onTap: () {
              Navigator.of(context).pushNamed('/${stamp.name}');
            },
            child: Align(
              alignment: Alignment.bottomCenter,
              child: Container(
                constraints: const BoxConstraints.tightFor(
                  width: double.infinity,
                ),
                color: Colors.black.withOpacity(0.5),
                child: Padding(
                  padding: const EdgeInsets.symmetric(
                    vertical: 4,
                    horizontal: 8,
                  ),
                  child: Text(
                    stamp.name,
                    textAlign: TextAlign.end,
                    style: Theme.of(context).textTheme.subhead.copyWith(
                          color: Colors.white,
                        ),
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
