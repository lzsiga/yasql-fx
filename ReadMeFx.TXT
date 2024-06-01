2024.06.01. Lorinczy Zsigmond
  * describe_fast is plain wrong (cf test/test0010), I'm removing it
  * Version number 1.83-0003

2024.05.30. Lorinczy Zsigmond
  * fix in parsing: special statement-end markers work again (cf test/
    test0009)
  * fix in the final print: don't do in batch mode
  * Version number 1.83-0002

2024.05.02. Lorinczy Zsigmond
  * command 'edit' now uses LC_CTYPE when writing/reading the temporary
    file
  * Version number 1.83-2

2024.03.xx. Lorinczy Zsigmond
  * Refactoring encoding (cf 'Wide character' problems)
  * Refactoring lexical parsing (cf 'semicolon in comment' problem)
  * using AL32UTF8 as charset and ncharset; using UTF-8 in history-file
  * using $LC_CTYPE in history (in memory)

2024.03.02. Lorinczy Zsigmond
  * Forked from https://sourceforge.net/projects/yasql/ version 1.83
    renamed as 'yasql-fx' (fixed)
  * Change 'do query_err' to 'query_err' in yasql.in (two occurances)
  * Workaround for some utf8-string-length-caching-magic problem
    via setting the variable in question to 'undef'
  * Removed 'substr': we don't truncate the data any more,
    not even long data. (Note: the previous problem doesn't manifest
    without substr. See test-script test/test0001.sh)
  * Version number 1.83-1
  * Mind you, changelog is tracked in four(?) different files,
    I updated only yasql.in
