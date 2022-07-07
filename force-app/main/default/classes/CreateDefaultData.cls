/**
 ** This code is adapted from the article at https://www.salesforce4ever.com/load-data-stored-as-csv-files-in-static-resources/.
 */
public with sharing class CreateDefaultData {
  public CreateDefaultData () {

  }

  private String QueryFile (String filename) {
    // Get the Static Resource
    StaticResource CsvFile = [SELECT Id, Body FROM StaticResource WHERE Name = :filename LIMIT 1];

    // Stringify the content of the Static Resources
    String CsvBody = '';

    if (CsvFile != null) {
      CsvBody = CsvFile.Body.toString();
    }

    return CsvBody;
  }
}
