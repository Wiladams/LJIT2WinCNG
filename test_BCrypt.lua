--package.path = package.path..";..\\Bhut\\?.lua;..\\Bhut\\core\\?.lua";

local ffi = require "ffi"

local BCrypt = require "BCrypt"

--[[
function GetAlgorithmProvider(algoid, impl)
	local lphAlgo = ffi.new("BCRYPT_ALG_HANDLE[1]")

print("Size: ", ffi.sizeof(lphAlgo));
	local algoidptr = ffi.cast("const uint16_t *", algoid)

	local status = BCrypt.Lib.BCryptOpenAlgorithmProvider(lphAlgo, algoidptr, impl, 0);

	if not BCrypt.BCRYPT_SUCCESS(status) then
		print("status: ", status);
		return nil
	end

	return lphAlgo[0]
end
--]]

local algo = BCrypt.BCryptAlgorithm(BCrypt.BCRYPT_RNG_ALGORITHM)

print("Algo: ",algo);

--local rngHandle = GetAlgorithmProvider(BCrypt.BCRYPT_RNG_ALGORITHM)

--print("Algorithm Handle: ", rngHandle);


function test_RandomBytes()
	for j=1,5 do
		local rngBuff, err = BCrypt.GetRandomBytes()

		print("Status: ", rngBuff, status);

		local buffLen = ffi.sizeof(rngBuff)

		for i=0,buffLen do
			print(rngBuff[i])
		end
		print("--");
	end
end

test_RandomBytes();
