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

sub terminal
{
	my $class = shift;
	my @args = @_;
	
	print "$class\n";
	
	if (exists $words{$class})
	{
		my @wwords = keys %{$words{$class}};
		my $word = @wwords[rand @wwords];
		
		if ($class =~ /^verb/)
		{
			my $subject = (map {/^sub(?:j(?:ect)?)?=(.*)$/i; $1 ? $1 : ()} @args)[0];
			my $tense = (map {/^ten(?:se)?=(.*)$/i; $1 ? $1 : ()} @args)[0];
			my $negation = (map {/^neg(?:ation)?=(.*)$/i; $1 ? $1 : ()} @args)[0]; 
			
			$subject //= "it"; # default to 3rd person singular
			$tense //= "present"; # default to present tense
			
			print Dumper($word, $subject, $tense, $negation);
						
			my$ret=conjugate( 'verb'=>$word, 
                             'tense'=>$tense, 
                           'pronoun'=>$subject,
                           $negation ? ('negation'=>$negation) : () );
                           
            die "Invalid args 「".join(", ", @args)."」 to $class\n";
            
            $ret =~ s/^\s*$subject//; #remove the subject, we aren't going to 
            print Dumper($ret);
            return $ret;
		}
	}
}

1;