# s(CASP) Dates

This is a library written in the s(CASP) variant of Prolog, to enable date calculations
when doing knowledge representations of legislation in s(CASP) code. It is a work
in progress, and is not recommended for production use.

## About

This module was written by Jason Morris of Lexpedite Legal Technology Ltd. Contributions are gratefully welcomed.

## Installation

Just download put the dates.pl file somewhere you can use it, and `#include 'path/to/dates.pl'.` inside
your scasp code.

## Testing

Install s(CASP) so it is on the path, and run `run_tests.sh` in the root of the package. See the `README.md` in the tests folder for advice on how to create additional tests.

## Usage

### Expressing Dates
A date is expressed as the term `date(Y,M,D)`, where all the components are integers,
M is between 1 and 12, and D is between 1 and the number of days in the relevant month.
A valid date will pass `valid_date(date(Y,M,D))`.

### Expressing Durations
A duration is expressed as the term `duration(S,Y,M,D)`, where `S` is `1` for into the future
and `-1` for into the past. `Y` is an integer, `M` and `D` non-negative integers.
A valid duration will pass `valid_duration(durations(S,Y,M,D))`.

### date_add
`date_add(start_date,duration,result_date)` will calculate the result of adding the duration
(which can be negative) to the `start_date`.
This predicate does not attempt to reduce days to months or years, due to the number of
days in each month being contingent. If you add a duration of months or years, and the result
would be a day that does not exist, like February 30, the result is rounded down to the
prior real date, both when adding and subtracting. January 30 + 1 Month = February 28 in a non-
leap year. Likewise, March 30 - 1 Month = February 28 in a non-leap year.

Example: What day is 400 days after April fools, 1980?
```prolog
?- date_add(date(1980,4,1),duration(1,0,0,400),X).
% X = date(1981,5,19)
```
Rounding Example: What is 1 month after January 30, 2021?
```prolog
?- date_add(date(2021,1,30),duration(1,0,1,0),X).
%X = date(2021,2,28).
```
### date_add_days
`date_add_days(start_date,Days,Result_date)` will accept a starting date and an integer,
positive, negative, or zero, and return the date that many days into the future or past.
This method of calculating dates is both considerably faster than using the duration
method, and more precise, and should be preferred except where durations are being used
to simplify user interfaces.

### before/after/eq/not_before/not_after
`before/2`, `after/2`, `eq/2`, `not_before/2`, `not_after/2`
all accept two dates and succeed if the first has the given relationship to
the second.

### days_bewteen
`days_between(date,date,days)` accepts two dates and calculates the number of days between
them. If the first date is earlier, the number of days will be positive. If the second
date is earlier, the number of days will be negative.

### day_of_week_name
`day_of_week_name(dow,name)` accepts a number between 0 and 6 and returns atoms sunday - saturday.

### day_of_week
`day_of_week(date,dow)` accpets a date and returns a number between 0 and 6 representing sunday to saturday.

### date_diff
`date_diff(date,date,duration)` accepts two dates and returns a duration between them.
Note that the duration is specified in days and sign only (e.g. `duration(1,0,0,12)`), and does not use months
and years, which means that for right now it is duplicative of `days_between/3`.
Allowing you to measure the difference in years, months, and days (which is useful primarily for
generating human interfaces), is underway.

### week_of_year
`week_of_year(date,week)` accepts date and returns a number indicating the week of the
year to which it belongs. Weeks are indexed from 1. The first week of the year is 
the days from January 1 of that year to the first Saturday of the year. If January 1
is a saturday, Week 1 is January 1 alone, and Week 2 is January 2-8. Weeks do not
span over year boundaries. Due to partial weeks at the start and end of the year, there
may be as many as 53 weeks in a year.

### first_day_of/last_day_of
`first_day_of/2`, and `last_day_of/2` accept a `year(Y)`, `month(Y,M)`, or `week(Y,W)`, and return the first or
last calendar day of that period, as appropriate.

### timestamp
`timestamp(date,ts)` accepts a date and returns the posix timestamp for midnight at the start of that date.

### to_date
`to_date(ts,date)` accepts a timestamp and returns the date during which that timestamp occurs.

### date_diff_duration
`date_diff_duration(date,date,duration)` accepts two dates and generates a duration indicating the time
between them in years, months, and days.
If the first date is earlier than the second, the duration will be positive.
The behaviour of months in this system is unpredictable.

## Important Notes
* This system is not aware of historical changes in calendar dates.
* This system is not aware of leap seconds, though that could probably be added, once times are implemented.
* This system cannot convert between calendar systems, e.g. Julian vs. Gregorian.
* This system cannot accommodate for how the borders of time zones may have changed in a given location over time.
* This system may not even have accurate current or historical information for daylight savings time.
* The system has not been checked for consistency with the legislative interpretation of dates and
  durations in any particular legal system. Check for consistency with your own interpretation act.

## Known Issues:
* `date_diff_duration` has not been tested and is probably broken for dates in the wrong order.
   or days going over month boundaries.
* `date_diff_duration` should be renamed to `date_diff`, and `days_between` renamed `date_diff_days`
  for consistency.
* Some of the epoch predicates are inconsistent in how they handle date terms. Missing the `date()` part. 
* It has not been checked for consistency with legislative interpretation of dates.

## Roadmap
Things that I'm planning on adding to the system:
* Time.
* Time zones.
* Time zone conversions
* Conversions between local and absolute (tz-specific) dates and times.
* Allow the user to specify a custom start-of-week.
* Allow the user to specify whether weeks cross over January 1.
* Improve human representation of answers by adding human versions for some and hiding others.

## Other Plans
Things that would be useful to add but which probably belong in different packages:
* Timepoint logic - allows the user to specify facts about the distance between timepoints
  without specifying what the actual time is.
* Custom Periods - allow the user to specify customized time periods in addition to things like
  week and month, and be able to calculate the distance between them, find the next one, etc.
  Useful for custom.