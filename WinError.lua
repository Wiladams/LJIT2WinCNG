local ffi = require "ffi"
local bit = require "bit"
local band = bit.band
local bor = bit.bor
local rshift = bit.rshift
local lshift = bit.lshift



--[[
//
// The return value of COM functions and methods is an HRESULT.
// This is not a handle to anything, but is merely a 32-bit value
// with several fields encoded in the value. The parts of an
// HRESULT are shown below.
//
// Many of the macros and functions below were orginally defined to
// operate on SCODEs. SCODEs are no longer used. The macros are
// still present for compatibility and easy porting of Win16 code.
// Newly written code should use the HRESULT macros and functions.
//

//
//  HRESULTs are 32 bit values layed out as follows:
//
//   3 3 2 2 2 2 2 2 2 2 2 2 1 1 1 1 1 1 1 1 1 1
//   1 0 9 8 7 6 5 4 3 2 1 0 9 8 7 6 5 4 3 2 1 0 9 8 7 6 5 4 3 2 1 0
//  +-+-+-+-+-+---------------------+-------------------------------+
//  |S|R|C|N|r|    Facility         |               Code            |
//  +-+-+-+-+-+---------------------+-------------------------------+
//
//  where
//
//      S - Severity - indicates success/fail
//
//          0 - Success
//          1 - Fail (COERROR)
//
//      R - reserved portion of the facility code, corresponds to NT's
//              second severity bit.
//
//      C - reserved portion of the facility code, corresponds to NT's
//              C field.
//
//      N - reserved portion of the facility code. Used to indicate a
//              mapped NT status value.
//
//      r - reserved portion of the facility code. Reserved for internal
//              use. Used to indicate HRESULT values that are not status
//              values, but are instead message ids for display strings.
//
//      Facility - is the facility code
//
//      Code - is the facility's status code
//
--]]

--
-- Define the facility codes
--
FACILITY_RPC                     = 1
FACILITY_DISPATCH                = 2
FACILITY_STORAGE                 = 3
FACILITY_WINDOWSUPDATE           = 36
FACILITY_WINRM                   = 51
FACILITY_WINDOWS_DEFENDER        = 80
FACILITY_WINDOWS                 = 8
FACILITY_WINDOWS_CE              = 24
FACILITY_USERMODE_VOLMGR         = 56
FACILITY_USERMODE_VIRTUALIZATION = 55
FACILITY_URT                     = 19
FACILITY_UMI                     = 22
FACILITY_UI                      = 42
FACILITY_TPM_SOFTWARE            = 41
FACILITY_TPM_SERVICES            = 40
FACILITY_SXS                     = 23
FACILITY_STATE_MANAGEMENT        = 34
FACILITY_SSPI                    = 9
FACILITY_SECURITY                = 9
FACILITY_SETUPAPI                = 15
FACILITY_SCARD                   = 16
FACILITY_SHELL                   = 39
FACILITY_USERMODE_VHD            = 58
FACILITY_SDIAG                   = 60
FACILITY_PLA                     = 48
FACILITY_OPC                     = 81
FACILITY_WIN32                   = 7
FACILITY_CONTROL                 = 10
FACILITY_WEBSERVICES             = 61
FACILITY_NULL                    = 0
FACILITY_NDIS                    = 52
FACILITY_METADIRECTORY           = 35
FACILITY_MSMQ                    = 14
FACILITY_MEDIASERVER             = 13
FACILITY_RAS                     = 83
FACILITY_INTERNET                = 12
FACILITY_ITF                     = 4
FACILITY_USERMODE_HYPERVISOR     = 53
FACILITY_HTTP                    = 25
FACILITY_GRAPHICS                = 38
FACILITY_FWP                     = 50
FACILITY_FVE                     = 49
FACILITY_USERMODE_FILTER_MANAGER = 31
FACILITY_DPLAY                   = 21
FACILITY_DIRECTORYSERVICE        = 37
FACILITY_CONFIGURATION           = 33
FACILITY_COMPLUS                 = 17
FACILITY_USERMODE_COMMONLOG      = 26
FACILITY_CMI                     = 54
FACILITY_CERT                    = 11
FACILITY_AAF                     = 18
FACILITY_ACS                     = 20
FACILITY_BACKGROUNDCOPY          = 32
FACILITY_BCD                     = 57
FACILITY_XPS                     = 82
FACILITY_MBN                     = 84


--
-- MessageId: ERROR_SUCCESS
--
-- MessageText:
--
-- The operation completed successfully.
--
ERROR_SUCCESS	= 0

NO_ERROR		= 0
SEC_E_OK		= 0x00000000

-- for KINECT

ERROR_DEVICE_NOT_CONNECTED			= 1167
ERROR_NOT_READY						= 21
ERROR_ALREADY_INITIALIZED			= 1247
ERROR_NO_MORE_ITEMS					= 259

E_POINTER							= (0x80004003)	-- Invalid pointer

