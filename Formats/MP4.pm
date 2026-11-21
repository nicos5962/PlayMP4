package Plugins::PlayMP4::Formats::MP4;

# Core reads the mp4 files without video (m4a, m4b, ...) and skips those that
# hold a video stream. This class is registered for mp4: it lets core read a
# file first and only takes over the files core gives up on because of their
# video, which then get the type mp4v. Tags, guessing and the Discogs id are
# those of Plugins::PlayAVI::Formats::AVI, which this plugin needs.

use strict;
use warnings;
use base qw(Plugins::PlayAVI::Formats::AVI);

use Slim::Formats::Movie;

# The type of the files with video (see custom-types.conf)
sub types       { qw(mp4v) }
sub logCategory { 'plugin.playmp4' }
sub pluginName  { 'PlayMP4' }

# Files without video stay with core
sub _wantsFile {
    my ($class, $hasVideo) = @_;

    return $hasVideo;
}

sub getTag {
    my ($class, $file, $anchor) = @_;
    return {} unless $file;

    my $tags = Slim::Formats::Movie->getTag($file, $anchor);

    return $tags if ref $tags eq 'HASH' && %$tags;

    return $class->SUPER::getTag($file, $anchor);
}

# Cover art of core first, then the picture or a frame of the video
sub getCoverArt {
    my ($class, $file) = @_;
    return unless $file;

    my $art = Slim::Formats::Movie->getCoverArt($file);

    return $art if defined $art && length $art;

    return $class->SUPER::getCoverArt($file);
}

# Seeking and streaming of the mp4 files core reads is core's
for my $method (qw(findFrameBoundaries getInitialAudioBlock volatileInitialAudioBlock parseStream)) {
    no strict 'refs';

    *{$method} = sub {
        shift;
        return Slim::Formats::Movie->$method(@_);
    };
}

1;
