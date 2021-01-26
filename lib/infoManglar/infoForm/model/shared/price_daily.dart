
import '../../../../shared/form/model/option.dart';
import '../../../../util/utility.dart';

import 'file_form.dart';

class PriceDaily {

  int id;

  String productType;
  String bioAquaticType;
  String shellQuality;

  double bioAquaticPrice;
  double otherProductsPrice;

  int shellCount;
  int sartsCount;
  int mielMangleCount;
  int craftCount;
  int plantasMangleCount;

  double shellPulpPounds;
  double crabPulpPounds;

  String crabQuality;
  String crabObservations;
  String otherProducts;
  String craftName;

  String serviceType;
  String bioemprendimientoName;

  List<FileForm> fileForms;

  PriceDaily({
    this.id,
    this.productType,
    this.bioAquaticType,
    this.shellQuality,
    this.otherProductsPrice,
    this.bioAquaticPrice,
    this.shellCount,
    this.sartsCount,
    this.mielMangleCount,
    this.craftCount,
    this.plantasMangleCount,
    this.shellPulpPounds,
    this.crabPulpPounds,
    this.crabQuality,
    this.crabObservations,
    this.otherProducts,
    this.craftName,
    this.serviceType,
    this.bioemprendimientoName,
    this.fileForms,
  });

  factory PriceDaily.fromOption(Option o) {
    List<FileForm> fileForms = [
      FileForm.fromOption(o.getOptionFromOptionsGroup('productImage')),
    ];
    List<Option> optionsGroup = o.optionsToGroup;
    return PriceDaily(
      id: o.idForm,
      productType: o.getValueFromOptionsGroup('productType', optionsGroup),
      bioAquaticType: o.getValueFromOptionsGroup('bioAquaticType', optionsGroup),
      shellQuality: o.getValueFromOptionsGroup('shellQuality', optionsGroup),
      otherProductsPrice: o.getValueFromOptionsGroup('otherProductsPrice', optionsGroup),
      bioAquaticPrice: o.getValueFromOptionsGroup('bioAquaticPrice', optionsGroup),
      shellCount: Utility.getInt(o.getValueFromOptionsGroup('shellCount', optionsGroup)), // Needs parse since is select not input
      sartsCount: o.getValueFromOptionsGroup('sartsCount', optionsGroup),
      mielMangleCount: o.getValueFromOptionsGroup('mielMangleCount', optionsGroup),
      craftCount: o.getValueFromOptionsGroup('craftCount', optionsGroup),
      plantasMangleCount: o.getValueFromOptionsGroup('plantasMangleCount', optionsGroup),
      shellPulpPounds: o.getValueFromOptionsGroup('shellPulpPounds', optionsGroup),
      crabPulpPounds: o.getValueFromOptionsGroup('crabPulpPounds', optionsGroup),
      crabQuality: o.getValueFromOptionsGroup('crabQuality', optionsGroup),
      crabObservations: o.getValueFromOptionsGroup('crabObservations', optionsGroup),
      otherProducts: o.getValueFromOptionsGroup('otherProducts', optionsGroup),
      craftName: o.getValueFromOptionsGroup('craftName', optionsGroup),
      serviceType: o.getValueFromOptionsGroup('serviceType', optionsGroup),
      bioemprendimientoName: o.getValueFromOptionsGroup('bioemprendimientoName', optionsGroup),
      fileForms: Utility.filterNull(fileForms),
    );
  }

  factory PriceDaily.fromJson(Map<String, dynamic> json) {
    List<FileForm> fileFormsFromJson = json['fileForms'].map<FileForm>( (f) => FileForm.fromJson(f) ).toList();
    return PriceDaily(
      id: json['id'],
      productType: json['productType'],
      bioAquaticType: json['bioAquaticType'],
      shellQuality: json['shellQuality'],
      otherProductsPrice: json['otherProductsPrice'],
      bioAquaticPrice: json['bioAquaticPrice'],
      shellCount: json['shellCount'],
      sartsCount: json['sartsCount'],
      mielMangleCount: json['mielMangleCount'],
      craftCount: json['craftCount'],
      plantasMangleCount: json['plantasMangleCount'],
      shellPulpPounds: json['shellPulpPounds'],
      crabPulpPounds: json['crabPulpPounds'],
      crabQuality: json['crabQuality'],
      crabObservations: json['crabObservations'],
      otherProducts: json['otherProducts'],
      craftName: json['craftName'],
      serviceType: json['serviceType'],
      bioemprendimientoName: json['bioemprendimientoName'],
      fileForms: fileFormsFromJson,
    );
  }

