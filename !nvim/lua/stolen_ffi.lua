local ffi = require "ffi"

-- > Custom C extension to get direct fold information from Neovim
-- Very obviously stolen from astroui, lol
-- Isn't it funny how we need an entire C ffi just to ask some questions about some folds?
-- Big props to whoever worked on this
ffi.cdef [[
	typedef struct {} Error;
	typedef struct {} win_T;
	typedef struct {
		int start;  // line number where deepest fold starts
		int level;  // fold level, when zero other fields are N/A
		int llevel; // lowest level that starts in v:lnum
		int lines;  // number of lines from v:lnum to end of closed fold
	} foldinfo_T;
	foldinfo_T fold_info(win_T* wp, int lnum);
	win_T *find_window_by_handle(int Window, Error *err);
	int compute_foldcolumn(win_T *wp, int col);
]]

return ffi
