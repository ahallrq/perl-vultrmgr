package Account;

use strict;
use warnings;

use lib "..";
use Request;
use JSON;

sub Info {
    my ($succ, $req) = Request::api_request("v1/account/info", "GET", 1, "");

    if ($succ) {
        my %data = %{decode_json($req)};
        my $bal_avail = sprintf "%.2f", ($data{"balance"} + $data{"pending_charges"}) * -1;
        my $bal = sprintf "%.2f", $data{"balance"} * -1;
        my $charges = sprintf "%.2f", $data{"pending_charges"};
        my $last_charges = sprintf "%.2f", $data{"last_payment_amount"} * -1;

        print "Balance: \$$bal (\$$bal_avail available)\n";
        print "Next billing charges: \$$charges\n";
        print "Last payment: \$$last_charges at $data{'last_payment_date'}.\n";
    }
}

1;
