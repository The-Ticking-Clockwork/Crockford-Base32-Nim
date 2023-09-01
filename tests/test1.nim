# This is just an example to get you started. You may wish to put all of your
# tests into a single file, or separate them into multiple `test1`, `test2`
# etc. files (better names are recommended, just make sure the name starts with
# the letter 't').
#
# To run these tests, simply execute `nimble test`.

import unittest

import crockfordb32

const hasNint = compiles:
  import nint128

when hasNint:
  import nint128

test "Encode Numbers":
  let a = encode(int, 2829, 3) == "2RD"
  echo "encode(int, 2829) == \"2RD\", ", a
  check a

  when hasNint:
    let b = encode(UInt128, "243282366920338463473374607231768211454".u128) == "5Q0SXC65Q407B6WVWGTJGFMBZY"
    echo "encode(UInt128, 243282366920338463473374607231768211454) == \"5Q0SXC65Q407B6WVWGTJGFMBZY\", ", b
    check b

test "Decode Numbers":
  let a = decode(int, "2RD") == 2829
  echo "decode(int, \"2RD\") == 2829, ", a
  check a

  when hasNint:
    let b = decode(UInt128, "5Q0SXC65Q407B6WVWGTJGFMBZY") == "243282366920338463473374607231768211454".u128
    echo "decode(UInt128, \"5Q0SXC65Q407B6WVWGTJGFMBZY\") == 243282366920338463473374607231768211454, ", b
    check b
