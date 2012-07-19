local ffi = require "ffi"
local C = ffi.C

require "WTypes"

local kernel32 = ffi.load("kernel32");

--[[
	WinNls.h

	Defined in Kernel32
--]]

ffi.cdef[[
int MultiByteToWideChar(UINT CodePage,
    DWORD    dwFlags,
    LPCSTR   lpMultiByteStr, int cbMultiByte,
    LPWSTR  lpWideCharStr, int cchWideChar);


int WideCharToMultiByte(UINT CodePage,
    DWORD    dwFlags,
	LPCWSTR  lpWideCharStr, int cchWideChar,
    LPSTR   lpMultiByteStr, int cbMultiByte,
    LPCSTR   lpDefaultChar,
    LPBOOL  lpUsedDefaultChar);
]]

local CP_ACP 		= 0		-- default to ANSI code page
local CP_OEMCP		= 1		-- default to OEM code page
local CP_MACCP		= 2		-- default to MAC code page
local CP_THREAD_ACP	= 3		-- current thread's ANSI code page
local CP_SYMBOL		= 42	-- SYMBOL translations


local function AnsiToUnicode16(in_Src)
	local nsrcBytes = #in_Src

	-- find out how many characters needed
	local charsneeded = kernel32.MultiByteToWideChar(CP_ACP, 0, in_Src, nsrcBytes, nil, 0);
--print("charsneeded: ", nsrcBytes, charsneeded);

	if charsneeded < 0 then
		return nil;
	end


	local buff = ffi.new("uint16_t[?]", charsneeded+1)

	local charswritten = kernel32.MultiByteToWideChar(CP_ACP, 0, in_Src, nsrcBytes, buff, charsneeded)
	buff[charswritten] = 0

--print("charswritten: ", charswritten)

	return ffi.string(buff, (charswritten*2)+1);
end


return {
	Lib = kernel32,

	-- Local functions
	AnsiToUnicode16 = AnsiToUnicode16,
	}
