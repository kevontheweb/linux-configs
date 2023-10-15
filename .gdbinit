set history save
set history remove-duplicates 0
set history filename ~/.gdb_history
# don't go into std lib files
skip -gfi /usr/include/c++/*/*/*
skip -gfi /usr/include/c++/*/*
skip -gfi /usr/include/c++/*

