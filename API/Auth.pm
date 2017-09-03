package Auth;

use strict;
use warnings;

use lib "..";
use Request;
use JSON;

sub Info {
    my ($succ, $req) = Request::api_request("v1/auth/info", "GET", 1, "");

    if ($succ) {
        my %data = %{decode_json($req)};
        
        print("Account: $data{name} ($data{email})\n");
        print("Permissions: " . join(", ", @{$data{acls}}) . "\n");
    }
}

1;
