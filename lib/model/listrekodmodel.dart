class TotalListRekod{
  final List<listRekodModel> listmodel;
  TotalListRekod({required this.listmodel});

  factory TotalListRekod.fromJson(List<dynamic> json) {
    List<listRekodModel> listmodel = <listRekodModel>[];
    listmodel = json.map((i) => listRekodModel.fromJson(i)).toList();
    return TotalListRekod(
        listmodel: listmodel
    );
  }
}

class listRekodModel {
  String? sTATUS;
  String? id;
  String? pid;
  String? pidboss;
  String? noinvoiceORDERFROMAGEN;
  String? noinvoiceORDERFROMOWN;
  String? noinvoiceORDERCUSTOMERTOHQ;
  String? totalcredit;
  String? mtResult;
  String? mtLogdatetime;
  String? totalcreditbyagent;
  String? mtResultbyagent;
  String? mtLogdatetimebyagent;
  String? trackingnoupdatedate;
  String? tugasanpilihanwarna;
  String? productid;
  String? quantity;
  String? productid2;
  String? productid3;
  String? productid4;
  String? productid5;
  String? productid6;
  String? productid7;
  String? productid8;
  String? productid9;
  String? productid10;
  String? productid11;
  String? productid12;
  String? productid13;
  String? productid14;
  String? productid15;
  String? productid16;
  String? productid17;
  String? productid18;
  String? productid19;
  String? productid20;
  String? quantity2;
  String? quantity3;
  String? quantity4;
  String? quantity5;
  String? quantity6;
  String? quantity7;
  String? quantity8;
  String? quantity9;
  String? quantity10;
  String? quantity11;
  String? quantity12;
  String? quantity13;
  String? quantity14;
  String? quantity15;
  String? quantity16;
  String? quantity17;
  String? quantity18;
  String? quantity19;
  String? quantity20;
  String? sTARTNEW;
  String? eND;
  String? dISPLAYMORE;
  String? customername;
  String? address;
  String? postcode;
  String? state;
  String? hpno;
  String? openservicename;
  String? openservicecost;
  String? productname;
  String? productname2;
  String? productname3;
  String? productname4;
  String? productname5;
  String? productname6;
  String? productname7;
  String? productname8;
  String? productname9;
  String? productname10;
  String? productname11;
  String? productname12;
  String? productname13;
  String? productname14;
  String? productname15;
  String? productname16;
  String? productname17;
  String? productname18;
  String? productname19;
  String? productname20;
  String? agentgroup;
  String? transactiondate;
  String? trackingno;
  String? attachment;
  String? attachmentlink;
  String? orderattachment;
  String? orderattachmentII;
  String? orderattachmentIII;
  String? bezasaat;
  String? tOTALBALANCECREDIT;
  String? tOTALREVENUE;
  String? tOTALREVENUETHISMONTH;
  String? tOTALREVENUELASTMONTH;
  String? tOTALREVENUETHISMONTHBULAN;
  String? tOTALREVENUELASTMONTHBULAN;
  String? tOTALORDER;
  String? actualsellingprice;
  String? actualpayingprice;
  String? shouldpayingprice;
  String? tunaiditerimaREAL;
  String? tunaiditerima;
  String? bakidipulangkan;
  String? note;
  String? notefromseller;
  String? notefromsellerSubnota1;
  String? notefromsellerSubnota2;
  String? fpxkey;
  String? camefrom;
  String? reasonpayless;
  String? typeofpayment;
  String? finalnotes;
  String? productownerpid;
  String? productownerpenggunaid;
  String? agentpenggunaid;
  String? hideImageTEMPO;
  String? hideImage;
  String? rejectEmailNotification;
  String? allowAgentToEdit;
  String? allowAgentToEditFPX;
  String? agentMustSelectPostage;
  String? hideActualQuantity;
  String? createdbypenggunaid;
  String? createdby;
  String? courier;
  String? openattachment;
  String? jenispenghantaran;
  String? lMSwarehouseorderid;
  String? sAPorderid;
  String? wEBHOOKorderid;
  String? wEBHOOKorderidStatus;
  String? wEBHOOKorderidHttpcode;
  String? currencyHq;
  String? shoppegramPaymentgateway;
  String? shoppegramOrderid;
  String? shoppegramUrl;
  String? wooUrl;
  String? wooOrderid;
  String? wooPaymentgateway;
  String? wooPaymentTxn;
  String? wooPaymentgatewayId;
  String? tiktokshopOrderid;
  String? shopeeOrderid;
  String? spOrderid;
  String? spUrl;
  String? wooCodecoupon;
  String? laststatusninjavandelivery;
  String? laststatusninjavandeliveryDatetime;
  String? laststatusdhldelivery;
  String? laststatusdhldeliveryDatetime;
  String? laststatusjntdelivery;
  String? laststatusjntdeliveryDatetime;
  String? laststatuscitylinkdelivery;
  String? laststatuscitylinkdeliveryDatetime;
  String? laststatusflashdelivery;
  String? laststatusflashdeliveryDatetime;
  String? laststatusbestexpressdelivery;
  String? laststatusbestexpressdeliveryDatetime;
  String? laststatusefmxdelivery;
  String? laststatusefmxdeliveryDatetime;
  String? laststatusabxdelivery;
  String? laststatusabxdeliveryDatetime;
  String? laststatusezisenddelivery;
  String? laststatusezisenddeliveryReturn;
  String? laststatusezisenddeliveryDatetime;
  String? laststatustiktokshopdelivery;
  String? laststatustiktokshopdeliveryDatetime;
  String? reason4cancel;
  String? trackingnoupdatebypidPenggunaid;
  String? bizappbotSent;
  String? bizappbotSentstatus;
  String? bizappbotSentcount;
  String? wsapmeSent;
  String? wsapmeSentstatus;
  String? wsapmeSentcount;
  String? paymenttype;
  String? posTempid;

