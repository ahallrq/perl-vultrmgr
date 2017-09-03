package Backup;

use strict;
use warnings;

use lib "..";
use Request;
use JSON;

sub List {
    my ($succ, $req) = Request::api_request("v1/backup/list", "GET", 1, "");

    if ($succ) {
        if ($req eq "[]") {
            print("No backups were found on this account.\n");
            return;
        }
        my %data = %{decode_json($req)};
        print "Current backups:\n";
        foreach my $backup (keys %data) {
            my $size_normal = "";
            if ($data{$backup}{size} > 1073741824) { $size_normal = $data{$backup}{size}/1073741824 . "GiB"; }
            elsif ($data{$backup}{size} > 1048576) { $size_normal = $data{$backup}{size}/1048576 . "MiB"; }
            elsif ($data{$backup}{size} > 1024) { $size_normal = $data{$backup}{size}/1024 . "KiB"; }
            else { $size_normal = $data{$backup}{size} . "B"; }

            print("Backup: $data{$backup}{BACKUPID} ($data{$backup}{description})\n");
            print("Created: $data{$backup}{date_created}\n");
            print("Size: $size_normal\n");
            print("Status: $data{$backup}{status}\n\n");
        }
    }
}

1;
