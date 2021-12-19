%% DESCRIPTION: Correctly measure later dates for date_diff_duration
%% DESCRIPTION: If the second date is later, the sign is positive.
#include '../dates.pl'.
?- date_diff_duration_sign(date(2000,1,1),date(2001,1,1),1).