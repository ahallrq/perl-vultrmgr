## <img width=25px src="https://www.vultr.com/dist/img/brand/logo_v_onwhite.svg">&nbsp;Vultr Manager

### A manager for your Vultr sevices written in Perl.

##### Requirements

* perl >= 5.0 < 6.0
* libwww-perl > 6.0
* libjson-perl > 2.90

Also requires a Vultr API key with the nessesary permissions.

##### Important Note

Currently this script only returns the balance and is very much a WIP.

##### Usage

As an API key is needed, you can either supply it as an enviroment variable (`API-KEY`) or by modifying the `API_KEY` variable in the script.

    $ API-KEY="12345678901234567890" vultrmgr.pl ...
