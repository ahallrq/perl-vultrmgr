#!/usr/bin/perl

use strict;
use warnings;

use LWP::UserAgent;
use JSON;

my $VULTR_API_URL = "https://api.vultr.com/";
my $API_KEY = "API_KEY_HERE";

my %API_RESP_CODES = ( 400 => "An Invalid API URL was specified. Check the URL and try again.",
                       403 => "An Invalid API key was supplied. Make sure the API key is present and correct.",
                       405 => "The wrong method was used for this function. Entire that the correct method is used (GET/POST).",
                       412 => "Request failed for some reason. Check the response body for more information.",
                       500 => "An unknown internal server error occured. Try again later.",
                       503 => "Excessive requests (2/s) has been detected. Slow down and try again later." );

my $KEY_FROM_ENV = $ENV{"API_KEY"};
if (defined $KEY_FROM_ENV and $KEY_FROM_ENV ne "") {
    $API_KEY = $KEY_FROM_ENV;
    print "API key from env: $API_KEY\n";
}
else {
    print "API key from source: $API_KEY\n";
}

sub vultr_api_request {
    my ($api, $request_type, $auth_required, $request_data) = @_;
    
    my $ua = LWP::UserAgent->new;
    my $api_request = HTTP::Request->new($request_type => $VULTR_API_URL . $api);
    if ($auth_required) {
        $api_request->header("API-Key" => $API_KEY);
    }
    $api_request->content($request_data);

    my $api_response = $ua->request($api_request);
    if ($api_response->is_success) {
        return $api_response->decoded_content;
    } else {
        print "Error: ", $api_response->code, " ",$api_response->message, "\n";
        print "$API_RESP_CODES{$api_response->code}\n";
        return 0;
    }
}

my $req = vultr_api_request("v1/account/info", "GET", 1, "");

if ($req) {
    my %data = %{decode_json($req)};
    my $bal = ($data{"balance"} + $data{"pending_charges"}) * -1;
    print "Balance: $bal\n";
}
