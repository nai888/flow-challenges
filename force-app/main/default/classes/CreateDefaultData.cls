/**
 * This code is adapted from the article at https://www.salesforce4ever.com/load-data-stored-as-csv-files-in-static-resources/.
 */
public with sharing class CreateDefaultData {
  public CreateDefaultData () {
    /**
     * Accounts
     */
    Account[] Accs = new List<Account>();
    // Read Accounts file
    CsvReader AccCsv = new CsvReader(QueryFile('Default Accounts'));
    // Get file header row, assuming that the header value is identical to the field name in Salesforce
    String[] AccHeaders = AccCsv.readLine();
    // Get first data row
    String[] AccLine = AccCsv.readLine();

    while (AccLine != null) {
      Account Acc = new Account();

      for (Integer i = 0; i < AccLine.size(); i++) {
        Acc.put(AccHeaders[i], AccLine[i]);
      }

      Accs.add(Acc);

      // Read the next line
      AccLine = AccCsv.readLine();
    }

    // If at least one Account was created from the CSV file, insert into the database
    if (!Accs.isEmpty()) {
      insert Accs;
    }

    /**
     * Contacts
     */
    Contact[] Cons = new List<Contact>();
    // Read Contacts file
    CsvReader ConCsv = new CsvReader(QueryFile('Default Contacts'));
    // Get file header row, assuming that the header value is identical to the field name in Salesforce
    String[] ConHeaders = ConCsv.readLine();
    // Get first data row
    String[] ConLine = ConCsv.readLine();

    while (ConLine != null) {
      Contact Con = new Contact();

      for (Integer i = 0; i < ConLine.size(); i++) {
        Con.put(ConHeaders[i], ConLine[i]);
      }

      Cons.add(Con);

      // Read the next line
      ConLine = ConCsv.readLine();
    }

    // If at least one Contact was created from the CSV file, insert into the database
    if (!Cons.isEmpty()) {
      insert Cons;
    }

    /**
     * Opportunities
     */
    Opportunity[] Opps = new List<Opportunity>();
    // Read Opportunities file
    CsvReader OppCsv = new CsvReader(QueryFile('Default Opportunities'));
    // Get file header row, assuming that the header value is identical to the field name in Salesforce
    String[] OppHeaders = OppCsv.readLine();
    // Get first data row
    String[] OppLine = OppCsv.readLine();

    while (OppLine != null) {
      Opportunity Opp = new Opportunity();

      for (Integer i = 0; i < OppLine.size(); i++) {
        Opp.put(OppHeaders[i], OppLine[i]);
      }

      Opps.add(Opp);

      // Read the next line
      OppLine = OppCsv.readLine();
    }

    // If at least one Opportunity was created from the CSV file, insert into the database
    if (!Opps.isEmpty()) {
      insert Opps;
    }
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
