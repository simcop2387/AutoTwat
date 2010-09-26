package AutoTwat::Generate;

use strict;
use warnings;

use AutoTwat::Generate::EN;

use Data::Dumper;

AutoTwat::Generate::EN::init();

my %classes;
my %vars;

sub generate
{
	my $input = shift;
	
	$input =~ s/{([^}]+)}/terminal($1)/eg while ($input =~ /{[^}]+}/);
}

sub terminal
{
	my $input = shift;
	my ($class, @args) = split(/:/, $input);
	
	print "$class\n";
	print Dumper \@args;
	
	my $ret;
	
	if (exists($classes{$class}))
	{
		$ret = getclass($class, @args);
	}
	else
	{
		#XXX FIX FOR LOCALITIES!
		$ret = AutoTwat::Generate::EN::terminal($class, @args);
	}
	
	if (@args ~~ /^sto(?:re)?=(.*)$/)
	{
		store($1, $ret);
	}
}

sub store
{
	my $var = shift;
	my $value = shift;
	
	$vars{$var} = $value;
}

sub getclass
{
	my $class = shift;
	my @args = @_;
}

sub addclass
{
	my $class = shift;
	my $definition = shift;
	
	$classes{$class} = $definition;
}

1;