  // TO SAVE
  Map<String, dynamic> toJson() {
    List<Map<String, dynamic>> fileFormsJson = fileForms
        .map<Map<String, dynamic>>( (FileForm f) => f.toJson() ).toList();

    Map<String, dynamic>  mapJson = {};
    mapJson['id'] = id;
    mapJson['productType'] = productType;
    mapJson['bioAquaticType'] = bioAquaticType;
    mapJson['shellQuality'] = shellQuality;
    mapJson['otherProductsPrice'] = otherProductsPrice;
    mapJson['bioAquaticPrice'] = bioAquaticPrice;
    mapJson['shellCount'] = shellCount;
    mapJson['sartsCount'] = sartsCount;
    mapJson['mielMangleCount'] = mielMangleCount;
    mapJson['craftCount'] = craftCount;
    mapJson['plantasMangleCount'] = plantasMangleCount;
    mapJson['shellPulpPounds'] = shellPulpPounds;
    mapJson['crabPulpPounds'] = crabPulpPounds;
    mapJson['crabQuality'] = crabQuality;
    mapJson['crabObservations'] = crabObservations;
    mapJson['otherProducts'] = otherProducts;
    mapJson['craftName'] = craftName;
    mapJson['serviceType'] = serviceType;
    mapJson['bioemprendimientoName'] = bioemprendimientoName;
    mapJson['fileForms'] = Utility.filterNull(fileFormsJson);
    return Utility.removeNull(mapJson);
  }

  updateOptionGroup(Option option){
    if (option.optionsToGroup == null) throw 'MOST HAVE OPTIONS TO GROUP TO ADD';
    option.idForm = id;
    option.getOptionFromOptionsGroup('productType').setValueInit(productType);
    option.getOptionFromOptionsGroup('bioAquaticType').setValueInit(bioAquaticType);
    option.getOptionFromOptionsGroup('otherProductsPrice').setValueInit(otherProductsPrice);
    option.getOptionFromOptionsGroup('shellQuality').setValueInit(shellQuality);
    option.getOptionFromOptionsGroup('shellCount').setValueInit(shellCount);
    option.getOptionFromOptionsGroup('bioAquaticPrice').setValueInit(bioAquaticPrice);
    option.getOptionFromOptionsGroup('shellPulpPounds').setValueInit(shellPulpPounds);
    option.getOptionFromOptionsGroup('crabQuality').setValueInit(crabQuality);
    option.getOptionFromOptionsGroup('sartsCount').setValueInit(sartsCount);
    option.getOptionFromOptionsGroup('crabObservations').setValueInit(crabObservations);
    option.getOptionFromOptionsGroup('crabPulpPounds').setValueInit(crabPulpPounds);
    option.getOptionFromOptionsGroup('mielMangleCount').setValueInit(mielMangleCount);
    option.getOptionFromOptionsGroup('otherProducts').setValueInit(otherProducts);
    option.getOptionFromOptionsGroup('craftName').setValueInit(craftName);
    option.getOptionFromOptionsGroup('craftCount').setValueInit(craftCount);
    option.getOptionFromOptionsGroup('plantasMangleCount').setValueInit(plantasMangleCount);
    option.getOptionFromOptionsGroup('serviceType').setValueInit(serviceType);
    option.getOptionFromOptionsGroup('bioemprendimientoName').setValueInit(bioemprendimientoName);
    option.getOptionFromOptionsGroup('productImage').setValueInit(Utility.getFileForm(this, 'productImage'));
  }

  isEmpty(){
    return otherProductsPrice == null &&
        bioAquaticPrice == null &&
        bioemprendimientoName == null;
  }

}
