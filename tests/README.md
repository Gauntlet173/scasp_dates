# Tests

This folder contains tests of the scasp_dates module. Run these tests
by running `./run_tests.sh` in the root of the package.

To create a test file:

## Description
Any lines beginning with `%% DESCRIPTION:` will be displayed to the
user running the tests.

## Include
Use `#include '../dates.pl'.` to include the module file.

## Facts and Query
Add s(CASP) code to create the facts and the query you want to test.
Ensure that your test passes if it returns any models. If, for
instance, you want to be sure that "February 31, 2000" is not a valid
date, you need to reverse the logic as follows:

```prolog
feb_30_not_valid :-
    not valid_date(date(2000,2,31)).

?- feb_30_not_valid.
```

Now the test will generate a model, which will be deemed a "pass" by
the run_tests.sh script.

Not that the query will be displayed to the user, so it is helpful to have a descriptive predicate if you cannot put the query there directly.