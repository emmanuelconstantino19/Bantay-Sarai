import 'package:flutter/material.dart';
import 'package:bantay_sarai/models/Farm.dart';
import 'package:bantay_sarai/screens/finalize_farm.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:geolocator/geolocator.dart';

class AddFarmView extends StatefulWidget {
  final Farm farm;
  AddFarmView({Key key, @required this.farm}) : super(key: key);

  @override
  _AddFarmViewState createState() => _AddFarmViewState();
}


class _AddFarmViewState extends State<AddFarmView> {
  String _choice = 'Yes';
  String cropPlanted, location, farmType, farmOwnership;
  TextEditingController _farmNameController = new TextEditingController();
  TextEditingController _annualIncomeController = new TextEditingController();
  TextEditingController _farmSizeController = new TextEditingController();
  final _formKey = GlobalKey<FormState>();

  Position farmCoordinates;

  Future<Position> _determinePosition() async {
    bool serviceEnabled;
    LocationPermission permission;

    // Test if location services are enabled.
    serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      // Location services are not enabled don't continue
      // accessing the position and request users of the
      // App to enable the location services.
      return Future.error('Location services are disabled.');
    }

    permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        // Permissions are denied, next time you could try
        // requesting permissions again (this is also where
        // Android's shouldShowRequestPermissionRationale
        // returned true. According to Android guidelines
        // your App should show an explanatory UI now.
        return Future.error('Location permissions are denied');
      }
    }

    if (permission == LocationPermission.deniedForever) {
      // Permissions are denied forever, handle appropriately.
      return Future.error(
          'Location permissions are permanently denied, we cannot request permissions.');
    }

    // When we reach here, permissions are granted and we can
    // continue accessing the position of the device.
    return await Geolocator.getCurrentPosition();
  }

  String province, municipality;
  var provinceMap = {
    "Abra": ["Bangued","Boliney","Bucay","Bucloc","Daguioman","Danglas","Dolores","La Paz","Lacub","Lagangilang","Lagayan","Langiden","Licuan-Baay","Luba","Malibcong","Manabo","Peñarrubia","Pidigan","Pilar","Sallapadan","San Isidro","San Juan","San Quintin","Tayum","Tineg","Tubo","Villaviciosa"],

    "Agusan del Norte": ["Buenavista","Butuan City","Cabadbaran City","Carmen","Jabonga","Kitcharao","Las Nieves","Magallanes","Mainit Lake","Nasipit","Remedios T. Romualdez","Santiago","Tubay"],

    "Agusan del Sur": ["Bayugan City","Bunawan","Esperanza","La Paz","Loreto","Prosperidad","Rosario","San Francisco","San Luis","Santa Josefa","Sibagat","Talacogon","Trento","Veruela"],

    "Aklan": ["Altavas","Balete","Banga","Batan","Buruanga","Ibajay","Kalibo","Lezo","Libacao","Madalag","Makato","Malay","Malinao","Nabas","New Washington","Numancia","Tangalan"],

    "Albay": ["Bacacay","Bato Lake","Camalig","Daraga","Guinobatan","Jovellar","Legazpi City","Libon","Ligao City","Malilipot","Malinao","Manito","Oas","Pio Duran","Polangui","Rapu-Rapu","Santo Domingo","Tabaco City","Tiwi"],

    "Antique": ["Anini-Y","Barbaza","Belison","Bugasong","Caluya","Culasi","Hamtic","Laua-An","Libertad","Pandan","Patnongon","San Jose","San Remigio","Sebaste","Sibalom","Tibiao","Tobias Fornier","Valderrama"],

    "Apayao": ["Calanasan","Conner","Flora","Kabugao","Luna","Pudtol","Santa Marcela"],

    "Aurora": ["Baler","Casiguran","Dilasag","Dinalungan","Dingalan","Dipaculao","Maria Aurora","San Luis"],

    "Basilan": [" Akbar"," Al-Barka"," Hadji Mohammad Ajul"," Isabela City"," Lamitan City"," Lantawan"," Maluso"," Sumisip"," Tipo-Tipo"," Tuburan"," Ungkaya Pukan"] ,

    "Bataan": ["Abucay","Bagac","Balanga City","Dinalupihan","Hermosa","Limay","Mariveles","Morong","Orani","Orion","Pilar","Samal"],

    "Batanes": ["Basco","Itbayat","Ivana","Mahatao","Sabtang","Uyugan"],

    "Batangas": ["Agoncillo","Alitagtag","Balayan","Balete","Batangas City","Bauan","Calaca","Calatagan","Cuenca","Ibaan","Laurel","Lemery","Lian","Lipa City","Lobo","Mabini","Malvar","Mataas Na Kahoy","Nasugbu","Padre Garcia","Rosario","San Jose","San Juan","San Luis","San Nicolas","San Pascual","Santa Teresita","Santo Tomas","Taal","Taal lake","Talisay","Tanauan City","Taysan","Tingloy","Tuy"],

    "Benguet": ["Atok","Baguio City","Bakun","Bokod","Buguias","Itogon","Kabayan","Kapangan","Kibungan","La Trinidad","Mankayan","Sablan","Tuba","Tublay"],

    "Biliran": ["Almeria","Biliran","Cabucgayan","Caibiran","Culaba","Kawayan","Maripipi","Naval"],

    "Bohol": ["Albuquerque","Alicia","Anda","Antequera","Baclayon","Balilihan","Batuan","Bien Unido","Bilar","Buenavista","Calape","Candijay","Carmen","Catigbian","Clarin","Corella","Cortes","Dagohoy","Danao","Dauis","Dimiao","Duero","Garcia Hernandez","Guindulman","Inabanga","Jagna","Jetafe","Lila","Loay","Loboc","Loon","Mabini","Maribojoc","Panglao","Pilar","Pres. Carlos P. Garcia","Sagbayan","San Isidro","San Miguel","Sevilla","Sierra Bullones","Sikatuna","Tagbilaran City","Talibon","Trinidad","Tubigon","Ubay","Valencia"],

    "Bukidnon": ["Baungon","Cabanglasan","Damulog","Dangcagan","Don Carlos","Impasug-Ong","Kadingilan","Kalilangan","Kibawe","Kitaotao","Lantapan","Libona","Malaybalay City","Malitbog","Manolo Fortich","Maramag","Pangantucan","Quezon","San Fernando","Sumilao","Talakag","Valencia City"],

    "Bulacan": ["Angat","Balagtas","Baliuag","Bocaue","Bulacan","Bustos","Calumpit","Doña Remedios Trinidad","Guiguinto","Hagonoy","Malolos City","Marilao","Meycauayan City","Norzagaray","Obando","Pandi","Paombong","Plaridel","Pulilan","San Ildefonso","San Jose del Monte City","San Miguel","San Rafael","Santa Maria"],

  "Cagayan": ["Abulug","Alcala","Allacapan","Amulung","Aparri","Baggao","Ballesteros","Buguey","Calayan","Camalaniugan","Claveria","Enrile","Gattaran","Gonzaga","Iguig","Lal-Lo","Lasam","Pamplona","Peñablanca","Piat","Rizal","Sanchez-Mira","Santa Ana","Santa Praxedes","Santa Teresita","Santo Niño","Solana","Tuao","Tuguegarao City"],

  "Camarines Norte": ["Basud","Capalonga","Daet","Jose Panganiban","Labo","Mercedes","Paracale","San Lorenzo Ruiz","San Vicente","Santa Elena","Talisay","Vinzons"],

  "Camarines Sur": ["Baao","Balatan","Bato","Bato Lake","Bombon","Buhi","Buhi Lake","Bula","Cabusao","Calabanga","Camaligan","Canaman","Caramoan","Del Gallego","Gainza","Garchitorena","Goa","Iriga City","Lagonoy","Libmanan","Lupi","Magarao","Milaor","Minalabac","Nabua","Naga City","Ocampo","Pamplona","Pasacao","Pili","Presentacion","Ragay","Sagnay","San Fernando","San Jose","Sipocot","Siruma","Tigaon","Tinambac"],

  "Camiguin": ["Catarman","Guinsiliban","Mahinog","Mambajao","Sagay"],

  "Capiz": ["Cuartero","Dao","Dumalag","Dumarao","Ivisan","Jamindan","Ma-Ayon","Mambusao","Panay","Panitan","Pilar","Pontevedra","President Roxas","Roxas City","Sapi-An","Sigma","Tapaz"],

  "Catanduanes": ["Bagamanoc","Baras","Bato","Caramoran","Gigmoto","Pandan","Panganiban","San Andres","San Miguel","Viga","Virac"],

  "Cavite": ["Alfonso","Amadeo","Bacoor","Carmona","Cavite City","Dasmariñas","General Emilio Aguinaldo","General Mariano Alvarez","General Trias","Imus","Indang","Kawit","Magallanes","Maragondon","Mendez","Naic","Noveleta","Rosario","Silang","Tagaytay City","Tanza","Ternate","Trece Martires City"],

"Cebu": ["Alcantara","Alcoy","Alegria","Aloguinsan","Argao","Asturias","Badian","Balamban","Bantayan","Barili","Bogo City","Boljoon","Borbon","Carcar","Carmen","Catmon","Cebu City","Compostela","Consolacion","Cordoba","Daanbantayan","Dalaguete","Danao City","Danao Lake","Dumanjug","Ginatilan","Lapu-Lapu City","Liloan","Madridejos","Malabuyoc","Mandaue City","Medellin","Minglanilla","Moalboal","Naga City","Oslob","Pilar","Pinamungahan","Poro","Ronda","Samboan","San Fernando","San Francisco","San Remigio","Santa Fe","Santander","Sibonga","Sogod","Tabogon","Tabuelan","Talisay City","Toledo City","Tuburan","Tudela"],

"Compostela Valley": ["Compostela","Laak","Mabini","Maco","Maragusan","Mawab","Monkayo","Montevista","Nabunturan","New Bataan","Pantukan"],

"Davao del Norte": ["Asuncion","Braulio E. Dujali","Carmen","Kapalong","New Corella","Panabo City","Samal City","San Isidro","Santo Tomas","Tagum City","Talaingod"],

"Davao del Sur": ["Bansalan","Davao City","Digos City","Don Marcelino","Hagonoy","Jose Abad Santos","Kiblawan","Magsaysay","Malalag","Malita","Matanao","Padada","Santa Cruz","Santa Maria","Sarangani","Sulop"],

"Davao Oriental": ["Baganga","Banaybanay","Boston","Caraga","Cateel","Governor Generoso","Lupon","Manay","Mati City","San Isidro","Tarragona"],

"Dinagat Islands": ["Basilisa","Cagdianao","Dinagat","Libjo","Loreto","San Jose","Tubajon"],

"Eastern Samar": ["Arteche","Balangiga","Balangkayan","Borongan City","Can-Avid","Dolores","General Macarthur","Giporlos","Guiuan","Hernani","Jipapad","Lawaan","Llorente","Maslog","Maydolong","Mercedes","Oras","Quinapondan","Salcedo","San Julian","San Policarpo","Sulat","Taft"],

"Guimaras": ["Buenavista","Jordan","Nueva Valencia","San Lorenzo","Sibunag"],

"Ifugao": ["Aguinaldo","Alfonso Lista","Asipulo","Banaue","Hingyon","Hungduan","Kiangan","Lagawe","Lamut","Mayoyao","Tinoc"],

"Ilocos Norte": ["Adams","Bacarra","Badoc","Bangui","Banna","Batac City","Burgos","Carasi","Currimao","Dingras","Dumalneg","Laoag City","Marcos","Nueva Era","Pagudpud","Paoay","Paoay Lake","Pasuquin","Piddig","Pinili","San Nicolas","Sarrat","Solsona","Vintar"],

"Ilocos Sur": ["Alilem","Banayoyo","Bantay","Burgos","Cabugao","Candon City","Caoayan","Cervantes","Galimuyod","Gregorio Del Pilar","Lidlidda","Magsingal","Nagbukel","Narvacan","Quirino","Salcedo","San Emilio","San Esteban","San Ildefonso","San Juan","San Vicente","Santa","Santa Catalina","Santa Cruz","Santa Lucia","Santa Maria","Santiago","Santo Domingo","Sigay","Sinait","Sugpon","Suyo","Tagudin","Vigan City"],

"Iloilo": ["Ajuy","Alimodian","Anilao","Badiangan","Balasan","Banate","Barotac Nuevo","Barotac Viejo","Batad","Bingawan","Cabatuan","Calinog","Carles","Concepcion","Dingle","Duenas","Dumangas","Estancia","Guimbal","Igbaras","Iloilo City","Janiuay","Lambunao","Leganes","Lemery","Leon","Maasin","Miagao","Mina","New Lucena","Oton","Passi City","Pavia","Pototan","San Dionisio","San Enrique","San Joaquin","San Miguel","San Rafael","Santa Barbara","Sara","Tigbauan","Tubungan","Zarraga"],

"Isabela": ["Alicia","Angadanan","Aurora","Benito Soliven","Burgos","Cabagan","Cabatuan","Cauayan City","Cordon","Delfin Albano","Dinapigue","Divilacan","Echague","Gamu","Ilagan","Jones","Luna","Maconacon","Mallig","Naguilian","Palanan","Quezon","Quirino","Ramon","Reina Mercedes","Roxas","San Agustin","San Guillermo","San Isidro","San Manuel","San Mariano","San Mateo","San Pablo","Santa Maria","Santiago City","Santo Tomas","Tumauini"],

"Kalinga": ["Balbalan","Lubuagan","Pasil","Pinukpuk","Rizal","Tabuk City","Tanudan","Tinglayan"],

"La Union": ["Agoo","Aringay","Bacnotan","Bagulin","Balaoan","Bangar","Bauang","Burgos","Caba","Luna","Naguilian","Pugo","Rosario","San Fernando City","San Gabriel","San Juan","Santo Tomas","Santol","Sudipen","Tubao"],

"Laguna": ["Alaminos","Bay","Biñan","Cabuyao","Calamba City","Calauan","Cavinti","Famy","Kalayaan","Kalibato Lake","Laguna lake","Liliw","Los Baños","Luisiana","Lumban","Mabitac","Magdalena","Majayjay","Nagcarlan","Paete","Pagsanjan","Pakil","Palakpakin Lake","Pangil","Pila","Rizal","Sampaloc Lake","San Pablo City","San Pedro","Santa Cruz","Santa Maria","Santa Rosa City","Siniloan","Victoria","Waterbody"],

"Lanao del Norte": ["Bacolod","Baloi","Baroy","Iligan City","Kapatagan","Kauswagan","Kolambugan","Lala","Linamon","Magsaysay","Maigo","Matungao","Munai","Nunungan","Pantao Ragat","Pantar","Poona Piagapo","Salvador","Sapad","Sultan Naga Dimaporo","Tagoloan","Tangcal","Tubod"],

"Lanao del Sur": ["Bacolod Kalawi","Balabagan","Balindong","Bayang","Binidayan","Buadiposo-Buntong","Bubong","Bumbaran","Butig","Calanogas","Dapao Lake","Ditsaan-Ramain","Ganassi","Kapai","Kapatagan","Lanao Lake","Lumba-Bayabao","Lumbaca Unayan","Lumbatan","Lumbayanague","Madalum","Madamba","Maguing","Malabang","Marantao","Marawi City","Marogong","Masiu","Mulondo","Pagayawan","Piagapo","Picong","Poona Bayabao","Pualas","Saguiaran","Sultan Dumalondong","Tagoloan II","Tamparan","Taraka","Tubaran","Tugaya","Wao"],

"Leyte": ["Abuyog","Alangalang","Albuera","Babatngon","Barugo","Bato","Baybay City","Burauen","Calubian","Capoocan","Carigara","Dagami","Dulag","Hilongos","Hindang","Inopacan","Isabel","Jaro","Javier","Julita","Kananga","La Paz","Leyte","Macarthur","Mahaplag","Matag-Ob","Matalom","Mayorga","Merida","Ormoc City","Palo","Palompon","Pastrana","San Isidro","San Miguel","Santa Fe","Tabango","Tabontabon","Tacloban City","Tanauan","Tolosa","Tunga","Villaba"],

"Maguindanao": ["Ampatuan","Buluan","Buluan Lake","Cotabato City","Datu Abdullah Sanki","Datu Anggal Midtimbang","Datu Paglas","Datu Piang","Datu Saudi-Ampatuan","Datu Unsay","Gen. S. K. Pendatun","Guindulungan","Mamasapano","Mangudadatu","Pagagawan","Pagalungan","Paglat","Pandag","Rajah Buayan","Shariff Aguak","South Upi","Sultan Sa Barongis","Talayan","Talitay"],

"Marinduque": ["Boac","Buenavista","Gasan","Mogpog","Santa Cruz","Torrijos"],

"Masbate": ["Aroroy","Baleno","Balud","Batuan","Cataingan","Cawayan","Claveria","Dimasalang","Esperanza","Mandaon","Masbate City","Milagros","Mobo","Monreal","Palanas","Pio V. Corpuz","Placer","San Fernando","San Jacinto","San Pascual","Uson"],

"Metropolitan Manila": ["Kalookan City","Las Piñas","Makati City","Malabon","Mandaluyong","Manila","Marikina","Muntinlupa","Navotas","Parañaque","Pasay City","Pasig City","Pateros","Quezon City","San Juan","Taguig","Valenzuela"],

"Misamis Occidental": ["Aloran","Baliangao","Bonifacio","Calamba","Clarin","Concepcion","Don Victoriano Chiongbian","Jimenez","Lopez Jaena","Oroquieta City","Ozamis City","Panaon","Plaridel","Sapang Dalaga","Sinacaban","Tangub City","Tudela"],

"Misamis Oriental": ["Alubijid","Balingasag","Balingoan","Binuangan","Cagayan de Oro City","Claveria","El Salvador City","Gingoog City","Gitagum","Initao","Jasaan","Kinoguitan","Lagonglong","Laguindingan","Libertad","Lugait","Magsaysay","Manticao","Medina","Naawan","Opol","Salay","Sugbongcogon","Tagoloan","Talisayan","Villanueva"],

"Mountain Province": ["Barlig","Bauko","Besao","Bontoc","Natonin","Paracelis","Sabangan","Sadanga","Sagada","Tadian"],

"Negros Occidental": ["Bacolod City","Bago City","Binalbagan","Cadiz City","Calatrava","Candoni","Cauayan","Enrique B. Magalona","Escalante City","Himamaylan City","Hinigaran","Hinoba-An","Ilog","Isabela","Kabankalan City","La Carlota City","La Castellana","Manapla","Moises Padilla","Murcia","Pontevedra","Pulupandan","Sagay City","Salvador Benedicto","San Carlos City","San Enrique","Silay City","Sipalay City","Talisay City","Toboso","Valladolid","Victorias City"],

"Negros Oriental": ["Amlan","Ayungon","Bacong","Bais City","Basay","Bayawan City","Bindoy","Canlaon City","Dauin","Dumaguete City","Guihulngan City","Jimalalud","La Libertad","Mabinay","Manjuyod","Pamplona","San Jose","Santa Catalina","Siaton","Sibulan","Tanjay City","Tayasan","Valencia","Vallehermoso","Zamboanguita"],

"North Cotabato": ["Alamada","Aleosan","Antipas","Arakan","Banisilan","Carmen","Kabacan","Kidapawan City","Libungan","Magpet","Makilala","Matalam","Midsayap","M'Lang","Pigkawayan","Pikit","President Roxas","Tulunan"],

"Northern Samar": ["Allen","Biri","Bobon","Capul","Catarman","Catubig","Gamay","Laoang","Lapinig","Las Navas","Lavezares","Lope de Vega","Mapanas","Mondragon","Palapag","Pambujan","Rosario","San Antonio","San Isidro","San Jose","San Roque","San Vicente","Silvino Lobos","Victoria"],

"Nueva Ecija": ["Aliaga","Bongabon","Cabanatuan City","Cabiao","Carranglan","Cuyapo","Gabaldon","Gapan City","General Mamerto Natividad","General Tinio","Guimba","Jaen","Laur","Licab","Llanera","Lupao","Muñoz City","Nampicuan","Palayan City","Pantabangan","Peñaranda","Quezon","Rizal","San Antonio","San Isidro","San Jose City","San Leonardo","Santa Rosa","Santo Domingo","Talavera","Talugtug","Zaragoza"],

"Nueva Vizcaya": ["Alfonso Castaneda","Ambaguio","Aritao","Bagabag","Bambang","Bayombong","Diadi","Dupax Del Norte","Dupax Del Sur","Kasibu","Kayapa","Quezon","Santa Fe","Solano","Villaverde"],

"Occidental Mindoro": ["Abra de Ilog","Calintaan","Looc","Lubang","Magsaysay","Mamburao","Paluan","Rizal","Sablayan","San Jose","Santa Cruz"],

"Oriental Mindoro": ["Baco","Bansud","Bongabong","Bulalacao","Calapan City","Gloria","Mansalay","Naujan","Naujan Lake","Pinamalayan","Pola","Puerto Galera","Roxas","San Teodoro","Socorro","Victoria"],

"Palawan": ["Aborlan","Agutaya","Araceli","Balabac","Bataraza","Brooke's Point","Busuanga","Cagayancillo","Coron","Culion","Cuyo","Dumaran","El Nido","Linapacan","Magsaysay","Narra","Puerto Princesa City","Quezon","Rizal","Roxas","San Vicente","Sofronio Espanola","Taytay"],

"Pampanga": ["Angeles City","Apalit","Arayat","Bacolor","Candaba","Floridablanca","Guagua","Lubao","Mabalacat","Macabebe","Magalang","Masantol","Mexico","Minalin","Porac","San Fernando City","San Luis","San Simon","Santa Ana","Santa Rita","Santo Tomas","Sasmuan"],

"Pangasinan": ["Agno","Aguilar","Alaminos City","Alcala","Anda","Asingan","Balungao","Bani","Basista","Bautista","Bayambang","Binalonan","Binmaley","Bolinao","Bugallon","Burgos","Calasiao","Dagupan City","Dasol","Infanta","Labrador","Laoac","Lingayen","Mabini","Malasiqui","Manaoag","Mangaldan","Mangatarem","Mapandan","Natividad","Pozzorubio","Rosales","San Carlos City","San Fabian","San Jacinto","San Manuel","San Nicolas","San Quintin","Santa Barbara","Santa Maria","Santo Tomas","Sison","Sual","Tayug","Umingan","Urbiztondo","Urdaneta City","Villasis"],

"Quezon": ["Agdangan","Alabat","Atimonan","Buenavista","Burdeos","Calauag","Candelaria","Catanauan","Dolores","General Luna","General Nakar","Guinayangan","Gumaca","Hinunangan","Infanta","Jomalig","Lopez","Lucban","Lucena City","Macalelon","Mauban","Mulanay","Padre Burgos","Pagbilao","Panukulan","Patnanungan","Perez","Pitogo","Plaridel","Polillo","Quezon","Real","Sampaloc","San Andres","San Antonio","San Francisco","San Narciso","Sariaya","Tagkawayan","Tayabas City","Tiaong","Unisan"],

"Quirino": ["Aglipay","Cabarroguis","Diffun","Maddela","Nagtipunan","Saguday"],

"Rizal": ["Angono","Antipolo City","Baras","Binangonan","Cainta","Cardona","Jala-Jala","Morong","Pililla","Rodriguez","San Mateo","Tanay","Taytay","Teresa"],

"Romblon": ["Alcantara","Banton","Cajidiocan","Calatrava","Concepcion","Corcuera","Ferrol","Looc","Magdiwang","Odiongan","Romblon","San Agustin","San Andres","San Fernando","San Jose","Santa Fe","Santa Maria"],

"Samar": ["Almagro","Basey","Calbayog City","Calbiga","Catbalogan City","Daram","Gandara","Hinabangan","Jiabong","Marabut","Matuguinao","Motiong","Pagsanghan","Paranas","Pinabacdao","San Jorge","San Jose de Buan","San Sebastian","Santa Margarita","Santa Rita","Santo Nino","Tagapul-An","Talalora","Tarangnan","Villareal","Zumarraga"],

"Sarangani": ["Alabel","Glan","Kiamba","Maasim","Maitum","Malapatan","Malungon"],

"Shariff Kabunsuan": ["Barira","Buldon","Datu Blah T. Sinsuat","Datu Odin Sinsuat","Kabuntalan","Matanog","Northern Kabuntalan","Parang","Sultan Kudarat","Sultan Mastura","Upi"],

"Siquijor": ["Enrique Villanueva","Larena","Lazi","Maria","San Juan","Siquijor"],

"Sorsogon": ["Barcelona","Bulan","Bulusan","Casiguran","Castilla","Donsol","Gubat","Irosin","Juban","Magallanes","Matnog","Pilar","Prieto Diaz","Santa Magdalena","Sorsogon City"],

"South Cotabato": ["Banga","General Santos City","Koronadal City","Lake Sebu","Norala","Polomolok","Santo Nino","Surallah","Tampakan","Tantangan","T'Boli","Tupi"],

"Southern Leyte": ["Anahawan","Bontoc","Hinunangan","Hinundayan","Libagon","Liloan","Limasawa","Maasin City","Macrohon","Malitbog","Padre Burgos","Pintuyan","Saint Bernard","San Francisco","San Juan","San Ricardo","Silago","Sogod","Tomas Oppus"],

"Sultan Kudarat": ["Bagumbayan","Buluan Lake","Columbio","Esperanza","Isulan","Kalamansig","Lambayong","Lebak","Lutayan","Palimbang","President Quirino","Sen. Ninoy Aquino","Tacurong City"],

"Sulu": ["Hadji Panglima Tahil","Indanan","Jolo","Kalingalan Caluang","Lugus","Luuk","Maimbung","Old Panamao","Pandami","Panglima Estino","Pangutaran","Parang","Pata","Patikul","Siasi","Talipao","Tapul","Tongkil"],

"Surigao del Norte": ["Alegria","Bacuag","Burgos","Claver","Dapa","Del Carmen","General Luna","Gigaquit","Mainit","Mainit Lake","Malimono","Pilar","Placer","San Benito","San Francisco","San Isidro","Santa Monica","Sison","Socorro","Surigao City","Tagana-An","Tubod"],

"Surigao del Sur": ["Barobo","Bayabas","Bislig City","Cagwait","Cantilan","Carmen","Carrascal","Cortes","Hinatuan","Lanuza","Lianga","Lingig","Madrid","Marihatag","San Agustin","San Miguel","Tagbina","Tago","Tandag City"],

"Tarlac": ["Anao","Bamban","Camiling","Capas","Concepcion","Gerona","La Paz","Mayantoc","Moncada","Paniqui","Pura","Ramos","San Clemente","San Jose","San Manuel","Santa Ignacia","Tarlac City","Victoria"],

"Tawi-tawi": ["Bongao","Languyan","Mapun","Panglima Sugala","Sapa-Sapa","Sibutu","Simunul","Sitangkai","South Ubian","Tandubas","Turtle Islands"],

"Zambales": ["Botolan","Cabangan","Candelaria","Castillejos","Iba","Masinloc","Olongapo City","Palauig","San Antonio","San Felipe","San Marcelino","San Narciso","Santa Cruz","Subic"],

"Zamboanga del Norte": ["Bacungan","Baliguian","Dapitan City","Dipolog City","Godod","Gutalac","Jose Dalman","Kalawit","Katipunan","La Libertad","Labason","Liloy","Manukan","Mutia","Pinan","Polanco","Pres. Manuel A. Roxas","Rizal","Salug","Sergio Osmena Sr.","Siayan","Sibuco","Sibutad","Sindangan","Siocon","Sirawai","Tampilisan"],

"Zamboanga del Sur": ["Aurora","Bayog","Dimataling","Dinas","Dumalinao","Dumingag","Guipos","Josefina","Kumalarang","Labangan","Lakewood","Lakewood Lake","Lapuyan","Mahayag","Margosatubig","Midsalip","Molave","Pagadian City","Pitogo","Ramon Magsaysay","San Miguel","San Pablo","Sominot","Tabina","Tambulig","Tigbao","Tukuran","Vincenzo A. Sagun","Zamboanga City"],

"Zamboanga Sibugay": ["Alicia","Buug","Diplahan","Imelda","Ipil","Kabasalan","Mabuhay","Malangas","Naga","Olutanga","Payao","Roseller Lim","Siay","Talusan","Titay","Tungawan"] ,
  };

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text("Add Farm"),
          centerTitle: true,
          elevation: 1,
        ),
        body: SingleChildScrollView(
            padding: EdgeInsets.symmetric(horizontal:MediaQuery.of(context).size.width/10, vertical:20),
            child: Form(
                key: _formKey,
              child: Column(
                children: <Widget>[
                  TextFormField(
                    validator: (val) => val.isEmpty ? 'field required' : null,
                    //autofocus: true,
                    decoration: new InputDecoration(
                        border: OutlineInputBorder(),
                        fillColor: Colors.white,
                        filled: true,
                        labelText: 'Farm name'),
                    controller: _farmNameController,
                  ),
                  SizedBox(height:10),
                  DropdownButtonFormField<String>(
                    validator: (value) => value == null ? 'field required' : null,
                    value: cropPlanted,
                    decoration: new InputDecoration(
                        border: OutlineInputBorder(),
                        fillColor: Colors.white,
                        filled: true,
                        labelText: 'Crop Planted'),
                    onChanged: (String newValue) {
                      setState(() {
                        cropPlanted = newValue;
                      });
                    },
                    items: <String>[
                      'Banana',
                      'Cacao',
                      'Coconut',
                      'Coffee',
                      'Corn',
                      'Rice',
                      'Soybean',
                      'Sugarcane',
                      'Tomato',
                      'Other Crop'
                    ]
                        .map<DropdownMenuItem<String>>((String value) {
                      return DropdownMenuItem<String>(
                        value: value,
                        child: Text(value),
                      );
                    }).toList(),
                  ),
                  SizedBox(height:10),
                  TextFormField(
                      validator: (val) => val.isEmpty ? 'field required' : null,
                      //autofocus: true,
                      keyboardType: TextInputType.number,
                      decoration: new InputDecoration(
                          border: OutlineInputBorder(),
                          fillColor: Colors.white,
                          filled: true,
                          labelText: 'Gross Annual Income Last Year'),
                      controller: _annualIncomeController
                  ),
                  SizedBox(height:10),
//                  DropdownButtonFormField<String>(
//                    validator: (value) => value == null ? 'field required' : null,
//                    value: location,
//                    decoration: new InputDecoration(
//                        border: OutlineInputBorder(),
//                        fillColor: Colors.white,
//                        filled: true,
//                        labelText: 'Location'),
//                    onChanged: (String newValue) {
//                      setState(() {
//                        location = newValue;
//                      });
//                    },
//                    items: <String>[
//                      'Bae, Laguna',
//                      'Nagcarlan, Laguna',
//                      'Pakil, Laguna',
//                    ]
//                        .map<DropdownMenuItem<String>>((String value) {
//                      return DropdownMenuItem<String>(
//                        value: value,
//                        child: Text(value),
//                      );
//                    }).toList(),
//                  ),
//                  SizedBox(height:10),
                  DropdownButtonFormField<String>(
                    validator: (value) => value == null ? 'field required' : null,
                    value: province,
                    decoration: new InputDecoration(
                        border: OutlineInputBorder(),
                        fillColor: Colors.white,
                        filled: true,
                        labelText: 'Province'),
                    onChanged: (String newValue) {
                      setState(() {
                        municipality=null;
                        province = newValue;
                      });
                    },
                    items: provinceMap.keys
                        .map<DropdownMenuItem<String>>((String value) {
                      return DropdownMenuItem<String>(
                        value: value,
                        child: Text(value),
                      );
                    }).toList(),
                  ),
                  SizedBox(height:10),
                  Column(
                    children: [
                      DropdownButtonFormField<String>(
                        validator: (value) => value == null ? 'field required' : null,
                        value: municipality,
                        decoration: new InputDecoration(
                            border: OutlineInputBorder(),
                            fillColor: Colors.white,
                            filled: true,
                            labelText: 'Municipality'),
                        onChanged: (String newValue) {
                          setState(() {
                            municipality = newValue;
                          });
                        },
                        items: province!=null ? provinceMap[province]
                            .map<DropdownMenuItem<String>>((String value) {
                          return DropdownMenuItem<String>(
                            value: value,
                            child: Text(value),
                          );
                        }).toList() : [],
                      ),
                      SizedBox(height:10),
                    ],
                  ),
                  TextFormField(
                      validator: (val) => val.isEmpty ? 'field required' : null,
                      //autofocus: true,
                      keyboardType: TextInputType.number,
                      decoration: new InputDecoration(
                          border: OutlineInputBorder(),
                          fillColor: Colors.white,
                          filled: true,
                          labelText: 'Farm Size (ha)'),
                      controller: _farmSizeController
                  ),
                  SizedBox(height:10),
                  DropdownButtonFormField<String>(
                    validator: (value) => value == null ? 'field required' : null,
                    value: farmType,
                    decoration: new InputDecoration(
                        border: OutlineInputBorder(),
                        fillColor: Colors.white,
                        filled: true,
                        labelText: 'Farm Type'),
                    onChanged: (String newValue) {
                      setState(() {
                        farmType = newValue;
                      });
                    },
                    items: <String>[
                      'Irrigated',
                      'Rainfed Upland',
                      'Rainfed Lowland',
                    ]
                        .map<DropdownMenuItem<String>>((String value) {
                      return DropdownMenuItem<String>(
                        value: value,
                        child: Text(value),
                      );
                    }).toList(),
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Padding(
                        padding: EdgeInsets.only(top:20),
                        child: Text('Are you an organic practioner?',style: TextStyle(color:Colors.grey[600],fontSize: 15),),
                      ),
                      ListTile(
                        title: const Text('Yes'),
                        leading: Radio(
                          value: 'Yes',
                          groupValue: _choice,
                          onChanged: (String value) {
                            setState(() {
                              _choice = value;
                              print(_choice);
                            });
                          },
                        ),
                      ),
                      ListTile(
                        title: const Text('No'),
                        leading: Radio(
                          value: 'No',
                          groupValue: _choice,
                          onChanged: (String value) {
                            setState(() {
                              _choice = value;
                            });
                          },
                        ),
                      ),
                    ],
                  ),
                  DropdownButtonFormField<String>(
                    validator: (value) => value == null ? 'field required' : null,
                    value: farmOwnership,
                    decoration: new InputDecoration(
                        border: OutlineInputBorder(),
                        fillColor: Colors.white,
                        filled: true,
                        labelText: 'Farm Ownership'),
                    onChanged: (String newValue) {
                      setState(() {
                        farmOwnership = newValue;
                      });
                    },
                    items: <String>[
                      'Registered Owner',
                      'Tenant',
                      'Lessee',
                    ]
                        .map<DropdownMenuItem<String>>((String value) {
                      return DropdownMenuItem<String>(
                        value: value,
                        child: Text(value),
                      );
                    }).toList(),
                  ),
                  SizedBox(height:30),
                  Row(
                    children: [
                      Text('Get Farm Coordinates - '),
                      Text('Optional', style: TextStyle(fontStyle: FontStyle.italic,))
                    ],
                  ),
                  SizedBox(height:10),
                  Text("Coordinates: [ ${farmCoordinates==null? '' : farmCoordinates.latitude.toString() + ', ' + farmCoordinates.longitude.toString()} ]"),
                  SizedBox(height:10),
                  Row(
                    children: [
                      Expanded(
                        child: OutlinedButton(
                          onPressed: () async {
                            Position coordinates;
                            coordinates = await _determinePosition();
                            setState(() {
                              farmCoordinates = coordinates;
                            });
                            },
                          child: Padding(
                            padding: EdgeInsets.all(16.0),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Icon(
                                  Icons.location_on,
                                  color: Colors.blue,
                                ),
                                Text('Press to get coordinates of farm'),
                              ],
                            ),
                          ), style: ButtonStyle(
                          foregroundColor: MaterialStateProperty.all<Color>(Colors.blue),
                        ),),
                      ),
                    ],
                  ),
                  SizedBox(height:10),
                  Text('Note: This will get your current coordinates. Make sure that you are in your farm location.', style: TextStyle(fontWeight: FontWeight.bold)),
                  SizedBox(height:30),
                  Row(
                    children: [
                      Expanded(
                        child:
                        ElevatedButton(
                          child: Padding(
                            padding: EdgeInsets.all(16.0),
                            child: Text('Submit'),
                          ),
                          onPressed: () async {
                            if(_formKey.currentState.validate()){
                              widget.farm.farmName = _farmNameController.text;
                              widget.farm.cropsPlanted = cropPlanted;
                              widget.farm.annualIncome = _annualIncomeController.text;
                              widget.farm.location = "${municipality}, ${province}";
                              widget.farm.farmSize = _farmSizeController.text;
                              widget.farm.farmType = farmType;
                              widget.farm.organicPractitioner = _choice;
                              widget.farm.farmOwnership = farmOwnership;
                              widget.farm.coordinates = farmCoordinates!=null ? [farmCoordinates.latitude,farmCoordinates.longitude] : null;
                              FocusScopeNode currentFocus = FocusScope.of(context);

                              if (!currentFocus.hasPrimaryFocus) {
                                currentFocus.unfocus();
                              }
                              Navigator.push(
                                context,
                                MaterialPageRoute(builder: (context) => FinalizeFarm(farm: widget.farm)),
                              );
                            }
                          },
                        ),
                      ),
                    ],
                  ),
//                  Padding(
//                    padding: const EdgeInsets.symmetric(horizontal:40.0),
//                    child: SizedBox(
//                      width: double.infinity,
//                      child: RaisedButton(
//                        shape: RoundedRectangleBorder(
//                            borderRadius: BorderRadius.circular(30.0),
//                            side: BorderSide(color: Colors.lightGreen[700])
//                        ),
//                        color: Colors.lightGreen[700],
//                        onPressed: () {
//                          if(_formKey.currentState.validate()){
//                            widget.farm.farmName = _farmNameController.text;
//                            widget.farm.cropsPlanted = cropPlanted;
//                            widget.farm.annualIncome = _annualIncomeController.text;
//                            widget.farm.location = location;
//                            widget.farm.farmSize = _farmSizeController.text;
//                            widget.farm.farmType = farmType;
//                            widget.farm.organicPractitioner = _choice;
//                            widget.farm.farmOwnership = farmOwnership;
//                            FocusScopeNode currentFocus = FocusScope.of(context);
//
//                            if (!currentFocus.hasPrimaryFocus) {
//                              currentFocus.unfocus();
//                            }
//                            Navigator.push(
//                              context,
//                              MaterialPageRoute(builder: (context) => FinalizeFarm(farm: widget.farm)),
//                            );
//                          }
//                        },
//                        textColor: Colors.white,
//                        padding: const EdgeInsets.symmetric(vertical:15.0),
//                        child: Text('Submit',style:TextStyle(fontSize:15)),
//                      ),
//                    ),
//                  ),
                ],
              )
            )
        )
    );
  }
}
