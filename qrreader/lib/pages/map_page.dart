import 'package:flutter/material.dart';
import 'package:qrreader/bloc/scans_bloc.dart';
import 'package:qrreader/models/scan_model.dart';

import 'package:qrreader/utils/utils.dart' as utils;


class MapPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {

    ScansBloc scansBloc = ScansBloc();
    return Center(
      child: StreamBuilder(
        stream: scansBloc.scansStream,
        builder: (BuildContext context, AsyncSnapshot<List<Scan>> snapshot) {
          if(!snapshot.hasData)
            return CircularProgressIndicator();
          if(snapshot.data.length == 0)
            return Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Icon(Icons.inbox, color: Colors.grey[300], size: 80.0,),
                Text('No encontramos ningún scan realizado...', style: TextStyle(color: Colors.grey[400]),),
              ],
            );
          return ListView.builder(
            itemCount: snapshot.data.length,
            itemBuilder: (context, index) {
              return Dismissible(
                key: UniqueKey(),
                background: Container(color: Colors.red),
                onDismissed: (dir) => scansBloc.deleteScan(snapshot.data.elementAt(index).id),
                child: ListTile(
                  onTap: () {
                    utils.abrirScan(context, snapshot.data.elementAt(index));
                  },
                  leading: Icon(Icons.location_on, color: Theme.of(context).primaryColor),
                  title: Text(snapshot.data.elementAt(index).value),
                  subtitle: Text('ID: ${snapshot.data.elementAt(index).id.toString()}'),
                  trailing: Icon(Icons.keyboard_arrow_right, color: Colors.grey),
                ),
              );
            },
          );
        },
      ),
    );
  }
}