  listRekodModel(
      {this.sTATUS,
      this.id,
      this.pid,
      this.pidboss,
      this.noinvoiceORDERFROMAGEN,
      this.noinvoiceORDERFROMOWN,
      this.noinvoiceORDERCUSTOMERTOHQ,
      this.totalcredit,
      this.mtResult,
      this.mtLogdatetime,
      this.totalcreditbyagent,
      this.mtResultbyagent,
      this.mtLogdatetimebyagent,
      this.trackingnoupdatedate,
      this.tugasanpilihanwarna,
      this.productid,
      this.quantity,
      this.productid2,
      this.productid3,
      this.productid4,
      this.productid5,
      this.productid6,
      this.productid7,
      this.productid8,
      this.productid9,
      this.productid10,
      this.productid11,
      this.productid12,
      this.productid13,
      this.productid14,
      this.productid15,
      this.productid16,
      this.productid17,
      this.productid18,
      this.productid19,
      this.productid20,
      this.quantity2,
      this.quantity3,
      this.quantity4,
      this.quantity5,
      this.quantity6,
      this.quantity7,
      this.quantity8,
      this.quantity9,
      this.quantity10,
      this.quantity11,
      this.quantity12,
      this.quantity13,
      this.quantity14,
      this.quantity15,
      this.quantity16,
      this.quantity17,
      this.quantity18,
      this.quantity19,
      this.quantity20,
      this.sTARTNEW,
      this.eND,
      this.dISPLAYMORE,
      this.customername,
      this.address,
      this.postcode,
      this.state,
      this.hpno,
      this.openservicename,
      this.openservicecost,
      this.productname,
      this.productname2,
      this.productname3,
      this.productname4,
      this.productname5,
      this.productname6,
      this.productname7,
      this.productname8,
      this.productname9,
      this.productname10,
      this.productname11,
      this.productname12,
      this.productname13,
      this.productname14,
      this.productname15,
      this.productname16,
      this.productname17,
      this.productname18,
      this.productname19,
      this.productname20,
      this.agentgroup,
      this.transactiondate,
      this.trackingno,
      this.attachment,
      this.attachmentlink,
      this.orderattachment,
      this.orderattachmentII,
      this.orderattachmentIII,
      this.bezasaat,
      this.tOTALBALANCECREDIT,
      this.tOTALREVENUE,
      this.tOTALREVENUETHISMONTH,
      this.tOTALREVENUELASTMONTH,
      this.tOTALREVENUETHISMONTHBULAN,
      this.tOTALREVENUELASTMONTHBULAN,
      this.tOTALORDER,
      this.actualsellingprice,
      this.actualpayingprice,
      this.shouldpayingprice,
      this.tunaiditerimaREAL,
      this.tunaiditerima,
      this.bakidipulangkan,
      this.note,
      this.notefromseller,
      this.notefromsellerSubnota1,
      this.notefromsellerSubnota2,
      this.fpxkey,
      this.camefrom,
      this.reasonpayless,
      this.typeofpayment,
      this.finalnotes,
      this.productownerpid,
      this.productownerpenggunaid,
      this.agentpenggunaid,
      this.hideImageTEMPO,
      this.hideImage,
      this.rejectEmailNotification,
      this.allowAgentToEdit,
      this.allowAgentToEditFPX,
      this.agentMustSelectPostage,
      this.hideActualQuantity,
      this.createdbypenggunaid,
      this.createdby,
      this.courier,
      this.openattachment,
      this.jenispenghantaran,
      this.lMSwarehouseorderid,
      this.sAPorderid,
      this.wEBHOOKorderid,
      this.wEBHOOKorderidStatus,
      this.wEBHOOKorderidHttpcode,
      this.currencyHq,
      this.shoppegramPaymentgateway,
      this.shoppegramOrderid,
      this.shoppegramUrl,
      this.wooUrl,
      this.wooOrderid,
      this.wooPaymentgateway,
      this.wooPaymentTxn,
      this.wooPaymentgatewayId,
      this.tiktokshopOrderid,
      this.shopeeOrderid,
      this.spOrderid,
      this.spUrl,
      this.wooCodecoupon,
      this.laststatusninjavandelivery,
      this.laststatusninjavandeliveryDatetime,
      this.laststatusdhldelivery,
      this.laststatusdhldeliveryDatetime,
      this.laststatusjntdelivery,
      this.laststatusjntdeliveryDatetime,
      this.laststatuscitylinkdelivery,
      this.laststatuscitylinkdeliveryDatetime,
      this.laststatusflashdelivery,
      this.laststatusflashdeliveryDatetime,
      this.laststatusbestexpressdelivery,
      this.laststatusbestexpressdeliveryDatetime,
      this.laststatusefmxdelivery,
      this.laststatusefmxdeliveryDatetime,
      this.laststatusabxdelivery,
      this.laststatusabxdeliveryDatetime,
      this.laststatusezisenddelivery,
      this.laststatusezisenddeliveryReturn,
      this.laststatusezisenddeliveryDatetime,
      this.laststatustiktokshopdelivery,
      this.laststatustiktokshopdeliveryDatetime,
      this.reason4cancel,
      this.trackingnoupdatebypidPenggunaid,
      this.bizappbotSent,
      this.bizappbotSentstatus,
      this.bizappbotSentcount,
      this.wsapmeSent,
      this.wsapmeSentstatus,
      this.wsapmeSentcount,
      this.paymenttype,
      this.posTempid});

