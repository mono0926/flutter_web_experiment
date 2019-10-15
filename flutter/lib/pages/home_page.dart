import 'dart:math';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../model/model.dart';
import 'image_detail_page.dart';

class HomePage extends StatelessWidget {
  const HomePage({Key key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    final notifier = Provider.of<StampsNotifier>(context);
    final stamps = notifier.stamps;
    return Scaffold(
      appBar: AppBar(
        title: const Text('ラヴさんスタンプ'),
        leading: IconButton(
          icon: Icon(Icons.menu),
          onPressed: () async {},
        ),
      ),
      body: LayoutBuilder(
        builder: (context, constraints) => GridView.builder(
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: min(5, constraints.maxWidth ~/ 150),
          ),
          itemBuilder: (context, index) => _GridCell(stamp: stamps[index]),
          itemCount: stamps.length,
        ),
      ),
    );
  }
}

class _GridCell extends StatelessWidget {
  const _GridCell({
    Key key,
    @required this.stamp,
  }) : super(key: key);

  final Stamp stamp;

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Ink.image(
        fit: BoxFit.cover,
        image: Image.network(
          stamp.imageUrl,
        ).image,
        child: InkWell(
          onTap: () {
            Navigator.of(context).push<void>(
              MaterialPageRoute(
                builder: (context) => ImageDetailPage(stamp: stamp),
                settings: RouteSettings(name: stamp.name),
              ),
            );
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
    );
  }
}
