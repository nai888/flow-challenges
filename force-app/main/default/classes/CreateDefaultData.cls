/**
 ** This code is adapted from the article at https://www.salesforce4ever.com/load-data-stored-as-csv-files-in-static-resources/.
 */
public with sharing class CreateDefaultData {
  public CreateDefaultData () {

  }

  private String QueryFile (String filename) {
    StaticResource CsvFile = null;
    String CsvBody = '';

    // Get the Static Resource
    StaticResource[] CsvFiles = [SELECT Id, Body FROM StaticResource WHERE Name = :filename LIMIT 1];

    // If a Static Resource is found, stringify the body of the file
    if (!CsvFiles.isEmpty()) {
      CsvFile = CsvFiles[0];
      CsvBody = CsvFile.Body.toString();
    }

    return CsvBody;
  }
}
