#!/usr/bin/perl

use Cwd qw();
my $current_working_dir = Cwd::abs_path();
use File::Basename qw();
my ($name, $rel_path, $suffix) = File::Basename::fileparse($0);
# our $JSON_PATH = "${current_working_dir}/${rel_path}.forecast.json";
our $JSON_PATH = "/${rel_path}.forecast.json";
our $INTERVAL = 3600;
our $API_KEY = '72Q4N3ZBWD3A8K69EQ6G726XF';
our $URL_TEMPLATE = "https://weather.visualcrossing.com/VisualCrossingWebServices/rest/services/timeline/Shanghai?unitGroup=metric&key=$API_KEY&contentType=json";

use Fcntl qw(:flock :seek);
use File::stat;
use strict;

my %args = map { $_ => 1 } @ARGV;
my $mode = $args{init} ? '>' : '+<';
open(my $json, $mode, $JSON_PATH) or die "Couldn't open JSON: $!";
flock($json, LOCK_EX) or die "Couldn't lock JSON: $!";

if ($args{init} or time() - stat($json)->ctime > $INTERVAL)
{
	require Mojo::UserAgent;
	my $ua = Mojo::UserAgent->new();

	$ua->on('error' => sub {
		my ($self, $err) = @_;
		die "User agent error: $err";
	});

	my $res = $ua->get($URL_TEMPLATE)->res;

	if ($res->is_empty)
	{
		die "Empty response";
	}
	elsif (not $res->is_success())
	{
		die sprintf("HTTP %s %s", $res->code, $res->message);
	}
	elsif (not defined($res->json))
	{
		die "Unparsable JSON";
	}

	truncate($json, 0);
	seek($json, 0, SEEK_SET);
	print $json $res->body;
	print $res->body;
}
else
{
	local $/; undef $/;
	print <$json>;
	print "\n";
}

close($json);
exit(0);