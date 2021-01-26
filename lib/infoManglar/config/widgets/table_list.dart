import '../../../util/style.dart';
import '../../../util/utility.dart';
import 'package:flutter/material.dart';

import '../../../constants.dart';

class TableList extends StatelessWidget{

  final String title;
  final List<String> titles;
  final List<List<String>> data;
  final VoidCallback onCreateNew;
  final Function onEdit;
  final Function onRemove;

  TableList({
    Key key,
    this.title,
    this.titles,
    this.data,
    this.onCreateNew,
    this.onEdit,
    this.onRemove,
  });

  @override
  Widget build(BuildContext context) {

    List<TableRow> rows = [];

    TableRow titlesTableRow = TableRow(
      children: _getTitles().map<Widget>( (String title) {
        return Container(
          padding: EdgeInsets.all(6),
          child: Text(title, style: StyleApp.getStyleSubTitle(12),),
        );
      }).toList(),
    );

    rows.add(titlesTableRow); // Add titles

    for (List<String> rData in data ) {
      final List<Widget> _children = rData.map<Widget>( (String text) {
        return Container(
          padding: EdgeInsets.all(4),
          child: Text(text, style: TextStyle(fontSize: 11),),
        );
      }).toList();
      int id = Utility.getInt(rData.asMap()[0]);
      _children.add(_getActions(id));
      TableRow newRow = TableRow(
        children: _children,
      );
      rows.add(newRow);
    }

    final tableTitle = Container(
      child: Center(
        child: ListTile(
          trailing: Row(
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              Container(
                margin: EdgeInsets.fromLTRB(6, 0, 6, 0),
                child: InkWell(
                  onTap: () => onCreateNew(),
                  child: Icon(Icons.add_circle_outline, color: Color(Constants.colorPrimary),),
                ),
              ),
            ],
          ),
          title: InkWell(
            child: Text(title, textAlign: TextAlign.center,style: StyleApp.getStyleTitle(16)),
          ),
        ),
      ),
    );

    final table = Container(
      child: Table(
          columnWidths: {
            0: FlexColumnWidth(0.4),
            1: FlexColumnWidth(1.6),
            2: FlexColumnWidth(1.2),
            3: FlexColumnWidth(1),
            4: FlexColumnWidth(1),
            5: FlexColumnWidth(1),
          },
        border: TableBorder.all(
          color: Color(Constants.colorPrimary),
        ),
        children: rows,
      ),
    );

    return Container(
      padding: EdgeInsets.all(20),
      child: Column(
        children: <Widget>[
          tableTitle,
          table,
        ],
      ),
    );

  }

  List<String> _getTitles() {
    final List<String> _titles = [];
    _titles.addAll(titles);
    _titles.add('Acciones');
    return _titles;
  }

  Widget _getActions(int id) {
    return Container(
      padding: EdgeInsets.all(6),
      child: Row(
        children: <Widget>[
          InkWell(
            onTap: () => onEdit(id),
            child: Icon(Icons.edit, color: Color(Constants.colorPrimary),),
          ),
          InkWell(
            onTap: () => onRemove(id),
            child: Icon(Icons.restore_from_trash, color: Color(Constants.colorPrimary),),
          )
        ],
      ),
    );
  }

}
