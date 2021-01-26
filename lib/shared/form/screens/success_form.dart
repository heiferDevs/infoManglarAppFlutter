import '../../../util/screens/wrapScreen.dart';
import 'package:flutter/material.dart';
import '../../../util/style.dart';
import '../../../util/user.dart';

class SuccessForm extends StatefulWidget{
  final idReport;
  SuccessForm({
    @required this.idReport,
  });

  @override
  _State createState() {
    return _State();
  }
}

class _State extends State<SuccessForm>{
  @override
  Widget build(BuildContext context) {

    final subtitle = Container(
      padding: EdgeInsets.fromLTRB(10, 20, 10, 20),
      child: Text('Agradecemos su reporte', style: StyleApp.getStyleSubTitle(16),),
    );

    final message = Container(
      padding: EdgeInsets.all(10),
      child: Text('Su registro se envió a los siguientes entes competentes de control en los manglares, pronto se comunicarán con usted.',
      style: TextStyle(
        fontSize: 14,
      )),
    );

    final goMenu = Container(
      padding: EdgeInsets.fromLTRB(10, 20, 10, 20),
      child: InkWell(
        child: Text('Menú', textAlign: TextAlign.center, style: StyleApp.getStyleSubTitle(18),),
        onTap: (){
          Navigator.of(context).pop();
        },
      ),
    );

    return WrapScreen(
      child: Container(
        padding: EdgeInsets.fromLTRB(30, 10, 30, 10),
        child: ListView(
          children: <Widget>[
            StyleApp.getTitle('GRACIAS'),
            subtitle,
            message,
            _getLogos(),
            goMenu,
          ],
        ),
      )
    );
  }

  Widget _getLogos() {
    switch (widget.idReport) {
      case 'tala':
      case 'contaminacion':
      case 'invasiones':
      case 'tecnicas_pesca':
      case 'trafico_especies':
        return Container(
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Container(
                width: 140,
                padding: EdgeInsets.all(10),
                child: Image( image: AssetImage(User.getImagePath('logo_MAE.png')),),
              ),
              Container(
                width: 140,
                padding: EdgeInsets.all(10),
                child: Image( image: AssetImage(User.getImagePath('logo_fiscalia.png')),),
              ),
            ],
          ),
        );
      case 'vida_silvestre':
        return Container(
          height: 120,
          padding: EdgeInsets.all(10),
          child: Image( image: AssetImage(User.getImagePath('logo_MAE.png')),),
        );
      case 'tallas_minimas':
      case 'epoca_veda':
        return Container(
          width: 140,
          padding: EdgeInsets.all(10),
          child: Image( image: AssetImage(User.getImagePath('logo_MPCEIP.png')),),
        );
      case 'delincuencia_maritima':
        return Container(
          height: 120,
          padding: EdgeInsets.all(10),
          child: Image( image: AssetImage(User.getImagePath('logo_fiscalia.png')),),
        );
    }
    return null;
  }

}