--[[
#define ERROR_INVALID_FUNCTION           1    // dderror
#define ERROR_FILE_NOT_FOUND             2
#define ERROR_PATH_NOT_FOUND             3
#define ERROR_TOO_MANY_OPEN_FILES        4
#define ERROR_ACCESS_DENIED              5
#define ERROR_INVALID_HANDLE             6
#define ERROR_ARENA_TRASHED              7
#define ERROR_NOT_ENOUGH_MEMORY          8    // dderror
#define ERROR_INVALID_BLOCK              9
#define ERROR_BAD_ENVIRONMENT            10
#define ERROR_BAD_FORMAT                 11
#define ERROR_INVALID_ACCESS             12
#define ERROR_INVALID_DATA               13
#define ERROR_OUTOFMEMORY                14
#define ERROR_INVALID_DRIVE              15
#define ERROR_CURRENT_DIRECTORY          16
#define ERROR_NOT_SAME_DEVICE            17
#define ERROR_NO_MORE_FILES              18
#define ERROR_WRITE_PROTECT              19
#define ERROR_BAD_UNIT                   20
#define ERROR_NOT_READY                  21
#define ERROR_BAD_COMMAND                22
#define ERROR_CRC                        23
#define ERROR_BAD_LENGTH                 24
#define ERROR_SEEK                       25
#define ERROR_NOT_DOS_DISK               26
#define ERROR_SECTOR_NOT_FOUND           27
#define ERROR_OUT_OF_PAPER               28
#define ERROR_WRITE_FAULT                29
#define ERROR_READ_FAULT                 30
#define ERROR_GEN_FAILURE                31
#define ERROR_SHARING_VIOLATION          32
#define ERROR_LOCK_VIOLATION             33
#define ERROR_WRONG_DISK                 34
#define ERROR_SHARING_BUFFER_EXCEEDED    36
#define ERROR_HANDLE_EOF                 38
#define ERROR_HANDLE_DISK_FULL           39
#define ERROR_NOT_SUPPORTED              50
#define ERROR_REM_NOT_LIST               51
#define ERROR_DUP_NAME                   52
#define ERROR_BAD_NETPATH                53
#define ERROR_NETWORK_BUSY               54
#define ERROR_DEV_NOT_EXIST              55    // dderror
#define ERROR_TOO_MANY_CMDS              56
#define ERROR_ADAP_HDW_ERR               57
#define ERROR_BAD_NET_RESP               58
#define ERROR_UNEXP_NET_ERR              59
#define ERROR_BAD_REM_ADAP               60
#define ERROR_PRINTQ_FULL                61
#define ERROR_NO_SPOOL_SPACE             62
#define ERROR_PRINT_CANCELLED            63
#define ERROR_NETNAME_DELETED            64
#define ERROR_NETWORK_ACCESS_DENIED      65
#define ERROR_BAD_DEV_TYPE               66
#define ERROR_BAD_NET_NAME               67
#define ERROR_TOO_MANY_NAMES             68
#define ERROR_TOO_MANY_SESS              69
#define ERROR_SHARING_PAUSED             70
#define ERROR_REQ_NOT_ACCEP              71
#define ERROR_REDIR_PAUSED               72
#define ERROR_FILE_EXISTS                80
#define ERROR_CANNOT_MAKE                82
#define ERROR_FAIL_I24                   83
#define ERROR_OUT_OF_STRUCTURES          84
#define ERROR_ALREADY_ASSIGNED           85
#define ERROR_INVALID_PASSWORD           86
#define ERROR_INVALID_PARAMETER          87    // dderror
#define ERROR_NET_WRITE_FAULT            88
#define ERROR_NO_PROC_SLOTS              89
#define ERROR_TOO_MANY_SEMAPHORES        100
#define ERROR_EXCL_SEM_ALREADY_OWNED     101
--]]















--
-- Severity values
--

SEVERITY_SUCCESS    = 0
SEVERITY_ERROR      = 1

--
-- Generic test for success on any status value (non-negative numbers
-- indicate success).
--

function SUCCEEDED(hr)
	return hr >= 0
end

--
-- and the inverse
--

function FAILED(hr)
	return hr < 0
end


--
-- Generic test for error on any status value.
--

function IS_ERROR(Status)
	return rshift(Status, 31) == SEVERITY_ERROR
end

--
-- Return the code
--

function HRESULT_CODE(hr)
	return band(hr, 0xFFFF)
end

--
--  Return the facility
--

function HRESULT_FACILITY(hr)
	return band(rshift(hr, 16), 0x1fff)
end

--
--  Return the severity
--

function HRESULT_SEVERITY(hr)
	return band(rshift(hr, 31), 0x1)
end

function HRESULT_PARTS(hr)
	return HRESULT_SEVERITY(hr), HRESULT_FACILITY(hr), HRESULT_CODE(hr)
end

--
-- Create an HRESULT value from component pieces
--

function MAKE_HRESULT(severity,facility,code)
    return bor(lshift(severity,31) , lshift(facility,16) , code)
end


--
-- HRESULT_FROM_WIN32(x) used to be a macro, however we now run it as an inline function
-- to prevent double evaluation of 'x'. If you still need the macro, you can use __HRESULT_FROM_WIN32(x)
--
function __HRESULT_FROM_WIN32(x)
	if x <= 0 then
		return x
	end

	return bor(band(x, 0x0000FFFF), lshift(FACILITY_WIN32, 16), 0x80000000)
end

NTE_BAD_FLAGS                    = 0x80090009;
NTE_INVALID_HANDLE               = 0x80090026;
NTE_INVALID_PARAMETER            = 0x80090027;
NTE_NO_MEMORY                    = 0x8009000E;

NTE_NO_MORE_ITEMS                = 0x8009002A;
NTE_SILENT_CONTEXT               = 0x80090022;


--[[
print("WinError.lua - TEST")

local res1 = MAKE_HRESULT(1, 2, 33)
print(string.format("0x%08x", res1))

print(string.format("%d, %d, %d", HRESULT_PARTS(res1)))
--]]
