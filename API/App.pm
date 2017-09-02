package App;

use strict;
use warnings;

use lib "..";
use Request;
use JSON;

sub List {
    my ($succ, $req) = Request::api_request("v1/app/list", "GET", 0, "");

    if ($succ) {
        my %data = %{decode_json($req)};
        print "Available applications:\n";
        foreach my $app (keys %data) {
            my $surcharge = sprintf '%.2f', $data{$app}{surcharge};
            printf "[\$%6s] %-24s: %-64s\n", $surcharge, "$data{$app}{name} ($data{$app}{short_name})", $data{$app}{deploy_name}
        }
    }
}

1;
