my $url = 'http://starwars.wikia.com/wiki/Main_Page'; # this is trying to query plu webpage

use LWP::Simple;
my $content = get $url;
die "Couldn't get $url" unless defined $content;

# create a stack
while ($content =~ m/<a href=\"((https?|ftp).*?)\"/g) {
	#print "$1\n";
	push (@stack, $1);
}

%found = ();
foreach (@stack) {
	$link = shift @stack;
	$content = get $link;
	if (!(exists $found{$content})) {
		print "$content\n";
		$found{$content} = 1;
		while ($content =~ m/<a href=\"((https?|ftp).*?)\"/g) {
			push (@stack, $1);
			#print "$1\n";
		}
	}
}

print "the end";
