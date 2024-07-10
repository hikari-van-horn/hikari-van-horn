#!/usr/bin/perl -CS

use JSON::XS;
use utf8;
use strict;

my %icons = (
	'clear-day'	=> "🌞",	# wi-day-sunny 	 
	'clear-night'	=> "\x{2601}",	# wi-night-clear
	'rain'	=> "🌧️", # wi-rain 	 
	'snow'	=> "\x{2744}", # wi-snow
	'sleet'	=> "🌨️", # wi-hail 	 
	'wind'	=> "\x{1F32C}", # wi-windy 	 
	'fog'	=> "🌁", # wi-fog 	 
	# 'cloudy'	=> "\x{2601}", # wi-cloudy 	 
    'cloudy'	=> "\x{2601}", # wi-cloudy 	 
	# 'cloudy'	=> "🌧️", # wi-cloudy 	 
	'partly-cloudy-day'	=> "⛅", # wi-day-cloudy 	 
	'partly-cloudy-night'	=> "☁️", # wi-night-cloudy 	 
);

# my %icons = (
# 	'clear-day'	=> "☀️",	# wi-day-sunny 	 
# 	'clear-night'	=> "🌌",	# wi-night-clear
# 	'rain'	=> "🌧️", # wi-rain 	 
# 	'snow'	=> "❄️", # wi-snow
# 	'sleet'	=> "🌨️", # wi-hail 	 
# 	'wind'	=> "🌬️", # wi-windy 	 
# 	'fog'	=> "🌁", # wi-fog 	 
# 	'cloudy'	=> "🌤️", # wi-cloudy 	 
# 	'partly-cloudy-day'	=> "⛅", # wi-day-cloudy 	 
# 	'partly-cloudy-night'	=> "☁️", # wi-night-cloudy 	 
# );

use Cwd qw();
my $current_working_dir = Cwd::abs_path();
use File::Basename qw();
my ($name, $rel_path, $suffix) = File::Basename::fileparse($0);

my $forecast = decode_json(`perl ${rel_path}forecast.pl`);

if (exists $icons{$forecast->{currentConditions}->{icon}})
{
	print $icons{$forecast->{currentConditions}->{icon}}, "\n";
}
else
{
	print "?\n";
}