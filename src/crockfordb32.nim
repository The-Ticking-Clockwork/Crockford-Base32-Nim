import std/[
  strutils
]

const hasNint = compiles:
  import pkg/nint128

when hasNint:
  import pkg/nint128

const CrockfordBase32Alphabet = "0123456789ABCDEFGHJKMNPQRSTVWXYZ"

proc encode*[T: SomeInteger](_: typedesc[T], number: T, length: int = 100): string =
  ## Encodes an integer as a crockford base32 string.
  var
    num = number
    count = 0

  while num > 0:
    if count >= length:
      break

    inc count

    let remainder = num mod 32.T

    result.insert($CrockfordBase32Alphabet[remainder])
    num = num div 32.T

proc decode*[T: SomeInteger](_: typedesc[T], inp: string): T =
  ## Decodes a number from crockford base32, raises a ValueError if
  ## it cannot be decoded.
  let encoded = inp.toUpperAscii().multiReplace(
    ("O", "0"), ("I", "1"), ("L", "1")
  )

  for chr in encoded:
    let value = CrockfordBase32Alphabet.find(chr)

    if value == -1:
      raise newException(ValueError, "Invalid character in encoded string")

    result = result * 32.T + value.T

when declared(nint128):
  proc encode*[T: SomeInt128](_: typedesc[T], number: T, length: int = 100): string =
    ## Encodes a 128-bit integer as a crockford base32 string.
    var
      num = number
      count = 0

    when T is Int128:
      template i(n: SomeInteger): Int128 = i128(n)

    else:
      template i(n: SomeInteger): Uint128 = u128(n)

    while num > i(0):
      if count >= length:
        break

      inc count

      let remainder = (num mod i(32)).lo.int

      result = CrockfordBase32Alphabet[remainder] & result
      num = num div i(32)

  proc decode*[T: SomeInt128](_: typedesc[T], encoded: string): T =
    ## Decodes a 128-bit number from crockford base32, raises a
    ## ValueError if it cannot be decoded.
    when T is Int128:
      template i(n: SomeInteger): Int128 = i128(n)

    else:
      template i(n: SomeInteger): Uint128 = u128(n)

    for chr in encoded:
      let value = CrockfordBase32Alphabet.find(chr)

      if value == -1:
        raise newException(ValueError, "Invalid character in encoded string")

      result = result * i(32) + i(value)
