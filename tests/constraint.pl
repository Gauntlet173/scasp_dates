%%DESCRIPTION: This tests checks to see whether we can use constraint techniques
%%DESCRIPTION: on dates that are converted to epoch time.

% We will say that there is are two periods, one starts on january 1, the
% other ends on December 31, each lasting a different number of days. Then
% we will ask what dates are available, and see if it can be converted back
% to dates.
%
% Actually, we don't need to test the ability to convert it back. We can
% calculate the dates, and then use constraint math to say whether
#include '../dates.pl'.
valid(X) :-
    date_add(date(2021,1,1),duration(1,0,0,200),End),
    date_add(date(2021,12,31),duration(-1,0,0,200),Start),
    before(X,End),
    after(X,Start).
    % epoch_date(End,E1),
    % epoch_date(Start,E2),
    % X #< E1,
    % X #> E2.
?- valid(X).