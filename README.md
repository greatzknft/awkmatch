# AWKmatch

A multi-pattern text matching tool to replace clumsy grep piping.

*	For the first file use the match file. The following files will be matched accordingly.
*	For the matches, simply use the first field as an option specifier (see flags below) and the second as the match itself.
*	A line of text is only matched if it matches all of the patterns (AND matching). OR matching is a future possibility.
*	Note: If you only use one field, it will be interpreted as a pattern to match with default flags

		
### CLI Switches:

		c - Enable color output (low-priority)
		H - Print filename
		n - Print line number
		s - Specify a custom field separator in the pattern file (default = "§")

### Pattern modifiers in match file:

		e - OR match (will not be implemented for now, future consideration)
		R - Regex (default)
		f - Exact match
		i - Case insensitive 
		I - Case sensitive (default)
		v - Inverse match

		Note: In case of contradictory flags, the default case is used 

