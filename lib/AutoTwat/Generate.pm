package AutoTwat::Generate;

use strict;
use warnings;

use AutoTwat::Generate::EN;

use Data::Dumper;

AutoTwat::Generate::EN::init();

my %classes;

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
	
	if (exists($classes{$class}))
	{
		return getclass($class, @args);
	}
	else
	{
		#XXX FIX FOR LOCALITIES!
		return AutoTwat::Generate::EN::terminal($class, @args);
	}
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