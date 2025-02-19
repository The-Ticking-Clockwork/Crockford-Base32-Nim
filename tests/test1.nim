# This is just an example to get you started. You may wish to put all of your
# tests into a single file, or separate them into multiple `test1`, `test2`
# etc. files (better names are recommended, just make sure the name starts with
# the letter 't').
#
# To run these tests, simply execute `nimble test`.

import std/[
  compilesettings,
  strutils,
  unittest
]

when not defined(js):
  const HasNint = block:
    var res = false

    for i in querySettingSeq(lazyPaths) & querySettingSeq(nimblePaths):
      echo i
      if "nint128" in i:
        res = true
        break

    res    

  when HasNint:
    {.define: crockfordb32NintSupport.}
    import nint128

else:
  import std/jsbigints

  const HasNint = false


import crockfordb32


test "Encode Numbers":
  let a = encode(int, 2829) == "2RD"
  echo "encode(int, 2829) == \"2RD\", ", a
  check a

  when HasNint:
    let b = encode(UInt128, "243282366920338463473374607231768211454".u128) == "5Q0SXC65Q407B6WVWGTJGFMBZY"
    echo "encode(UInt128, 243282366920338463473374607231768211454) == \"5Q0SXC65Q407B6WVWGTJGFMBZY\", ", b
    check b

  when defined(js):
    let b = encode(JsBigInt, big("243282366920338463473374607231768211454")) == "5Q0SXC65Q407B6WVWGTJGFMBZY"
    echo "encode(JsBigInt, 243282366920338463473374607231768211454) == \"5Q0SXC65Q407B6WVWGTJGFMBZY\", ", b
    check b

test "Decode Numbers":
  let a = decode(int, "2RD") == 2829
  echo "decode(int, \"2RD\") == 2829, ", a
  check a

  when HasNint:
    let b = decode(UInt128, "5Q0SXC65Q407B6WVWGTJGFMBZY") == "243282366920338463473374607231768211454".u128
    echo "decode(UInt128, \"5Q0SXC65Q407B6WVWGTJGFMBZY\") == 243282366920338463473374607231768211454, ", b
    check b

  when defined(js):
    let b = decode(JsBigInt, "5Q0SXC65Q407B6WVWGTJGFMBZY") == big("243282366920338463473374607231768211454")
    echo "decode(JsBigInt, \"5Q0SXC65Q407B6WVWGTJGFMBZY\") == 243282366920338463473374607231768211454, ", b
    check b
