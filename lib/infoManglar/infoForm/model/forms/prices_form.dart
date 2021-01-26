
import '../../model/shared/price_daily.dart';
import '../../../../shared/form/model/form_config.dart';
import '../../../../shared/form/model/option.dart';
import '../../../../util/utility.dart';

class PricesForm{

  int pricesFormId;
  int userId;
  int organizationManglarId;
  String formType;

  List<PriceDaily> priceDailies;

  String name;
  String mobile;
  String address;

  PricesForm({
    this.pricesFormId,
    this.formType,
    this.userId,
    this.organizationManglarId,
    this.priceDailies,
    this.name,
    this.mobile,
    this.address,
  });

  factory PricesForm.fromFormConfig(FormConfig formConfig, int userId, int organizationManglarId) {
    List<PriceDaily> priceDailies = formConfig.getOptions('dailyOffer')
      .map<PriceDaily>( (Option o) {
        print('will call with option id ${o.id}');
        return PriceDaily.fromOption(o);
    }).toList();
    return PricesForm(
      formType: formConfig.idReport,
      pricesFormId: formConfig.idForm,
      userId: userId,
      organizationManglarId: organizationManglarId,
      priceDailies: priceDailies,
      name: formConfig.getValue('name'),
      mobile: formConfig.getValue('mobile'),
      address: formConfig.getValue('address'),
    );
  }

  factory PricesForm.fromJson(Map<String, dynamic> json) {
    List<PriceDaily> priceDailiesJson = json['priceDailies'].map<PriceDaily>( (f) => PriceDaily.fromJson(f) ).toList();
    return PricesForm(
      pricesFormId: json['pricesFormId'],
      formType: json['formType'],
      userId: json['userId'],
      organizationManglarId: json['organizationManglarId'],
      priceDailies: priceDailiesJson,
      name: json['name'],
      mobile: json['mobile'],
      address: json['address'],
    );
  }

  // TO SAVE
  Map<String, dynamic> toJson() {
    List<Map<String, dynamic>> priceDailiesJson = priceDailies
        .where((PriceDaily priceDaily) => !priceDaily.isEmpty() ).toList()
        .map<Map<String, dynamic>>( (PriceDaily priceDaily) => priceDaily.toJson() )
        .toList();
    Map<String, dynamic>  mapJson = {};
    mapJson['pricesFormId'] = pricesFormId;
    mapJson['formType'] = formType;
    mapJson['userId'] = userId;
    mapJson['organizationManglarId'] = organizationManglarId;
    mapJson['priceDailies'] = Utility.filterNull(priceDailiesJson);
    mapJson['name'] = name;
    mapJson['mobile'] = mobile;
    mapJson['address'] = address;
    return Utility.removeNull(mapJson);
  }

  FormConfig updateFormConfig(FormConfig formConfig){
    formConfig.removeOptionsCreatedByUser();
    formConfig.idForm = pricesFormId;

    formConfig.getOption('name').setValueInit(name);
    formConfig.getOption('mobile').setValueInit(mobile);
    formConfig.getOption('address').setValueInit(address);

    Option base = formConfig.getOption('dailyOffers'); // most have optionsToAdd
    priceDailies.sort( (a, b) => a.id.compareTo(b.id) );
    priceDailies.forEach( (PriceDaily priceDaily) {
      formConfig.updateOptionGroup(base, priceDaily.updateOptionGroup);
    });
    return formConfig;
  }

}
