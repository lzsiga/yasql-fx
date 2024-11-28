undated
  * 'prompt' command (see test/test0015.sh)
  * standalone comments are now skipped (see test/test0016.sh)
  * no padding for the last field of the record
  * rewrite in describe (using packages)
  * Version number 1.83-0009

2024.10.28. lzs
  * order by in 'show users'
  * more information in 'show synonyms'
  * new 'show dblinks'
  * information message in 'describe' about 'synonyms'
    mind you, 'dblink over dblink' doesn't work
  * describe on dblink (partial)
  * information at startup: database, server, user, uid, sid, sessionid
  * Version number 1.83-0008

2024.10.23. lzs
  * little fix about describing synonyms that refer to tables via dblink
  * Version number 1.83-0007

2024.08.12. lzs
  * Use variables NLS_DATE_FORMAT, NLS_TIMESTAMP_FORMAT, NLS_TIMESTAMP_TZ_FORMAT
  * Version number 1.83-0006

2024.06.15. lzs
  * fix within \i format
  * Version number 1.83-0005

2024.06.14. lzs
  * improvments in describe
  * header-printing became a subrutin
  * Version number 1.83-0004

2024.06.01. lzs
  * describe_fast is plain wrong (cf test/test0010), I'm removing it
  * Version number 1.83-0003

2024.05.30. lzs
  * fix in parsing: special statement-end markers work again (cf test/
    test0009)
  * fix in the final print: don't do in batch mode
  * Version number 1.83-0002

2024.05.02. lzs
  * command 'edit' now uses LC_CTYPE when writing/reading the temporary
    file
  * Version number 1.83-2

2024.03.xx. lzs
  * Refactoring encoding (cf 'Wide character' problems)
  * Refactoring lexical parsing (cf 'semicolon in comment' problem)
  * using AL32UTF8 as charset and ncharset; using UTF-8 in history-file
  * using $LC_CTYPE in history (in memory)

2024.03.02. Lorinczy Zsigmond (lzs)
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
