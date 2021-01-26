import '../../../plugins/camera_only_photo.dart';
import '../../../plugins/fileExport.dart';
import '../../../plugins/url_launcher.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'dart:io';

import '../../../constants.dart';
import '../../../plugins/file_picker.dart';
import '../../../plugins/geolocator.dart';
import '../../../util/user.dart';
import '../../../util/style.dart';
import '../../../util/utility.dart';

import '../../../util/screens/displayPicture.dart';
import '../screens/form_screen.dart';
import '../model/option.dart';
import '../model/form_config.dart';
import '../model/data.dart';

class Input extends StatefulWidget {

  final dynamic config;

  Input({ @required this.config }): super();

  @override
  _InputState createState() => _InputState();

}

class _InputState extends State<Input> {

  Color primaryColor = Color(0xff000);
  Color primaryColorLight = Color(0xff000);
  double _margin = 6;

  @override
  Widget build(BuildContext context) {
    primaryColor = Theme.of(context).primaryColor;
    primaryColorLight = Theme.of(context).primaryColorLight;
    return getTextField(widget.config);
  }

  getTextField(Option config){
    switch(config.type){
      case 'title':
        return getTitle(config);
      case 'subtitle':
        return getSubTitle(config);
      case 'input':
        return getInput(config);
      case 'inputTextArea':
        return getInputTextArea(config);
      case 'inputTextAreaWithHelp':
        return getInputTextAreaWithHelp(config);
      case 'inputWithHelp':
        return getInputWithHelp(config);
      case 'toggle':
        return getToggle(config);
      case 'select':
        return getDropdown(config);
      case 'selectMultiple':
        return getSelectMultiple(config);
      case 'calendar':
        return getCalendar(config);
      case 'file':
        return getFile(config);
      case 'fileGeoJson':
        return getFileGeoJson(config);
      case 'gpsInput':
        return getGpsInput(config);
      case 'addOption':
        return getAddOption(config);
      case "groupInputs":
        return getGroupInputs(config);
      default:
        return Text('FALTA TEXTFIELD FOR TYPE ${config.type}');
    }
  }

  Widget getLabel(String label, Option config){
    bool asAlert = config.showValidate && (!config.valid() || Utility.hasErrorInput(config));
    return _getLabelCustom(label, asAlert);
  }

