#!/usr/bin/perl

use strict;
use warnings;

use Net::Twitter;
use Data::Dumper;
use DBI;

my $dbh = DBI->connect("dbi:SQLite:dbname=/home/ryan/workspace/AutoTwat/twits.db", "", "");

  my $nt = Net::Twitter->new(
      traits   => [qw/OAuth API::REST/],
      consumer_key        => "LzZDIgpDjaZxqDtay2AVmA",
      consumer_secret     => "i88IM0jujOljITKhRZF8QdSbOeojAmrwi7cVDWcI",
      access_token        => "195127847-vToZL4GZVRFLMI9lM1t1efhz8My6qyzTIc9ThTg6",
      access_token_secret => "iCA3Xd3zGpQreQbT8E50JMrOJlN1jW8ZloK34ar4",
  );
  
#    $nt->update({ status => 'Hello world!' });

my $sth = $dbh->prepare("INSERT INTO twats (user, text) VALUES (?, ?)");

for my $twit (@{$nt->public_timeline()})
{
	$sth->execute($twit->{user}{screen_name}, $twit->{text});
	print $twit->{user}{screen_name}, ": ", $twit->{text}, "\n";
}