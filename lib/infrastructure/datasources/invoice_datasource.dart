import 'package:cip_payment_web/domain/datasources/invoice_datasource.dart';
import 'package:cip_payment_web/domain/entities/company.dart';
import 'package:cip_payment_web/infrastructure/mappers/company_mapper.dart';
import 'package:cip_payment_web/infrastructure/models/company_model.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class InvoicedbDatasource extends InvoiceDatasource {
  final FirebaseFirestore firestoredb = FirebaseFirestore.instance;

  @override
  Future<Company?> createRuc(CompanyModel newCompany) async {
    try {
      final response = await firestoredb
          .collection('Company')
          .add(newCompany.toJson());
      if (response.id.isNotEmpty) {
        // 2. Obtener datos recién guardados
        final snapshot = await response.get();
        final data = snapshot.data() as Map<String, dynamic>;

        // 3. Mapear a Response
        final companyResponse = CompanyModel.fromJson(data);

        // 4. Mapear a Entidad
        final newCompany = CompanyMapper.companyResponseToEntity(
          companyResponse,
        );
        return newCompany;
      }
      return null;
    } catch (e) {
      return null;
    }
  }

  @override
  Future<List<Company>> getRucs(String personId) async {
    try {
      final snapshot = await firestoredb
          .collection('Company')
          .where('personId', isEqualTo: personId)
          .get();

      final companiesResponse = snapshot.docs.map((doc) {
        final data = doc.data();
        return CompanyModel.fromJson(data);
      }).toList();
      // Mapear lista de Response a lista de Entity
      final companies = companiesResponse
          .map((resp) => CompanyMapper.companyResponseToEntity(resp))
          .toList();

      return companies;
    } catch (e) {
      // print('❌ Error al obtener cursos: $e');
      return [];
    }
  }

  @override
  Future<Company?> updateRuc(CompanyModel companyUpdate) async {
    try {
      // 1. Actualizar documento en Firestore
      await firestoredb.collection('Company').doc(companyUpdate.id).update({
        ...companyUpdate.toJson(), // asumiendo que tienes un método toJson()
        "status": "completed", // forzamos cambio de estado
        "updatedAt":
            FieldValue.serverTimestamp(), // opcional, timestamp del servidor
      });

      // 2. Obtener documento actualizado
      final snapshot = await firestoredb
          .collection('Company')
          .doc(companyUpdate.id)
          .get();

      if (snapshot.exists) {
        final data = snapshot.data() as Map<String, dynamic>;
        final companyResponse = CompanyModel.fromJson(data);
        final company = CompanyMapper.companyResponseToEntity(companyResponse);
        return company;
      } else {
        return null; // Documento no existe
      }
    } catch (e) {
      print("Error al actualizar RUC: $e");
      return null;
    }
  }
}
