%% DESCRIPTION Putting a date into epoch and converting back gives the same date.
#include '../dates.pl'.

?- epoch_date(date(1977,4,14),ED), epoch_to_date(ED,Y,M,D).