package Plugins::PlayMP4::Register;

# Registers the PlayMP4 tag handler. Kept free of any web/UI dependency so it
# can be used by both the server plugin and the scanner importer.

use strict;
use warnings;

use Slim::Formats;
use Slim::Utils::Log;

use constant HANDLER => 'Plugins::PlayMP4::Formats::MP4';

my $log = logger('plugin.playmp4');

# Server types of the plugin (see custom-types.conf)
# mp4 is the type of the core reader: the plugin wraps it, see Formats/MP4.pm
my @types = qw(mp4 mp4v);

sub registerFormatHandler {
    my ($class, $tagClasses) = @_;

    Slim::Formats->init();

    $tagClasses ||= \%Slim::Formats::tagClasses;

    return 0 unless ref($tagClasses) eq 'HASH';

    for my $type (@types) {
        next if defined $tagClasses->{$type} && $tagClasses->{$type} eq HANDLER;

        $tagClasses->{$type} = HANDLER;

        main::DEBUGLOG && $log->is_debug && $log->debug("PlayMP4: registered $type tag handler");
    }

    return 1;
}

1;
