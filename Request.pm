package Request;

use LWP::UserAgent;

my $VULTR_API_URL = "https://api.vultr.com/";

my %API_RESP_CODES = ( 400 => "An Invalid API URL was specified. Check the URL and try again.",
                       403 => "An Invalid API key was supplied. Make sure the API key is present and correct.",
                       405 => "The wrong method was used for this function. Entire that the correct method is used (GET/POST).",
                       412 => "Request failed for some reason. Check the response body for more information.",
                       500 => "An unknown internal server error occured. Try again later.",
                       503 => "Excessive requests (2/s) has been detected. Slow down and try again later." );

sub api_request {
    my ($api, $request_type, $auth_required, $request_data) = @_;

    my $ua = LWP::UserAgent->new;
    my $api_request = HTTP::Request->new($request_type => $VULTR_API_URL . $api);
    if ($auth_required) {
        $api_request->header("API-Key" => $main::API_KEY);
    }
    $api_request->content($request_data);

    my $api_response = $ua->request($api_request);
    if ($api_response->is_success) {
        return (1, $api_response->decoded_content);
    } else {
        print "Error: ", $api_response->code, " ",$api_response->message, "\n";
        print "$API_RESP_CODES{$api_response->code}\n";
        return (0, $api_response->decoded_content);
    }
}

1;
