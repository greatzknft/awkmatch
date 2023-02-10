#!/usr/bin/gawk -f

# AWKmatch: 	A multi-pattern text matching tool to replace clumsy grep piping.
#		For the matches, simply use the first field as an option specifier (see flags below) and the second as the match itself.
#
#		Note: If you only use one field, it will be interpreted as a pattern to match with default flags
#
# CLI Switches:
#		
#		c - Enable color output (low-priority)
#		H - Print filename
#		n - Print line number
#		s - Specify a custom field separator in the pattern file (default = "§")
#
# Pattern modifiers in match file:
#
#		e - Regex (default)
#		f - Exact match
#		i - Case insensitive 
#		I - Case sensitive (default)
#		v - Inverse match
#
#		Note: In case of contradictory flags, the default case is used 

# 1st file - Patterns
FNR == NR 
{
	patternIntegrityCheck($0);
	if(NF==2)
	{
		if(match($1,"i") && !match($1,"I")) 	patternFlags[NR,"caseInsensitive"]	= 1;
		else 					patternFlags[NR,"caseInsensitive"]	= 0;
		if(match($1,"f") && !match($1,"e")) 	patternFlags[NR,"noRegex"]		= 1;
		else 					patternFlags[NR,"noRegex"]		= 0;
		if(match($1,"v"))			patternFlags[NR,"inverseMatch"]		= 1;
		else 					patternFlags[NR,"inverseMatch"]		= 0;

		pattern[NR] = $2
	}
	else if(NF==1)
	{
		patternFlags[NR,"caseInsensitive"]	= 0;
		patternFlags[NR,"noRegex"]		= 0;
		patternFlags[NR,"inverseMatch"]		= 0;

		pattern[NR] = $1
	}
	else
	{
		errorHandler("Invalid number of fields in match file (line #" NR")", WARNING);
		next;
	}
}
# Other files - Data to be processed
FNR < NR 
{
	# Match every pattern on each line and skip lines that don't match
	for(line = 1; line <= patternLines; line++)
	{
		if(patternFlags[line, "noRegex"]) 		linePattern = "\<" pattern[line] "\>";
		else 						linePattern = pattern[line];
		if(patternFlags[line, "caseInsensitive"]) { 	lineText = tolower($0); linePattern = tolower(linePattern);}
		else 						lineText = $0;
		if(patternFlags[line, "inverseMatch"])		matchResult = (lineText !~ linePattern);
		else						matchResult = (lineText ~ linePattern); 

		# Is this really necessary?
		if(!matchResult) break;
	}
		if(!matchResult) next;
		displayResults();
}
END
{
	if(FNR==NR) patternLines = NR;
}
function errorHandler(message, severity)
{

}

function displayResults()
{

}