  listRekodModel.fromJson(Map<String, dynamic> json) {
    sTATUS = json['STATUS'];
    id = json['id'];
    pid = json['pid'];
    pidboss = json['pidboss'];
    noinvoiceORDERFROMAGEN = json['noinvoice_ORDERFROMAGEN'];
    noinvoiceORDERFROMOWN = json['noinvoice_ORDERFROMOWN'];
    noinvoiceORDERCUSTOMERTOHQ = json['noinvoice_ORDERCUSTOMERTOHQ'];
    totalcredit = json['totalcredit'];
    mtResult = json['mt_result'];
    mtLogdatetime = json['mt_logdatetime'];
    totalcreditbyagent = json['totalcreditbyagent'];
    mtResultbyagent = json['mt_resultbyagent'];
    mtLogdatetimebyagent = json['mt_logdatetimebyagent'];
    trackingnoupdatedate = json['trackingnoupdatedate'];
    tugasanpilihanwarna = json['tugasanpilihanwarna'];
    productid = json['productid'];
    quantity = json['quantity'];
    productid2 = json['productid2'];
    productid3 = json['productid3'];
    productid4 = json['productid4'];
    productid5 = json['productid5'];
    productid6 = json['productid6'];
    productid7 = json['productid7'];
    productid8 = json['productid8'];
    productid9 = json['productid9'];
    productid10 = json['productid10'];
    productid11 = json['productid11'];
    productid12 = json['productid12'];
    productid13 = json['productid13'];
    productid14 = json['productid14'];
    productid15 = json['productid15'];
    productid16 = json['productid16'];
    productid17 = json['productid17'];
    productid18 = json['productid18'];
    productid19 = json['productid19'];
    productid20 = json['productid20'];
    quantity2 = json['quantity2'];
    quantity3 = json['quantity3'];
    quantity4 = json['quantity4'];
    quantity5 = json['quantity5'];
    quantity6 = json['quantity6'];
    quantity7 = json['quantity7'];
    quantity8 = json['quantity8'];
    quantity9 = json['quantity9'];
    quantity10 = json['quantity10'];
    quantity11 = json['quantity11'];
    quantity12 = json['quantity12'];
    quantity13 = json['quantity13'];
    quantity14 = json['quantity14'];
    quantity15 = json['quantity15'];
    quantity16 = json['quantity16'];
    quantity17 = json['quantity17'];
    quantity18 = json['quantity18'];
    quantity19 = json['quantity19'];
    quantity20 = json['quantity20'];
    sTARTNEW = json['STARTNEW'];
    eND = json['END'];
    dISPLAYMORE = json['DISPLAYMORE'];
    customername = json['customername'];
    address = json['address'];
    postcode = json['postcode'];
    state = json['state'];
    hpno = json['hpno'];
    openservicename = json['openservicename'];
    openservicecost = json['openservicecost'];
    productname = json['productname'];
    productname2 = json['productname2'];
    productname3 = json['productname3'];
    productname4 = json['productname4'];
    productname5 = json['productname5'];
    productname6 = json['productname6'];
    productname7 = json['productname7'];
    productname8 = json['productname8'];
    productname9 = json['productname9'];
    productname10 = json['productname10'];
    productname11 = json['productname11'];
    productname12 = json['productname12'];
    productname13 = json['productname13'];
    productname14 = json['productname14'];
    productname15 = json['productname15'];
    productname16 = json['productname16'];
    productname17 = json['productname17'];
    productname18 = json['productname18'];
    productname19 = json['productname19'];
    productname20 = json['productname20'];
    agentgroup = json['agentgroup'];
    transactiondate = json['transactiondate'];
    trackingno = json['trackingno'];
    attachment = json['attachment'];
    attachmentlink = json['attachmentlink'];
    orderattachment = json['orderattachment'];
    orderattachmentII = json['orderattachmentII'];
    orderattachmentIII = json['orderattachmentIII'];
    bezasaat = json['bezasaat'];
    tOTALBALANCECREDIT = json['TOTALBALANCECREDIT'];
    tOTALREVENUE = json['TOTALREVENUE'];
    tOTALREVENUETHISMONTH = json['TOTALREVENUE_THISMONTH'];
    tOTALREVENUELASTMONTH = json['TOTALREVENUE_LASTMONTH'];
    tOTALREVENUETHISMONTHBULAN = json['TOTALREVENUE_THISMONTH_BULAN'];
    tOTALREVENUELASTMONTHBULAN = json['TOTALREVENUE_LASTMONTH_BULAN'];
    tOTALORDER = json['TOTALORDER'];
    actualsellingprice = json['actualsellingprice'];
    actualpayingprice = json['actualpayingprice'];
    shouldpayingprice = json['shouldpayingprice'];
    tunaiditerimaREAL = json['tunaiditerimaREAL'];
    tunaiditerima = json['tunaiditerima'];
    bakidipulangkan = json['bakidipulangkan'];
    note = json['note'];
    notefromseller = json['notefromseller'];
    notefromsellerSubnota1 = json['notefromseller_subnota1'];
    notefromsellerSubnota2 = json['notefromseller_subnota2'];
    fpxkey = json['fpxkey'];
    camefrom = json['camefrom'];
    reasonpayless = json['reasonpayless'];
    typeofpayment = json['typeofpayment'];
    finalnotes = json['finalnotes'];
    productownerpid = json['productownerpid'];
    productownerpenggunaid = json['productownerpenggunaid'];
    agentpenggunaid = json['agentpenggunaid'];
    hideImageTEMPO = json['hideImage_TEMPO'];
    hideImage = json['hideImage'];
    rejectEmailNotification = json['rejectEmailNotification'];
    allowAgentToEdit = json['allowAgentToEdit'];
    allowAgentToEditFPX = json['allowAgentToEditFPX'];
    agentMustSelectPostage = json['agentMustSelectPostage'];
    hideActualQuantity = json['hideActualQuantity'];
    createdbypenggunaid = json['createdbypenggunaid'];
    createdby = json['createdby'];
    courier = json['courier'];
    openattachment = json['openattachment'];
    jenispenghantaran = json['jenispenghantaran'];
    lMSwarehouseorderid = json['LMSwarehouseorderid'];
    sAPorderid = json['SAPorderid'];
    wEBHOOKorderid = json['WEBHOOKorderid'];
    wEBHOOKorderidStatus = json['WEBHOOKorderid_status'];
    wEBHOOKorderidHttpcode = json['WEBHOOKorderid_httpcode'];
    currencyHq = json['currency_hq'];
    shoppegramPaymentgateway = json['shoppegram_paymentgateway'];
    shoppegramOrderid = json['shoppegram_orderid'];
    shoppegramUrl = json['shoppegram_url'];
    wooUrl = json['woo_url'];
    wooOrderid = json['woo_orderid'];
    wooPaymentgateway = json['woo_paymentgateway'];
    wooPaymentTxn = json['woo_payment_txn'];
    wooPaymentgatewayId = json['woo_paymentgateway_id'];
    tiktokshopOrderid = json['tiktokshop_orderid'];
    shopeeOrderid = json['shopee_orderid'];
    spOrderid = json['sp_orderid'];
    spUrl = json['sp_url'];
    wooCodecoupon = json['woo_codecoupon'];
    laststatusninjavandelivery = json['laststatusninjavandelivery'];
    laststatusninjavandeliveryDatetime =
        json['laststatusninjavandelivery_datetime'];
    laststatusdhldelivery = json['laststatusdhldelivery'];
    laststatusdhldeliveryDatetime = json['laststatusdhldelivery_datetime'];
    laststatusjntdelivery = json['laststatusjntdelivery'];
    laststatusjntdeliveryDatetime = json['laststatusjntdelivery_datetime'];
    laststatuscitylinkdelivery = json['laststatuscitylinkdelivery'];
    laststatuscitylinkdeliveryDatetime =
        json['laststatuscitylinkdelivery_datetime'];
    laststatusflashdelivery = json['laststatusflashdelivery'];
    laststatusflashdeliveryDatetime = json['laststatusflashdelivery_datetime'];
    laststatusbestexpressdelivery = json['laststatusbestexpressdelivery'];
    laststatusbestexpressdeliveryDatetime =
        json['laststatusbestexpressdelivery_datetime'];
    laststatusefmxdelivery = json['laststatusefmxdelivery'];
    laststatusefmxdeliveryDatetime = json['laststatusefmxdelivery_datetime'];
    laststatusabxdelivery = json['laststatusabxdelivery'];
    laststatusabxdeliveryDatetime = json['laststatusabxdelivery_datetime'];
    laststatusezisenddelivery = json['laststatusezisenddelivery'];
    laststatusezisenddeliveryReturn = json['laststatusezisenddelivery_return'];
    laststatusezisenddeliveryDatetime =
        json['laststatusezisenddelivery_datetime'];
    laststatustiktokshopdelivery = json['laststatustiktokshopdelivery'];
    laststatustiktokshopdeliveryDatetime =
        json['laststatustiktokshopdelivery_datetime'];
    reason4cancel = json['reason4cancel'];
    trackingnoupdatebypidPenggunaid = json['trackingnoupdatebypid_penggunaid'];
    bizappbotSent = json['bizappbot_sent'];
    bizappbotSentstatus = json['bizappbot_sentstatus'];
    bizappbotSentcount = json['bizappbot_sentcount'];
    wsapmeSent = json['wsapme_sent'];
    wsapmeSentstatus = json['wsapme_sentstatus'];
    wsapmeSentcount = json['wsapme_sentcount'];
    paymenttype = json['paymenttype'];
    posTempid = json['pos_tempid'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['STATUS'] = sTATUS;
    data['id'] = id;
    data['pid'] = pid;
    data['pidboss'] = pidboss;
    data['noinvoice_ORDERFROMAGEN'] = noinvoiceORDERFROMAGEN;
    data['noinvoice_ORDERFROMOWN'] = noinvoiceORDERFROMOWN;
    data['noinvoice_ORDERCUSTOMERTOHQ'] = noinvoiceORDERCUSTOMERTOHQ;
    data['totalcredit'] = totalcredit;
    data['mt_result'] = mtResult;
    data['mt_logdatetime'] = mtLogdatetime;
    data['totalcreditbyagent'] = totalcreditbyagent;
    data['mt_resultbyagent'] = mtResultbyagent;
    data['mt_logdatetimebyagent'] = mtLogdatetimebyagent;
    data['trackingnoupdatedate'] = trackingnoupdatedate;
    data['tugasanpilihanwarna'] = tugasanpilihanwarna;
    data['productid'] = productid;
    data['quantity'] = quantity;
    data['productid2'] = productid2;
    data['productid3'] = productid3;
    data['productid4'] = productid4;
    data['productid5'] = productid5;
    data['productid6'] = productid6;
    data['productid7'] = productid7;
    data['productid8'] = productid8;
    data['productid9'] = productid9;
    data['productid10'] = productid10;
    data['productid11'] = productid11;
    data['productid12'] = productid12;
    data['productid13'] = productid13;
    data['productid14'] = productid14;
    data['productid15'] = productid15;
    data['productid16'] = productid16;
    data['productid17'] = productid17;
    data['productid18'] = productid18;
    data['productid19'] = productid19;
    data['productid20'] = productid20;
    data['quantity2'] = quantity2;
    data['quantity3'] = quantity3;
    data['quantity4'] = quantity4;
    data['quantity5'] = quantity5;
    data['quantity6'] = quantity6;
    data['quantity7'] = quantity7;
    data['quantity8'] = quantity8;
    data['quantity9'] = quantity9;
    data['quantity10'] = quantity10;
    data['quantity11'] = quantity11;
    data['quantity12'] = quantity12;
    data['quantity13'] = quantity13;
    data['quantity14'] = quantity14;
    data['quantity15'] = quantity15;
    data['quantity16'] = quantity16;
    data['quantity17'] = quantity17;
    data['quantity18'] = quantity18;
    data['quantity19'] = quantity19;
    data['quantity20'] = quantity20;
    data['STARTNEW'] = sTARTNEW;
    data['END'] = eND;
    data['DISPLAYMORE'] = dISPLAYMORE;
    data['customername'] = customername;
    data['address'] = address;
    data['postcode'] = postcode;
    data['state'] = state;
    data['hpno'] = hpno;
    data['openservicename'] = openservicename;
    data['openservicecost'] = openservicecost;
    data['productname'] = productname;
    data['productname2'] = productname2;
    data['productname3'] = productname3;
    data['productname4'] = productname4;
    data['productname5'] = productname5;
    data['productname6'] = productname6;
    data['productname7'] = productname7;
    data['productname8'] = productname8;
    data['productname9'] = productname9;
    data['productname10'] = productname10;
    data['productname11'] = productname11;
    data['productname12'] = productname12;
    data['productname13'] = productname13;
    data['productname14'] = productname14;
    data['productname15'] = productname15;
    data['productname16'] = productname16;
    data['productname17'] = productname17;
    data['productname18'] = productname18;
    data['productname19'] = productname19;
    data['productname20'] = productname20;
    data['agentgroup'] = agentgroup;
    data['transactiondate'] = transactiondate;
    data['trackingno'] = trackingno;
    data['attachment'] = attachment;
    data['attachmentlink'] = attachmentlink;
    data['orderattachment'] = orderattachment;
    data['orderattachmentII'] = orderattachmentII;
    data['orderattachmentIII'] = orderattachmentIII;
    data['bezasaat'] = bezasaat;
    data['TOTALBALANCECREDIT'] = tOTALBALANCECREDIT;
    data['TOTALREVENUE'] = tOTALREVENUE;
    data['TOTALREVENUE_THISMONTH'] = tOTALREVENUETHISMONTH;
    data['TOTALREVENUE_LASTMONTH'] = tOTALREVENUELASTMONTH;
    data['TOTALREVENUE_THISMONTH_BULAN'] = tOTALREVENUETHISMONTHBULAN;
    data['TOTALREVENUE_LASTMONTH_BULAN'] = tOTALREVENUELASTMONTHBULAN;
    data['TOTALORDER'] = tOTALORDER;
    data['actualsellingprice'] = actualsellingprice;
    data['actualpayingprice'] = actualpayingprice;
    data['shouldpayingprice'] = shouldpayingprice;
    data['tunaiditerimaREAL'] = tunaiditerimaREAL;
    data['tunaiditerima'] = tunaiditerima;
    data['bakidipulangkan'] = bakidipulangkan;
    data['note'] = note;
    data['notefromseller'] = notefromseller;
    data['notefromseller_subnota1'] = notefromsellerSubnota1;
    data['notefromseller_subnota2'] = notefromsellerSubnota2;
    data['fpxkey'] = fpxkey;
    data['camefrom'] = camefrom;
    data['reasonpayless'] = reasonpayless;
    data['typeofpayment'] = typeofpayment;
    data['finalnotes'] = finalnotes;
    data['productownerpid'] = productownerpid;
    data['productownerpenggunaid'] = productownerpenggunaid;
    data['agentpenggunaid'] = agentpenggunaid;
    data['hideImage_TEMPO'] = hideImageTEMPO;
    data['hideImage'] = hideImage;
    data['rejectEmailNotification'] = rejectEmailNotification;
    data['allowAgentToEdit'] = allowAgentToEdit;
    data['allowAgentToEditFPX'] = allowAgentToEditFPX;
    data['agentMustSelectPostage'] = agentMustSelectPostage;
    data['hideActualQuantity'] = hideActualQuantity;
    data['createdbypenggunaid'] = createdbypenggunaid;
    data['createdby'] = createdby;
    data['courier'] = courier;
    data['openattachment'] = openattachment;
    data['jenispenghantaran'] = jenispenghantaran;
    data['LMSwarehouseorderid'] = lMSwarehouseorderid;
    data['SAPorderid'] = sAPorderid;
    data['WEBHOOKorderid'] = wEBHOOKorderid;
    data['WEBHOOKorderid_status'] = wEBHOOKorderidStatus;
    data['WEBHOOKorderid_httpcode'] = wEBHOOKorderidHttpcode;
    data['currency_hq'] = currencyHq;
    data['shoppegram_paymentgateway'] = shoppegramPaymentgateway;
    data['shoppegram_orderid'] = shoppegramOrderid;
    data['shoppegram_url'] = shoppegramUrl;
    data['woo_url'] = wooUrl;
    data['woo_orderid'] = wooOrderid;
    data['woo_paymentgateway'] = wooPaymentgateway;
    data['woo_payment_txn'] = wooPaymentTxn;
    data['woo_paymentgateway_id'] = wooPaymentgatewayId;
    data['tiktokshop_orderid'] = tiktokshopOrderid;
    data['shopee_orderid'] = shopeeOrderid;
    data['sp_orderid'] = spOrderid;
    data['sp_url'] = spUrl;
    data['woo_codecoupon'] = wooCodecoupon;
    data['laststatusninjavandelivery'] = laststatusninjavandelivery;
    data['laststatusninjavandelivery_datetime'] =
        laststatusninjavandeliveryDatetime;
    data['laststatusdhldelivery'] = laststatusdhldelivery;
    data['laststatusdhldelivery_datetime'] = laststatusdhldeliveryDatetime;
    data['laststatusjntdelivery'] = laststatusjntdelivery;
    data['laststatusjntdelivery_datetime'] = laststatusjntdeliveryDatetime;
    data['laststatuscitylinkdelivery'] = laststatuscitylinkdelivery;
    data['laststatuscitylinkdelivery_datetime'] =
        laststatuscitylinkdeliveryDatetime;
    data['laststatusflashdelivery'] = laststatusflashdelivery;
    data['laststatusflashdelivery_datetime'] =
        laststatusflashdeliveryDatetime;
    data['laststatusbestexpressdelivery'] = laststatusbestexpressdelivery;
    data['laststatusbestexpressdelivery_datetime'] =
        laststatusbestexpressdeliveryDatetime;
    data['laststatusefmxdelivery'] = laststatusefmxdelivery;
    data['laststatusefmxdelivery_datetime'] =
        laststatusefmxdeliveryDatetime;
    data['laststatusabxdelivery'] = laststatusabxdelivery;
    data['laststatusabxdelivery_datetime'] = laststatusabxdeliveryDatetime;
    data['laststatusezisenddelivery'] = laststatusezisenddelivery;
    data['laststatusezisenddelivery_return'] =
        laststatusezisenddeliveryReturn;
    data['laststatusezisenddelivery_datetime'] =
        laststatusezisenddeliveryDatetime;
    data['laststatustiktokshopdelivery'] = laststatustiktokshopdelivery;
    data['laststatustiktokshopdelivery_datetime'] =
        laststatustiktokshopdeliveryDatetime;
    data['reason4cancel'] = reason4cancel;
    data['trackingnoupdatebypid_penggunaid'] =
        trackingnoupdatebypidPenggunaid;
    data['bizappbot_sent'] = bizappbotSent;
    data['bizappbot_sentstatus'] = bizappbotSentstatus;
    data['bizappbot_sentcount'] = bizappbotSentcount;
    data['wsapme_sent'] = wsapmeSent;
    data['wsapme_sentstatus'] = wsapmeSentstatus;
    data['wsapme_sentcount'] = wsapmeSentcount;
    data['paymenttype'] = paymenttype;
    data['pos_tempid'] = posTempid;
    return data;
  }
}