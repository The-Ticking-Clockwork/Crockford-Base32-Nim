# Crockford Base32 (Nim)
This is an unfinished implementation of Crockford Base32 in Nim, it
doesn't support checking, but PRs are welcome if someone wishes to
implement that.

If you're using [`nint128`](https://github.com/rockcavera/nim-nint128)
in your project, we support encoding or decoding of those types too!

[`stint`](https://github.com/status-im/nim-stint) support is
unimplemented, but planned to be added in the future.

This project is also licensed under CC0, so it can be used in any way,
shape or form! No credit needed (but still appreciated)!

## Usage
```nim
import crockfordb32

let encoded = int.encode(2829)
echo encoded  # Output is `2RD`

let decoded = int.decode("2RD")
echo decoded  # Output is `2829`
```

The `encode` functions additionally have a length parameter allowing
you to pad the generated string (for example, ULIDs must be 26
characters long).
