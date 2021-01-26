
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import '../../../util/style.dart';
import '../../../util/utility.dart';
import '../../../infoManglar/infoForm/repository/info_form_repository.dart';
import '../../../infoManglar/infoForm/model/history/history_change.dart';

class HistoryWidget extends StatefulWidget {

  final String formType;
  final int formId;

  HistoryWidget({
    this.formType,
    this.formId,
  }): super();

  @override
  _State createState() => _State();

}

class _State extends State<HistoryWidget> {

  final infoFormRepository = InfoFormRepository();
  final _formatDate = new DateFormat('yyyy-MM-dd HH:mm');
  bool showHistory = false;

  @override
  Widget build(BuildContext context) {
    return showHistory ? _getHistoryExpanded() : _getHistorySimple();
  }

  Widget _getHistorySimple() {
    return FutureBuilder(
      future: infoFormRepository.getHistory(widget.formType, widget.formId),
      builder: (context, snapshot){
        if (snapshot.hasData) {
          return Container(
              margin: EdgeInsets.only(top: 2, right: 10),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: <Widget>[
                  Text('Ultimo cambio:', textAlign: TextAlign.end, style: StyleApp.getStyleTitle(12),),
                  (snapshot.data.length == 0 ?
                    Text('No tiene cambios', textAlign: TextAlign.end, style: StyleApp.getStyleTitle(12),) :
                    _getHistoryText(snapshot.data[snapshot.data.length-1])
                  ),
                  snapshot.data.length <= 1 ? SizedBox() : _getTextWidget('(Ver más)'),
                ],
              )
          );
        } else if (snapshot.hasError) {
          return Utility.getErrorMessage();
        }
        return Container(height: 40, child: Utility.getCircularProgress(),);
      },
    );
  }

  Widget _getHistoryExpanded() {
    return FutureBuilder(
      future: infoFormRepository.getHistory(widget.formType, widget.formId),
      builder: (context, snapshot){
        if (snapshot.hasData) {
          return Container(
              margin: EdgeInsets.only(top: 2, right: 10),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: snapshot.data.map<Widget>( (HistoryChange h) => _getHistoryText(h)).toList(),
              )
          );
        } else if (snapshot.hasError) {
          return Utility.getErrorMessage();
        }
        return Container(height: 160, child: Utility.getCircularProgress(),);
      },
    );
  }

  Widget _getHistoryText(HistoryChange h){
    String formatDate = _formatDate.format(
        DateTime.fromMillisecondsSinceEpoch(h.date ?? 0));
    String action = h.typeChange == 'created' ? 'Creado por' : 'Editado por';
    return _getTextWidget('$action ${h.userName} ($formatDate)');
  }

  Widget _getTextWidget(String text){
    return InkWell(
      onTap: () {
        setState(() {
          showHistory = !showHistory;
        });
      },
      child: Text(
        text,
        textAlign: TextAlign.end, style: StyleApp.getStyleTitle(12),
      ),
    );
  }

}
