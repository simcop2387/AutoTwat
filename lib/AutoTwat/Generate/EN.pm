package AutoTwat::Generate::EN;

use strict;
use warnings;

use Lingua::EN::Conjugate qw( conjugate );
use Lingua::EN::Inflect;
use Data::Dumper;

my %words;

sub init {
	open(my $fh, "<", "tmp/pos/part-of-speech.txt") or die "can't open pos: $!";
	
	my %posdb = (
	  N => "noun_word",
	  h => "noun_phrase",
	  t => "verb_transitive",
	  i => "verb_intransitive",
	  V => "verb_participle",
	  A => "adjective",
	  v => "adverb",
	  C => "conjunction",
	  P => "preposition",
	  "!" => "interjection",
	  r => "pronoun",
	  D => "article_definite",
	  I => "article_indefinite",
	  o => "nominative",
	);
	
	while (my $line = <$fh>)
	{
		my ($word, $pos) = split(/\t/, $line, 2);
		
		for my $id (keys %posdb)
		{
			$words{$posdb{$id}}{$word} = 1 if ($pos =~ /$id/);
		}
	}
}

sub verb {
  my $input = shift;
  
}

1;