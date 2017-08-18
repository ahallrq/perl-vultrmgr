#!/usr/bin/perl

use strict;
use warnings;

use LWP::UserAgent;
use JSON;

our $API_KEY = "API_KEY_HERE";

our %API_RESP_CODES = ( 400 => "An Invalid API URL was specified. Check the URL and try again.",
                        403 => "An Invalid API key was supplied. Make sure the API is present and correct.",
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

my $ua = LWP::UserAgent->new;
my $vultr_api_url = "https://api.vultr.com/v1/account/info";

my $api_request = HTTP::Request->new("GET" => $vultr_api_url);
$api_request->header("API-Key" => $API_KEY);
$api_request->content("");

my $api_response = $ua->request($api_request);
if ($api_response->is_success) {
    my $message = $api_response->decoded_content;
    my %data = %{decode_json($message)};
    my $bal = ($data{"balance"} + $data{"pending_charges"}) * -1;
    print "Balance: $bal\n";
} else {
    print "Error: ", $api_response->code, " ",$api_response->message, "\n";
    print "$API_RESP_CODES{$api_response->code}\n";
}
