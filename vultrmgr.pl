#!/usr/bin/perl

use strict;
use warnings;

use Getopt::Long;
use File::Basename;

use API::Account;
use API::App;
use API::Auth;

our $API_KEY;

sub debug {
    my $DEBUG = $ENV{"DEBUG"};
    if (defined $DEBUG and $DEBUG eq "1")
    { return 1; } else { return 0; }
}

my $KEY_FROM_ENV = $ENV{"API_KEY"};
if (defined $KEY_FROM_ENV and $KEY_FROM_ENV ne "") {
    $API_KEY = $KEY_FROM_ENV;
    if (debug) {print "API key from env: $API_KEY\n";}
} else {
    if (debug) {print "API key from source: $API_KEY\n";}
}

sub usage {
    my $prog_name = basename($0);
    print("Usage: $prog_name [--help] [options]\n");
}

sub help {
    usage();
    print <<EOF;
Options with a star (*) require an api key.
You can set an api key by exporting API_KEY=<key> as an environment variable.

--account-info * - Show account information and balance.
--app-list - Show a list of available applications.
--auth-info * - Show information on the supplied api key.
EOF
}

my $arg_account_info;
my $arg_app_list;
my $arg_auth_info;
my $arg_help;

GetOptions( "account-info" => \$arg_account_info,
            "app-list" => \$arg_app_list,
            "auth-info" => \$arg_auth_info,
            "help" => \$arg_help )
or die("Error in command line arguments.\n");

if (!defined $KEY_FROM_ENV or $KEY_FROM_ENV eq "") {
    print("Warning: No API key was specified. Many operations will fail without one!\n");
}

if ($arg_account_info) {
    Account::Info();
} elsif ($arg_app_list) {
    App::List();
} elsif ($arg_auth_info) {
    Auth::Info();
} elsif ($arg_help) {
    help();
} else {
    usage();
}
