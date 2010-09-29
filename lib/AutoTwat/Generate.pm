package AutoTwat::Generate;

use strict;
use warnings;

use AutoTwat::Generate::EN;

use Data::Dumper;

AutoTwat::Generate::EN::init();

my %classes = (rand => [], random => []); #place holder classes
my %vars;

sub generate
{
	my $input = shift;
	
	$input =~ s/{([^}]+)}/terminal($1)/eg while ($input =~ /{[^}]+}/);
	$input =~ s|/\*.*?\*/||g;
	
	return $input;
}

sub terminal
{
	my $input = shift;
	my ($class, @args) = split(/:/, $input);
	
	print "$class\n";
	print Dumper \@args;
	
	s/$([^_\$]+)_?/getvar($1)/eg for @args;
	
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
	
	print "DEBUG: $class - $ret\n";
	
	return $ret;
}

sub getvar
{
	my $var = shift;
	die "No such variable $var" unless exists($vars{$var});
	
	return $vars{$var};
}

sub store
{
	my $var = shift;
	my $value = shift;
	
	$vars{$var} = $value;
}

sub randrange {my ($max, $min) = @_; rand() * ($max-$min) + $min};

sub getclass
{
	my $class = shift;
	my @args = @_;
	
	if ($class =~ /rand(?:om)?/)
	{
		my $max   = (map {/^max(?:imum)?=(\d+)$/i; $1 ? $1 : ()} @args)[0];
		my $min   = (map {/^min(?:imum)?=(\d+)$/i; $1 ? $1 : ()} @args)[0];
		my $float = (map {/^float(?:=(\d+))?$/i ? ($1 ? $1 : "1") : ()} @args)[0];
		
		#default is a range of [1,10]
		$max //= 10;
		$min //= 1;
		$float //= 0; # we don't use floats by default
		
		my $rand = randrange($min, $max);
		
		if ($float)
		{
			return sprintf "%f$float", $rand;
		}
		else
		{
			return int($rand+0.5);
		}
	}
}

sub addclass
{
	my $class = shift;
	my $definition = shift;
	
	$classes{$class} = $definition;
}

1;