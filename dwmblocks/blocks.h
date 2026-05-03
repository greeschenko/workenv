//Modify this file to change what commands output to your statusbar, and recompile using the make command.
static const Block blocks[] = {
	/*Icon*/	/*Command*/		/*Update Interval*/	/*Update Signal*/
    {"CPU ", "~/prodev/workenv/dwmblocks_scripts/sb-cpu", 1, 0},
	{"MEM ", "~/prodev/workenv/dwmblocks_scripts/sb-memory",	30,	0},
	{"SSD ", "~/prodev/workenv/dwmblocks_scripts/sb-storage",	30,	0},
	{"BAT ", "~/prodev/workenv/dwmblocks_scripts/sb-battery",	30,	0},

	{"", "~/prodev/workenv/dwmblocks_scripts/sb-brightness",	5, 0},
	{"", "~/prodev/workenv/dwmblocks_scripts/sb-sound",	5, 0},
	{"", "~/prodev/workenv/dwmblocks_scripts/sb-network",	5, 0},
	{"", "date '+%b %d %H:%M (%a)'",	5, 0},
};

//sets delimiter between status commands. NULL character ('\0') means no delimiter.
static char delim[] = "   ";
static unsigned int delimLen = 5;
