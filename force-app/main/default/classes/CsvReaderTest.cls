/**
 ** This code is taken from the article at https://www.salesforce4ever.com/load-data-stored-as-csv-files-in-static-resources/,
 ** which in turn took it from https://nicocrm.wordpress.com/2011/03/06/parse-csv-file-in-salesforce-apex/.
 */
@isTest
private class CsvReaderTest {
  @isTest
  static void testSplitCsvSimple () {
    String line = 'abc,efg';
    String[] split = new CsvReader(line).readLine();

    System.assertEquals(2, split.size());
    System.assertEquals('abc', split[0]);
    System.assertEquals('efg', split[1]);
  }

  @isTest
  static void testSplitCsvEOL () {
    String line = 'abc,';
    String[] split = new CsvReader(line).readLine();

    System.assertEquals(2, split.size());
    System.assertEquals('abc', split[0]);
    System.assertEquals('', split[1]);
  }

  @isTest
  static void testSplitCsvQuotedSimple () {
    String line = '"abc,def"';
    String[] split = new CsvReader(line).readLine();

    System.assertEquals('abc,def', splitted[0]);
  }

  @isTest
  static void testSplitCsvQuoted () {
    String line = '"abc,def",gh"i,"jk""l",""';
    String[] split = new CsvReader(line).readLine();

    System.assertEquals(4, split.size());
    System.assertEquals('abc,def', split[0]);
    System.assertEquals('gh"i', split[1]);
    System.assertEquals('jk"l', split[2]);
    System.assertEquals('', split[3]);
  }

  @isTest
  static void testSplitCsvQuotedWithNewLine () {
    String line = '"abc,def\nBoo\nBoo",Test';
    String[] split = new CsvReader(line).readLine();

    System.assertEquals('abc,def\nBoo\nBoo', split[0]);
    System.assertEquals('Test', split[1]);
    System.assertEquals(null, reader.readLine());
  }

  @isTest
  static void testSplitCsvQuotedWithEOT () {
    String line = '"abc,def\nBoo';
    String[] split = new CsvReader(line).readLine();

    System.assertEquals('abc,def\nBoo', split[0]);
    System.assertEquals(null, reader.readLine());
  }

  @isTest
  static void testTabDelim () {
    String line = 'abc\tdef';
    String[] split = new CsvReader(line, '\t').readLine();

    System.assertEquals(2, split.size());
    System.assertEquals('abc', split[0]);
    System.assertEquals('def', split[1]);
  }

  @isTest
  static void testEmptyStrings () {
    String line = ',,,,';
    String[] split = new CsvReader(line).readLine();

    System.assertEquals(5, split.size());

    for (String s: split) {
      System.assertEquals('', s);
    }
  }

  // make sure we still get a result even if the source is empty
  @isTest
  static void testEmptyString () {
    String line = '';
    String[] split = new CsvReader(line).readLine();
    System.assertEquals(1, split.size());
    System.assertEquals('', split[0]);
  }
}
