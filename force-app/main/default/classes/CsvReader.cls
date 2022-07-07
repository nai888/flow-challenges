/**
 ** This code is taken from the article at https://www.salesforce4ever.com/load-data-stored-as-csv-files-in-static-resources/,
 ** which in turn took it from https://nicocrm.wordpress.com/2011/03/06/parse-csv-file-in-salesforce-apex/.
 */
public with sharing class CsvReader {
  private String delim = ',';
  // the input data
  private String[] buffer;

  public CsvReader (String data) {
    this.buffer = data.split('\n');
  }

  public CsvReader (String data, String delim) {
    this.buffer = data.split('\n');
    this.delim = delim;
  }

  // Read and parse next available line. Return null if end of stream.
  public String[] readLine () {
    if (buffer.size() == 0) {
      return null;
    }

    String line = this.buffer.remove(0);
    String[] parts = new String[] {};

    while (line != '') {
      Integer next = 0;

      if (line.startsWith('"') ) {
        line = line.substring(1); // strip initial " character
        Integer quoteIndex = findDelim(line, 0);

        while (quoteIndex == -1) {
          if (buffer.size() == 0) {
            // EOT!
            quoteIndex = line.length();
          } else {
            // Grab the next line
            Integer skip = line.length();
            line += '\n' + this.buffer.remove(0);
            quoteIndex = findDelim(line, skip);
          }
        }

        // advance to delimiter
        next = quoteIndex + 1;
        parts.add(line.substring(0, quoteIndex).replace('""', '"'));
      } else {
        next = line.indexOf(this.delim, next);

        if (next == -1) {
          next = line.length();
        }

        // NB in Substring, "endindex" is the index of the character AFTER the last index to get
        parts.add(line.substring(0, next));
      }

      if (next == line.length() - 1) {
        // case of a terminating delimiter
        parts.add('');
        line = next < line.length() ? line.substring(next + 1) : '';
      }
    }

    if (parts.size() == 0) {
      // empty string - we still want to return something...
      parts.add('');
    }

    return parts;
  }

  static private Pattern delimPattern = Pattern.compile('(?<!")"(?!")');

  // Find next delimiter in the line
  private Integer findDelim (String line, Integer skip) {
    Matcher m = delimPattern.matcher(line);
    m.region(skip, m.regionEnd());

    if (!m.find()) {
      return -1;
    }

    return m.start();
  }
}
