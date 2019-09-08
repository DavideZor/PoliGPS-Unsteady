function m = time_in_minutes(hours, minutes, seconds)

m = hours*60 + minutes + round(seconds/60);

end