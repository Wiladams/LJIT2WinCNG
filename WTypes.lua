local ffi = require"ffi"
local bit = require"bit"

local bnot = bit.bnot
local band = bit.band
local bor = bit.bor
local lshift = bit.lshift
local rshift = bit.rshift


ffi.cdef[[

// Basic Data types
typedef unsigned char	BYTE;
typedef long			BOOL;
typedef BYTE			BOOLEAN;
typedef char			CHAR;
typedef wchar_t			WCHAR;
typedef uint16_t		WORD;
typedef unsigned long	DWORD;
typedef uint32_t		DWORD32;
typedef int				INT;
typedef int32_t			INT32;
typedef int64_t			INT64;
typedef float 			FLOAT;
typedef long			LONG;
typedef signed int		LONG32;
typedef int64_t			LONGLONG;
typedef size_t			SIZE_T;

typedef uint8_t			BCHAR;
typedef unsigned char	UCHAR;
typedef unsigned int	UINT;
typedef unsigned int	UINT32;
typedef unsigned long	ULONG;
typedef unsigned int	ULONG32;
typedef unsigned short	USHORT;
typedef uint64_t		ULONGLONG;


// Some pointer types
typedef unsigned char	*PUCHAR;
typedef unsigned int	*PUINT;
typedef unsigned int	*PUINT32;
typedef unsigned long	*PULONG;
typedef unsigned int	*PULONG32;
typedef unsigned short	*PUSHORT;
typedef LONGLONG 		*PLONGLONG;
typedef ULONGLONG 		*PULONGLONG;


typedef void *			PVOID;
typedef DWORD *			DWORD_PTR;
typedef intptr_t		LONG_PTR;
typedef uintptr_t		UINT_PTR;
typedef uintptr_t		ULONG_PTR;
typedef ULONG_PTR *		PULONG_PTR;


typedef DWORD *			LPCOLORREF;

typedef BOOL *			LPBOOL;
typedef char *			LPSTR;
typedef short *			LPWSTR, PWSTR;
typedef const short *	LPCWSTR;
typedef LPSTR			LPTSTR;

typedef DWORD *			LPDWORD;
typedef void *			LPVOID;
typedef WORD *			LPWORD;

typedef const char *	LPCSTR;
typedef LPCSTR			LPCTSTR;
typedef const void *	LPCVOID;


typedef void *			HANDLE;

]]


