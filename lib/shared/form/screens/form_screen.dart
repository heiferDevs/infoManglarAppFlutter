
import 'package:flutter/material.dart';

import '../widgets/input.dart';
import '../../../util/style.dart';
import '../../../util/utility.dart';
import '../../form/model/option.dart';
import '../../form/model/form_config.dart';
import '../../../util/screens/wrapScreen.dart';
import '../../../util/widgets/wrapListView.dart';
import '../../../shared/form/widgets/history_widget.dart';
import '../../../infoManglar/infoForm/controller/info_form_save_controller.dart';

class FormScreen extends StatefulWidget {

  final FormConfig formConfig;

  FormScreen({
    @required this.formConfig,
  });

  @override
  FormScreenState createState() => FormScreenState();
}

class FormScreenState extends State<FormScreen> {

  FormConfig _formConfig;
  final infoFormSaveController = InfoFormSaveController();

  @override
  void initState() {
    super.initState();
    _formConfig = widget.formConfig;
    _formConfig.configOptions(context, _onSave);
    _formConfig.doBackupOptions();
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
        child: GestureDetector(
          onTap: () {
            FocusScope.of(context).requestFocus(new FocusNode()); // Hide keyboard on dismiss
          },
          child: WrapScreen(
            child: Builder(builder: (contextScaffold) => WrapListView(
              children: _getInputs(_formConfig, contextScaffold),
            )),
          ),
        ),
        onWillPop: () {
          bool hasChanges = _formConfig.hasChangeOptions();
          if (!_formConfig.enableSubmit || !hasChanges){
            return Future( () => true );
          }
          return Utility.showConfirm(context, '¿Esta seguro?', 'Se perderan los datos que ha ingresado', () {
            if (_formConfig.onCancel != null) _formConfig.onCancel();
          });
        });
  }

  _onSave({idOptionChange = ''}){
    setState(() {
      _formConfig.configOptions(context, _onSave);
    });
  }

  List<Widget> _getInputs(FormConfig formConfig, context){
    List<Widget> w = formConfig.options
        .where( (Option o) => formConfig.isShowOption(o) ).toList()
        .map<Widget>( (Option o) => Input(config: o) ).toList();
    if ( formConfig.enableSubmit )
      w.add(_getSaveButton(formConfig.submitLabel, context));
    if (formConfig.idForm != null) {
      w.insert(0, Container(
        margin: EdgeInsets.only(top: 18, right: 10),
        child: Text('Formulario Id: ${formConfig.idForm}', textAlign: TextAlign.end, style: StyleApp.getStyleTitle(12),),
      ));
      w.insert(1, HistoryWidget(formType: formConfig.idReport, formId: formConfig.idForm));
    }
    return w;
  }

  _saveInfo(BuildContext context){
    List<Option> optionsToSave = _formConfig.options
      .where( (Option o) => !o.avoidValue() && _formConfig.isShowOption(o) ).toList();

    if ( !Utility.isValidForm(optionsToSave, context) ) {
      _onSave(); // SHOW WARNINGS
      return;
    }
    if (_formConfig.isFromOptionGroup){
      Utility.navBack(context); // if pass validation only needs to back to the form
      return;
    }
    infoFormSaveController.save(_formConfig, context).then( (bool success) {
      if (success) {
        Utility.navBack(context);
      }
    });
  }

  _getSaveButton(String submitLabel, context){
    return FlatButton(
      padding: const EdgeInsets.all(0.0),
      onPressed: () => _saveInfo(context),
      child: Container(
        margin: EdgeInsets.fromLTRB(0, 20, 0, 40),
        decoration: BoxDecoration(
          color: Theme.of(context).primaryColor,
          borderRadius: BorderRadius.all(Radius.circular(20))
        ),
        width: 360,
        padding: const EdgeInsets.all(10.0),
        child: Text(
          submitLabel ?? 'GUARDAR',
          textAlign: TextAlign.center,
          style: TextStyle(color: Colors.white, fontSize: 16),
        ),
      ),
    );
  }

}