 Widget _getLabelCustom(String label, asAlert){
    return Container(
      padding: EdgeInsets.all(0.0),
      width: 120,
      child: Column (
        crossAxisAlignment: CrossAxisAlignment.end,
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Text(
            '$label:',
            textAlign: TextAlign.right,
            style: TextStyle(
              fontWeight: FontWeight.bold,
              color: asAlert ? Colors.red : primaryColorLight,
            ),
          )
        ],
      ),
    );
  }
  
  getTitle(Option config){
    return Container(
      padding: EdgeInsets.fromLTRB(18.0, 22.0, 18.0, 14.0),
      child: Text(
          config.label,
          textAlign: TextAlign.center,
          style: StyleApp.getStyleTitle(18)),
    );
  }

  getSubTitle(Option config){
    return Container(
      padding: EdgeInsets.fromLTRB(10.0, 12.0, 10.0, 12.0),
      child: Text(
          config.label,
          textAlign: TextAlign.center,
          style: StyleApp.getStyleTitle(12)),
    );
  }

  getAddOption(Option config){
    return ListTile(
      trailing: Row(
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          Container(
            margin: EdgeInsets.fromLTRB(6, 0, 6, 0),
            child: InkWell(
              onTap: () => config.onClick(),
              child: Icon(Icons.add_circle_outline, color: primaryColor,),
            ),
          ),
        ],
      ),
      title: InkWell(
        onTap: () => config.onClick(),
        child: Text(config.label, textAlign: TextAlign.center,style: StyleApp.getStyleTitle(18)),
      ),
    );
  }

  getGroupInputs(Option config){

    final String imageAsset = User.getImagePath(config.pathImageVideo);

    final FormConfig formConfig = FormConfig.fromOptionGroup(config);

    // RESTORE IN CASE OF CANCEL
    formConfig.onCancel = () {
      config.restoreFromBackupOptionsToGroup();
    };

    final icon = Container(
      margin: EdgeInsets.all(16),
      width: 40,
      height: 40,
      child: Center(
          child: Image.asset(imageAsset)
      ),
    );

    final width = MediaQuery.of(context).size.width * 0.6;

    List<Widget> children = config.optionsToGroup
        .where( (Option o) => formConfig.isShowOption(o) && o.hasValue() ).toList()
        .map<Container>( (Option option) {
      return Container(
          width: width,
          margin: EdgeInsets.all(4.0),
          child: Row(
            children: <Widget>[
              Text('${option.label}: ',
                textAlign: TextAlign.left,
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  color: primaryColorLight,
                ),
              ),
              Expanded(child: Text(option.hasValue() ? option.getValue().toString() : '', overflow: TextOverflow.ellipsis)),
            ],
          )
      );
    }).toList();

    children.insert(0, Container(
      width: width,
      child: ListTile(
        dense: true,
        trailing: InkWell(onTap: () => config.onClick(config), child: Icon(Icons.delete_outline, color: primaryColor,),),
        title: Text(config.getLabelIndex(), style: StyleApp.getStyleTitle(14),),
      ),
    ));

    final values = Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: children,
    );

    return FlatButton(
      child: Container(
        margin: EdgeInsets.fromLTRB(0, _margin, 0, _margin),
        decoration: StyleApp.getBoxDecoration(),
        child: Row(
          children: <Widget>[
            icon,
            values,
          ],
        ),
      ),
      onPressed: (){
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => FormScreen(formConfig: formConfig)),
        );
      }
    );

  }

  _keyboardType(String typeInput){
    switch(typeInput){
      case 'decimal':
      case 'numberToString':
      case 'number':
        return TextInputType.number;
      case 'textPersonName':
        return TextInputType.text;
      case 'textEmailAddress':
        return TextInputType.emailAddress;
      case 'password':
        return TextInputType.text;
      case 'date':
        return TextInputType.datetime;
      default:
        return TextInputType.text;
    }
  }

  getInput(Option config){
    return Container(
      margin: EdgeInsets.all(_margin),
      decoration: StyleApp.getBoxDecoration(),
      child: ListTile(
        leading: getLabel(config.getLabelIndex(), config),
        dense: true,
//        trailing: asAlert ? Icon(Icons.warning, color: Colors.red,) : null,
        title: TextField(
          enabled: config.isEditable,
          controller: config.textController,
          obscureText: config.typeInput == 'password',
          inputFormatters: Utility.validateInput(config.validate),
          keyboardType: _keyboardType(config.typeInput),
          style: TextStyle(
            color: !config.isEditable ? Color(Constants.colorPrimary) : null,
          ),
          decoration: InputDecoration(
            isDense: true,
            border: InputBorder.none,
            hintText: config.placeholder,
          ),
        ),
      ),
    );
  }

  getInputTextArea(Option config){
    return Container(
      margin: EdgeInsets.all(_margin),
      decoration: StyleApp.getBoxDecoration(),
      child: ListTile(
        leading: getLabel(config.label, config),
        dense: true,
        title: TextField(
          enabled: true,
          controller: config.textController,
          maxLines: null,
          keyboardType: TextInputType.multiline,
          decoration: InputDecoration(
            isDense: true,
            hintText: config.placeholder,
            border: OutlineInputBorder(),
          ),
        ),
      ),
    );
  }

  getDropdown(Option config){

    // PREVENT FAIL IF CURRENT OPTIONS NOT CONTAINS OLD VALUE
    Data evaluateItem = config.options.firstWhere((Data d) => d.id == config.value.id, orElse: () => null);
    if (evaluateItem == null) {
      config.options.add(Data(id: config.value.id, state: config.value.id));
    }

    final items = config.options.map<DropdownMenuItem<String>>((Data value) {
      return DropdownMenuItem<String>(
        value: value.id,
        child: Text(value.state),
      );
    }).toList();

    return Container(
      margin: EdgeInsets.all(_margin),
      decoration: StyleApp.getBoxDecoration(),
      child: ListTile(
        leading: getLabel(config.label, config),
        dense: true,
        title: DropdownButton(
            value: config.value.id,
            isDense: true,
            isExpanded: true,
            items: items,
            onChanged: (value) => config.onClick(value),
        ),
      ),
    );
  }

  getSelectMultiple(Option config){
    return Container(
      margin: EdgeInsets.all(_margin),
      decoration: StyleApp.getBoxDecoration(),
      child: InkWell(
        onTap: (){
          List<String> options = config.options.map<String>( (d) => d.state ).toList();
          Utility.getValueMultipleSelect(context, options, config.label, config.selectedValues)
          .then((multipleValues){
            config.onClick(multipleValues);
          });
        },
        child: ListTile(
          leading: getLabel(config.label, config),
          dense: true,
          trailing: Icon(Icons.arrow_drop_down),
          title: Text(config.getValueNoNull(), style: TextStyle(fontSize: 16,),),
        ),
      ),
    );
  }

  getInputTextAreaWithHelp(Option config){
    return Container(
      margin: EdgeInsets.all(_margin),
      decoration: StyleApp.getBoxDecoration(),
      child: ListTile(
        leading: getLabel(config.label, config),
        trailing: Tooltip(message: config.textHelp, child: Icon(Icons.help_outline, color: primaryColor,),),
        dense: true,
        title: TextField(
          enabled: true,
          controller: config.textController,
          maxLines: null,
          keyboardType: TextInputType.multiline,
          decoration: InputDecoration(
            isDense: true,
            hintText: config.placeholder,
            border: OutlineInputBorder(),
          ),
        ),
      ),
    );
  }

  getInputWithHelp(Option config){
    return Container(
      margin: EdgeInsets.all(_margin),
      decoration: StyleApp.getBoxDecoration(),
      child: ListTile(
        leading: getLabel(config.label, config),
        trailing: Tooltip(message: config.textHelp, child: Icon(Icons.help_outline, color: primaryColor,),),
        dense: true,
        title: TextField(
          enabled: true,
          controller: config.textController,
          inputFormatters: Utility.validateInput(config.validate),
          keyboardType: _keyboardType(config.typeInput),
          decoration: InputDecoration(
            isDense: true,
            border: InputBorder.none,
            hintText: config.placeholder,
          ),
        ),
      ),
    );
  }

  Future<Null> _showCalendar(BuildContext context, Function onSuccess, String currentValue) async{

    DateTime currentDate = currentValue == null ? DateTime.now() : DateTime.parse(currentValue);

    final DateTime date = await showDatePicker(
      context: context,
      initialDate: currentDate,
      firstDate: currentDate.subtract(Duration(days: 360)),
      lastDate: DateTime.now(),
    );
    if ( date != null ){
      String formattedDate = DateFormat('yyyy-MM-dd').format(date);
      onSuccess(formattedDate);
    }
  }

  getCalendar(Option config){

    String currentValue = config.hasValue() ? config.getValueNoNull() : null;

    return Container(
      margin: EdgeInsets.all(_margin),
      decoration: StyleApp.getBoxDecoration(),
      child: ListTile(
        leading: getLabel(config.label, config),
        trailing: GestureDetector(
            onTap: () => _showCalendar(context, config.onClick, currentValue),
            child: Icon(Icons.date_range, color: primaryColor,),
        ),
        dense: true,
        title: InkWell(
          child: Text(config.hasValue() ? config.getValueNoNull() : ''),
          onTap: () => _showCalendar(context, config.onClick, currentValue),
        ),
      ),
    );
  }

  getFile(Option config){

    final camera = InkWell(
      onTap: () {
        Utility.navTo(context, CameraOnlyPhoto(
          title: config.label,
          onSave: (nameNotUsed, path, type) {
            String nameFile = Utility.getNameFile(config, nameNotUsed);
            config.value = Data(id: nameFile, state: nameFile);
            config.pathImageVideo = path;
            config.typeInput = type;
            config.onClick();
          },
        ));
      },
      child: Container(
        margin: EdgeInsets.fromLTRB(5, 0, 5, 0),
        child: Icon(Icons.camera_alt, color: primaryColor),
      )
    );

    final file = InkWell(
        onTap: () {
          FilePickerApp.getImageOrDocumentPath().then( (FileExport fileExport) {
            if ( fileExport == null ) {
              Utility.showToast(context, 'FORMATO O ARCHIVO NO VALIDO');
              return;
            }
            String nameFile = Utility.getNameFile(config, fileExport.name);
            config.value = Data(id: nameFile, state: nameFile);
            config.pathImageVideo = fileExport.path;
            config.fileExport = fileExport;
            config.typeInput = fileExport.type;
            config.onClick();
          });
        },
        child: Container(
          margin: EdgeInsets.fromLTRB(5, 0, 5, 0),
          child: Icon(Icons.file_upload, color: primaryColor,),
        )
    );

    final listTile = ListTile(
      leading: getLabel(config.label, config),
      trailing: Row(
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          (Constants.isWeb ? SizedBox() : camera),
          file,
        ],
      ),
      dense: true,
      title: Text(
        config.hasValue() ? config.getValueNoNull() : (config.placeholder == null ? '' : config.placeholder),
      ),
    );

    final imageToShow = _getImageFile(config);

    final image = imageToShow == null ?
      SizedBox(height: 0.0) :
      Container(
        margin: EdgeInsets.fromLTRB(5, 10, 5, 0),
        width: 100,
        child: FlatButton(
          onPressed: (){
            if (config.typeInput == 'photo') {
              print('is photo nav to');
              Utility.navTo(context, DisplayPicture(
                title: config.getValueNoNull(),
                imagePath: config.pathImageVideo,
                imageUrl: config.url,
              ));
            } else if (config.typeInput == 'document') {
              print('is document nav to ${config.url}');
              UrlLauncher.launchURL(config.url);
            }
          },
          child: imageToShow,
        ),
      );

    return Container(
      margin: EdgeInsets.all(_margin),
      decoration: StyleApp.getBoxDecoration(),
      child: Column(
        children: <Widget>[
          image,
          listTile,
        ],
      ),
    );
  }

  Widget _getImageFile(Option config){
    if (config.typeInput == 'document' && config.url != null) {
      return Image.asset("${Constants.imagesPath}doc_icon.png");
    }
    if (config.typeInput == 'geojson' && config.url != null) {
      return Image.asset("${Constants.imagesPath}geoportal_icon.png");
    }
    if (config.pathImageVideo != null) {
      return Image.file(File(config.pathImageVideo));
    }
    if (config.url != null) {
      return Image.network(config.url);
    }
    return null;
  }

  getFileGeoJson(Option config){
    final file = InkWell(
        onTap: () {
          FilePickerApp.getGeoJsonPath().then( (FileExport fileExport) {
            if ( fileExport == null ) {
              Utility.showToast(context, 'FORMATO O ARCHIVO NO VALIDO');
              return;
            }
            String nameFile = Utility.getNameFile(config, fileExport.name);
            config.value = Data(id: nameFile, state: nameFile);
            config.pathImageVideo = fileExport.path;
            config.fileExport = fileExport;
            config.typeInput = fileExport.type;
            config.onClick();
          });
        },
        child: Container(
          margin: EdgeInsets.fromLTRB(5, 0, 5, 0),
          child: Icon(Icons.file_upload, color: primaryColor,),
        )
    );

    final listTile = ListTile(
      leading: getLabel(config.label, config),
      trailing: Row(
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          file,
        ],
      ),
      dense: true,
      title: Text(
        config.hasValue() ? config.getValueNoNull() : '',
      ),
    );

    final imageToShow = _getImageFile(config);

    final image = imageToShow == null ?
    SizedBox(height: 0.0) :
    Container(
      margin: EdgeInsets.fromLTRB(5, 10, 5, 0),
      width: 100,
      child: FlatButton(
        onPressed: (){
          if (config.typeInput == 'geojson') {
            print('is geojson nav to ${config.url}');
            UrlLauncher.launchURL(config.url);
          }
        },
        child: imageToShow,
      ),
    );

    return Container(
      margin: EdgeInsets.all(_margin),
      decoration: StyleApp.getBoxDecoration(),
      child: Column(
        children: <Widget>[
          image,
          listTile,
        ],
      ),
    );
  }


  getGpsInput(Option config){

    final loadLocation = InkWell(
      onTap: () {
        GeolocatorApp.getCurrentPosition().then( (String position){
          config.value = Data(id: position, state: position);
          config.onClick();
        });
      }, child: Icon(Icons.location_on, color: primaryColor, size: 20,)
    );

    return Container(
      margin: EdgeInsets.all(_margin),
      decoration: StyleApp.getBoxDecoration(),
      child: ListTile(
        leading: getLabel(config.label, config),
        trailing: loadLocation,
        dense: true,
        title: Text(config.hasValue() ? config.getValueNoNull() : ''),
      ),
    );

  }

  getToggle(Option config){
    bool current = config.value != null ? (config.value.state == 'true') : false;
    return Container(
      margin: EdgeInsets.all(_margin),
      decoration: StyleApp.getBoxDecoration(),
      child: ListTile(
        dense: true,
        trailing: Switch(value: current, onChanged: (value){
          config.onClick(value ? 'true' : 'false');
        }),
        title: Text(config.label),
      ),
    );
  }

}
