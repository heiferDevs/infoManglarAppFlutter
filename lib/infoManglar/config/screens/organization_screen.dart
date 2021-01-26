
import '../../../infoManglar/config/model/organization_manglar.dart';
import '../../../infoManglar/config/repository/config_repository.dart';
import '../../../shared/form/model/data.dart';
import '../../../shared/form/model/option.dart';
import '../../../shared/form/widgets/input.dart';
import '../../../util/screens/wrapScreen.dart';
import 'package:flutter/material.dart';

import '../../../util/style.dart';
import '../../../util/utility.dart';


class OrganizationScreen extends StatefulWidget{

  final VoidCallback onSave;
  final int organizationManglarId;

  OrganizationScreen({
    @required this.onSave,
    this.organizationManglarId,
  });

  @override
  _State createState() {
    return _State();
  }
}

class _State extends State<OrganizationScreen> {

  bool _isLoading = true;

  final _configRepository = ConfigRepository();

  // Options
  final Option nameOption = Option(label: 'Nombre', type: 'input', typeInput: 'text');
  final Option nameCompleteOption = Option(label: 'Nombre completo', type: 'input', typeInput: 'text');

  @override
  void initState() {
    super.initState();
    _updateOrganizationManglar();
  }

  @override
  Widget build(BuildContext context) {

    final nameInput = Input(config: nameOption);
    final nameCompleteInput = Input(config: nameCompleteOption);

    return WrapScreen(
      child: _isLoading ?
      Utility.getCircularProgress() :
      Container(
          padding: EdgeInsets.fromLTRB(30, 10, 30, 10),
          child: ListView(
            children: <Widget>[
              nameInput,
              nameCompleteInput,
              _saveButton(context),
            ],
          )
      )
    );
  }

  _saveButton(context){
    return StyleApp.getButton('Guardar', () {
      if ( nameOption.hasValue() && nameCompleteOption.hasValue() ) {
        OrganizationManglar organizationManglar = OrganizationManglar(
            organizationManglarId: widget.organizationManglarId,
            organizationManglarName: nameOption.getValue(),
            organizationManglarCompleteName: nameCompleteOption.getValue(),
        );
        Utility.showLoading(context);
        _configRepository.saveOrganizationManglar(organizationManglar).then( (Data result) {
            Utility.dismissLoading(context);
            print('error <${result.state}>');
            if (result.state == 'OK') {
              Utility.navBack(context);
              Utility.showToast(context, 'Se guardo correctamente');
              widget.onSave();
            }
            else {
              Utility.showToast(context, result.state);
            }
        });
      }
      else {
        Utility.showToast(context, 'LLene todos los campos');
      }
    });
  }

  void _updateOrganizationManglar() {
    if (widget.organizationManglarId == null) {
      setState(() {
        _isLoading = false;
      });
      return;
    }
    _configRepository.getOrganizationManglar(widget.organizationManglarId).then((OrganizationManglar organizationManglar){
      setState(() {
        _isLoading = false;
        nameOption.setValueInit(organizationManglar.organizationManglarName);
        nameCompleteOption.setValueInit(organizationManglar.organizationManglarCompleteName);
      });
    });
  }

}
