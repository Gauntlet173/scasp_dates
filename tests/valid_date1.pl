%% DESCRIPTION: February 30 is not a valid date.
#include '../dates.pl'.

working :- 
    not valid_date(2000,2,30).

?- working.