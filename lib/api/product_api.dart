import 'package:merchant_gerbook_flutter/models/terms_of_condition.dart';
import 'package:merchant_gerbook_flutter/utils/http_request.dart';

class ProductApi extends HttpRequest {
  getContract() async {
    var res = await get('/merchant-contract');
    return TermsOfCondition.fromJson(res as Map<String, dynamic>);
  }
}
