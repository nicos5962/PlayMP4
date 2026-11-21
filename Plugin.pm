package Plugins::PlayMP4::Plugin;

use strict;
use warnings;

use base qw(Slim::Plugin::Base);

use Slim::Utils::Log;
use Plugins::PlayMP4::Register;

my $log = Slim::Utils::Log->addLogCategory({
    category     => 'plugin.playmp4',
    defaultLevel => 'INFO',
    description  => 'PLUGIN_PLAYMP4',
});

sub initPlugin {
    my $class = shift;

    my $version = $class->_pluginDataFor('version') || 'unknown';
    $log->info("Initializing PlayMP4 plugin $version");

    Plugins::PlayMP4::Register->registerFormatHandler();

    $class->SUPER::initPlugin(@_);
}

sub getDisplayName { 'PLUGIN_PLAYMP4' }

1;
