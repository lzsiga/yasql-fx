2024.03.02. Lorinczy Zsigmond
  * Forked from https://sourceforge.net/projects/yasql/ version 1.83
    renamed as 'yasql-fx' (fixed)
  * Change 'do query_err' to 'query_err' in yasql.in (two occurances)
  * Workaround for some utf8-string-length-caching-magic problem
    via setting the variable in question to 'undef'
