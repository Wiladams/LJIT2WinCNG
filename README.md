LJIT2WinCNG
===========

LuaJIT FFI interface to Windows Crytography Next Generation functions found on Windows in the BCrypt.dll and NCrypt.dll libraries.

CNG is for Windows what OpenSSL is for the rest of the world.  CNG is not a single libary, but rather a collection of libraries and technologies that provide support for various cryptography scenarios on the Windows platform.  

LJIT2WinCNG is two things.  First, it provides the simple FFI based interface to these libraries.  This is not much more than providing the raw access to the functions that are found in the various .dll files.

Second, it acts as a 'wrapper' for the functions, providing a much more sane Lua way of accessing things.

Example:  Generating Random Bytes

		local rngBuff, err = BCrypt.GetRandomBytes(16)

This will generate a buffer of 16 random bytes.  the function will return a Lua "string" with the bytes in it, or nil, and an appropriate error.

Access to digests is fairly straight forward as well:

	print("SHA1: ", BCrypt.SHA1(content));
	print("SHA256: ", BCrypt.SHA256(content));
	print("SHA384: ", BCrypt.SHA384(content));
	print("SHA512: ", BCrypt.SHA512(content));

	print("MD2: ", BCrypt.MD2(content));
	print("MD4: ", BCrypt.MD4(content));
	print("MD5: ", BCrypt.MD5(content));

Basically, all the various bits and pieces are stitched together in these easily called functions.  You can choose to access the interfaces at any level from the lowest level access to the underlying system calls, all the way up to using fairly simple functions such as there.
