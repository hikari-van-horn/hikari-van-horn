#!/usr/bin/perl -CS

use JSON::XS;
use Text::Wrap;
use utf8;
use strict;
use Cwd qw();
my $current_working_dir = Cwd::abs_path();
use File::Basename qw();
my ($name, $rel_path, $suffix) = File::Basename::fileparse($0);

my %icons = (
	'clear-day'	=> "🌞",	# wi-day-sunny 	 
	'clear-night'	=> "\x{2601}",	# wi-night-clear
	'rain'	=> "\x{26C6}", # wi-rain 	 
	'snow'	=> "\x{2744}", # wi-snow
	'sleet'	=> "🌨️", # wi-hail 	 
	'wind'	=> "\x{1F32C}", # wi-windy 	 
	'fog'	=> "🌁", # wi-fog 	 
	# 'cloudy'	=> "\x{2601}", # wi-cloudy 	 
    'cloudy'	=> "\x{2601}", # wi-cloudy 	 
	'partly-cloudy-day'	=> "⛅", # wi-day-cloudy 	 
	'partly-cloudy-night'	=> "☁️", # wi-night-cloudy 	 
);

sub get_icon_for_condition {
	my ($condition) = @_;
	if (exists $icons{$condition})
	{
		return $icons{$condition};
	}
	else
	{
		return "?";
	}
}

# my $forecast = decode_json(`${current_working_dir}/${rel_path}forecast.pl`);
# my $JSON_PATH = "${current_working_dir}/${rel_path}.forecast.json";
# my $JSON_PATH = "${rel_path}.forecast.json";
# print "JSON_PATH: $JSON_PATH\n";
# open(my $json, "+<", $JSON_PATH) or die "Couldn't open JSON: $!";
my $forecast = decode_json(`perl ${rel_path}forecast.pl`);
# my $forecast = decode_json(<$json>);
my $count = 0;

my $firstDay = $forecast->{days}[0];


my @days = ('SUN', 'MON', 'TUE', 'WED', 'THU', 'FRI', 'SAT');

for my $point (@{$forecast->{days}})
{
	my @time = localtime($point->{datetimeEpoch});
	my $dayIdx = $time[6];
	my $day = $days[$dayIdx];
	print "${day}:\t ",
		
		int($point->{tempmin} + 0.5), "\x{B0}C - ",
		int($point->{tempmax} + 0.5), "\x{B0}C\t",
		lc($point->{conditions}), "\n";

	$count++;
	last if $count >= 7;
}

print "\n-------------------\n\n";
$count = 0;

for my $point (@{$firstDay->{hours}})
{
	my @now = localtime();
	my $now_hour = $now[2];
	my @time = localtime($point->{datetimeEpoch});
	my $min = $time[1];
	my $hour = $time[2];
	if($hour < $now_hour)
	{
		next;
	} else {
		my $ampm = $hour < 12 ? 'AM' : 'PM';

		if ($hour == 0)
		{
			$hour = 12;
		}
		elsif ($hour > 12)
		{
			$hour -= 12;
		}

		print $hour, ':', sprintf('%02d', $min), ' ', $ampm, " \t",
			int($point->{temp} + 0.5), "\x{B0} - ", get_icon_for_condition($point->{icon}), "\n";

		$count++;
		last if $count >= 7;
	}
	
}

if ($count < 7)
{
	print "Tomorrow:\n";
	my $left_count = 7 - $count;
	$count = 0;
	my $nextDay = $forecast->{days}[1];
	for my $point (@{$nextDay->{hours}})
	{
		my @now = localtime();
		my $now_hour = $now[2];
		my @time = localtime($point->{datetimeEpoch});
		my $min = $time[1];
		my $hour = $time[2];
		my $ampm = $hour < 12 ? 'AM' : 'PM';

		if ($hour == 0)
		{
			$hour = 12;
		}
		elsif ($hour > 12)
		{
			$hour -= 12;
		}

		print $hour, ':', sprintf('%02d', $min), ' ', $ampm, " \t",
			int($point->{temp} + 0.5), "\x{B0} - ", get_icon_for_condition($point->{icon}), "\n";

		$count++;
		last if $count >= $left_count;
		
	}
}

print "\n";


