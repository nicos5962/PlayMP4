package Plugins::PlayMP4::Importer;

use strict;
use warnings;

use Plugins::PlayMP4::Register;

sub initPlugin {
    my $class = shift;

    Plugins::PlayMP4::Register->registerFormatHandler();
    return 1;
}

sub startScan {
    my $class = shift;
    return;
}

1;
