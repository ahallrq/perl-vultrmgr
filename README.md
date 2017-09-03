## <img width=25px src="https://www.vultr.com/dist/img/brand/logo_v_onwhite.svg">&nbsp;Vultr Manager

### A manager for your Vultr sevices written in Perl.

##### Requirements

*Note: Earlier versions may work. The following versions tested were from Debian Jessie.*

* perl >= 5.20 < 6.0
* libwww-perl >= 6.08
* libjson-perl >= 2.61

Also requires a Vultr API key with the nessesary permissions.

##### Important Note

Currently this script only returns the balance and is very much a WIP.

##### Usage

As an API key is needed, you can either supply it as an enviroment variable (`API_KEY`) or by modifying the `$API_KEY` variable in the script.

    $ API_KEY="12345678901234567890" vultrmgr.pl [--help] [options]

As expected a full listing of options can be found with the `--help` switch.
