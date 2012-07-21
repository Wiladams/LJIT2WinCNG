--package.path = package.path..";..\\Bhut\\?.lua;..\\Bhut\\core\\?.lua";

local ffi = require "ffi"

local BCrypt = require "BCrypt"



function test_RngAlgorithm()
	local rngalgo = BCrypt.BCryptAlgorithm(BCrypt.BCRYPT_RNG_ALGORITHM)

	print("Algo: ",rngalgo);
end

--print("Algorithm Handle: ", rngHandle);

local function bintohex(bytes, len)
	local str = ffi.string(bytes, len)

	return (str:gsub('(.)', function(c)
		return string.format('%02x', string.byte(c))
	end))
end

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

function test_sha1_hash()
	local sh1, err = BCrypt.SHA1Algorithm:CreateHash();

print("SHA1, status: ", sh1, tonumber(status));

	--print(sh1:GetHashLength());

	local outlen = sh1:GetHashDigestLength();
	local outbuff = ffi.new("uint8_t[?]", outlen);

	sh1:HashMore("Take this as the first input to be hashed");
	sh1:Finish(outbuff, outlen);

	local hex = bintohex(outbuff, outlen);

	print(hex);
end


--test_RandomBytes();

test_sha1_hash();
